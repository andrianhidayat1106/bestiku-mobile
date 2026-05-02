import 'package:bestieku/app/core/theme/app_colors.dart';
import 'package:bestieku/app/models/transaction_model.dart';
import 'package:bestieku/app/models/wallet_model.dart';
import 'package:bestieku/app/routes/app_pages.dart';
import 'package:bestieku/utils/currency_format.dart';
import 'package:bestieku/utils/currency_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/wallet_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
// Gunakan supabase_flutter, bukan hanya supabase
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dropdown_flutter/custom_dropdown.dart';

class WalletView extends GetView<WalletController> {
  // Ambil user yang sedang login
  final user = Supabase.instance.client.auth.currentUser;

  // Ambil nama dari metadata (pastikan key 'name' atau 'full_name' sesuai saat registrasi)
  String get userName => user?.userMetadata?['full_name'] ?? "Guest";

  WalletView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsGeometry.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset("assets/images/user.svg", width: 30),
                        SizedBox(width: 8),
                        Text(userName),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Lakukan yang terbaik hari ini!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat(
                        "EEE, d MMM yyyy",
                        'id_ID',
                      ).format(DateTime.now()),
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 12, bottom: 28),
                          width: double.maxFinite,
                          alignment: Alignment.bottomLeft,
                          height: 150,
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Obx(
                            () => Text(
                              "${CurrencyHelper.formatRupiah(controller.totalAllWalletAmount.value)}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 12),
                          alignment: Alignment.centerLeft,
                          width: double.maxFinite,
                          height: 75,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "Total Uang Anda",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () async {
                        await Get.toNamed(Routes.WALLET_DETAIL);
                        controller.fetchWallet();
                        controller.fetchAllTransaction();
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.chevron_right,
                            color: AppColors
                                .primary, // Warna abu-abu agar tidak terlalu mencolok
                            size: 25,
                          ),
                          Text(
                            "Dompet Anda",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Obx(() {
                      return Column(
                        children: [
                          SizedBox(
                            height: 145,
                            child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return SizedBox(width: 8);
                              },
                              itemCount: controller.listWallet.length,
                              clipBehavior: Clip.none,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final WalletModel wallet =
                                    controller.listWallet[index];
                                return Material(
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        controller.selectWallet.value = wallet;
                                        Get.bottomSheet(
                                          isScrollControlled: true,
                                          WalletTransactionSheet(),
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(12),
                                        width: 150,
                                        height: 145,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black,
                                              blurRadius: 0.2,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(12),
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFF7F7F7),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),
                                                  child: SvgPicture.asset(
                                                    controller.listIcon(
                                                      wallet.icon,
                                                    ),
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                          controller.listColor(
                                                            wallet.color,
                                                          ),
                                                          BlendMode.srcIn,
                                                        ),
                                                  ),
                                                ),
                                                SizedBox(width: 6),
                                                Expanded(
                                                  child: Text(
                                                    wallet.name.toString(),
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              thickness: 1,
                                              color: Colors.grey,
                                            ),
                                            Text(
                                              "Total",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey,
                                                fontSize: 12,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              "${CurrencyHelper.formatRupiah(wallet.totalAmount)}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.lightOrange,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 16),
                          InkWell(
                            onTap: () => Get.toNamed(Routes.WALLET_TRANSACTION),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.chevron_right,
                                  color: AppColors
                                      .primary, // Warna abu-abu agar tidak terlalu mencolok
                                  size: 25,
                                ),
                                Text(
                                  "Riwayat Transaksi",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),

                          ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(right: 16),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final TransactionModel transaction =
                                  controller.listTransaction[index];

                              return Container(
                                height: 80,
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 0.2,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(12),
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF7F7F7),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: SvgPicture.asset(
                                        controller.listIcon(
                                          transaction.wallet!.icon.toString(),
                                        ),
                                        colorFilter: ColorFilter.mode(
                                          controller.listColor(
                                            transaction.wallet!.color,
                                          ),
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            transaction.wallet!.name.toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),

                                          Text(
                                            transaction.description
                                                        .toString() ==
                                                    ""
                                                ? "(Tanpa Deskripsi)"
                                                : transaction.description
                                                      .toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    transaction.transactionType == "credit"
                                        ? Text(
                                            "-" +
                                                CurrencyHelper.formatRupiah(
                                                  transaction.amount,
                                                ),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                            ),
                                          )
                                        : Text(
                                            "+" +
                                                CurrencyHelper.formatRupiah(
                                                  transaction.amount,
                                                ),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                          ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 12);
                            },
                            itemCount: controller.listTransaction.length,
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WalletTransactionSheet extends GetView<WalletController> {
  const WalletTransactionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.6,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Transaksi",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
              SizedBox(height: 12),
              Expanded(
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Dompet"),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors
                                .grey
                                .shade300, // Warna border default TextField
                            width: 1.0,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: DropdownFlutter<WalletModel>(
                            initialItem: controller.selectWallet.value,
                            decoration: CustomDropdownDecoration(
                              listItemStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                              headerStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                            ),

                            items: controller.listWallet,
                            onChanged: (WalletModel? wallet) {
                              if (wallet != null) {
                                controller.selectWallet.value = wallet;
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text("Total Uang"),
                      SizedBox(height: 4),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        // 2. Mencegah input selain angka di level sistem
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CurrencyFormat(),
                        ],
                        controller: controller.totalAmountController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Jumlah tidak boleh kosong";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.red, width: 1),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text("Deskripsi"),
                      SizedBox(height: 4),
                      TextFormField(
                        maxLines: 4,
                        controller: controller.descriptionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Nama dompet tidak boleh kosong";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.red, width: 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        controller.addTransaction('credit');
                      },

                      child: Text("Pengeluaran"),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        controller.addTransaction('debit');
                      },
                      child: Text("Pendapatan"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
