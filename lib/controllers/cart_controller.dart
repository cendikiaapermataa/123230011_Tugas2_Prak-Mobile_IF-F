import 'package:flutter/material.dart'; // Tambahan untuk warna Snackbar
import 'package:get/get.dart';
import '../models/product.dart';

class CartController extends GetxController {
  // Menggunakan Map untuk menyimpan produk beserta jumlah (quantity)-nya
  var cartItems = <Product, int>{}.obs;

  // Method untuk menambah produk (jika sudah ada, quantity bertambah)
  void addToCart(Product product) {
    if (cartItems.containsKey(product)) {
      cartItems[product] = cartItems[product]! + 1; // Tambah quantity
    } else {
      cartItems[product] = 1; // Masukkan barang baru dengan quantity 1
    }
    Get.snackbar(
      "Berhasil",
      "Item ditambahkan",
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 1),
    );
  }

  // Method untuk mengurangi quantity
  void reduceItem(Product product) {
    if (cartItems.containsKey(product) && cartItems[product] == 1) {
      cartItems.remove(
        product,
      ); // Jika sisa 1 dan dikurangi, hapus dari keranjang
    } else if (cartItems.containsKey(product)) {
      cartItems[product] = cartItems[product]! - 1; // Kurangi quantity
    }
  }

  // Method untuk menghapus produk sepenuhnya dari keranjang
  void removeFromCart(Product product) {
    cartItems.remove(product);
    // Tambahan feedback visual saat item dihapus
    Get.snackbar(
      "Dihapus",
      "${product.title} telah dihapus dari keranjang",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withOpacity(0.1),
      colorText: Colors.red,
      duration: const Duration(seconds: 1),
    );
  }

  // Menghitung total harga (Harga Produk x Kuantitas)
  double get totalPrice {
    return cartItems.entries.fold(
      0,
      (sum, entry) => sum + ((entry.key.price ?? 0) * entry.value),
    );
  }

  // Menghitung total seluruh jumlah item untuk ditampilkan di Badge
  int get totalItems {
    return cartItems.values.fold(0, (sum, quantity) => sum + quantity);
  }
}
