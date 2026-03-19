import 'package:bestieku/app/data/wallet_provider.dart';
import 'package:bestieku/app/modules/wallet/wallet_detail/controllers/wallet_detail_controller.dart';
import 'package:get/get.dart';

class WalletController extends GetxController {
  WalletProvider _walletProvider = WalletProvider();

  @override
  void onInit() {
    super.onInit();
  }

  void fetchWallet() {}
}
