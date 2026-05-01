import 'dart:io';

import 'package:barq_recharge/core/utils/currency_formatter.dart';
import 'package:barq_recharge/data/models/agent_dashboard_summary.dart';
import 'package:barq_recharge/data/repositories/commission_logs_repository.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class CommissionExportService {
  const CommissionExportService(this._commissionLogsRepository);

  final CommissionLogsRepository _commissionLogsRepository;

  Future<File> exportMonthlyPdf({
    required String agentName,
    required DateTime month,
    required AgentDashboardSummary summary,
  }) async {
    final logs = await _commissionLogsRepository.fetchAllForMonth(month);
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return [
            pw.Text('تقرير عمولات برق'),
            pw.SizedBox(height: 8),
            pw.Text('الوكيل: $agentName'),
            pw.Text('الشهر: ${month.month}/${month.year}'),
            pw.SizedBox(height: 12),
            pw.Text(
              'إجمالي المبيعات: ${CurrencyFormatter.formatYer(summary.monthlySalesMinor)}',
            ),
            pw.Text(
              'إجمالي العمولة: ${CurrencyFormatter.formatYer(summary.monthlyCommissionMinor)}',
            ),
            pw.SizedBox(height: 16),
            pw.Table.fromTextArray(
              headers: const ['المرجع', 'الخدمة', 'الإجمالي', 'العمولة'],
              data: logs
                  .map(
                    (log) => [
                      log.transactionReference,
                      log.serviceKey,
                      CurrencyFormatter.formatYer(log.totalAmountMinor),
                      CurrencyFormatter.formatYer(log.commissionAmountMinor),
                    ],
                  )
                  .toList(),
            ),
          ];
        },
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final file = File(
      '${directory.path}/barq_commission_${month.year}_${month.month}.pdf',
    );
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
