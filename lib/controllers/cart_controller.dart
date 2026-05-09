import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product.dart';

class CartController extends GetxController {
  // KRITERIA 1: Menyimpan daftar produk di keranjang menggunakan RxList
  var cartItems = <Product>[].obs;

  // Method untuk menambah produk
  void addToCart(Product product) {
    cartItems.add(product);
    Get.snackbar(
      "Berhasil",
      "Item ditambahkan",
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 1),
    );
  }

  // Method untuk menghapus produk dari keranjang
  void removeFromCart(Product product) {
    cartItems.remove(product);
    // Feedback visual saat item dihapus
    Get.snackbar(
      "Dihapus",
      "${product.title} telah dihapus dari keranjang",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withOpacity(0.1),
      colorText: Colors.red,
      duration: const Duration(seconds: 1),
    );
  }

  // Method untuk menghitung total harga menggunakan fold pada List
  double get totalPrice {
    return cartItems.fold(0, (sum, item) => sum + (item.price ?? 0));
  }

  // Menghitung total seluruh jumlah item untuk ditampilkan di Badge
  int get totalItems {
    return cartItems.length;
  }
}
