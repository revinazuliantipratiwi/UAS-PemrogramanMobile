import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'stock.dart';

class StockPostPage extends StatefulWidget {
  final Stock stock;

  StockPostPage({required this.stock});

  @override
  _StockPostPageState createState() => _StockPostPageState();
}

class _StockPostPageState extends State<StockPostPage> {
  Future<void> postData() async {
    var url = Uri.parse('https://api.kartel.dev/stocks');

    var body = json.encode({
      'name': widget.stock.name,
      'qty': widget.stock.qty.toString(), // Konversi qty ke String
      'attr': widget.stock.attr,
      'weight': widget.stock.weight.toString(), // Konversi weight ke String
      'createdAt': widget.stock.createdAt.toIso8601String(),
      'updatedAt': widget.stock.updatedAt.toIso8601String(),
      'issuer': widget.stock.issuer,
    });

    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        print('Data berhasil ditambahkan');
      } else {
        print('Gagal menambahkan data: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Exception saat melakukan POST data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Post Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Name: ${widget.stock.name}'),
            Text('Quantity: ${widget.stock.qty}'),
            Text('Attribute: ${widget.stock.attr}'),
            Text('Weight: ${widget.stock.weight}'),
            Text('Created At: ${widget.stock.createdAt}'),
            Text('Updated At: ${widget.stock.updatedAt}'),
            Text('Issuer: ${widget.stock.issuer}'),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                postData(); // Panggil postData untuk mem-post data stock
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
