import 'package:aplikasi_barang/sales/addsalespage.dart';
import 'package:aplikasi_barang/sales/sales.dart';
import 'package:aplikasi_barang/sales/updatesalespage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SalesListPage extends StatelessWidget {
  final List<Sales> sales;

  SalesListPage({required this.sales});

  void _navigateToUpdatePage(BuildContext context, Sales sales) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateSalesPage(sales: sales),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Sales sales) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Delete Sale'),
        content: Text('Are you sure you want to delete this sale?'),
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
              Navigator.of(context).pop(); // Close confirmation dialog

              try {
                final response = await http.delete(
                  Uri.parse('https://api.kartel.dev/sales/${sales.id}'),
                );

                if (response.statusCode == 200 || response.statusCode == 204) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Sale deleted successfully'),
                      backgroundColor: Colors.green,
                    ),
                  );

                  // Refresh page if necessary
                  // For example, call a function to reload the sales list after deletion
                  // refreshSalesList();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to delete sale: ${response.body}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to delete sale: $e'),
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
        builder: (context) => AddSalesPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales List'),
      ),
      body: sales.isEmpty
          ? Center(
              child: Text('No sales available'),
            )
          : ListView.builder(
              itemCount: sales.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(sales[index].buyer ?? 'Unnamed Sale'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Phone: ${sales[index].phone ?? 'Not provided'}'),
                      Text('Date: ${sales[index].date ?? 'Not provided'}'),
                      Text('Status: ${sales[index].status ?? 'Not provided'}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _navigateToUpdatePage(
                          context,
                          sales[index],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () =>
                            _showDeleteConfirmation(context, sales[index]),
                      ),
                    ],
                  ),
                  onTap: () => _navigateToUpdatePage(context, sales[index]),
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
