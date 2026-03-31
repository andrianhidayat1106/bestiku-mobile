import 'package:bestieku/app/models/wallet_model.dart';

class TransactionModel {
  int? id;
  WalletModel? wallet;
  int? balanceAfter;
  int? amount;
  String? transactionType;
  String? description;

  TransactionModel({
    this.id,
    this.wallet,
    this.balanceAfter,
    this.amount,
    this.transactionType,
    this.description,
  });

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wallet = json['wallet'] != null
        ? WalletModel.fromJson(json['wallet'])
        : null;
    balanceAfter = json['balance_after'];
    amount = json['amount'];
    transactionType = json['transaction_type'];
    description = json['description'];
  }

  @override
  String toString() {
    return 'Transaction(type: $transactionType, amount: $amount)';
  }
}
