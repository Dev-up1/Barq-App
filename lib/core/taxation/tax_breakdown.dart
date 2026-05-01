class TaxBreakdown {
  const TaxBreakdown({
    required this.baseAmountMinor,
    required this.taxRatePercent,
    required this.taxAmountMinor,
    required this.totalAmountMinor,
  });

  final int baseAmountMinor;
  final int taxRatePercent;
  final int taxAmountMinor;
  final int totalAmountMinor;
}
