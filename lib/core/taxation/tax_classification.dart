enum TaxClassification {
  mobileTelecom('mobile_telecom', 10),
  generalSales('general_sales', 5);

  const TaxClassification(this.key, this.ratePercent);

  final String key;
  final int ratePercent;

  static TaxClassification fromKey(String value) {
    return TaxClassification.values.firstWhere(
      (item) => item.key == value,
      orElse: () => TaxClassification.generalSales,
    );
  }
}
