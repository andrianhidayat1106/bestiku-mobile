import 'package:bestieku/app/core/theme/app_colors.dart';
import 'package:bestieku/app/modules/profile/views/profile_view.dart';
import 'package:bestieku/app/modules/wallet/views/wallet_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: [ProfileView(), WalletView(), ProfileView()],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeIndex,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: SvgPicture.asset(
                  "assets/images/icons/task.svg",
                  height: 25,
                  colorFilter: const ColorFilter.mode(
                    Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: SvgPicture.asset(
                  "assets/images/icons/task.svg",
                  height: 25,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: "Tugas",
            ),

            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: SvgPicture.asset(
                  "assets/images/icons/wallet.svg",
                  height: 25,
                  colorFilter: const ColorFilter.mode(
                    Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: SvgPicture.asset(
                  "assets/images/icons/wallet.svg",
                  height: 25,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: "Dompet",
            ),

            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: SvgPicture.asset(
                  "assets/images/icons/profile.svg",
                  height: 25,
                  colorFilter: const ColorFilter.mode(
                    Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: SvgPicture.asset(
                  "assets/images/icons/profile.svg",
                  height: 25,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: "Profil",
            ),
          ],
        ),
      ),
    );
  }
}
