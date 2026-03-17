class WalletModel {
  int? id;
  String? name;
  int? totalAmount;
  String? logo;
  String? color;

  WalletModel({this.id, this.name, this.totalAmount, this.logo, this.color});

  WalletModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    totalAmount = json['total_amount'];
    logo = json['logo'];
    color = json['color'];
  }
}
