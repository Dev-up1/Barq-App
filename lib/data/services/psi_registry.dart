import 'package:barq_recharge/core/config/app_env.dart';
import 'package:barq_recharge/core/constants/service_catalog_seed.dart';
import 'package:barq_recharge/core/errors/app_exception.dart';
import 'package:barq_recharge/data/models/psi_resolution.dart';
import 'package:barq_recharge/data/repositories/services_catalog_repository.dart';
import 'package:dio/dio.dart';

class PsiRegistry {
  PsiRegistry({
    required ServicesCatalogRepository catalogRepository,
    Dio? dio,
  })  : _catalogRepository = catalogRepository,
        _dio = dio ?? Dio();

  final ServicesCatalogRepository _catalogRepository;
  final Dio _dio;

  Future<void> ensureSeeded() {
    return _catalogRepository.seedDefaults();
  }

  Future<PsiResolution> resolvePsi(ServiceKey serviceKey) async {
    await ensureSeeded();

    final fromCatalog =
        await _catalogRepository.findByServiceKey(serviceKey.key);
    if (fromCatalog != null) {
      return PsiResolution(
        serviceKey: serviceKey,
        psiCode: fromCatalog.psiCode,
        source: 'catalog',
      );
    }

    final seed = serviceCatalogSeed.where((item) => item.serviceKey == serviceKey);
    if (seed.isNotEmpty) {
      return PsiResolution(
        serviceKey: serviceKey,
        psiCode: seed.first.defaultPsiCode,
        source: 'local_default',
      );
    }

    throw const PsiResolutionException(
      'Unable to resolve PSI code for service key.',
      code: 'psi_not_found',
    );
  }

  Future<void> refreshOverrides() async {
    if (!AppEnv.hasPsiOverrideUrl) {
      return;
    }

    final response = await _dio.get<List<dynamic>>(AppEnv.psiOverrideUrl);
    final data = response.data ?? <dynamic>[];

    for (final rawItem in data) {
      if (rawItem is! Map<String, dynamic>) {
        continue;
      }

      final serviceKeyValue = rawItem['service_key'] as String?;
      final psiCode = rawItem['psi_code'] as int?;
      if (serviceKeyValue == null || psiCode == null) {
        continue;
      }

      final seed = serviceCatalogSeed.where(
        (item) => item.serviceKey.key == serviceKeyValue,
      );
      if (seed.isEmpty) {
        continue;
      }

      final item = seed.first;
      await _catalogRepository.upsertService(
        serviceKey: item.serviceKey.key,
        nameAr: item.nameAr,
        nameEn: item.nameEn,
        category: item.category.key,
        provider: item.provider,
        psiCode: psiCode,
        taxClass: item.taxClassification,
        isActive: true,
        lastUpdatedAt: DateTime.now(),
      );
    }
  }
}
