import 'dart:convert';
import 'package:http/http.dart' as http;

class Stock {
  final String name;
  final String qty; // Ubah tipe dari int menjadi String
  final String attr;
  final String weight; // Ubah tipe dari int menjadi String
  final DateTime createdAt;
  final DateTime updatedAt;
  final String issuer;

  Stock({
    required this.name,
    required this.qty,
    required this.attr,
    required this.weight,
    required this.createdAt,
    required this.updatedAt,
    required this.issuer,
  });

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
        name: json['name'] ?? '',
        qty: json['qty'].toString(), // Konversi ke String
        attr: json['attr'] ?? '',
        weight: json['weight'].toString(), // Konversi ke String
        createdAt: DateTime.parse(json['createdAt'] ?? ''),
        updatedAt: DateTime.parse(json['updatedAt'] ?? ''),
        issuer: json['issuer'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'qty': qty,
        'attr': attr,
        'weight': weight,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'issuer': issuer,
      };

  static Future<List<Stock>> fetchStocks(String id) async {
    final response =
        await http.get(Uri.parse('https://api.kartel.dev/stocks/$id'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Stock> stocks = data.map((json) => Stock.fromJson(json)).toList();
      return stocks;
    } else {
      throw Exception('Failed to load stocks');
    }
  }
}
