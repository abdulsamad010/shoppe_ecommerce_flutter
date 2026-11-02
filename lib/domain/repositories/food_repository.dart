import 'package:shoppe_ecommerce_flutter/data/models/food_model.dart';

abstract class FoodRepository {
  Future<List<FoodModel>> getFoodData();
  void saveSearchHistory(String searchText);
  Future<Map<String,dynamic>> fetchSearchHistory();
  Future<void> updateFavoriteProductsIds(String productId);
  Future<List<String>> fetchFavoriteProductsIds();
  Future<List<Map<String,dynamic>>> fetchCart();
  Future<void> updateCart(Map<String,dynamic> specificCartMap,String operation);
  Future<String> fetchAddress();
  Future<String> fetchContact();
  Future<bool> deleteUser();
  Future<void> editAddressContact(String value,String purpose);
  Future<void> storeOrder(Map<String,dynamic> orderDetails);
  Future<List<Map<String,dynamic>>> fetchDelivery();
  Future<List<Map<String,dynamic>>> fetchVoucher();
  Future<Map<String,dynamic>> fetchOrdersAndImage();
  Future<Map<String,dynamic>> fetchFlashSale();
  Future<void> storeReview(Map<String,dynamic> details);
  Future<Map<String, List<String>>> getSubCategories();
}