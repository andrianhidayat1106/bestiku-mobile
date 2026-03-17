import 'package:bestieku/app/models/wallet_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WalletDetailController extends GetxController {
  final supabase = Supabase.instance.client;

  var listWallet = <WalletModel>[].obs;
  var isLoading = false.obs;

  int? selectedWalletId;
  final nameController = TextEditingController();
  final amountController = TextEditingController(text: "0");
  final formKey = GlobalKey<FormState>();
  var selectColorName = 'green'.obs;
  var selectIconName = 'wallet'.obs;

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

  @override
  void onInit() {
    fetchWallet();
    super.onInit();
  }

  Future<void> fetchWallet() async {
    try {
      isLoading.value = true;

      final data = await supabase.from("wallet").select();

      listWallet.value = (data as List)
          .map((item) => WalletModel.fromJson(item))
          .toList();

      print(listWallet.value);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addWallet() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;
      await supabase.from("wallet").insert({
        'name': nameController.text.trim(),
        'total_amount': int.parse(amountController.text.trim()),
        'color': selectColorName.value,
        'icon': selectIconName.value,
      });

      Get.back();
      clearForm();
      fetchWallet();
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
      await supabase.from("wallet").delete().eq('id', selectedWalletId);

      Get.back();
      fetchWallet();

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
    amountController.text = wallet.totalAmount.toString();
    selectColorName.value = wallet.color.toString();
    selectIconName.value = wallet.icon.toString();
    selectedWalletId = wallet.id;
  }

  void prepareAdd() {
    nameController.text = "";
    amountController.text = "";
    selectColorName.value = "";
    selectIconName.value = "";
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
      await supabase
          .from("wallet")
          .update({
            'name': nameController.text.trim(),
            'total_amount': int.parse(amountController.text.trim()),
            'color': selectColorName.value,
            'icon': selectIconName.value,
          })
          .eq('id', selectedWalletId);
      Get.back();
      fetchWallet();
      Get.snackbar(
        "Sukses",
        "Dompet berhasil diperbarui",
        snackPosition: SnackPosition.TOP, // Muncul dari atas
        backgroundColor: Colors.green, // Warna hijau sukses
        colorText: Colors.white, // Teks putih agar kontras
        icon: const Icon(
          Icons.check_circle,
          color: Colors.white,
        ), // Tambah ikon biar cakep
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
