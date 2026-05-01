import 'package:barq_recharge/core/constants/service_catalog_seed.dart';

class CommissionService {
  const CommissionService();

  int calculateCommissionMinor({
    required ServiceKey serviceKey,
    required int totalAmountMinor,
  }) {
    switch (serviceKey) {
      case ServiceKey.yemenMobileBalance:
      case ServiceKey.youPackages:
      case ServiceKey.sabafonPrepaid:
        return ((totalAmountMinor * 3) / 100).round();
      case ServiceKey.adenNet:
        return ((totalAmountMinor * 4) / 100).round();
      case ServiceKey.pubgUc:
        return ((totalAmountMinor * 5) / 100).round();
    }
  }
}
