import 'package:get/get.dart';

import '../controllers/wallet_transaction_controller.dart';

class WalletTransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletTransactionController>(
      () => WalletTransactionController(),
    );
  }
}
