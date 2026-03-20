import 'package:bestieku/app/data/wallet_provider.dart';
import 'package:bestieku/app/models/wallet_model.dart';
import 'package:bestieku/app/modules/wallet/wallet_detail/controllers/wallet_detail_controller.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletController extends GetxController {
  var listWallet = <WalletModel>[].obs;

  final WalletProvider _walletProvider = WalletProvider();

  var isLoading = false.obs;

  TextEditingController amount = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchWallet();
  }

  String listIcon(String? value) {
    switch (value) {
      case 'wallet':
        return "assets/images/icons/wallet.svg";
      case 'wallet_two':
        return "assets/images/icons/wallet_two.svg";
      case 'bank':
        return "assets/images/icons/bank.svg";
      default:
        return "assets/images/icons/wallet.svg";
    }
  }

  Color listColor(String? value) {
    switch (value) {
      case 'red':
        return const Color.fromARGB(255, 143, 105, 112);
      case 'blue':
        return const Color(0XFF00C0E8);
      case 'green':
        return const Color(0XFF34C759);
      default:
        return const Color(0XFF34C759);
    }
  }

  Future<void> fetchWallet() async {
    try {
      isLoading.value = true;

      final data = await _walletProvider.getWallet();

      listWallet.value = (data as List)
          .map((item) => WalletModel.fromJson(item))
          .toList();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
