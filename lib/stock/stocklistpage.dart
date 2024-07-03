import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aplikasi_barang/stock/stock.dart';
import 'package:aplikasi_barang/stock/addstockpage.dart';
import 'package:aplikasi_barang/stock/updatestockpage.dart';

class StockListPage extends StatelessWidget {
  final List<Stock> stocks;

  StockListPage({required this.stocks});

  void _navigateToUpdatePage(BuildContext context, Stock stock) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateStockPage(stock: stock),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Stock stock) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Delete Stock'),
        content: Text('Are you sure you want to delete this stock?'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Delete'),
            onPressed: () async {
              Navigator.of(context).pop(); // Tutup dialog konfirmasi

              try {
                final response = await http.delete(
                  Uri.parse('https://api.kartel.dev/stocks/${stock.id}'),
                );

                if (response.statusCode == 200 || response.statusCode == 204) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Stock deleted successfully'),
                      backgroundColor: Colors.green,
                    ),
                  );

                  // Refresh halaman jika diperlukan
                  // Misalnya, panggil fungsi untuk memuat ulang daftar stok setelah penghapusan
                  // refreshStockList();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to delete stock: ${response.body}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to delete stock: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void _navigateToAddPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddStockPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock List'),
      ),
      body: stocks.isEmpty
          ? Center(
              child: Text('No stocks available'),
            )
          : ListView.builder(
              itemCount: stocks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(stocks[index].name ?? 'Unnamed Stock'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quantity: ${stocks[index].qty ?? 0}'),
                      Text(
                          'Attribute: ${stocks[index].attr ?? 'No attribute'}'),
                      Text('Weight: ${stocks[index].weight ?? 0}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _navigateToUpdatePage(
                          context,
                          stocks[index],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () =>
                            _showDeleteConfirmation(context, stocks[index]),
                      ),
                    ],
                  ),
                  onTap: () => _navigateToUpdatePage(context, stocks[index]),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddPage(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
