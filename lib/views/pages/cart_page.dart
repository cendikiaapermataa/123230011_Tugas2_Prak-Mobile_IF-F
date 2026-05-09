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
        return ListView.builder(
          itemCount: controller.cartItems.length,
          itemBuilder: (context, index) {
            // Karena menggunakan Map, kita ambil key (Product) berdasarkan index
            final product = controller.cartItems.keys.toList()[index];
            final quantity =
                controller.cartItems[product]; // Ambil quantity-nya

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                title: Text(product.title ?? 'No Name'),
                subtitle: Text('\$${product.price}'),

                // Bagian yang ditambahkan (tombol -, text, +, dan tombol hapus)
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Tombol Kurang (-)
                    IconButton(
                      icon: const Icon(
                        Icons.remove_circle_outline,
                        color: Colors.orange,
                      ),
                      onPressed: () => controller.reduceItem(product),
                    ),
                    // Text Quantity
                    Text(
                      '$quantity',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Tombol Tambah (+)
                    IconButton(
                      icon: const Icon(
                        Icons.add_circle_outline,
                        color: Colors.blue,
                      ),
                      onPressed: () => controller.addToCart(product),
                    ),
                    // FITUR BARU: Tombol Hapus Langsung (Tempat Sampah)
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () {
                        Get.defaultDialog(
                          title: "Hapus Item",
                          middleText:
                              "Yakin ingin menghapus ${product.title} dari keranjang?",
                          textConfirm: "Ya, Hapus",
                          confirmTextColor: Colors.white,
                          onConfirm: () {
                            // PERBAIKANNYA DI SINI:
                            Get.back(); // 1. Tutup dialognya TERLEBIH DAHULU
                            controller.removeFromCart(
                              product,
                            ); // 2. Baru hapus datanya dan munculkan snackbar
                          },
                          textCancel: "Batal",
                        );
                      },
                    ),
                  ],
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
                "Total:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
