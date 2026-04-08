import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyFormat extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 1. Jika input benar-benar kosong, kembalikan teks "Rp 0"
    if (newValue.text.isEmpty) {
      return TextEditingValue(
        text: 'Rp 0',
        selection: TextSelection.collapsed(offset: 4), // Kursor setelah "Rp 0"
      );
    }

    // 2. Cegah error jika user memasukkan karakter yang bukan angka
    String onlyNumbers = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Jika setelah dihapus karakter non-angka ternyata kosong, balikkan ke Rp 0
    if (onlyNumbers.isEmpty) {
      return TextEditingValue(
        text: 'Rp 0',
        selection: TextSelection.collapsed(offset: 4),
      );
    }

    // 3. Parsing ke double (Gunakan tryParse agar lebih aman)
    double value = double.parse(onlyNumbers);

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
