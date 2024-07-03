import 'package:aplikasi_barang/stock/stock.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:aplikasi_barang/stock/stockpost.dart'; // Assuming this is where StockPostPage is imported from

class StockPage extends StatefulWidget {
  final String id;

  StockPage({required this.id});

  @override
  _StockPageState createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  late Future<List<dynamic>> _futureStocks;

  @override
  void initState() {
    super.initState();
    _futureStocks = fetchStocks();
  }

  Future<List<dynamic>> fetchStocks() async {
    final response =
        await http.get(Uri.parse('https://api.kartel.dev/stocks/${widget.id}'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to load stocks');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock'),
      ),
      body: Center(
        child: FutureBuilder<List<dynamic>>(
          future: _futureStocks,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var stock = snapshot.data![index];
                  return ListTile(
                    title: Text(stock['name'] ?? ''),
                    subtitle: Text(
                      'Quantity: ${stock['qty'] ?? 0}, Attribute: ${stock['attr'] ?? ''}, Weight: ${stock['weight'] ?? 1}',
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StockPostPage(
                            stock: Stock(
                              name: stock['name'] ?? '',
                              qty: stock['qty'] ?? 0,
                              attr: stock['attr'] ?? '',
                              weight: stock['weight'] ?? 0,
                              createdAt:
                                  DateTime.parse(stock['createdAt'] ?? ''),
                              updatedAt:
                                  DateTime.parse(stock['updatedAt'] ?? ''),
                              issuer: stock['issuer'] ?? '',
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
