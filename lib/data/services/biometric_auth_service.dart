import 'package:local_auth/local_auth.dart';

class BiometricAuthResult {
  const BiometricAuthResult({
    required this.success,
    required this.message,
  });

  final bool success;
  final String message;
}

class BiometricAuthService {
  BiometricAuthService({LocalAuthentication? localAuthentication})
      : _localAuthentication = localAuthentication ?? LocalAuthentication();

  final LocalAuthentication _localAuthentication;

  Future<bool> canCheckBiometrics() async {
    final canCheck = await _localAuthentication.canCheckBiometrics;
    final supported = await _localAuthentication.isDeviceSupported();
    return canCheck && supported;
  }

  Future<BiometricAuthResult> authenticateForRecharge() async {
    final canCheck = await canCheckBiometrics();
    if (!canCheck) {
      return const BiometricAuthResult(
        success: false,
        message: 'المصادقة البيومترية غير متاحة أو غير مفعلة على هذا الجهاز.',
      );
    }

    final authenticated = await _localAuthentication.authenticate(
      localizedReason: 'أكد هويتك البيومترية قبل تنفيذ عملية الشحن',
      options: const AuthenticationOptions(
        biometricOnly: true,
        stickyAuth: true,
      ),
    );

    if (!authenticated) {
      return const BiometricAuthResult(
        success: false,
        message: 'تم إلغاء أو رفض المصادقة البيومترية.',
      );
    }

    return const BiometricAuthResult(
      success: true,
      message: 'تم التحقق البيومتري بنجاح.',
    );
  }
}
