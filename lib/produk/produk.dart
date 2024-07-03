class Produk {
  String? id;
  String? name;
  int? price;
  int? qty;
  String? attr;
  int? weight;

  Produk({
    this.id,
    this.name,
    this.price,
    this.qty,
    this.attr,
    this.weight,
  });

  Produk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    qty = json['qty'];
    attr = json['attr'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['qty'] = this.qty;
    data['attr'] = this.attr;
    data['weight'] = this.weight;

    return data;
  }
}
