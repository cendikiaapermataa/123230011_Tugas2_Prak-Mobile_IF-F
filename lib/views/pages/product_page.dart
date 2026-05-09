import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/product_controller.dart';
import '../../controllers/cart_controller.dart'; // Import CartController
import '../../views/widgets/product_card.dart';

class ProductPage extends GetView<ProductController> {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Inisialisasi CartController agar bisa digunakan di halaman ini
    final cartController = Get.put(CartController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Home Page'),
        actions: [
          // MEMENUHI KRITERIA 3: Badge jumlah item menggunakan Obx
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Get.toNamed('/cart'); // Route ke CartPage
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Obx(() {
                  if (cartController.cartItems.isEmpty) return const SizedBox();
                  return Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${cartController.cartItems.length}',
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Obx(() {
          // PERBAIKAN 1: Hapus .value karena isLoading sudah bool
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blueGrey),
            );
          }
          return GridView.builder(
            // PERBAIKAN 2: Ganti productList menjadi products
            itemCount: controller.products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio:
                  0.55, // Disesuaikan sedikit agar muat tombol tambah
            ),
            itemBuilder: (context, index) {
              final product = controller.products[index];
              return Column(
                children: [
                  Expanded(
                    // PERBAIKAN 3: Tambahkan parameter onTap
                    child: ProductCard(
                      product: product,
                      onTap: () {
                        Get.toNamed("/detail", arguments: product);
                      },
                    ),
                  ),
                  const SizedBox(height: 4),
                  // MEMENUHI KRITERIA 2: Button Tambahkan ke Keranjang
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        cartController.addToCart(product);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.blueGrey, // Disesuaikan dengan tema card
                      ),
                      child: const Text(
                        "Tambah",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }),
      ),
    );
  }
}
