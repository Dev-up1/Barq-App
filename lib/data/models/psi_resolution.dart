import 'package:barq_recharge/core/constants/service_catalog_seed.dart';

class PsiResolution {
  const PsiResolution({
    required this.serviceKey,
    required this.psiCode,
    required this.source,
  });

  final ServiceKey serviceKey;
  final int psiCode;
  final String source;
}
