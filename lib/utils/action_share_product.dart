import 'package:share_plus/share_plus.dart';
import '../api/api_config.dart';

class ShareProductUtil {
  static void shareProduct({
    required String productId,
    required String productName,
    required double productPrice,
    String? productDescription,
  }) {
    // https://siboyo.store/food/1
    // https://siboyo.store/food/:id
    // Output :
    // Kunjungi Siboyo Store Terdekat!
    // Produk: Mie Ayam
    // Harga: Rp 25000
    // Deskripsi: Mie Ayam Suwir
    // Lihat produk: https://siboyo.store/food/1
    final productUrl = '${ApiConfig.apiBaseUrlViewsShare}/$productId';

    final message = StringBuffer();
    message.writeln('Kunjungi Siboyo Store Terdekat!\n');
    message.writeln('Produk: $productName');
    message.writeln('Harga: Rp ${productPrice.toStringAsFixed(0)}');

    if (productDescription != null && productDescription.isNotEmpty) {
      message.writeln('\nDeskripsi: $productDescription');
    }

    message.writeln('\nLihat produk: $productUrl');

    Share.share(
      message.toString(),
      subject: productName,
    );
  }
}
