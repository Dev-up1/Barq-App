import 'package:barq_recharge/core/config/app_env.dart';
import 'package:barq_recharge/core/errors/app_exception.dart';
import 'package:barq_recharge/data/models/current_actor.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsappSupportService {
  const WhatsappSupportService();

  Future<Uri> buildSupportUri({
    required CurrentActor actor,
    required String transactionReference,
  }) async {
    if (!AppEnv.hasWhatsAppSupportConfig) {
      throw const ConfigurationException(
        'WhatsApp support configuration is missing.',
      );
    }

    final packageInfo = await PackageInfo.fromPlatform();
    final appVersion = packageInfo.version;

    final text = AppEnv.whatsappSupportTemplate
        .replaceAll('{app_version}', appVersion)
        .replaceAll('{user_id}', actor.id)
        .replaceAll('{transaction_reference}', transactionReference);

    return Uri.https(
      'wa.me',
      '/${AppEnv.whatsappSupportNumber}',
      {'text': text},
    );
  }

  Future<void> openSupportChat({
    required CurrentActor actor,
    required String transactionReference,
  }) async {
    final uri = await buildSupportUri(
      actor: actor,
      transactionReference: transactionReference,
    );
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
