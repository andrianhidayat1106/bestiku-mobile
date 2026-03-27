import 'dart:ffi';

import 'package:bestieku/app/data/transaction_provider.dart';
import 'package:bestieku/app/data/wallet_provider.dart';
import 'package:bestieku/app/models/transaction_model.dart';
import 'package:bestieku/app/models/wallet_model.dart';
import 'package:bestieku/app/modules/wallet/wallet_detail/controllers/wallet_detail_controller.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletController extends GetxController {
  var listWallet = <WalletModel>[].obs;
  var listTransaction = <TransactionModel>[].obs;
  final WalletProvider _walletProvider = WalletProvider();
  final TransactionProvider _transactionProvider = TransactionProvider();
  var isLoading = false.obs;

  TextEditingController totalAmountController = TextEditingController(
    text: "0",
  );
  TextEditingController descriptionController = TextEditingController();

  var selectWallet = Rxn<WalletModel>();
  @override
  void onInit() {
    super.onInit();
    fetchWallet();
    fetchAllTransaction();
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

  Future<void> addTransaction(String transactionType) async {
    try {
      isLoading(true);

      if (selectWallet.value != null) {
        _transactionProvider.createTransactionRpc({
          'p_type': transactionType,
          'p_desc': descriptionController.text.trim(),
          'p_amount': totalAmountController.text.trim(),
          'p_wallet_id': selectWallet.value!.id,
        });
      }

      Get.back();
      clearForm();
      Get.snackbar(
        "Sukses",
        "Dompet baru berhasil ditambahkan",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      fetchWallet();
      fetchAllTransaction();
    } finally {
      isLoading(false);
    }
  }

  void clearForm() {
    selectWallet.value == null;
    totalAmountController.clear();
    descriptionController.clear();
  }

  Future<void> fetchAllTransaction() async {
    try {
      isLoading.value = true;
      final data = await _transactionProvider.getAllTransaction();

      listTransaction.value = (data as List)
          .map((item) => TransactionModel.fromJson(item))
          .toList();
    } finally {
      isLoading.value = false;
    }
  }
}
