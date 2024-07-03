import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aplikasi_barang/produk/produk.dart';
import 'package:aplikasi_barang/produk/addprodukpage.dart';
import 'package:aplikasi_barang/produk/updateprodukpage.dart';

class ProdukListPage extends StatelessWidget {
  final List<Produk> products;

  ProdukListPage({required this.products});

  void _navigateToUpdatePage(BuildContext context, Produk products) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateProdukPage(produk: products),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Produk products) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Delete Product'),
        content: Text('Are you sure you want to delete this product?'),
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
                  Uri.parse('https://api.kartel.dev/products/${products.id}'),
                );

                if (response.statusCode == 200 || response.statusCode == 204) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Product deleted successfully'),
                      backgroundColor: Colors.green,
                    ),
                  );

                  // Refresh page if needed
                  // e.g., call a function to reload the list of products after deletion
                  // refreshProductList();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Failed to delete product: ${response.body}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to delete product: $e'),
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
        builder: (context) => AddProdukPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: products.isEmpty
          ? Center(
              child: Text('No products available'),
            )
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(products[index].name ?? 'Unnamed Product'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Price: ${products[index].price ?? 0}'),
                      Text('Quantity: ${products[index].qty ?? 0}'),
                      Text(
                          'Attribute: ${products[index].attr ?? 'No attribute'}'),
                      Text('Weight: ${products[index].weight ?? 0}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _navigateToUpdatePage(
                          context,
                          products[index],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () =>
                            _showDeleteConfirmation(context, products[index]),
                      ),
                    ],
                  ),
                  onTap: () => _navigateToUpdatePage(context, products[index]),
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
