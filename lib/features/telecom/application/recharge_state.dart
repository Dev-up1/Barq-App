import 'package:barq_recharge/core/constants/service_catalog_seed.dart';
import 'package:barq_recharge/core/taxation/tax_breakdown.dart';

enum RechargeSubmissionStatus {
  idle,
  ready,
  processing,
  success,
  offlineQueued,
  failure,
}

class RechargeUiState {
  const RechargeUiState({
    this.selectedServiceKey,
    this.providerLabel,
    this.subdivision,
    this.targetIdentifier = '',
    this.baseAmountInput = '',
    this.taxBreakdown,
    this.status = RechargeSubmissionStatus.idle,
    this.feedbackMessage,
    this.lastTransactionReference,
  });

  final ServiceKey? selectedServiceKey;
  final String? providerLabel;
  final String? subdivision;
  final String targetIdentifier;
  final String baseAmountInput;
  final TaxBreakdown? taxBreakdown;
  final RechargeSubmissionStatus status;
  final String? feedbackMessage;
  final String? lastTransactionReference;

  bool get canSubmit =>
      selectedServiceKey != null &&
      subdivision != null &&
      targetIdentifier.trim().isNotEmpty &&
      taxBreakdown != null &&
      status != RechargeSubmissionStatus.processing;

  RechargeUiState copyWith({
    ServiceKey? selectedServiceKey,
    String? providerLabel,
    String? subdivision,
    String? targetIdentifier,
    String? baseAmountInput,
    TaxBreakdown? taxBreakdown,
    RechargeSubmissionStatus? status,
    String? feedbackMessage,
    String? lastTransactionReference,
    bool clearFeedback = false,
  }) {
    return RechargeUiState(
      selectedServiceKey: selectedServiceKey ?? this.selectedServiceKey,
      providerLabel: providerLabel ?? this.providerLabel,
      subdivision: subdivision ?? this.subdivision,
      targetIdentifier: targetIdentifier ?? this.targetIdentifier,
      baseAmountInput: baseAmountInput ?? this.baseAmountInput,
      taxBreakdown: taxBreakdown ?? this.taxBreakdown,
      status: status ?? this.status,
      feedbackMessage:
          clearFeedback ? null : feedbackMessage ?? this.feedbackMessage,
      lastTransactionReference:
          lastTransactionReference ?? this.lastTransactionReference,
    );
  }
}
