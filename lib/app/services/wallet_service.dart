import 'package:bestieku/app/data/wallet_provider.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WalletService extends GetxController {
  WalletProvider _provider = WalletProvider();
  final _supabase = Supabase.instance.client;

  var listWallet = <dynamic>[].obs;
  var isLoading = false.obs;

  Future<WalletService> init() async {
    await fetchAllWallets();
    return this;
  }

  Future<void> fetchAllWallets() async {
    try {
      isLoading(true);
    } catch (e) {
      print(e);
    }
  }
}
