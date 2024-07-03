import 'dart:convert';
import 'package:aplikasi_barang/sales/sales.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateSalesPage extends StatefulWidget {
  final Sales sales;

  UpdateSalesPage({required this.sales});

  @override
  _UpdateSalesPageState createState() => _UpdateSalesPageState();
}

class _UpdateSalesPageState extends State<UpdateSalesPage> {
  final _buyerController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dateController = TextEditingController();
  final _statusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _buyerController.text = widget.sales.buyer ?? '';
    _phoneController.text = widget.sales.phone ?? '';
    _dateController.text = widget.sales.date ?? '';
    _statusController.text = widget.sales.status ?? '';
  }

  Future<void> _updateSales() async {
    final url = Uri.parse('https://api.kartel.dev/sales/${widget.sales.id}');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'buyer': _buyerController.text,
      'phone': _phoneController.text,
      'date': _dateController.text,
      'status': _statusController.text,
    });

    try {
      final response = await http.put(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        // Success
        print('Sale updated successfully: ${response.body}');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text('Sale updated successfully'),
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
        print('Failed to update sale: ${response.body}');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to update sale: ${response.body}'),
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
      print('Failed to update sale: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to update sale: $e'),
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
        title: Text('Update Sale'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _buyerController,
              decoration: InputDecoration(labelText: 'Buyer'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Date'),
              keyboardType: TextInputType.datetime,
            ),
            TextField(
              controller: _statusController,
              decoration: InputDecoration(labelText: 'Status'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateSales,
              child: Text('Update Sale'),
            ),
          ],
        ),
      ),
    );
  }
}
