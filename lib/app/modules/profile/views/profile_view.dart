import 'package:bestieku/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.only(left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipOval(
                  child: SvgPicture.asset(
                    "assets/images/user.svg",
                    width: 80,
                    height: 80,
                  ),
                ),
                SizedBox(height: 6),
                Center(
                  child: Text(
                    "Andrian Hidayat",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 24),
                Text("Dompet"),
                SizedBox(height: 12),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.WALLET_DETAIL),
                  child: Container(
                    height: 84,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(8),
                      child: Row(
                        children: [
                          Container(
                            width: 63,
                            height: 63,
                            decoration: BoxDecoration(
                              color: Color(0xFF00C0E8).withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/images/icons/wallet.svg",
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Text("Dompet", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.WALLET_DETAIL),
                  child: Container(
                    height: 84,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(8),
                      child: Row(
                        children: [
                          Container(
                            width: 63,
                            height: 63,
                            decoration: BoxDecoration(
                              color: Color(0xFF00C0E8).withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/images/icons/wallet.svg",
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            "Riwayat Transaksi",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text("Tugas"),
                SizedBox(height: 12),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.TASK_LIST),
                  child: Container(
                    height: 84,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(8),
                      child: Row(
                        children: [
                          Container(
                            width: 63,
                            height: 63,
                            decoration: BoxDecoration(
                              color: Color(0xFF4CDA3A).withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/images/icons/task.svg",
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Text("Daftar Tugas", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.TASK_LIST),
                  child: Container(
                    height: 84,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(8),
                      child: Row(
                        children: [
                          Container(
                            width: 63,
                            height: 63,
                            decoration: BoxDecoration(
                              color: Color(0xFF4CDA3A).withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/images/icons/task.svg",
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Text("Tugas Project", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text("Profile"),
                SizedBox(height: 12),
                GestureDetector(
                  onTap: () => controller.logout(),
                  child: Container(
                    height: 84,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(8),
                      child: Row(
                        children: [
                          Container(
                            width: 63,
                            height: 63,
                            decoration: BoxDecoration(
                              color: Color(0xFFFF8D21).withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/images/icons/logout.svg",
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Text("Keluar", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
