import 'package:barq_recharge/core/taxation/tax_breakdown.dart';
import 'package:barq_recharge/core/taxation/tax_classification.dart';

class TaxService {
  const TaxService();

  TaxBreakdown calculate({
    required int baseAmountMinor,
    required TaxClassification taxClass,
  }) {
    final taxAmountMinor =
        ((baseAmountMinor * taxClass.ratePercent) / 100).round();

    return TaxBreakdown(
      baseAmountMinor: baseAmountMinor,
      taxRatePercent: taxClass.ratePercent,
      taxAmountMinor: taxAmountMinor,
      totalAmountMinor: baseAmountMinor + taxAmountMinor,
    );
  }
}
