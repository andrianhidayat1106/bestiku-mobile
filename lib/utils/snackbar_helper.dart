import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackbar {
  static void _show({
    required String title,
    required String message,
    required Color color,
    required IconData icon,
  }) {
    Get.rawSnackbar(
      title: title,
      message: message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: color.withValues(alpha: 0.9),
      // Menggunakan widget Icon secara langsung
      icon: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 8.0),
        child: Icon(icon, color: Colors.white, size: 28),
      ),
      margin: const EdgeInsets.all(16),
      borderRadius: 10,
      duration: const Duration(seconds: 3),
      shouldIconPulse: false,
      // Pada rawSnackbar, kita bisa mengatur text style secara lebih eksplisit jika perlu
      mainButton: null,
      boxShadows: [
        BoxShadow(
          color: color.withValues(alpha: 0.3),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  // --- Versi-versi snackbar yang bisa dipanggil ---

  /// Gunakan saat data berhasil disimpan atau diperbarui (Warna Biru/Hijau)
  static void success(String message) {
    _show(
      title: "Berhasil",
      message: message,
      color: Colors.green,
      icon: Icons.check_circle_outline,
    );
  }

  /// Gunakan untuk informasi umum (Warna Biru Terang)
  static void info(String message) {
    _show(
      title: "Informasi",
      message: message,
      color: Colors.lightBlue,
      icon: Icons.info_outline,
    );
  }

  /// Gunakan saat ada penghapusan data (Warna Merah)
  static void delete(String message) {
    _show(
      title: "Dihapus",
      message: message,
      color: Colors.redAccent,
      icon: Icons.delete_outline,
    );
  }

  /// Gunakan saat terjadi error sistem atau validasi gagal (Warna Oranye/DeepOrange)
  static void error(String message) {
    _show(
      title: "Gagal",
      message: message,
      color: Colors.deepOrange,
      icon: Icons.warning_amber_rounded,
    );
  }
}
