import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aplikasi_barang/produk/produk.dart';

class UpdateProdukPage extends StatefulWidget {
  final Produk produk;

  UpdateProdukPage({required this.produk});

  @override
  _UpdateProdukPageState createState() => _UpdateProdukPageState();
}

class _UpdateProdukPageState extends State<UpdateProdukPage> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _qtyController = TextEditingController();
  final _attrController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.produk.name ?? '';
    _priceController.text = widget.produk.price?.toString() ?? '';
    _qtyController.text = widget.produk.qty?.toString() ?? '';
    _attrController.text = widget.produk.attr ?? '';
    _weightController.text = widget.produk.weight?.toString() ?? '';
  }

  Future<void> _updateProduk() async {
    final url =
        Uri.parse('https://api.kartel.dev/products/${widget.produk.id}');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'name': _nameController.text,
      'price': int.tryParse(_priceController.text) ?? 1,
      'qty': int.tryParse(_qtyController.text) ?? 1,
      'attr': _attrController.text,
      'weight': int.tryParse(_weightController.text) ?? 1,
    });

    try {
      final response = await http.put(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        // Success
        print('Product updated successfully: ${response.body}');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text('Product updated successfully'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Error
        print('Failed to update product: ${response.body}');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to update product: ${response.body}'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Network error
      print('Failed to update product: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to update product: $e'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _qtyController,
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _attrController,
              decoration: InputDecoration(labelText: 'Attribute'),
            ),
            TextField(
              controller: _weightController,
              decoration: InputDecoration(labelText: 'Weight'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateProduk,
              child: Text('Update Product'),
            ),
          ],
        ),
      ),
    );
  }
}
