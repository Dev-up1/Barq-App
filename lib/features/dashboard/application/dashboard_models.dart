import 'package:barq_recharge/core/constants/mock_services.dart';

class DashboardAlertData {
  const DashboardAlertData({
    required this.title,
    required this.actionLabel,
  });

  final String title;
  final String actionLabel;
}

class DashboardViewData {
  const DashboardViewData({
    required this.walletBalanceMinor,
    required this.telecomServices,
    required this.gamingServices,
    required this.alert,
  });

  final int walletBalanceMinor;
  final List<ServiceItem> telecomServices;
  final List<GamingItem> gamingServices;
  final DashboardAlertData? alert;
}
