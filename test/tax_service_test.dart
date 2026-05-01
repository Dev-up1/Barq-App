import 'package:barq_recharge/core/taxation/tax_classification.dart';
import 'package:barq_recharge/core/taxation/tax_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const service = TaxService();

  group('TaxService', () {
    test('calculates 10 percent telecom tax', () {
      final result = service.calculate(
        baseAmountMinor: 1000,
        taxClass: TaxClassification.mobileTelecom,
      );

      expect(result.taxRatePercent, 10);
      expect(result.taxAmountMinor, 100);
      expect(result.totalAmountMinor, 1100);
    });

    test('calculates 5 percent general sales tax', () {
      final result = service.calculate(
        baseAmountMinor: 1000,
        taxClass: TaxClassification.generalSales,
      );

      expect(result.taxRatePercent, 5);
      expect(result.taxAmountMinor, 50);
      expect(result.totalAmountMinor, 1050);
    });
  });
}
