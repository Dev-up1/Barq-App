import 'package:barq_recharge/core/constants/service_catalog_seed.dart';
import 'package:barq_recharge/data/services/commission_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const service = CommissionService();

  group('CommissionService', () {
    test('applies 3 percent for telecom services', () {
      final amount = service.calculateCommissionMinor(
        serviceKey: ServiceKey.yemenMobileBalance,
        totalAmountMinor: 10000,
      );

      expect(amount, 300);
    });

    test('applies 4 percent for aden net', () {
      final amount = service.calculateCommissionMinor(
        serviceKey: ServiceKey.adenNet,
        totalAmountMinor: 10000,
      );

      expect(amount, 400);
    });

    test('applies 5 percent for pubg uc', () {
      final amount = service.calculateCommissionMinor(
        serviceKey: ServiceKey.pubgUc,
        totalAmountMinor: 10000,
      );

      expect(amount, 500);
    });
  });
}
