import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class HomePageController extends GetxController {
  void goToListProduk() {
    Get.toNamed(AppRoutes.listProduk);
  }
}
