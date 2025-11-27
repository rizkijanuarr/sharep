class ProductListModel {
  final String id;
  final String name;
  final String image;
  final String description;
  final double price;

  ProductListModel({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
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

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: _parsePrice(json['price']),
      image: json['image'] ?? '📦',
    );
  }
}
