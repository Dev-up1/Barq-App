import 'package:barq_recharge/core/config/app_env.dart';
import 'package:barq_recharge/core/constants/mock_services.dart';
import 'package:barq_recharge/core/networking/aggregator_api_client.dart';
import 'package:barq_recharge/core/taxation/tax_service.dart';
import 'package:barq_recharge/data/db/app_database.dart';
import 'package:barq_recharge/data/models/agent_dashboard_summary.dart';
import 'package:barq_recharge/data/models/current_actor.dart';
import 'package:barq_recharge/data/repositories/local_wallet_repository.dart';
import 'package:barq_recharge/data/repositories/commission_logs_repository.dart';
import 'package:barq_recharge/data/repositories/pending_sms_queue_repository.dart';
import 'package:barq_recharge/data/repositories/services_catalog_repository.dart';
import 'package:barq_recharge/data/repositories/sub_accounts_repository.dart';
import 'package:barq_recharge/data/repositories/transactions_repository.dart';
import 'package:barq_recharge/data/services/biometric_auth_service.dart';
import 'package:barq_recharge/data/services/commission_export_service.dart';
import 'package:barq_recharge/data/services/commission_service.dart';
import 'package:barq_recharge/data/services/offline_sms_service.dart';
import 'package:barq_recharge/data/services/psi_registry.dart';
import 'package:barq_recharge/data/services/recharge_service.dart';
import 'package:barq_recharge/data/services/spending_limit_service.dart';
import 'package:barq_recharge/data/services/whatsapp_support_service.dart';
import 'package:barq_recharge/features/telecom/application/recharge_controller.dart';
import 'package:barq_recharge/features/telecom/application/recharge_state.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppStage { splash, auth, home }

final appStageProvider = StateProvider<AppStage>((ref) => AppStage.splash);
final homeTabProvider = StateProvider<String>((ref) => 'home');
final serviceTabProvider =
    StateProvider<ServiceTab>((ref) => ServiceTab.services);
final isOfflineModeProvider = StateProvider<bool>((ref) => false);
final supabaseReadyProvider =
    Provider<bool>((ref) => AppEnv.hasSupabaseConfig);
final aggregatorConfigReadyProvider =
    Provider<bool>((ref) => AppEnv.hasAggregatorConfig);
final smsFallbackConfigReadyProvider =
    Provider<bool>((ref) => AppEnv.hasSmsFallbackConfig);
final whatsappSupportConfigReadyProvider =
    Provider<bool>((ref) => AppEnv.hasWhatsAppSupportConfig);
final connectivityProvider = Provider<Connectivity>((ref) {
  return Connectivity();
});
final currentSubAccountIdProvider = StateProvider<int?>((ref) => null);

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(() {
    database.close();
  });
  return database;
});

final localWalletRepositoryProvider = Provider<LocalWalletRepository>((ref) {
  return LocalWalletRepository(ref.watch(appDatabaseProvider));
});

final transactionsRepositoryProvider =
    Provider<TransactionsRepository>((ref) {
  return TransactionsRepository(ref.watch(appDatabaseProvider));
});

final pendingSmsQueueRepositoryProvider =
    Provider<PendingSmsQueueRepository>((ref) {
  return PendingSmsQueueRepository(ref.watch(appDatabaseProvider));
});

final subAccountsRepositoryProvider = Provider<SubAccountsRepository>((ref) {
  return SubAccountsRepository(ref.watch(appDatabaseProvider));
});

final commissionLogsRepositoryProvider =
    Provider<CommissionLogsRepository>((ref) {
  return CommissionLogsRepository(ref.watch(appDatabaseProvider));
});

final servicesCatalogRepositoryProvider =
    Provider<ServicesCatalogRepository>((ref) {
  return ServicesCatalogRepository(ref.watch(appDatabaseProvider));
});

final taxServiceProvider = Provider<TaxService>((ref) {
  return const TaxService();
});
final commissionServiceProvider = Provider<CommissionService>((ref) {
  return const CommissionService();
});
final biometricAuthServiceProvider = Provider<BiometricAuthService>((ref) {
  return BiometricAuthService();
});
final whatsappSupportServiceProvider = Provider<WhatsappSupportService>((ref) {
  return const WhatsappSupportService();
});
final spendingLimitServiceProvider = Provider<SpendingLimitService>((ref) {
  return SpendingLimitService(
    walletRepository: ref.watch(localWalletRepositoryProvider),
    transactionsRepository: ref.watch(transactionsRepositoryProvider),
  );
});

final aggregatorDioProvider = Provider<Dio>((ref) {
  return AggregatorApiClient().client;
});

final psiRegistryProvider = Provider<PsiRegistry>((ref) {
  return PsiRegistry(
    catalogRepository: ref.watch(servicesCatalogRepositoryProvider),
  );
});

final servicesCatalogBootstrapProvider = FutureProvider<void>((ref) async {
  final registry = ref.watch(psiRegistryProvider);
  await registry.ensureSeeded();
  await registry.refreshOverrides();
});

final rechargeServiceProvider = Provider<RechargeService>((ref) {
  return RechargeService(ref.watch(aggregatorDioProvider));
});

final offlineSmsServiceProvider = Provider<OfflineSmsService>((ref) {
  return OfflineSmsService(ref.watch(pendingSmsQueueRepositoryProvider));
});
final commissionExportServiceProvider =
    Provider<CommissionExportService>((ref) {
  return CommissionExportService(ref.watch(commissionLogsRepositoryProvider));
});

final currentActorProvider = FutureProvider<CurrentActor>((ref) async {
  final subAccountId = ref.watch(currentSubAccountIdProvider);
  if (subAccountId != null) {
    final account =
        await ref.watch(subAccountsRepositoryProvider).findById(subAccountId);
    if (account != null) {
      return CurrentActor(
        id: 'staff-${account.id}',
        displayName: account.displayName,
        isOwner: false,
        isActive: account.isActive,
        dailySpendingLimitMinor: account.dailySpendingLimitMinor,
        monthlySpendingLimitMinor: account.monthlySpendingLimitMinor,
      );
    }
  }

  final wallet = await ref.watch(localWalletRepositoryProvider).fetchCurrentWallet();
  return CurrentActor(
    id: 'owner-1',
    displayName: wallet?.agentName ?? 'وكيل برق',
    isOwner: true,
    isActive: true,
    dailySpendingLimitMinor: wallet?.dailySpendingLimitMinor,
    monthlySpendingLimitMinor: wallet?.monthlySpendingLimitMinor,
  );
});

final agentDashboardSummaryProvider =
    FutureProvider<AgentDashboardSummary>((ref) async {
  final repo = ref.watch(commissionLogsRepositoryProvider);
  final now = DateTime.now();
  final dayStart = DateTime(now.year, now.month, now.day);
  final monthStart = DateTime(now.year, now.month);
  final nextDay = dayStart.add(const Duration(days: 1));
  final nextMonth = DateTime(now.year, now.month + 1);

  final dailySales = await repo.totalSalesForRange(dayStart, nextDay);
  final dailyCommission =
      await repo.totalCommissionForRange(dayStart, nextDay);
  final monthlySales = await repo.totalSalesForRange(monthStart, nextMonth);
  final monthlyCommission =
      await repo.totalCommissionForRange(monthStart, nextMonth);

  return AgentDashboardSummary(
    dailySalesMinor: dailySales,
    dailyCommissionMinor: dailyCommission,
    monthlySalesMinor: monthlySales,
    monthlyCommissionMinor: monthlyCommission,
  );
});

final rechargeControllerProvider = NotifierProvider.autoDispose<
    RechargeController, RechargeUiState>(RechargeController.new);
