import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_page_controller.dart';

class HomePageScreen extends GetView<HomePageController> {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: controller.goToListProduk,
              child: const Text('Lihat Daftar Produk'),
            ),
          ],
        ),
      ),
    );
  }
}
