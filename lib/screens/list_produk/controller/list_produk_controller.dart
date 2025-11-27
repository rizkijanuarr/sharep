import 'dart:developer' as developer;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/product_list_model.dart';
import '../../../api/api_config.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/action_share_product.dart';

class ListProdukController extends GetxController {
  final products = <ProductListModel>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  // URL Constants
  final String urlProductFood = ApiConfig.listFoodUrl;
  final String urlShareBase = ApiConfig.apiBaseUrl;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await http.get(
        Uri.parse(urlProductFood),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic>? productList;

        // Ambil list dari response (bisa langsung List atau nested di 'data')
        if (data is List) {
          productList = data;
        } else if (data is Map && data['data'] is List) {
          productList = data['data'];
        }

        // Parse ke model jika berhasil dapat list
        if (productList != null) {
          products.value = productList
              .map((item) => ProductListModel.fromJson(item))
              .toList();
        } else {
          errorMessage.value = 'Format data tidak sesuai';
        }
      } else {
        errorMessage.value = 'Gagal memuat produk: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void actionShareProduct(ProductListModel product) {
    ShareProductUtil.shareProduct(
      productId: product.id.toString(),
      productName: product.name,
      productPrice: product.price,
      productDescription: product.description,
    );
  }


  void goToProductDetail(ProductListModel product) {

    Get.toNamed(
      AppRoutes.productDetail,
      arguments: {
        'id': product.id,
        'name': product.name,
        'price': product.price,
        'description': product.description,
        'image': product.image,
      },
    );
  }
}
