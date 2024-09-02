import 'package:intl/intl.dart';

class AppUtils {
  static String currencyFormater(double amount) {
    final formatCurrency = NumberFormat.currency(locale: 'en_US', symbol: '');
    String formattedSubtotal = formatCurrency.format(amount);
    return formattedSubtotal;
  }
}
