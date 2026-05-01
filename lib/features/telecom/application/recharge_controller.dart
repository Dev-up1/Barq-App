import 'dart:math';

import 'package:barq_recharge/app/app_providers.dart';
import 'package:barq_recharge/core/constants/service_catalog_seed.dart';
import 'package:barq_recharge/core/errors/arabic_error_mapper.dart';
import 'package:barq_recharge/core/taxation/tax_classification.dart';
import 'package:barq_recharge/data/db/app_database.dart';
import 'package:barq_recharge/data/models/recharge_models.dart';
import 'package:barq_recharge/features/telecom/application/recharge_state.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RechargeController extends AutoDisposeNotifier<RechargeUiState> {
  @override
  RechargeUiState build() {
    return const RechargeUiState();
  }

  void selectService({
    required ServiceKey serviceKey,
    required String providerLabel,
    required String subdivision,
  }) {
    state = RechargeUiState(
      selectedServiceKey: serviceKey,
      providerLabel: providerLabel,
      subdivision: subdivision,
    );
  }

  void updateTargetIdentifier(String value) {
    state = state.copyWith(
      targetIdentifier: value,
      status: RechargeSubmissionStatus.idle,
      clearFeedback: true,
    );
  }

  void updateBaseAmount(String value) {
    final amount = int.tryParse(value);
    if (amount == null || amount <= 0) {
      state = state.copyWith(
        baseAmountInput: value,
        taxBreakdown: null,
        status: RechargeSubmissionStatus.idle,
        clearFeedback: true,
      );
      return;
    }

    final breakdown = ref.read(taxServiceProvider).calculate(
          baseAmountMinor: amount,
          taxClass: _resolveTaxClassification(),
        );

    state = state.copyWith(
      baseAmountInput: value,
      taxBreakdown: breakdown,
      status: RechargeSubmissionStatus.ready,
      clearFeedback: true,
    );
  }

  TaxClassification _resolveTaxClassification() {
    final serviceKey = state.selectedServiceKey;
    if (serviceKey == null) {
      return TaxClassification.generalSales;
    }

    final seed = serviceCatalogSeed.firstWhere(
      (item) => item.serviceKey == serviceKey,
      orElse: () => serviceCatalogSeed.first,
    );
    return seed.taxClassification;
  }

  Future<void> submit() async {
    if (!state.canSubmit || state.selectedServiceKey == null) {
      state = state.copyWith(
        status: RechargeSubmissionStatus.failure,
        feedbackMessage: 'أكمل البيانات المطلوبة قبل تأكيد عملية الدفع.',
      );
      return;
    }

    final baseAmount = int.tryParse(state.baseAmountInput);
    if (baseAmount == null || baseAmount <= 0 || state.taxBreakdown == null) {
      state = state.copyWith(
        status: RechargeSubmissionStatus.failure,
        feedbackMessage: 'أدخل مبلغاً صحيحاً لإتمام العملية.',
      );
      return;
    }

    final reference = _buildReference();
    state = state.copyWith(
      status: RechargeSubmissionStatus.processing,
      clearFeedback: true,
      lastTransactionReference: reference,
    );

    try {
      final biometricResult =
          await ref.read(biometricAuthServiceProvider).authenticateForRecharge();
      if (!biometricResult.success) {
        state = state.copyWith(
          status: RechargeSubmissionStatus.failure,
          feedbackMessage: biometricResult.message,
          lastTransactionReference: reference,
        );
        return;
      }

      final actor = await ref.read(currentActorProvider.future);
      if (!actor.isActive) {
        state = state.copyWith(
          status: RechargeSubmissionStatus.failure,
          feedbackMessage: 'هذا الحساب الفرعي غير مفعل حالياً.',
          lastTransactionReference: reference,
        );
        return;
      }

      final limitResult = await ref.read(spendingLimitServiceProvider).evaluateRechargeLimit(
            transactionAmountMinor: state.taxBreakdown!.totalAmountMinor,
            actor: actor,
          );
      if (!limitResult.allowed) {
        state = state.copyWith(
          status: RechargeSubmissionStatus.failure,
          feedbackMessage: limitResult.message,
          lastTransactionReference: reference,
        );
        return;
      }

      final psi = await ref
          .read(psiRegistryProvider)
          .resolvePsi(state.selectedServiceKey!);

      final input = ExecuteRechargeInput(
        serviceKey: state.selectedServiceKey!,
        targetIdentifier: state.targetIdentifier.trim(),
        baseAmountMinor: baseAmount,
        psiCode: psi.psiCode,
        taxBreakdown: state.taxBreakdown!,
        localReference: reference,
      );

      if (ref.read(isOfflineModeProvider)) {
        await ref.read(offlineSmsServiceProvider).queueAndLaunch(input);
        await ref.read(transactionsRepositoryProvider).createTransaction(
              TransactionsCompanion.insert(
                reference: reference,
                serviceKey: state.selectedServiceKey!.key,
                serviceType: _resolveTaxClassification().key,
                psiCode: psi.psiCode,
                targetIdentifier: state.targetIdentifier.trim(),
                baseAmountMinor: baseAmount,
                taxAmountMinor: state.taxBreakdown!.taxAmountMinor,
                totalAmountMinor: state.taxBreakdown!.totalAmountMinor,
                status: 'pending_sms',
                channel: 'sms_fallback',
              ),
            );
        await ref.read(commissionLogsRepositoryProvider).insertLog(
              transactionReference: reference,
              serviceKey: state.selectedServiceKey!.key,
              baseAmountMinor: baseAmount,
              totalAmountMinor: state.taxBreakdown!.totalAmountMinor,
              commissionAmountMinor: ref
                  .read(commissionServiceProvider)
                  .calculateCommissionMinor(
                    serviceKey: state.selectedServiceKey!,
                    totalAmountMinor: state.taxBreakdown!.totalAmountMinor,
                  ),
            );

        state = state.copyWith(
          status: RechargeSubmissionStatus.offlineQueued,
          feedbackMessage: 'تم تجهيز العملية في وضع الرسائل النصية.',
          lastTransactionReference: reference,
        );
        return;
      }

      await ref.read(rechargeServiceProvider).executeRecharge(input);
      await ref.read(transactionsRepositoryProvider).createTransaction(
            TransactionsCompanion.insert(
              reference: reference,
              serviceKey: state.selectedServiceKey!.key,
              serviceType: _resolveTaxClassification().key,
              psiCode: psi.psiCode,
              targetIdentifier: state.targetIdentifier.trim(),
              baseAmountMinor: baseAmount,
              taxAmountMinor: state.taxBreakdown!.taxAmountMinor,
              totalAmountMinor: state.taxBreakdown!.totalAmountMinor,
              status: 'submitted',
              channel: 'api',
              syncedAt: drift.Value(DateTime.now()),
            ),
          );
      await ref.read(commissionLogsRepositoryProvider).insertLog(
            transactionReference: reference,
            serviceKey: state.selectedServiceKey!.key,
            baseAmountMinor: baseAmount,
            totalAmountMinor: state.taxBreakdown!.totalAmountMinor,
            commissionAmountMinor: ref
                .read(commissionServiceProvider)
                .calculateCommissionMinor(
                  serviceKey: state.selectedServiceKey!,
                  totalAmountMinor: state.taxBreakdown!.totalAmountMinor,
                ),
          );

      state = state.copyWith(
        status: RechargeSubmissionStatus.success,
        feedbackMessage: 'تم إرسال عملية الشحن بنجاح.',
        lastTransactionReference: reference,
      );
    } catch (error) {
      state = state.copyWith(
        status: RechargeSubmissionStatus.failure,
        feedbackMessage: ArabicErrorMapper.map(error),
        lastTransactionReference: reference,
      );
    }
  }

  void clearFeedback() {
    state = state.copyWith(clearFeedback: true);
  }

  String _buildReference() {
    final random = Random();
    final suffix = random.nextInt(999999).toString().padLeft(6, '0');
    return 'BRQ-${DateTime.now().millisecondsSinceEpoch}-$suffix';
  }
}
