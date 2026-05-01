import 'package:barq_recharge/core/constants/service_catalog_seed.dart';
import 'package:barq_recharge/core/taxation/tax_breakdown.dart';
import 'package:barq_recharge/data/models/recharge_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('serializes recharge payload using resolved PSI and totals', () {
    const input = ExecuteRechargeInput(
      serviceKey: ServiceKey.youPackages,
      targetIdentifier: '777777777',
      baseAmountMinor: 1000,
      psiCode: 7,
      localReference: 'ref-001',
      taxBreakdown: TaxBreakdown(
        baseAmountMinor: 1000,
        taxRatePercent: 10,
        taxAmountMinor: 100,
        totalAmountMinor: 1100,
      ),
    );

    final payload = RechargePayloadDto(
      reference: input.localReference,
      targetIdentifier: input.targetIdentifier,
      psiCode: input.psiCode,
      baseAmountMinor: input.baseAmountMinor,
      taxAmountMinor: input.taxBreakdown.taxAmountMinor,
      totalAmountMinor: input.taxBreakdown.totalAmountMinor,
    );

    expect(payload.toJson()['psi_code'], 7);
    expect(payload.toJson()['tax_amount_minor'], 100);
    expect(payload.toJson()['total_amount_minor'], 1100);
  });
}
