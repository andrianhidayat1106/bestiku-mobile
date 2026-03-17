import 'package:bestieku/app/core/theme/app_colors.dart';
import 'package:bestieku/app/models/wallet_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../controllers/wallet_detail_controller.dart';
import 'package:flutter/services.dart';

class WalletDetailView extends GetView<WalletDetailController> {
  const WalletDetailView({super.key});
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
                    'Daftar Dompet',
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
                padding: EdgeInsets.only(top: 16),
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsetsGeometry.only(left: 16, right: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          controller.prepareAdd();
                          Get.bottomSheet(
                            isScrollControlled: true,

                            WalletFormSheet(isEdit: false),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: Text(
                          "Tambah Dompet",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: EdgeInsetsGeometry.only(left: 16, right: 16),
                      child: Text("Daftar Transaksi"),
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        child: Container(
                          height: 80,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [BoxShadow(color: Colors.black)],
                          ),
                          child: Obx(() {
                            if (controller.isLoading.value) {
                              return Center(child: CircularProgressIndicator());
                            }

                            if (controller.listWallet.isEmpty) {
                              return Center(
                                child: Text("Daftar Dompet anda masih kosong"),
                              );
                            }

                            return ListView.separated(
                              separatorBuilder: (context, index) => Divider(
                                height: 1, // Tinggi area divider
                                thickness: 1, // Ketebalan garis
                                color: Colors.grey[200], // Warna garis (soft)
                                indent:
                                    70, // Garis mulai setelah icon (biar rapi)
                                endIndent:
                                    16, // Jarak garis sebelum mentok kanan
                              ),
                              itemCount: controller.listWallet.length,
                              itemBuilder: (context, index) {
                                final wallet = controller.listWallet[index];
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
                                        controller.prepareEdit(wallet);
                                        Get.bottomSheet(
                                          isScrollControlled: true,
                                          WalletFormSheet(isEdit: true),
                                        );
                                      },
                                      borderRadius: BorderRadius.circular(12),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(12),
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFF7F7F7),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: SvgPicture.asset(
                                              "assets/images/icons/wallet.svg",
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  wallet.name ?? "Kosong",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  "Total Uang : ${wallet.totalAmount}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WalletFormSheet extends GetView<WalletDetailController> {
  final bool isEdit;
  const WalletFormSheet({super.key, this.isEdit = false});

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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  isEdit ? "Edit Dompet" : "Tambah Dompet",
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
                  key: controller.formKey,
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nama Dompet"),
                      SizedBox(height: 4),
                      TextFormField(
                        controller: controller.nameController,

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
                      SizedBox(height: 8),
                      Text("Total Uang"),
                      SizedBox(height: 4),
                      TextFormField(
                        controller: controller.amountController,
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
                        // 2. Batasi input hanya angka (membutuhkan import 'package:flutter/services.dart')
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Logo"),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.selectIcon("wallet");
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(12),
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                // ignore: unrelated_type_equality_checks
                                                controller
                                                        .selectIconName
                                                        .value ==
                                                    "wallet"
                                                ? AppColors.primary
                                                : Colors.transparent,
                                            width: 2,
                                          ),
                                          color: Color(0xFFF7F7F7),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: SvgPicture.asset(
                                          "assets/images/icons/wallet.svg",
                                          colorFilter: ColorFilter.mode(
                                            Colors.grey,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () {
                                        controller.selectIcon("wallet_two");
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(12),
                                        width: 50,
                                        height: 50,

                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                // ignore: unrelated_type_equality_checks
                                                controller
                                                        .selectIconName
                                                        .value ==
                                                    "wallet_two"
                                                ? AppColors.primary
                                                : Colors.transparent,
                                            width: 2,
                                          ),
                                          color: Color(0xFFF7F7F7),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: SvgPicture.asset(
                                          "assets/images/icons/wallet_two.svg",
                                          colorFilter: ColorFilter.mode(
                                            Colors.grey,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () {
                                        controller.selectIcon("bank");
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(12),
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                // ignore: unrelated_type_equality_checks
                                                controller
                                                        .selectIconName
                                                        .value ==
                                                    "bank"
                                                ? AppColors.primary
                                                : Colors.transparent,
                                            width: 2,
                                          ),
                                          color: Color(0xFFF7F7F7),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: SvgPicture.asset(
                                          "assets/images/icons/bank.svg",
                                          colorFilter: ColorFilter.mode(
                                            Colors.grey,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
                          Obx(() {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Warna"),
                                SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.selectColor("green");
                                      },
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                // ignore: unrelated_type_equality_checks
                                                controller
                                                        .selectColorName
                                                        .value ==
                                                    "green"
                                                ? AppColors.primary
                                                : Colors.transparent,
                                            width: 2,
                                          ),
                                          color: Color(0XFF34C759),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () {
                                        controller.selectColor("blue");
                                      },
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                // ignore: unrelated_type_equality_checks
                                                controller
                                                        .selectColorName
                                                        .value ==
                                                    "blue"
                                                ? AppColors.primary
                                                : Colors.transparent,
                                            width: 2,
                                          ),
                                          color: Color(0XFF00C0E8),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () {
                                        controller.selectColor("red");
                                      },
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                // ignore: unrelated_type_equality_checks
                                                controller
                                                        .selectColorName
                                                        .value ==
                                                    "red"
                                                ? AppColors.primary
                                                : Colors.transparent,
                                            width: 2,
                                          ),
                                          color: Color.fromARGB(
                                            255,
                                            143,
                                            105,
                                            112,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              isEdit
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppColors.primary),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 15,
                              ),
                            ),
                            onPressed: () {
                              controller.deleteWallet();
                            },
                            child: Text("Hapus"),
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
                            ),
                            onPressed: () {
                              controller.updateWallet();
                            },
                            child: Text("Simpan"),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () {
                          controller.addWallet();
                        },
                        child: Text("Tambahkan"),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
