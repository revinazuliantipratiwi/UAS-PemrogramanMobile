import 'dart:convert';
import 'package:aplikasi_barang/produk/produk.dart';
import 'package:http/http.dart' as http;

class ProductApi {
  static const String baseUrl = 'https://api.kartel.dev';

  // GET request untuk mengambil detail produk
  static Future<List<Produk>> fetchProduk() async {
    try {
      var url = Uri.parse('$baseUrl/products');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        Iterable jsonResponse = jsonDecode(response.body);
        List<Produk> products =
            jsonResponse.map((model) => Produk.fromJson(model)).toList();
        return products;
      } else {
        print('Failed to load products: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error loading products: $e');
      throw Exception('Failed to load products: $e');
    }
  }

  // POST request untuk menambahkan produk baru
  static Future<Produk> createProduk(Produk produk) async {
    try {
      var url = Uri.parse('$baseUrl/products');
      var requestBody = jsonEncode(produk.toJson());
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
        return Produk.fromJson(jsonDecode(response.body));
      } else {
        print('Failed to create product: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to create product: ${response.body}');
      }
    } catch (e) {
      print('Error creating product: $e');
      throw Exception('Failed to create product: $e');
    }
  }

  // PUT request untuk mengupdate produk
  static Future<Produk> updateProduk(String id, Produk updateProduk) async {
    try {
      var url = Uri.parse('$baseUrl/products/$id');
      var body = jsonEncode(updateProduk.toJson());
      print('Request body: $body');

      var response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        return Produk.fromJson(jsonDecode(response.body));
      } else {
        print('Failed to update product: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to update product: ${response.body}');
      }
    } catch (e) {
      print('Error updating product: $e');
      throw Exception('Failed to update product: $e');
    }
  }

  // DELETE request untuk menghapus produk
  static Future<void> deleteProduk(String id) async {
    try {
      var url = Uri.parse('$baseUrl/products/$id');
      var response = await http.delete(url);

      if (response.statusCode == 200) {
        return;
      } else {
        print('Failed to delete product: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to delete product: ${response.body}');
      }
    } catch (e) {
      print('Error deleting product: $e');
      throw Exception('Failed to delete product: $e');
    }
  }

  static fetchSales() {}
}
