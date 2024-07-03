import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aplikasi_barang/stock/stock.dart';

class UpdateStockPage extends StatefulWidget {
  final Stock stock;

  UpdateStockPage({required this.stock});

  @override
  _UpdateStockPageState createState() => _UpdateStockPageState();
}

class _UpdateStockPageState extends State<UpdateStockPage> {
  final _nameController = TextEditingController();
  final _qtyController = TextEditingController();
  final _attrController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.stock.name ?? '';
    _qtyController.text = widget.stock.qty?.toString() ?? '';
    _attrController.text = widget.stock.attr ?? '';
    _weightController.text = widget.stock.weight?.toString() ?? '';
  }

  Future<void> _updateStock() async {
    final url = Uri.parse('https://api.kartel.dev/stocks/${widget.stock.id}');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'name': _nameController.text,
      'qty': int.tryParse(_qtyController.text) ?? 1,
      'attr': _attrController.text,
      'weight': int.tryParse(_weightController.text) ?? 1,
    });

    try {
      final response = await http.put(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        // Success
        print('Stock updated successfully: ${response.body}');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text('Stock updated successfully'),
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
        print('Failed to update stock: ${response.body}');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to update stock: ${response.body}'),
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
      print('Failed to update stock: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to update stock: $e'),
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
        title: Text('Update Stock'),
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
              onPressed: _updateStock,
              child: Text('Update Stock'),
            ),
          ],
        ),
      ),
    );
  }
}
