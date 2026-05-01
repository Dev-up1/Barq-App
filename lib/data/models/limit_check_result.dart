class LimitCheckResult {
  const LimitCheckResult({
    required this.allowed,
    required this.dailySpentMinor,
    required this.monthlySpentMinor,
    this.message,
  });

  final bool allowed;
  final int dailySpentMinor;
  final int monthlySpentMinor;
  final String? message;
}
