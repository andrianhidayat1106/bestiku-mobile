import 'package:bestieku/app/data/wallet_provider.dart';
import 'package:bestieku/app/models/wallet_model.dart';
import 'package:bestieku/app/modules/wallet/wallet_detail/controllers/wallet_detail_controller.dart';
import 'package:get/get.dart';

class WalletController extends GetxController {
  var listWallet = <WalletModel>[].obs;

  final WalletProvider _walletProvider = WalletProvider();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchWallet();
  }

  Future<void> fetchWallet() async {
    try {
      isLoading.value = true;

      final data = await _walletProvider.getWallet();

      listWallet.value = (data as List)
          .map((item) => WalletModel.fromJson(item))
          .toList();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
