 import 'package:shoppe_ecommerce_flutter/domain/entities/food.dart';
import 'package:shoppe_ecommerce_flutter/domain/repositories/food_repository.dart';

class GetFoods{
  FoodRepository repository;
  GetFoods({required this.repository});

  @override
  Future<List<Food>> callFoodData() {
    return repository.getFoodData();
  }

  @override
  void callSaveSearchHistory(String searchText){
    return repository.saveSearchHistory(searchText);
  }

  @override
  Future<Map<String,dynamic>> callFetchSearchHistory(){
    return repository.fetchSearchHistory();
  }

  @override
  Future<List<String>> fetchFavoriteProductsIds(){
    return repository.fetchFavoriteProductsIds();
  }

  @override
  Future<void> updateFavoriteProductsIds(String productId){
    return repository.updateFavoriteProductsIds(productId);
  }


  Future<List<Map<String,dynamic>>> fetchCart(){
    return repository.fetchCart();
  }
  Future<void> updateCart(Map<String,dynamic> specificCartMap,String operation){
    return repository.updateCart(specificCartMap, operation);
  }

  Future<String> fetchAddress(){
    return repository.fetchAddress();
  }

  Future<String> fetchContact(){
    return repository.fetchContact();
  }

  Future<void> editAddressContact(String value,String purpose){
    return repository.editAddressContact(value,purpose);
  }

  Future<void> storeOrder(Map<String,dynamic> orderDetails){
    return repository.storeOrder(orderDetails);
  }
  Future<List<Map<String,dynamic>>> fetchDelivery(){
    return repository.fetchDelivery();
  }
  Future<List<Map<String,dynamic>>> fetchVoucher(){
    return repository.fetchVoucher();
  }

  Future<Map<String,dynamic>> fetchOrdersAndImage(){
    return repository.fetchOrdersAndImage();
  }

  Future<void> storeReview(Map<String,dynamic> details){
    return repository.storeReview(details);
  }

  Future<Map<String, List<String>>> getSubCategories(){
    return repository.getSubCategories();
  }

  Future<bool> deleteUser(){
    return repository.deleteUser();
  }

}