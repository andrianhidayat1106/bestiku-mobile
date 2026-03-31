import 'package:bestieku/app/core/theme/app_colors.dart';
import 'package:bestieku/app/models/wallet_model.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_flutter/custom_dropdown.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controllers/wallet_transaction_controller.dart';

class WalletTransactionView extends GetView<WalletTransactionController> {
  const WalletTransactionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.only(left: 16, right: 16),
              child: Stack(
                alignment: AlignmentGeometry.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back),
                      color: AppColors.primary,
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  Text(
                    'Daftar Transaksi',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 48),
            Expanded(
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 44),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Pendapatan",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: 16,
                                      right: 16,
                                    ),
                                    width: double.infinity,
                                    height: 50,

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
                                    child: Center(
                                      child: Obx(
                                        () => Text(
                                          "+${controller.totalDebit}",
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 24),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Pengeluaran",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: 16,
                                      right: 16,
                                    ),
                                    width: double.infinity,
                                    height: 50,

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
                                    child: Center(
                                      child: Obx(
                                        () => Text(
                                          "-${controller.totalDebit}",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Rentang Tanggal",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(height: 4),
                            GestureDetector(
                              onTap: () {
                                Get.bottomSheet(CalendarView());
                              },
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                padding: EdgeInsets.symmetric(horizontal: 16),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 18,
                                      color: AppColors.primary,
                                    ),
                                    Obx(
                                      () => Text(
                                        controller.rangeText, // dummy text
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Text(
                          "Dompet",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                        ),

                        SizedBox(height: 4),
                        Obx(() {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(color: Colors.black, blurRadius: 0.2),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),

                              child: DropdownFlutter(
                                initialItem: controller.listWalletWithAll.first,
                                decoration: CustomDropdownDecoration(
                                  listItemStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                  ),
                                  headerStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),

                                items: controller.listWalletWithAll,
                                onChanged: (WalletModel? wallet) {
                                  if (wallet != null) {
                                    controller.selectWallet.value = wallet;
                                  }
                                },
                              ),
                            ),
                          );
                        }),
                        SizedBox(height: 24),
                        Text(
                          "Daftar Transaksi",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(height: 4),
                        Obx(() {
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final transaction =
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
                                        controller.walletController.listIcon(
                                          transaction.wallet!.icon.toString(),
                                        ),
                                        colorFilter: ColorFilter.mode(
                                          controller.walletController.listColor(
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
                                            "-" + transaction.amount.toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                            ),
                                          )
                                        : Text(
                                            "+" + transaction.amount.toString(),
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
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalendarView extends StatelessWidget {
  final WalletTransactionController walletTransactionController = Get.put(
    WalletTransactionController(),
  );
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.6,
      child: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Obx(() {
          return TableCalendar(
            focusedDay: walletTransactionController.focusedDay.value,
            firstDay: DateTime.utc(2026, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            availableCalendarFormats: const {CalendarFormat.month: 'Month'},
            rangeStartDay: walletTransactionController.rangeStart.value,
            rangeEndDay: walletTransactionController.rangeEnd.value,
            calendarFormat: walletTransactionController.calendarFormat.value,
            rangeSelectionMode: RangeSelectionMode.enforced,
            onRangeSelected: walletTransactionController.onRangeSelected,
            onFormatChanged: (format) =>
                walletTransactionController.calendarFormat.value = format,
          );
        }),
      ),
    );
  }
}
