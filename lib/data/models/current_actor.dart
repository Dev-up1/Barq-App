class CurrentActor {
  const CurrentActor({
    required this.id,
    required this.displayName,
    required this.isOwner,
    required this.isActive,
    this.dailySpendingLimitMinor,
    this.monthlySpendingLimitMinor,
  });

  final String id;
  final String displayName;
  final bool isOwner;
  final bool isActive;
  final int? dailySpendingLimitMinor;
  final int? monthlySpendingLimitMinor;
}
