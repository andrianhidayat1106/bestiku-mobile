import 'package:bestieku/app/modules/profile/controllers/profile_controller.dart';
import 'package:bestieku/app/modules/task/controllers/task_controller.dart';
import 'package:bestieku/app/modules/wallet/controllers/wallet_controller.dart';
import 'package:get/get.dart';

import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.put<WalletController>(WalletController());
    Get.put<ProfileController>(ProfileController());
    Get.put<TaskController>(TaskController());
  }
}
