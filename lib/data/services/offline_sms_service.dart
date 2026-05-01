import 'package:barq_recharge/core/config/app_env.dart';
import 'package:barq_recharge/core/errors/app_exception.dart';
import 'package:barq_recharge/data/models/offline_sms_models.dart';
import 'package:barq_recharge/data/models/recharge_models.dart';
import 'package:barq_recharge/data/repositories/pending_sms_queue_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class OfflineSmsService {
  const OfflineSmsService(this._queueRepository);

  final PendingSmsQueueRepository _queueRepository;

  OfflineSmsCommand buildSmsCommand(ExecuteRechargeInput input) {
    if (!AppEnv.hasSmsFallbackConfig) {
      throw const ConfigurationException(
        'SMS fallback configuration is missing.',
      );
    }

    final template = AppEnv.aggregatorSmsTemplate
        .replaceAll('{reference}', input.localReference)
        .replaceAll('{psi_code}', input.psiCode.toString())
        .replaceAll('{target}', input.targetIdentifier)
        .replaceAll('{base_amount}', input.baseAmountMinor.toString())
        .replaceAll('{tax_amount}', input.taxBreakdown.taxAmountMinor.toString())
        .replaceAll(
          '{total_amount}',
          input.taxBreakdown.totalAmountMinor.toString(),
        );

    return OfflineSmsCommand(
      destinationNumber: AppEnv.aggregatorSmsNumber,
      message: template,
    );
  }

  Future<OfflineSmsResult> queueAndLaunch(ExecuteRechargeInput input) async {
    final command = buildSmsCommand(input);

    await _queueRepository.enqueue(
      reference: input.localReference,
      serviceKey: input.serviceKey.key,
      destinationNumber: command.destinationNumber,
      smsBody: command.message,
      status: 'pending',
    );

    final uri = Uri(
      scheme: 'sms',
      path: command.destinationNumber,
      queryParameters: <String, String>{'body': command.message},
    );

    await launchUrl(uri);

    await _queueRepository.updateStatus(
      reference: input.localReference,
      status: 'intent_opened',
      processedAt: DateTime.now(),
    );

    return OfflineSmsResult(
      reference: input.localReference,
      destinationNumber: command.destinationNumber,
      message: command.message,
    );
  }
}
