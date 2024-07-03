import 'package:aplikasi_barang/stock/stockget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  void _goToStockPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => StockPage(
                id: '',
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu), // Icon garis tiga
              onPressed: () {
                Scaffold.of(context)
                    .openDrawer(); // Buka drawer saat ikon diklik
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
              leading: Icon(Icons.storage), // Icon untuk Stock
              title: Text('Stock'),
              onTap: () {
                Navigator.pop(context); // Tutup drawer setelah dipilih
                _goToStockPage(
                    context); // Panggil method untuk navigasi ke StockPage
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart), // Icon untuk Produk
              title: Text('Produk'),
              onTap: () {
                Navigator.pop(context); // Tutup drawer setelah dipilih
                // Tambahkan navigasi untuk opsi Produk jika diperlukan
              },
            ),
            ListTile(
              leading: Icon(Icons.monetization_on), // Icon untuk Sales
              title: Text('Sales'),
              onTap: () {
                Navigator.pop(context); // Tutup drawer setelah dipilih
                // Tambahkan navigasi untuk opsi Sales jika diperlukan
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
