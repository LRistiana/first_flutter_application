import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String rupiah(int amount) {
    try {
      final NumberFormat currencyFormatter = NumberFormat.currency(
        locale: 'id_ID',
        symbol: 'Rp ',
        decimalDigits: 0,
      );
      return currencyFormatter.format(amount);
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return 'Rp 0';
    }
  }
}
