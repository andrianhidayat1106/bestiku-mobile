import 'package:intl/intl.dart';

class CurrencyHelper {
  static String formatRupiah(dynamic number) {
    if (number == null) return "Rp 0";

    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0, // Ubah jadi 2 jika ingin ada ,00 di belakang
    ).format(number);
  }
}
