class OfflineSmsCommand {
  const OfflineSmsCommand({
    required this.destinationNumber,
    required this.message,
  });

  final String destinationNumber;
  final String message;
}

class OfflineSmsResult {
  const OfflineSmsResult({
    required this.reference,
    required this.destinationNumber,
    required this.message,
  });

  final String reference;
  final String destinationNumber;
  final String message;
}
