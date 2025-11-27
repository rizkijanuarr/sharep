import 'package:get/get.dart';
import '../screens/home/screen/home_page_screen.dart';
import '../screens/home/controller/home_page_controller.dart';
import '../screens/list_produk/screen/list_produk_screen.dart';
import '../screens/list_produk/controller/list_produk_controller.dart';
import '../screens/product_detail/screen/product_detail_screen.dart';
import '../screens/product_detail/controller/product_detail_controller.dart';

class AppRoutes {
  static const home = '/';
  static const listProduk = '/list-produk';
  static const productDetail = '/product-detail';

  static final routes = [
    GetPage(
      name: home,
      page: () => const HomePageScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => HomePageController());
      }),
    ),
    GetPage(
      name: listProduk,
      page: () => const ListProdukScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ListProdukController());
      }),
    ),
    GetPage(
      name: productDetail,
      page: () => const ProductDetailScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ProductDetailController());
      }),
    ),
  ];
}
