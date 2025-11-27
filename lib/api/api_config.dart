class ApiConfig {
  static const String apiBaseUrl = 'https://siboyo.store/api';
  static const String apiBaseUrlViewsShare = 'https://siboyo.store/food';
  static const String listFoodEndpoint = '/food';

  static String get listFoodUrl => '$apiBaseUrl$listFoodEndpoint';
  static String getDetailFoodUrl(String id) => '$apiBaseUrl$listFoodEndpoint/$id';
}
