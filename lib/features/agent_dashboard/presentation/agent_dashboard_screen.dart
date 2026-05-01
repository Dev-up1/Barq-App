import 'package:barq_recharge/app/app_providers.dart';
import 'package:barq_recharge/core/utils/currency_formatter.dart';
import 'package:barq_recharge/features/agent_dashboard/application/agent_dashboard_providers.dart';
import 'package:barq_recharge/shared/theme/app_colors.dart';
import 'package:barq_recharge/shared/widgets/glass_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AgentDashboardScreen extends ConsumerWidget {
  const AgentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(agentDashboardSummaryProvider);
    final subAccounts = ref.watch(subAccountsListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('لوحة الوكيل')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          summary.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => const Text('تعذر تحميل الملخص المالي.'),
            data: (data) => Column(
              children: [
                _SummaryCard(
                  title: 'إجمالي مبيعات اليوم',
                  value: CurrencyFormatter.formatYer(data.dailySalesMinor),
                ),
                const SizedBox(height: 12),
                _SummaryCard(
                  title: 'صافي عمولة اليوم',
                  value: CurrencyFormatter.formatYer(data.dailyCommissionMinor),
                ),
                const SizedBox(height: 12),
                _SummaryCard(
                  title: 'إجمالي مبيعات الشهر',
                  value: CurrencyFormatter.formatYer(data.monthlySalesMinor),
                ),
                const SizedBox(height: 12),
                _SummaryCard(
                  title: 'صافي عمولة الشهر',
                  value: CurrencyFormatter.formatYer(data.monthlyCommissionMinor),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () async {
              final wallet =
                  await ref.read(localWalletRepositoryProvider).fetchCurrentWallet();
              final data = await ref.read(agentDashboardSummaryProvider.future);
              await ref.read(commissionExportServiceProvider).exportMonthlyPdf(
                    agentName: wallet?.agentName ?? 'وكيل برق',
                    month: DateTime.now(),
                    summary: data,
                  );
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم إنشاء تقرير PDF الشهري بنجاح.'),
                ),
              );
            },
            icon: const Icon(Icons.picture_as_pdf_rounded),
            label: const Text('تصدير التقرير'),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Text(
                  'إدارة الحسابات الفرعية',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              IconButton(
                onPressed: () => _showCreateSubAccountDialog(context, ref),
                icon: const Icon(Icons.person_add_alt_1_rounded),
              ),
            ],
          ),
          const SizedBox(height: 12),
          subAccounts.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => const Text('تعذر تحميل الحسابات الفرعية.'),
            data: (items) {
              if (items.isEmpty) {
                return const GlassCard(
                  child: Text('لا توجد حسابات فرعية مضافة حتى الآن.'),
                );
              }

              return Column(
                children: items
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: GlassCard(
                          borderRadius: 24,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.displayName,
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'الحد اليومي: ${CurrencyFormatter.formatYer(item.dailySpendingLimitMinor)}',
                                    ),
                                    Text(
                                      'الحد الشهري: ${CurrencyFormatter.formatYer(item.monthlySpendingLimitMinor)}',
                                    ),
                                  ],
                                ),
                              ),
                              Switch(
                                value: item.isActive,
                                onChanged: (value) async {
                                  await ref
                                      .read(subAccountsRepositoryProvider)
                                      .updateSubAccount(
                                        id: item.id,
                                        isActive: value,
                                      );
                                  ref.invalidate(subAccountsListProvider);
                                },
                              ),
                              IconButton(
                                onPressed: () async {
                                  await ref
                                      .read(subAccountsRepositoryProvider)
                                      .removeSubAccount(item.id);
                                  ref.invalidate(subAccountsListProvider);
                                },
                                icon: const Icon(
                                  Icons.delete_outline_rounded,
                                  color: AppColors.danger,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showCreateSubAccountDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final nameController = TextEditingController();
    final pinController = TextEditingController();
    final dailyController = TextEditingController(text: '50000');
    final monthlyController = TextEditingController(text: '500000');

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('إضافة حساب فرعي'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'اسم الموظف'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: pinController,
                  decoration: const InputDecoration(labelText: 'رمز PIN'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: dailyController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'الحد اليومي'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: monthlyController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'الحد الشهري'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('إلغاء'),
            ),
            FilledButton(
              onPressed: () async {
                await ref.read(subAccountsRepositoryProvider).createSubAccount(
                      displayName: nameController.text.trim(),
                      pinCode: pinController.text.trim(),
                      dailySpendingLimitMinor:
                          int.tryParse(dailyController.text.trim()) ?? 50000,
                      monthlySpendingLimitMinor:
                          int.tryParse(monthlyController.text.trim()) ?? 500000,
                    );
                ref.invalidate(subAccountsListProvider);
                if (context.mounted) Navigator.of(context).pop();
              },
              child: const Text('حفظ'),
            ),
          ],
        );
      },
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: 24,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 8),
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.success,
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
