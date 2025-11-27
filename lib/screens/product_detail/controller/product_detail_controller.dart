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
    print('🔵 ProductDetailController onInit called');
    print('🔵 Get.arguments: ${Get.arguments}');
    print('🔵 Get.arguments type: ${Get.arguments.runtimeType}');
    print('🔵 Get.parameters: ${Get.parameters}');
    _loadProductFromArguments();
  }

  void _loadProductFromArguments() {
    final args = Get.arguments;
    print('🔵 _loadProductFromArguments called');
    print('🔵 Arguments: $args');
    print('🔵 Arguments type: ${args.runtimeType}');

    if (args != null && args is Map<String, dynamic>) {
      print('🔵 Arguments is Map<String, dynamic>');
      // Jika ada slug dari deep link (sebenarnya ini adalah ID dari URL)
      if (args.containsKey('slug')) {
        final productId = args['slug'] as String;
        print('🔵 Loading product by slug (ID): $productId');
        fetchProductDetail(productId);
      }
      // Jika ada ID, fetch dari API
      else if (args.containsKey('id')) {
        final productId = args['id'].toString();
        print('🔵 Loading product by ID: $productId');
        fetchProductDetail(productId);
      }
      // Load dari data lengkap
      else {
        print('🔵 Loading product from full data');
        product.value = ProductDetailModel.fromJson(args);
      }
    } else {
      print('🔴 No arguments found or invalid format');
      print('🔴 Redirecting to list produk...');

      Future.delayed(const Duration(milliseconds: 100), () {
        Get.snackbar(
          'Error',
          'Data produk tidak ditemukan',
          snackPosition: SnackPosition.BOTTOM,
        );
      });

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
