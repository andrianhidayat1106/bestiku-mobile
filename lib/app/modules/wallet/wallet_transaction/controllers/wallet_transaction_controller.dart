import 'package:bestieku/app/core/theme/app_colors.dart';
import 'package:bestieku/app/data/transaction_provider.dart';
import 'package:bestieku/app/models/transaction_model.dart';
import 'package:bestieku/app/models/wallet_model.dart';
import 'package:bestieku/app/modules/wallet/controllers/wallet_controller.dart';
import 'package:bestieku/utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class WalletTransactionController extends GetxController {
  var focusedDay = DateTime.now().obs;
  var rangeStart = Rxn<DateTime>();
  var rangeEnd = Rxn<DateTime>();
  var calendarFormat = CalendarFormat.month.obs;
  var listWalletWithAll = <WalletModel>[].obs;
  var selectWallet = Rxn<WalletModel>();
  final WalletController walletController = WalletController();
  final TransactionProvider _transactionProvider = TransactionProvider();
  var isLoading = false.obs;
  var isDelete = false.obs;
  var listTransaction = <TransactionModel>[].obs;

  var totalCredit = 0.0.obs;
  var totalDebit = 0.0.obs;

  @override
  void onInit() {
    super.onInit();

    DateTime now = DateTime.now();

    rangeStart = Rxn<DateTime>(DateTime(now.year, now.month, now.day, 0, 0, 0));
    rangeEnd = Rxn<DateTime>(
      DateTime(now.year, now.month, now.day, 23, 59, 59),
    );

    listWalletWithAll.clear();
    listWalletWithAll.add(WalletModel(id: 0, name: "Semua Dompet"));
    ever(walletController.listWallet, (List<WalletModel> walletsFromApi) {
      listWalletWithAll.assignAll([
        WalletModel(id: 0, name: "Semua Dompet"),
        ...walletsFromApi, // Spread operator untuk menggabungkan data API
      ]);
    });
    everAll([rangeStart, rangeEnd, selectWallet], (_) {
      getTransaction();
    });
    walletController.fetchWallet();
    getTransaction();
  }

  void onRangeSelected(DateTime? start, DateTime? end, DateTime focused) {
    rangeStart.value = start;
    rangeEnd.value = end;
    focusedDay.value = focused;
    getTransaction();
  }

  String get rangeText {
    if (rangeStart.value == null) return "Pilih tanggal";

    DateFormat formatter = DateFormat("dd/MM/yyyy");
    String start = formatter.format(rangeStart.value ?? DateTime.now());

    String end = rangeEnd.value != null
        ? formatter.format(rangeEnd.value!)
        : start;

    return "$start - $end";
  }

  Future<void> getTransaction() async {
    final start = rangeStart.value;
    final end = rangeEnd.value;
    final wallet = selectWallet.value;

    if (start == null || end == null || wallet == null) return;

    try {
      isLoading.value = true;

      final data = await _transactionProvider.fetchTransactionsByRangeAndWallet(
        start,
        end,
        wallet,
      );

      listTransaction.value = (data as List)
          .map((item) => TransactionModel.fromJson(item))
          .toList();

      totalCredit.value = listTransaction
          .where((t) => t.transactionType == "credit")
          .fold(0.0, (sum, item) => sum + (item.amount ?? 0));

      totalDebit.value = listTransaction
          .where((t) => t.transactionType == "debit")
          .fold(0.0, (sum, item) => sum + (item.amount ?? 0));
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteTransaction(int id) async {
    try {
      // 1. Tampilkan loading dialog
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        barrierDismissible: false,
      );

      isLoading.value = true;

      // 2. Eksekusi hapus di provider
      await _transactionProvider.deleteTransaction(id);

      // 3. Tutup loading dialog
      if (Get.isDialogOpen ?? false) Get.back();

      // 4. Refresh data di UI
      // Panggil fetchTransaction agar daftar di halaman depan terupdate
      await getTransaction();
      // Jika saldo wallet juga berubah setelah hapus, refresh wallet juga
      await walletController.fetchWallet();

      // 5. Berikan feedback sukses
      Get.closeAllSnackbars();
      AppSnackbar.delete("Transaksi berhasil dihapus");

      // Matikan mode delete jika ingin otomatis kembali normal setelah hapus satu data
      // isDelete.value = false;
    } catch (e) {
      // Tutup loading jika error
      if (Get.isDialogOpen ?? false) Get.back();

      Get.snackbar(
        "Error",
        "Gagal menghapus transaksi: ${e.toString()}",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
