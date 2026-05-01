import 'package:barq_recharge/core/taxation/tax_classification.dart';

enum ServiceCategory {
  mobileTelecom('mobile_telecom'),
  internet('internet'),
  gaming('gaming'),
  utilities('utilities'),
  digitalGoods('digital_goods');

  const ServiceCategory(this.key);

  final String key;
}

enum ServiceKey {
  yemenMobileBalance('yemen_mobile_balance'),
  youPackages('you_packages'),
  sabafonPrepaid('sabafon_prepaid'),
  adenNet('aden_net'),
  pubgUc('pubg_uc');

  const ServiceKey(this.key);

  final String key;

  static ServiceKey fromKey(String value) {
    return ServiceKey.values.firstWhere((item) => item.key == value);
  }
}

class ServiceCatalogSeedItem {
  const ServiceCatalogSeedItem({
    required this.serviceKey,
    required this.nameAr,
    required this.nameEn,
    required this.category,
    required this.provider,
    required this.defaultPsiCode,
    required this.taxClassification,
  });

  final ServiceKey serviceKey;
  final String nameAr;
  final String nameEn;
  final ServiceCategory category;
  final String provider;
  final int defaultPsiCode;
  final TaxClassification taxClassification;
}

const serviceCatalogSeed = <ServiceCatalogSeedItem>[
  ServiceCatalogSeedItem(
    serviceKey: ServiceKey.yemenMobileBalance,
    nameAr: 'يمن موبايل رصيد',
    nameEn: 'Yemen Mobile Balance',
    category: ServiceCategory.mobileTelecom,
    provider: 'Yemen Mobile',
    defaultPsiCode: 1,
    taxClassification: TaxClassification.mobileTelecom,
  ),
  ServiceCatalogSeedItem(
    serviceKey: ServiceKey.youPackages,
    nameAr: 'يو باقات',
    nameEn: 'YOU Packages',
    category: ServiceCategory.mobileTelecom,
    provider: 'YOU',
    defaultPsiCode: 7,
    taxClassification: TaxClassification.mobileTelecom,
  ),
  ServiceCatalogSeedItem(
    serviceKey: ServiceKey.sabafonPrepaid,
    nameAr: 'سبأفون مسبق الدفع',
    nameEn: 'Sabafon Prepaid',
    category: ServiceCategory.mobileTelecom,
    provider: 'Sabafon',
    defaultPsiCode: 14,
    taxClassification: TaxClassification.mobileTelecom,
  ),
  ServiceCatalogSeedItem(
    serviceKey: ServiceKey.adenNet,
    nameAr: 'عدن نت',
    nameEn: 'Aden Net',
    category: ServiceCategory.internet,
    provider: 'Aden Net',
    defaultPsiCode: 41,
    taxClassification: TaxClassification.generalSales,
  ),
  ServiceCatalogSeedItem(
    serviceKey: ServiceKey.pubgUc,
    nameAr: 'بوبجي UC',
    nameEn: 'PUBG UC',
    category: ServiceCategory.gaming,
    provider: 'PUBG',
    defaultPsiCode: 88,
    taxClassification: TaxClassification.generalSales,
  ),
];
