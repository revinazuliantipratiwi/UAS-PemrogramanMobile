import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aplikasi_barang/sales/sales.dart';

class SalesApi {
  static const String baseUrl = 'https://api.kartel.dev';

  // GET request untuk mengambil semua sales
  static Future<List<Sales>> fetchSales() async {
    try {
      var url = Uri.parse('$baseUrl/sales');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        Iterable jsonResponse = jsonDecode(response.body);
        List<Sales> salesList =
            jsonResponse.map((model) => Sales.fromJson(model)).toList();
        return salesList;
      } else {
        throw Exception('Failed to load sales: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load sales: $e');
    }
  }

  // POST request untuk menambahkan sales baru
  static Future<Sales> createSales(Sales sales) async {
    try {
      var url = Uri.parse('$baseUrl/sales');
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(sales.toJson()),
      );

      if (response.statusCode == 201) {
        return Sales.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create sales: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create sales: $e');
    }
  }

  // PUT request untuk mengupdate sales berdasarkan ID
  static Future<Sales> updateSales(String id, Sales updatedSales) async {
    try {
      var url = Uri.parse('$baseUrl/sales/$id');
      var response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(updatedSales.toJson()),
      );

      if (response.statusCode == 200) {
        return Sales.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to update sales: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update sales: $e');
    }
  }

  // DELETE request untuk menghapus sales berdasarkan ID
  static Future<void> deleteSales(String id) async {
    try {
      var url = Uri.parse('$baseUrl/sales/$id');
      var response = await http.delete(url);

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('Failed to delete sales: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete sales: $e');
    }
  }

  static fetchProduk() {}
}
