import 'package:barq_recharge/app/app_providers.dart';
import 'package:barq_recharge/core/constants/mock_services.dart';
import 'package:barq_recharge/core/taxation/tax_classification.dart';
import 'package:barq_recharge/features/dashboard/application/dashboard_models.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectivityStatusProvider = FutureProvider<bool>((ref) async {
  final results = await ref.watch(connectivityProvider).checkConnectivity();
  return !results.contains(ConnectivityResult.none);
});

final dashboardBootstrapProvider = FutureProvider<void>((ref) async {
  await ref.watch(servicesCatalogBootstrapProvider.future);
  final walletRepository = ref.watch(localWalletRepositoryProvider);
  final currentWallet = await walletRepository.fetchCurrentWallet();
  if (currentWallet == null) {
    await walletRepository.upsertWallet(
      agentName: 'وكيل برق',
      availableBalanceMinor: 12500,
      reservedBalanceMinor: 0,
      lastSyncedAt: DateTime.now(),
    );
  }
});

final dashboardAlertProvider = FutureProvider<DashboardAlertData?>((ref) async {
  final transactions = await ref
      .watch(transactionsRepositoryProvider)
      .fetchRecentTransactions(limit: 10);

  final hasRecentInternet = transactions.any(
    (item) => item.serviceType == TaxClassification.generalSales.key,
  );

  if (hasRecentInternet) {
    return const DashboardAlertData(
      title: 'باقة الإنترنت تقترب من الانتهاء',
      actionLabel: 'اضغط للتجديد',
    );
  }

  return const DashboardAlertData(
    title: 'الرصيد جاهز لتنفيذ عمليات الشحن المحلية',
    actionLabel: 'متابعة',
  );
});

final dashboardViewDataProvider = FutureProvider<DashboardViewData>((ref) async {
  await ref.watch(dashboardBootstrapProvider.future);
  final wallet = await ref.watch(localWalletRepositoryProvider).fetchCurrentWallet();
  final alert = await ref.watch(dashboardAlertProvider.future);

  return DashboardViewData(
    walletBalanceMinor: wallet?.availableBalanceMinor ?? 0,
    telecomServices: telecomServices,
    gamingServices: gamingItems,
    alert: alert,
  );
});
