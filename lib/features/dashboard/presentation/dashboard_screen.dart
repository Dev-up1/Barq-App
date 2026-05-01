import 'package:barq_recharge/app/app_providers.dart';
import 'package:barq_recharge/core/config/app_env.dart';
import 'package:barq_recharge/core/constants/app_strings.dart';
import 'package:barq_recharge/core/constants/mock_services.dart';
import 'package:barq_recharge/core/constants/service_catalog_seed.dart';
import 'package:barq_recharge/core/utils/currency_formatter.dart';
import 'package:barq_recharge/data/models/current_actor.dart';
import 'package:barq_recharge/features/agent_dashboard/presentation/agent_dashboard_screen.dart';
import 'package:barq_recharge/features/dashboard/application/dashboard_models.dart';
import 'package:barq_recharge/features/dashboard/application/dashboard_providers.dart';
import 'package:barq_recharge/features/telecom/application/recharge_state.dart';
import 'package:barq_recharge/shared/theme/app_colors.dart';
import 'package:barq_recharge/shared/widgets/glass_card.dart';
import 'package:barq_recharge/shared/widgets/swipe_to_pay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    ref.listen<RechargeUiState>(rechargeControllerProvider, (previous, next) {
      final message = next.feedbackMessage;
      if (message == null || message.isEmpty) return;
      _showRechargeFeedback(next);
      if (next.status == RechargeSubmissionStatus.success ||
          next.status == RechargeSubmissionStatus.offlineQueued) {
        Navigator.of(context, rootNavigator: true).maybePop();
      }
      ref.read(rechargeControllerProvider.notifier).clearFeedback();
    });

    final activeHomeTab = ref.watch(homeTabProvider);
    final dashboardData = ref.watch(dashboardViewDataProvider);
    final connectivityState = ref.watch(connectivityStatusProvider);
    final supportReady = ref.watch(whatsappSupportConfigReadyProvider);

    connectivityState.whenData((isOnline) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(isOfflineModeProvider.notifier).state = !isOnline;
      });
    });

    return Scaffold(
      floatingActionButton: supportReady
          ? FloatingActionButton.extended(
              onPressed: _openGeneralSupportChat,
              backgroundColor: AppColors.foreground,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.support_agent_rounded),
              label: const Text('الدعم'),
            )
          : null,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.background,
        ),
        child: Stack(
          children: [
            const _BackdropGlow(
              top: -30,
              right: -24,
              size: 220,
              color: Color(0x2E8ECBF6),
            ),
            const _BackdropGlow(
              top: 180,
              left: -42,
              size: 190,
              color: Color(0x2619A76F),
            ),
            const _BackdropGlow(
              bottom: 110,
              right: 20,
              size: 160,
              color: Color(0x1494A3B8),
            ),
            SafeArea(
              child: IndexedStack(
                index: _indexForTab(activeHomeTab),
                children: [
                  _HomeDashboardView(
                    dashboardData: dashboardData,
                    connectivityState: connectivityState,
                  ),
                  const _HistoryView(),
                  const _PlaceholderView(
                    title: 'الإحصائيات',
                    subtitle:
                        'ستظهر هنا مؤشرات الشحن والضرائب والاستهلاك المحلي بصورة أوضح في التحديثات التالية.',
                    icon: Icons.trending_up_rounded,
                  ),
                  const _SupportAndAgentView(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const _BottomNavBar(),
    );
  }

  int _indexForTab(String tab) {
    switch (tab) {
      case 'history':
        return 1;
      case 'insights':
        return 2;
      case 'settings':
        return 3;
      default:
        return 0;
    }
  }

  void _showRechargeFeedback(RechargeUiState next) {
    final reference = next.lastTransactionReference;
    final canContactSupport = next.status == RechargeSubmissionStatus.failure &&
        reference != null &&
        reference.isNotEmpty &&
        ref.read(whatsappSupportConfigReadyProvider);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(next.feedbackMessage!),
          action: canContactSupport
              ? SnackBarAction(
                  label: 'تواصل مع الدعم',
                  onPressed: () => _openSupportChatForReference(reference!),
                )
              : null,
        ),
      );
  }

  Future<void> _openGeneralSupportChat() async {
    await _openSupportChatForReference('GENERAL-SUPPORT');
  }

  Future<void> _openSupportChatForReference(String transactionReference) async {
    try {
      final actor = await ref.read(currentActorProvider.future);
      await ref.read(whatsappSupportServiceProvider).openSupportChat(
            actor: actor,
            transactionReference: transactionReference,
          );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تعذر فتح واتساب. تأكد من إعداد رقم الدعم على الجهاز.'),
        ),
      );
    }
  }
}

class _HomeDashboardView extends ConsumerWidget {
  const _HomeDashboardView({
    required this.dashboardData,
    required this.connectivityState,
  });

  final AsyncValue<DashboardViewData> dashboardData;
  final AsyncValue<bool> connectivityState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serviceTab = ref.watch(serviceTabProvider);
    final isOffline = ref.watch(isOfflineModeProvider);
    final aggregatorReady = ref.watch(aggregatorConfigReadyProvider);

    return dashboardData.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'تعذر تحميل البيانات المحلية.',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
      data: (data) => ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 120),
        children: [
          _HeaderSection(isOffline: isOffline),
          const SizedBox(height: 18),
          if (!aggregatorReady)
            const _InfoBanner(
              icon: Icons.cloud_off_rounded,
              message:
                  'إعدادات مزود الخدمة غير مكتملة. أضف عنوان API والتوكن قبل البناء المحلي.',
              color: AppColors.danger,
            ),
          if (isOffline)
            _InfoBanner(
              icon: Icons.sms_rounded,
              message:
                  'وضع عدم الاتصال نشط. سيتم توجيه العملية إلى رسالة SMS على الرقم ${AppEnv.aggregatorSmsNumber.isEmpty ? 'غير المعرّف بعد' : AppEnv.aggregatorSmsNumber}.',
              color: AppColors.offline,
            ),
          _WalletCard(balanceMinor: data.walletBalanceMinor),
          const SizedBox(height: 16),
          if (data.alert != null) _AiAlertBanner(alert: data.alert!),
          const SizedBox(height: 16),
          GlassCard(
            padding: const EdgeInsets.all(6),
            borderRadius: 24,
            child: Row(
              children: [
                Expanded(
                  child: _SegmentButton(
                    title: 'الخدمات والشحن',
                    isActive: serviceTab == ServiceTab.services,
                    onTap: () => ref.read(serviceTabProvider.notifier).state =
                        ServiceTab.services,
                    activeColors: const [AppColors.primary, AppColors.success],
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: _SegmentButton(
                    title: 'الألعاب والاشتراكات',
                    isActive: serviceTab == ServiceTab.gaming,
                    onTap: () => ref.read(serviceTabProvider.notifier).state =
                        ServiceTab.gaming,
                    activeColors: const [
                      Color(0xFF8B5CF6),
                      AppColors.secondary
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          if (serviceTab == ServiceTab.services)
            _TelecomGrid(services: data.telecomServices)
          else
            _GamingGrid(games: data.gamingServices),
        ],
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection({required this.isOffline});

  final bool isOffline;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(isOffline ? 0.82 : 0.64),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isOffline
              ? AppColors.offline.withOpacity(0.18)
              : AppColors.highlight.withOpacity(0.9),
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 24,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('مرحباً بك', style: theme.textTheme.headlineMedium),
                const SizedBox(height: 4),
                Text(
                  AppStrings.agentSubtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.muted,
                  ),
                ),
              ],
            ),
          ),
          _StatusIcon(
            icon: isOffline ? Icons.wifi_off_rounded : Icons.wifi_rounded,
            background: isOffline
                ? AppColors.offline.withOpacity(0.12)
                : AppColors.primary.withOpacity(0.12),
            foreground: isOffline ? AppColors.offline : AppColors.primary,
          ),
          const SizedBox(width: 12),
          const _StatusIcon(
            icon: Icons.notifications_none_rounded,
            background: Color(0x1FA5D6F3),
            foreground: AppColors.foreground,
          ),
        ],
      ),
    );
  }
}

class _InfoBanner extends StatelessWidget {
  const _InfoBanner({
    required this.icon,
    required this.message,
    required this.color,
  });

  final IconData icon;
  final String message;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: GlassCard(
        borderRadius: 22,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.foreground,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WalletCard extends StatelessWidget {
  const _WalletCard({required this.balanceMinor});

  final int balanceMinor;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: 32,
      padding: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.darkBackground, AppColors.darkCard],
          ),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: Colors.white.withOpacity(0.08)),
                  ),
                  child: Text(
                    'Live balance',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                ),
                const Spacer(),
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'رصيد الوكيل',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              CurrencyFormatter.formatYer(balanceMinor),
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              'جاهز لعمليات الشحن والدفع المحلي',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AiAlertBanner extends StatelessWidget {
  const _AiAlertBanner({required this.alert});

  final DashboardAlertData alert;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: 24,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.auto_awesome_rounded,
                color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(alert.title,
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 2),
                Text(
                  alert.actionLabel,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.secondaryDeep,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TelecomGrid extends StatelessWidget {
  const _TelecomGrid({required this.services});

  final List<ServiceItem> services;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('اختر الخدمة', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: services.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.76,
          ),
          itemBuilder: (context, index) {
            final item = services[index];
            return GlassCard(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
              borderRadius: 24,
              child: InkWell(
                onTap: () => _showServiceSheet(context, item),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: item.color.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(item.icon, color: item.color, size: 26),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item.name,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.foreground,
                          ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _showServiceSheet(BuildContext context, ServiceItem item) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _ServiceSelectionSheet(service: item),
    );
  }
}

class _GamingGrid extends StatelessWidget {
  const _GamingGrid({required this.games});

  final List<GamingItem> games;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الألعاب والاشتراكات',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 6),
        Text(
          'واجهة الألعاب جاهزة بصرياً وسيتم ربط تدفق الشراء الخاص بها تدريجياً.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: games.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            final item = games[index];
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    item.colors.first.withOpacity(0.22),
                    item.colors.last.withOpacity(0.38),
                  ],
                ),
              ),
              child: GlassCard(
                borderRadius: 28,
                padding: const EdgeInsets.all(18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(item.icon, style: const TextStyle(fontSize: 42)),
                    const SizedBox(height: 14),
                    Text(item.name,
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(item.subtitle,
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _ServiceSelectionSheet extends ConsumerWidget {
  const _ServiceSelectionSheet({required this.service});

  final ServiceItem service;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GlassCard(
        borderRadius: 28,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: service.color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(service.icon, color: service.color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    service.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              'اختر نوع العملية',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: service.subdivisions
                  .map(
                    (subdivision) => ActionChip(
                      label: Text(subdivision),
                      onPressed: () {
                        final serviceKey =
                            _serviceKeyFor(service.id, subdivision);
                        ref
                            .read(rechargeControllerProvider.notifier)
                            .selectService(
                              serviceKey: serviceKey,
                              providerLabel: service.name,
                              subdivision: subdivision,
                            );
                        Navigator.of(context).pop();
                        showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) => const _RechargeCheckoutSheet(),
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  ServiceKey _serviceKeyFor(String serviceId, String subdivision) {
    if (serviceId == 'yemen-mobile') return ServiceKey.yemenMobileBalance;
    if (serviceId == 'you') return ServiceKey.youPackages;
    if (serviceId == 'sabafon') return ServiceKey.sabafonPrepaid;
    if (serviceId == 'aden-net') return ServiceKey.adenNet;
    return subdivision.contains('باقات')
        ? ServiceKey.youPackages
        : ServiceKey.adenNet;
  }
}

class _RechargeCheckoutSheet extends ConsumerStatefulWidget {
  const _RechargeCheckoutSheet();

  @override
  ConsumerState<_RechargeCheckoutSheet> createState() =>
      _RechargeCheckoutSheetState();
}

class _RechargeCheckoutSheetState
    extends ConsumerState<_RechargeCheckoutSheet> {
  late final TextEditingController _targetController;
  late final TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _targetController = TextEditingController();
    _amountController = TextEditingController();
  }

  @override
  void dispose() {
    _targetController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(rechargeControllerProvider);
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: GlassCard(
        borderRadius: 30,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                state.providerLabel ?? 'إتمام عملية الشحن',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 4),
              Text(state.subdivision ?? '', style: theme.textTheme.bodySmall),
              const SizedBox(height: 18),
              TextField(
                controller: _targetController,
                keyboardType: TextInputType.phone,
                onChanged: ref
                    .read(rechargeControllerProvider.notifier)
                    .updateTargetIdentifier,
                decoration: const InputDecoration(
                  labelText: 'رقم الهاتف أو الحساب',
                  hintText: 'أدخل الرقم المستهدف',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                onChanged: ref
                    .read(rechargeControllerProvider.notifier)
                    .updateBaseAmount,
                decoration: const InputDecoration(
                  labelText: 'المبلغ الأساسي',
                  hintText: 'مثال: 1000',
                ),
              ),
              const SizedBox(height: 18),
              _TaxBreakdownCard(state: state),
              const SizedBox(height: 18),
              SwipeToPay(
                label: 'اسحب للدفع',
                enabled: state.canSubmit,
                processing: state.status == RechargeSubmissionStatus.processing,
                onCompleted: () {
                  ref.read(rechargeControllerProvider.notifier).submit();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TaxBreakdownCard extends StatelessWidget {
  const _TaxBreakdownCard({required this.state});

  final RechargeUiState state;

  @override
  Widget build(BuildContext context) {
    final breakdown = state.taxBreakdown;
    return GlassCard(
      borderRadius: 24,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ملخص العملية', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          _BreakdownRow(
            label: 'المبلغ الأساسي',
            value: breakdown == null
                ? '--'
                : CurrencyFormatter.formatYer(breakdown.baseAmountMinor),
          ),
          const SizedBox(height: 8),
          _BreakdownRow(
            label: 'الضريبة',
            value: breakdown == null
                ? '--'
                : '${breakdown.taxRatePercent}% - ${CurrencyFormatter.formatYer(breakdown.taxAmountMinor)}',
          ),
          const Divider(height: 24),
          _BreakdownRow(
            label: 'الإجمالي النهائي',
            value: breakdown == null
                ? '--'
                : CurrencyFormatter.formatYer(breakdown.totalAmountMinor),
            highlight: true,
          ),
        ],
      ),
    );
  }
}

class _BreakdownRow extends StatelessWidget {
  const _BreakdownRow({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  final String label;
  final String value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final style = highlight
        ? Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.success,
            )
        : Theme.of(context).textTheme.bodyMedium;

    return Row(
      children: [
        Expanded(child: Text(label, style: style)),
        Text(value, style: style),
      ],
    );
  }
}

class _HistoryView extends ConsumerWidget {
  const _HistoryView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<dynamic>>(
      future:
          ref.watch(transactionsRepositoryProvider).fetchRecentTransactions(),
      builder: (context, snapshot) {
        final items = snapshot.data ?? <dynamic>[];
        if (items.isEmpty) {
          return const _PlaceholderView(
            title: 'السجل',
            subtitle: 'لم يتم تنفيذ عمليات بعد.',
            icon: Icons.receipt_long_rounded,
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(20),
          itemBuilder: (context, index) {
            final item = items[index];
            return GlassCard(
              borderRadius: 22,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.reference,
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 6),
                  Text(item.targetIdentifier),
                  const SizedBox(height: 6),
                  Text(
                    '${item.channel == 'sms_fallback' ? 'SMS' : 'API'} - ${CurrencyFormatter.formatYer(item.totalAmountMinor)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemCount: items.length,
        );
      },
    );
  }
}

class _SupportAndAgentView extends ConsumerWidget {
  const _SupportAndAgentView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supportReady = ref.watch(whatsappSupportConfigReadyProvider);
    final actor = ref.watch(currentActorProvider);
    final isOffline = ref.watch(isOfflineModeProvider);

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
      children: [
        const _SectionTitle(
          title: 'الدعم والإدارة',
          subtitle: 'مركز المساندة السريعة ولوحة تحكم الوكيل وإدارة الموظفين.',
        ),
        const SizedBox(height: 16),
        GlassCard(
          borderRadius: 28,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.support_agent_rounded,
                      color: AppColors.success,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'الدعم عبر واتساب',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                supportReady
                    ? 'افتح محادثة مباشرة مع الدعم الفني مع إمكانية تمرير رقم العملية تلقائياً عند الفشل.'
                    : 'أضف رقم دعم واتساب في إعدادات البيئة لتفعيل التواصل المباشر.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 16),
              actor.when(
                loading: () => const LinearProgressIndicator(),
                error: (_, __) => const SizedBox.shrink(),
                data: (currentActor) => Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    FilledButton.icon(
                      onPressed: supportReady
                          ? () => _openSupport(context, ref, currentActor)
                          : null,
                      icon: const Icon(Icons.chat_rounded),
                      label: const Text('محادثة الدعم'),
                    ),
                    OutlinedButton.icon(
                      onPressed: supportReady
                          ? () => _openSupport(
                                context,
                                ref,
                                currentActor,
                                reference:
                                    'HELP-${DateTime.now().millisecondsSinceEpoch}',
                              )
                          : null,
                      icon: const Icon(Icons.report_problem_rounded),
                      label: const Text('بلاغ عام'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        GlassCard(
          borderRadius: 28,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'الحالة الحالية',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              _StatusLine(
                label: 'وضع الشبكة',
                value:
                    isOffline ? 'غير متصل - سيتم استخدام SMS' : 'متصل بالخدمة',
                valueColor: isOffline ? AppColors.offline : AppColors.success,
              ),
              const SizedBox(height: 8),
              _StatusLine(
                label: 'رقم دعم واتساب',
                value: supportReady
                    ? AppEnv.whatsappSupportNumber
                    : 'غير مهيأ بعد',
                valueColor: supportReady ? AppColors.primary : AppColors.muted,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        GlassCard(
          borderRadius: 28,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'لوحة الوكيل',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              Text(
                'الوصول إلى ملخص المبيعات، صافي العمولة، إدارة الحسابات الفرعية، وتصدير تقرير العمولة الشهري.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const AgentDashboardScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.storefront_rounded),
                label: const Text('فتح لوحة الوكيل'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _openSupport(
    BuildContext context,
    WidgetRef ref,
    CurrentActor actor, {
    String reference = 'GENERAL-SUPPORT',
  }) async {
    try {
      await ref.read(whatsappSupportServiceProvider).openSupportChat(
            actor: actor,
            transactionReference: reference,
          );
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تعذر فتح واتساب حالياً.')),
      );
    }
  }
}

class _BottomNavBar extends ConsumerWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTab = ref.watch(homeTabProvider);
    final items = const [
      ('home', Icons.home_rounded, 'الرئيسية'),
      ('history', Icons.history_rounded, 'السجل'),
      ('insights', Icons.trending_up_rounded, 'الإحصائيات'),
      ('settings', Icons.settings_rounded, 'الإعدادات'),
    ];

    return Container(
      height: 90,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xEFFFFFFF),
            Color(0xCCF3F6FA),
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.highlight.withOpacity(0.85)),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 30,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          final isActive = activeTab == item.$1;
          return InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => ref.read(homeTabProvider.notifier).state = item.$1,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: isActive
                    ? Colors.white.withOpacity(0.72)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item.$2,
                    color: isActive ? AppColors.foreground : AppColors.muted,
                    size: 26,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.$3,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color:
                              isActive ? AppColors.foreground : AppColors.muted,
                        ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  const _SegmentButton({
    required this.title,
    required this.isActive,
    required this.onTap,
    required this.activeColors,
  });

  final String title;
  final bool isActive;
  final VoidCallback onTap;
  final List<Color> activeColors;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: isActive
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: activeColors,
              )
            : null,
        color: isActive ? null : Colors.white.withOpacity(0.5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isActive ? Colors.white : AppColors.muted,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BackdropGlow extends StatelessWidget {
  const _BackdropGlow({
    this.top,
    this.right,
    this.bottom,
    this.left,
    required this.size,
    required this.color,
  });

  final double? top;
  final double? right;
  final double? bottom;
  final double? left;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      bottom: bottom,
      left: left,
      child: IgnorePointer(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color,
                blurRadius: 80,
                spreadRadius: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusIcon extends StatelessWidget {
  const _StatusIcon({
    required this.icon,
    required this.background,
    required this.foreground,
  });

  final IconData icon;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, color: foreground, size: 22),
    );
  }
}

class _StatusLine extends StatelessWidget {
  const _StatusLine({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodyMedium)),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: valueColor,
                ),
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 6),
        Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

class _PlaceholderView extends StatelessWidget {
  const _PlaceholderView({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: GlassCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 44, color: AppColors.primary),
              const SizedBox(height: 16),
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
