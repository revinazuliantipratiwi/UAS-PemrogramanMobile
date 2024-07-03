import 'package:flutter/material.dart';
import 'home.dart'; // Impor file home.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(), // Gunakan HomePage dari home.dart sebagai home
    );
  }
}
