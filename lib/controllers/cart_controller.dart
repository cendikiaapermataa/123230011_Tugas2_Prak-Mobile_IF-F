import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product.dart';

class CartController extends GetxController {
  var cartItems = <Product>[].obs;

  //method untuk nambah produk
  void addToCart(Product product) {
    cartItems.add(product);
    Get.snackbar(
      "Berhasil",
      "Item ditambahkan",
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 1),
    );
  }

  //method untuk ngapus produk dari keranjang
  void removeFromCart(Product product) {
    cartItems.remove(product);
    Get.snackbar(
      "Dihapus",
      "${product.title} telah dihapus dari keranjang",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withOpacity(0.1),
      colorText: Colors.red,
      duration: const Duration(seconds: 1),
    );
  }

  //method untuk ngitung total harga list
  double get totalPrice {
    return cartItems.fold(0, (sum, item) => sum + (item.price ?? 0));
  }

  //ngitung total seluruh jumlah item untuk ditampilin di badge
  int get totalItems {
    return cartItems.length;
  }
}
