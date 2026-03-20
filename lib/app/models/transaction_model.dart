class TransactionModel {
  int? id;
  int? walletId;
  int? balanceAfter;
  int? amount;
  String? transactionType;
  String? description;

  TransactionModel({
    this.id,
    this.walletId,
    this.balanceAfter,
    this.amount,
    this.transactionType,
    this.description,
  });

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    walletId = json['wallet_id'];
    balanceAfter = json['balance_after'];
    amount = json['amount'];
    transactionType = json['transactionType'];
    description = json['description'];
  }
}
