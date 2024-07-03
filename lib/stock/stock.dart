class Stock {
  String? id;
  String? name;
  int? qty;
  String? attr;
  int? weight;

  Stock({
    this.id,
    this.name,
    this.qty,
    this.attr,
    this.weight,
  });

  Stock.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    qty = json['qty'];
    attr = json['attr'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['qty'] = this.qty;
    data['attr'] = this.attr;
    data['weight'] = this.weight;

    return data;
  }
}
