// Lokasi: lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/pages/product_page.dart';
import 'views/pages/cart_page.dart';     // Tambahkan import ini
import 'bindings/product_binding.dart';
import 'bindings/cart_binding.dart';     // Tambahkan import ini

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Belajar GetX',
      initialRoute: '/products',
      getPages: [
        GetPage(
          name: '/products',
          page: () => const ProductPage(),
          binding: ProductBinding(),
        ),
        // MEMENUHI KRITERIA 5: Route untuk CartPage dengan Binding-nya
        GetPage(
          name: '/cart',
          page: () => const CartPage(),
          binding: CartBinding(),
        ),
      ],
    );
  }
}