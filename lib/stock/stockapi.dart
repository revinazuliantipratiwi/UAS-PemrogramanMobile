import 'dart:convert';
import 'package:http/http.dart' as http;
import 'stock.dart';

class StockApi {
  static const String baseUrl = 'https://api.kartel.dev';

  // GET request untuk mengambil semua stock
  static Future<List<Stock>> fetchStocks() async {
    try {
      var url = Uri.parse('$baseUrl/stocks');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        Iterable jsonResponse = jsonDecode(response.body);
        List<Stock> stocks =
            jsonResponse.map((model) => Stock.fromJson(model)).toList();
        return stocks;
      } else {
        throw Exception('Failed to load stocks');
      }
    } catch (e) {
      throw Exception('Failed to load stocks: $e');
    }
  }

  // GET request untuk mengambil detail stock berdasarkan ID
  static Future<Stock> fetchStockById(String id) async {
    try {
      var url = Uri.parse('$baseUrl/stocks/$id');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        return Stock.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load stock');
      }
    } catch (e) {
      throw Exception('Failed to load stock: $e');
    }
  }

  // POST request untuk menambahkan stock baru
  static Future<Stock> createStock(Stock stock) async {
    try {
      var url = Uri.parse('$baseUrl/stocks');
      var requestBody = jsonEncode(stock.toJson());
      print(
          'Request body: $requestBody'); // Tambahkan logging untuk request body

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: requestBody,
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        return Stock.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create stock: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create stock: $e');
    }
  }

  // PUT request untuk mengupdate stock
  static Future<Stock> updateStock(String id, Stock updatedStock) async {
    try {
      var url = Uri.parse('$baseUrl/stocks/$id');
      var response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(updatedStock.toJson()),
      );

      if (response.statusCode == 200) {
        return Stock.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to update stock: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update stock: $e');
    }
  }

  // DELETE request untuk menghapus stock
  static Future<void> deleteStock(String id) async {
    try {
      var url = Uri.parse('$baseUrl/stocks/$id');
      var response = await http.delete(url);

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('Failed to delete stock: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete stock: $e');
    }
  }

  static fetchSales() {}
}
