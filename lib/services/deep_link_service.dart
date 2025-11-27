import 'dart:async';
import 'dart:developer' as developer;
import 'package:app_links/app_links.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class DeepLinkService {
  static final DeepLinkService _instance = DeepLinkService._internal();
  factory DeepLinkService() => _instance;
  DeepLinkService._internal();

  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  Future<void> init() async {
    _appLinks = AppLinks();

    // Handle initial link jika app dibuka dari link
    final initialUri = await _appLinks.getInitialLink();
    if (initialUri != null) {
      developer.log('🔗 Initial link: $initialUri', name: 'DeepLinkService');
      _handleDeepLink(initialUri);
    }

    // Listen untuk link yang masuk saat app sudah berjalan
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      developer.log('🔗 Incoming link: $uri', name: 'DeepLinkService');
      _handleDeepLink(uri);
    }, onError: (err) {
      developer.log('❌ Error handling link: $err', name: 'DeepLinkService');
    });
  }

  void _handleDeepLink(Uri uri) {
    developer.log('📱 Processing deep link: ${uri.toString()}',
        name: 'DeepLinkService');
    developer.log('   Scheme: ${uri.scheme}', name: 'DeepLinkService');
    developer.log('   Host: ${uri.host}', name: 'DeepLinkService');
    developer.log('   Path: ${uri.path}', name: 'DeepLinkService');
    developer.log('   Path segments: ${uri.pathSegments}', name: 'DeepLinkService');

    String? productSlug;

    // Handle custom scheme: siboyo://food/{slug}
    if (uri.scheme == 'siboyo') {
      if (uri.host == 'food') {
        if (uri.pathSegments.isNotEmpty) {
          productSlug = uri.pathSegments[0];
          developer.log('✅ Custom scheme - Product slug: $productSlug',
              name: 'DeepLinkService');
        } else {
          developer.log('✅ Custom scheme - No slug, show list',
              name: 'DeepLinkService');
        }

        Get.toNamed(AppRoutes.listProduk, arguments: {'slug': productSlug});

        Get.snackbar(
          'Deep Link Berhasil!',
          productSlug != null ? 'Mencari produk: $productSlug' : 'Membuka daftar produk',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
        return;
      }
    }

    // Handle: https://siboyo.store/food/{slug} or /product/{slug}
    if ((uri.host == 'siboyo.store' || uri.host == 'www.siboyo.store') && uri.pathSegments.isNotEmpty) {
      if (uri.pathSegments[0] == 'food' || uri.pathSegments[0] == 'product') {
        if (uri.pathSegments.length > 1) {
          productSlug = uri.pathSegments[1];
          developer.log('✅ HTTPS - Product slug: $productSlug',
              name: 'DeepLinkService');

          // Navigate langsung ke detail produk dengan slug
          Future.delayed(const Duration(milliseconds: 500), () {
            Get.offAllNamed(AppRoutes.productDetail, arguments: {'slug': productSlug});

            Get.snackbar(
              'Deep Link Berhasil!',
              'Membuka produk: $productSlug',
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 2),
            );
          });
        } else {
          developer.log('✅ HTTPS - No slug, show list',
              name: 'DeepLinkService');

          // Jika tidak ada slug, tampilkan list
          Future.delayed(const Duration(milliseconds: 500), () {
            Get.offAllNamed(AppRoutes.listProduk);
          });
        }
      }
    }
  }

  void dispose() {
    _linkSubscription?.cancel();
  }
}
