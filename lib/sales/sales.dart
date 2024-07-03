class Sales {
  String? id;
  String? buyer;
  String? phone;
  String? date;
  String? status;

  Sales({
    this.id,
    this.buyer,
    this.phone,
    this.date,
    this.status,
  });

  Sales.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    buyer = json['buyer'];
    phone = json['phone'];
    date = json['date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['buyer'] = this.buyer;
    data['phone'] = this.phone;
    data['date'] = this.date;
    data['status'] = this.status;

    return data;
  }
}
