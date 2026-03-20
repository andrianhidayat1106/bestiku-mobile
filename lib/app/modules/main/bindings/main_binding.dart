import 'package:bestieku/app/modules/wallet/controllers/wallet_controller.dart';
import 'package:get/get.dart';

import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.put<WalletController>(WalletController());
  }
}
