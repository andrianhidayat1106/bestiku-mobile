import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyFormat extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Jika input kosong
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    // Mengambil angka saja dari input
    double value = double.parse(
      newValue.text.replaceAll(RegExp(r'[^0-9]'), ''),
    );

    // Format menjadi Rupiah
    final formatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    String newText = formatter.format(value);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  static int parseToInt(String value) {
    if (value.isEmpty) return 0;
    // Menghapus semua karakter kecuali angka 0-9
    String cleanString = value.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(cleanString) ?? 0;
  }
}
