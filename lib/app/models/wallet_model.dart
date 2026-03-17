class WalletModel {
  int? id;
  String? name;
  int? totalAmount;
  String? icon;
  String? color;

  WalletModel({this.id, this.name, this.totalAmount, this.icon, this.color});

  WalletModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    totalAmount = json['total_amount'];
    icon = json['icon'];
    color = json['color'];
  }
}
