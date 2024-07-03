import 'package:aplikasi_barang/produk/produk.dart';
import 'package:aplikasi_barang/produk/produkapi.dart';
import 'package:aplikasi_barang/produk/produklistpage.dart';
import 'package:aplikasi_barang/sales/sales.dart';
import 'package:aplikasi_barang/sales/salesapi.dart';
import 'package:aplikasi_barang/sales/saleslistpage.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_barang/stock/stocklistpage.dart';
import 'package:aplikasi_barang/stock/stockapi.dart';
import 'package:aplikasi_barang/stock/stock.dart'; // Pastikan path ini sesuai dengan struktur proyek kamu

class HomePage extends StatelessWidget {
  final StockApi stockApi = StockApi();
  final ProductApi productApi = ProductApi();
  final SalesApi salesApi = SalesApi();

  void _goToStockPage(BuildContext context) async {
    try {
      List<Stock> stocks = await StockApi.fetchStocks();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StockListPage(stocks: stocks),
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to load stocks: $e'),
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

  void _goToProdukPage(BuildContext context) async {
    try {
      List<Produk> products = await ProductApi.fetchProduk();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProdukListPage(products: products),
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to load products: $e'),
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

  void _goToSalesPage(BuildContext context) async {
    try {
      List<Sales> sales = await SalesApi.fetchSales();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SalesListPage(sales: sales),
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to load sales: $e'),
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
        title: Text('Homepage'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.storage),
              title: Text('Stock'),
              onTap: () {
                Navigator.pop(context);
                _goToStockPage(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart_checkout),
              title: Text('Produk'),
              onTap: () {
                Navigator.pop(context);
                _goToProdukPage(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text('Sales'),
              onTap: () {
                Navigator.pop(context);
                _goToSalesPage(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Ini adalah halaman utama',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
