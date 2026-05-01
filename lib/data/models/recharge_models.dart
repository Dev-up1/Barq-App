import 'package:barq_recharge/core/constants/service_catalog_seed.dart';
import 'package:barq_recharge/core/taxation/tax_breakdown.dart';

class ExecuteRechargeInput {
  const ExecuteRechargeInput({
    required this.serviceKey,
    required this.targetIdentifier,
    required this.baseAmountMinor,
    required this.psiCode,
    required this.taxBreakdown,
    required this.localReference,
  });

  final ServiceKey serviceKey;
  final String targetIdentifier;
  final int baseAmountMinor;
  final int psiCode;
  final TaxBreakdown taxBreakdown;
  final String localReference;
}

class RechargePayloadDto {
  const RechargePayloadDto({
    required this.reference,
    required this.targetIdentifier,
    required this.psiCode,
    required this.baseAmountMinor,
    required this.taxAmountMinor,
    required this.totalAmountMinor,
  });

  final String reference;
  final String targetIdentifier;
  final int psiCode;
  final int baseAmountMinor;
  final int taxAmountMinor;
  final int totalAmountMinor;

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'reference': reference,
      'target_number': targetIdentifier,
      'psi_code': psiCode,
      'base_amount_minor': baseAmountMinor,
      'tax_amount_minor': taxAmountMinor,
      'total_amount_minor': totalAmountMinor,
    };
  }
}

class RechargeResult {
  const RechargeResult({
    required this.reference,
    required this.payload,
    required this.responseData,
  });

  final String reference;
  final RechargePayloadDto payload;
  final Map<String, dynamic> responseData;
}
