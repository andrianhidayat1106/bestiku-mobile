import 'package:bestieku/app/data/transaction_provider.dart';
import 'package:bestieku/app/data/wallet_provider.dart';
import 'package:bestieku/app/models/wallet_model.dart';
import 'package:bestieku/app/modules/wallet/controllers/wallet_controller.dart';
import 'package:bestieku/utils/currency_format.dart';
import 'package:bestieku/utils/currency_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WalletDetailController extends GetxController {
  WalletProvider _walletProvider = WalletProvider();
  WalletController walletController = WalletController();
  TransactionProvider _transactionProvider = TransactionProvider();

  var isLoading = false.obs;

  int? selectedWalletId;
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var selectColorName = 'green'.obs;
  var selectIconName = 'wallet'.obs;

  @override
  void onInit() {
    super.onInit();
    walletController.fetchWallet();
  }

  void selectColor(String name) {
    selectColorName.value = name;
  }

  void selectIcon(String name) {
    selectIconName.value = name;
  }

  void clearForm() {
    nameController.clear();
    amountController.clear();
    selectColorName.value = 'green';
    selectIconName.value = 'wallet';
  }

  Future<void> addWallet() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;

      final Map<String, dynamic> data = {
        'name': nameController.text.trim(),
        'total_amount': CurrencyFormat.parseToInt(amountController.text),
        'color': selectColorName.value,
        'icon': selectIconName.value,
      };
      await _walletProvider.createWallet(data);

      Get.back();
      clearForm();
      await walletController.fetchWallet();
      Get.snackbar(
        "Sukses",
        "Dompet baru berhasil ditambahkan",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar("Error", "Gagal menambah dompet: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteWallet() async {
    final selectedWalletId = this.selectedWalletId;

    if (selectedWalletId == null) {
      Get.snackbar("Error", "ID tidak ditemukan");
      return;
    }
    try {
      isLoading.value = true;
      await _walletProvider.deleteWallet(selectedWalletId);

      Get.back();
      await walletController.fetchWallet();

      Get.snackbar(
        "Sukses",
        "Dompet telah dihapus",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar("Error", "Gagal menghapus data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void prepareEdit(WalletModel wallet) {
    nameController.text = wallet.name.toString();
    amountController.text =
        "${CurrencyHelper.formatRupiah(wallet.totalAmount)}";
    selectColorName.value = wallet.color.toString();
    selectIconName.value = wallet.icon.toString();
    selectedWalletId = wallet.id;
  }

  void prepareAdd() {
    nameController.text = "";
    amountController.text = "Rp 0";
    selectColorName.value = "green";
    selectIconName.value = "wallet";
    selectedWalletId = null;
  }

  Future<void> updateWallet() async {
    final selectedWalletId = this.selectedWalletId;
    if (selectedWalletId == null) {
      Get.snackbar("Error", "ID tidak ditemukan");
      return;
    }

    try {
      isLoading.value = true;

      // 1. Ambil saldo lama sebagai int
      final walletLama = walletController.listWallet.firstWhere(
        (w) => w.id == selectedWalletId,
      );
      int saldoLama = (walletLama.totalAmount ?? 0).toInt();

      // 2. Parse saldo baru ke int
      int saldoBaru = CurrencyFormat.parseToInt(amountController.text.trim());

      // 3. Logika pencatatan transaksi jika saldo berubah
      if (saldoBaru != saldoLama) {
        int selisih = saldoBaru - saldoLama;

        Map<String, dynamic> transactionData = {
          'p_wallet_id': selectedWalletId, // Gunakan p_wallet_id
          'p_amount': selisih.abs(), // Gunakan p_amount
          'p_type': selisih > 0 ? 'debit' : 'credit', // Gunakan p_type
          'p_desc': 'Penyesuaian Saldo', // Gunakan p_desc (sesuai saran error)
        };

        // Memanggil RPC atau provider transaksi
        await _transactionProvider.createTransactionRpc(transactionData);
      } else {
        Map<String, dynamic> data = {
          'name': nameController.text.trim(),
          'color': selectColorName.value,
          'icon': selectIconName.value,
        };

        // Eksekusi update wallet
        await _walletProvider.updateWallet(selectedWalletId, data);
      }

      // --- Sisa kode UI (Get.back, snackbar, dll) ---
      Get.back();
      await walletController.fetchWallet();
      Get.snackbar(
        "Informasi",
        "Dompet berhasil diperbarui",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.blueAccent.withOpacity(0.9),
        colorText: Colors.white,
        icon: const Icon(Icons.info_outline, color: Colors.white, size: 28),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        duration: const Duration(seconds: 3),
        shouldIconPulse: false, // Ikon diam, lebih elegan
        boxShadows: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      );
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
