import 'package:bestieku/app/models/wallet_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WalletDetailController extends GetxController {
  final supabase = Supabase.instance.client;

  var listWallet = <WalletModel>[].obs;
  var isLoading = false.obs;

  final nameController = TextEditingController();
  final amountController = TextEditingController();
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
  }
}
