import 'package:barq_recharge/core/constants/service_catalog_seed.dart';
import 'package:barq_recharge/core/taxation/tax_classification.dart';
import 'package:barq_recharge/data/db/app_database.dart';
import 'package:drift/drift.dart';

class ServicesCatalogRepository {
  const ServicesCatalogRepository(this._database);

  final AppDatabase _database;

  Future<void> seedDefaults() async {
    for (final item in serviceCatalogSeed) {
      await upsertService(
        serviceKey: item.serviceKey.key,
        nameAr: item.nameAr,
        nameEn: item.nameEn,
        category: item.category.key,
        provider: item.provider,
        psiCode: item.defaultPsiCode,
        taxClass: item.taxClassification,
        isActive: true,
        lastUpdatedAt: DateTime.now(),
      );
    }
  }

  Future<int> upsertService({
    required String serviceKey,
    required String nameAr,
    required String nameEn,
    required String category,
    required String provider,
    required int psiCode,
    required TaxClassification taxClass,
    required bool isActive,
    DateTime? lastUpdatedAt,
  }) {
    return _database.into(_database.servicesCatalog).insertOnConflictUpdate(
          ServicesCatalogCompanion(
            serviceKey: Value(serviceKey),
            nameAr: Value(nameAr),
            nameEn: Value(nameEn),
            category: Value(category),
            provider: Value(provider),
            psiCode: Value(psiCode),
            taxClass: Value(taxClass),
            isActive: Value(isActive),
            lastUpdatedAt: Value(lastUpdatedAt),
          ),
        );
  }

  Future<ServicesCatalogData?> findByServiceKey(String value) {
    return (_database.select(_database.servicesCatalog)
          ..where((table) => table.serviceKey.equals(value)))
        .getSingleOrNull();
  }

  Future<List<ServicesCatalogData>> fetchActiveServices() {
    return (_database.select(_database.servicesCatalog)
          ..where((table) => table.isActive.equals(true)))
        .get();
  }
}
