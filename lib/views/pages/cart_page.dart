import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';

class CartPage extends GetView<CartController> {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang Belanja')),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return const Center(child: Text("Keranjang masih kosong"));
        }

        // Membaca item langsung dari RxList
        return ListView.builder(
          itemCount: controller.cartItems.length,
          itemBuilder: (context, index) {
            // Karena menggunakan List, kita ambil datanya dengan indeks langsung
            final product = controller.cartItems[index];

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                leading: const Icon(Icons.shopping_bag_outlined),
                title: Text(product.title ?? 'No Name'),
                subtitle: Text('\$${product.price}'),

                // Hanya menyisakan tombol hapus, tidak ada tambah/kurang
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () {
                    Get.defaultDialog(
                      title: "Hapus Item",
                      middleText:
                          "Yakin ingin menghapus ${product.title} dari keranjang?",
                      textConfirm: "Ya, Hapus",
                      confirmTextColor: Colors.white,
                      onConfirm: () {
                        Get.back(); // 1. Tutup dialognya TERLEBIH DAHULU
                        controller.removeFromCart(
                          product,
                        ); // 2. Hapus data dan munculkan snackbar
                      },
                      textCancel: "Batal",
                    );
                  },
                ),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Obx(
        () => Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 10)],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Harga:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "\$${controller.totalPrice.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
