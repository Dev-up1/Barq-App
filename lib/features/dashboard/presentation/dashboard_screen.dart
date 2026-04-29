import 'package:barq_recharge/app/app_providers.dart';
import 'package:barq_recharge/core/constants/app_strings.dart';
import 'package:barq_recharge/core/constants/mock_services.dart';
import 'package:barq_recharge/shared/theme/app_colors.dart';
import 'package:barq_recharge/shared/widgets/glass_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeHomeTab = ref.watch(homeTabProvider);

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0x1410B981),
              AppColors.background,
              Color(0x14A5D6F3),
            ],
          ),
        ),
        child: SafeArea(
          child: IndexedStack(
            index: _indexForTab(activeHomeTab),
            children: const [
              _HomeDashboardView(),
              _PlaceholderView(
                title: 'السجل',
                subtitle: 'سيتم ربط العمليات وقاعدة البيانات المحلية في الخطوة التالية.',
                icon: Icons.history_rounded,
              ),
              _PlaceholderView(
                title: 'الإحصائيات',
                subtitle: 'هنا ستظهر ملخصات المبيعات والضرائب وحالة رصيد الوكيل.',
                icon: Icons.trending_up_rounded,
              ),
              _PlaceholderView(
                title: 'الإعدادات',
                subtitle: 'إدارة Supabase، وضع الاتصال، وإعدادات الوكيل ستوضع هنا.',
                icon: Icons.settings_rounded,
              ),
            ],
          ),
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
}

class _HomeDashboardView extends ConsumerWidget {
  const _HomeDashboardView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serviceTab = ref.watch(serviceTabProvider);
    final isOffline = ref.watch(isOfflineModeProvider);
    final supabaseReady = ref.watch(supabaseReadyProvider);
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 120),
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('مرحباً بك', style: theme.textTheme.headlineMedium),
                  const SizedBox(height: 4),
                  Text(
                    AppStrings.agentSubtitle,
                    style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.muted),
                  ),
                ],
              ),
            ),
            _StatusIcon(
              icon: isOffline ? Icons.wifi_off_rounded : Icons.wifi_rounded,
              background: isOffline ? const Color(0x14EF4444) : const Color(0x1410B981),
              foreground: isOffline ? AppColors.danger : AppColors.primary,
            ),
            const SizedBox(width: 12),
            const _StatusIcon(
              icon: Icons.notifications_none_rounded,
              background: Color(0x1FA5D6F3),
              foreground: AppColors.foreground,
            ),
          ],
        ),
        const SizedBox(height: 20),
        if (!supabaseReady)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: GlassCard(
              borderRadius: 22,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.cloud_off_rounded, color: AppColors.danger),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Supabase غير مفعّل بعد. أضف قيم الربط عبر dart-define قبل تشغيل التطبيق.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.foreground,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (isOffline)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: GlassCard(
              borderRadius: 22,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.sms_rounded, color: AppColors.danger),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('وضع الرسائل النصية نشط', style: theme.textTheme.titleMedium),
                        const SizedBox(height: 2),
                        Text(
                          'سيتم تحويل عمليات الشحن المدعومة إلى SMS عند انقطاع الإنترنت.',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [AppColors.primary, Color(0xCC10B981)],
            ),
            borderRadius: BorderRadius.circular(32),
            boxShadow: const [
              BoxShadow(
                color: Color(0x3310B981),
                blurRadius: 28,
                offset: Offset(0, 18),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'رصيد الوكيل',
                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 10),
              Text(
                '12,500 ${AppStrings.currencyCode}',
                style: theme.textTheme.headlineLarge?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 6),
              Text(
                'جاهز لعمليات الشحن والدفع المحلي',
                style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
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
                  activeColors: const [AppColors.primary, Color(0xCC10B981)],
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _SegmentButton(
                  title: 'الألعاب والاشتراكات',
                  isActive: serviceTab == ServiceTab.gaming,
                  onTap: () =>
                      ref.read(serviceTabProvider.notifier).state = ServiceTab.gaming,
                  activeColors: const [Color(0xFF8B5CF6), Color(0xCC8B5CF6)],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        if (serviceTab == ServiceTab.services) ...[
          Text('اختر الخدمة', style: theme.textTheme.titleLarge),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: telecomServices.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.76,
            ),
            itemBuilder: (context, index) {
              final item = telecomServices[index];
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
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.foreground,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ] else ...[
          Text('الألعاب والبطاقات الرقمية', style: theme.textTheme.titleLarge),
          const SizedBox(height: 6),
          Text(
            'واجهة أولية مستندة إلى تصميم Figma المصدّر محلياً.',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: gamingItems.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 0.9,
            ),
            itemBuilder: (context, index) {
              final item = gamingItems[index];
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
                      Text(item.name, style: theme.textTheme.titleMedium),
                      const SizedBox(height: 4),
                      Text(item.subtitle, style: theme.textTheme.bodySmall),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ],
    );
  }

  void _showServiceSheet(BuildContext context, ServiceItem item) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        final theme = Theme.of(context);
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
                        color: item.color.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(item.icon, color: item.color),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(item.name, style: theme.textTheme.titleLarge),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text('اختر نوع العملية', style: theme.textTheme.titleMedium),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: item.subdivisions
                      .map(
                        (subdivision) => ActionChip(
                          label: Text(subdivision),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
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
        color: AppColors.glassStrong,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(0.4)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 24,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item.$2,
                    color: isActive ? AppColors.primary : AppColors.muted,
                    size: 26,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.$3,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isActive ? AppColors.primary : AppColors.muted,
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
        gradient: isActive ? LinearGradient(colors: activeColors) : null,
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
