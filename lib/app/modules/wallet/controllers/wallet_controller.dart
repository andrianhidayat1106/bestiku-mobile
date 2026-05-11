import 'dart:ffi';

import 'package:bestieku/app/core/theme/app_colors.dart';
import 'package:bestieku/app/data/transaction_provider.dart';
import 'package:bestieku/app/data/wallet_provider.dart';
import 'package:bestieku/app/models/transaction_model.dart';
import 'package:bestieku/app/models/wallet_model.dart';
import 'package:bestieku/app/modules/wallet/wallet_detail/controllers/wallet_detail_controller.dart';
import 'package:bestieku/utils/currency_format.dart';
import 'package:bestieku/utils/snackbar_helper.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class WalletController extends GetxController {
  var listWallet = <WalletModel>[].obs;
  var listTransaction = <TransactionModel>[].obs;
  final WalletProvider _walletProvider = WalletProvider();
  final TransactionProvider _transactionProvider = TransactionProvider();
  var isLoading = false.obs;
  var totalAllWalletAmount = 0.0.obs;
  TextEditingController totalAmountController = TextEditingController(
    text: "Rp 0",
  );
  TextEditingController descriptionController = TextEditingController();

  var selectWallet = Rxn<WalletModel>();

  @override
  void onInit() {
    super.onInit();
    fetchDataFirst();
  }

  void fetchDataFirst() async {
    try {
      isLoading(true);

      fetchWallet();
      fetchAllTransaction();
      fetchAllWalletAmount();
    } catch (e) {
    } finally {
      isLoading(false);
    }
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
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        barrierDismissible: false,
      );
      if (selectWallet.value != null) {
        await _transactionProvider.createTransactionRpc({
          'p_type': transactionType,
          'p_desc': descriptionController.text.trim(),
          'p_amount': CurrencyFormat.parseToInt(
            totalAmountController.text.trim(),
          ),
          'p_wallet_id': selectWallet.value!.id,
        });
      }
      await Future.wait([
        fetchAllTransaction(),
        fetchWallet(),
        fetchAllWalletAmount(),
      ]);
      Get.closeAllSnackbars();
      if (Get.isDialogOpen ?? false) Get.back();
      Get.back();
      clearForm();
      AppSnackbar.success("Berhasil Menambah Transaksi");
    } finally {
      isLoading(false);
    }
  }

  void clearForm() {
    selectWallet.value == null;
    totalAmountController.text = "Rp 0";
    descriptionController.clear();
  }

  Future<void> fetchAllTransaction() async {
    try {
      isLoading.value = true;
      final data = await _transactionProvider.getAllTransaction();
      // print(data);
      listTransaction.value = (data as List)
          .map((item) => TransactionModel.fromJson(item))
          .toList();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAllWalletAmount() async {
    try {
      final data = await _walletProvider.getAllWalletAmount();
      totalAllWalletAmount.value = data;
    } catch (e) {
      print(e);
    }
  }
}
