class AppException implements Exception {
  const AppException(this.message, {this.code, this.cause});

  final String message;
  final String? code;
  final Object? cause;

  @override
  String toString() => 'AppException(code: $code, message: $message)';
}

class ConfigurationException extends AppException {
  const ConfigurationException(super.message, {super.code, super.cause});
}

class PsiResolutionException extends AppException {
  const PsiResolutionException(super.message, {super.code, super.cause});
}

class NetworkException extends AppException {
  const NetworkException(super.message, {super.code, super.cause});
}
