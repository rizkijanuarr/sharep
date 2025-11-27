import 'dart:developer' as developer;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/product_detail_model.dart';
import '../../../api/api_config.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/action_share_product.dart';

class ProductDetailController extends GetxController {
  final Rx<ProductDetailModel?> product = Rx<ProductDetailModel?>(null);
  final isLoading = false.obs;

  // URL Constants
  final String urlShareBase = ApiConfig.apiBaseUrl;
  String getDetailFoodUrl(String id) => ApiConfig.getDetailFoodUrl(id);

  @override
  void onInit() {
    super.onInit();
    _loadProductFromArguments();
  }

  void _loadProductFromArguments() {
    final args = Get.arguments;

    if (args != null && args is Map<String, dynamic>) {
      // Jika ada slug dari deep link
      if (args.containsKey('slug')) {
        final slug = args['slug'] as String;

        // Tampilkan pesan bahwa fitur ini belum tersedia
        Get.snackbar(
          'Info',
          'Fitur detail produk by slug belum tersedia. Silakan pilih produk dari list.',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );

        // Redirect ke list produk
        Future.delayed(const Duration(seconds: 1), () {
          Get.offAllNamed(AppRoutes.listProduk);
        });
      }
      // Jika ada ID, fetch dari API
      else if (args.containsKey('id')) {
        final productId = args['id'].toString();
        fetchProductDetail(productId);
      }
      // Load dari data lengkap
      else {
        product.value = ProductDetailModel.fromJson(args);
      }
    } else {

      Get.snackbar(
        'Error',
        'Data produk tidak ditemukan',
        snackPosition: SnackPosition.BOTTOM,
      );

      Future.delayed(const Duration(seconds: 1), () {
        Get.offAllNamed(AppRoutes.listProduk);
      });
    }
  }

  Future<void> fetchProductDetail(String id) async {
    try {
      isLoading.value = true;
      final detailUrl = getDetailFoodUrl(id);

      final response = await http.get(
        Uri.parse(detailUrl),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        product.value = ProductDetailModel.fromJson(data);
      }
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }

  void actionShareProduct(ProductDetailModel product) {
  ShareProductUtil.shareProduct(
    productId: product.id.toString(),
    productName: product.name,
    productPrice: product.price,
    productDescription: product.description,
  );
}

}
