class ProductDetailModel {
  final String id;
  final String name;
  final String description;
  final String image;
  final double price;

  ProductDetailModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  static double _parsePrice(dynamic price) {
    if (price == null) return 0.0;

    if (price is num) {
      return price.toDouble();
    }

    if (price is String) {
      final cleanPrice = price.replaceAll('.', '').replaceAll(',', '.');
      return double.tryParse(cleanPrice) ?? 0.0;
    }

    return 0.0;
  }

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: _parsePrice(json['price']),
      image: json['image'] ?? '📦',
    );
  }
}
