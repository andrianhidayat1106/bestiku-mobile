import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/wallet_transaction_controller.dart';

class WalletTransactionView extends GetView<WalletTransactionController> {
  const WalletTransactionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WalletTransactionView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'WalletTransactionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
