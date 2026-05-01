import 'package:intl/intl.dart';

class CurrencyFormatter {
  const CurrencyFormatter._();

  static String formatYer(int amountMinor) {
    final formatted = NumberFormat.decimalPattern('ar').format(amountMinor);
    return '$formatted ر.ي';
  }
}
