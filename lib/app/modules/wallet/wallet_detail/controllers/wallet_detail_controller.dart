import 'package:bestieku/app/core/theme/app_colors.dart';
import 'package:bestieku/app/data/transaction_provider.dart';
import 'package:bestieku/app/data/wallet_provider.dart';
import 'package:bestieku/app/models/wallet_model.dart';
import 'package:bestieku/app/modules/wallet/controllers/wallet_controller.dart';
import 'package:bestieku/utils/currency_format.dart';
import 'package:bestieku/utils/currency_helper.dart';
import 'package:bestieku/utils/snackbar_helper.dart';
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

      Get.dialog(
        const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        barrierDismissible: false,
      );

      // 1. Parse saldo awal
      int saldoAwal = CurrencyFormat.parseToInt(amountController.text.trim());

      // 2. Siapkan data wallet
      final Map<String, dynamic> walletData = {
        'name': nameController.text.trim(),
        'total_amount': 0,
        'color': selectColorName.value,
        'icon': selectIconName.value,
      };

      // 3. Simpan wallet dan ambil response (asumsi return data wallet termasuk ID)
      final response = await _walletProvider.createWallet(walletData);

      // Ambil ID wallet yang baru saja dibuat
      // Sesuaikan key 'id' dengan struktur response dari Supabase/Backend Anda
      final newWalletId = response['id'];

      // 4. Jika saldo awal != 0, catat sebagai transaksi 'Saldo Awal'
      if (saldoAwal != 0 && newWalletId != null) {
        Map<String, dynamic> transactionData = {
          'p_wallet_id': newWalletId,
          'p_amount': saldoAwal.abs(),
          'p_type': saldoAwal > 0 ? 'debit' : 'credit',
          'p_desc': 'Saldo Awal',
        };

        await _transactionProvider.createTransactionRpc(transactionData);
      }

      if (Get.isDialogOpen ?? false) Get.back();
      Get.back();
      clearForm();
      await walletController.fetchWallet();
      Get.closeAllSnackbars();
      AppSnackbar.success("Berhasil Menambah Wallet");
    } catch (e) {
      if (Get.isDialogOpen ?? false)
        Get.back(); // Pastikan dialog loading tertutup jika error
      Get.snackbar("Error", "Gagal menambah dompet: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteWallet() async {
    if (isLoading.value) return;
    final selectedWalletId = this.selectedWalletId;

    if (selectedWalletId == null) {
      Get.snackbar("Error", "ID tidak ditemukan");
      return;
    }
    try {
      isLoading.value = true;
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        barrierDismissible: false,
      );
      await _walletProvider.deleteWallet(selectedWalletId);

      await walletController.fetchWallet();
      if (Get.isDialogOpen ?? false) Get.back();
      Get.back();
      Get.closeAllSnackbars();
      AppSnackbar.delete("Berhasil Menghapus Wallet");
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
    if (!formKey.currentState!.validate()) {
      return;
    }

    final selectedWalletId = this.selectedWalletId;

    if (selectedWalletId == null) {
      Get.snackbar("Error", "ID tidak ditemukan");
      return;
    }

    try {
      isLoading.value = true;
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        barrierDismissible: false,
      );
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
      if (Get.isDialogOpen ?? false) Get.back();
      Get.back();
      await walletController.fetchWallet();
      Get.closeAllSnackbars();
      AppSnackbar.info("Berhasil Memperbarui Wallet");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
