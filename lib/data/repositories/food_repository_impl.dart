
import 'package:shoppe_ecommerce_flutter/data/datasources/food_data.dart';
import 'package:shoppe_ecommerce_flutter/data/models/food_model.dart';
import 'package:shoppe_ecommerce_flutter/domain/repositories/food_repository.dart';

class FoodRepositoryImpl extends FoodRepository {
  FoodData fD = FoodData();

  Future<List<FoodModel>> getFoodData() async {
    List<Map<String, dynamic>> products = await fD.foodData();

    List<FoodModel> foodProductsModel = [];

    for (int i = 0; i < products.length; i++) {
      foodProductsModel.add(
        FoodModel(
          materials: List<String>.from(products[i]["materials"] ?? []),
          origin: products[i]["origin"] ?? "",
          relatedTmages:
          List<String>.from(products[i]["relatedTmages"] ?? []),
          reviewersImages:
          List<String>.from(products[i]["reviewersImages"] ?? []),
          reviewersNames:
          List<String>.from(products[i]["reviewersNames"] ?? []),

          itemsSold: products[i]["itemsSold"],
          arrivalDate: products[i]["arrivalDate"],
          discountPercentage: products[i]["discountPercentage"],
          name: products[i]["name"],
          description: products[i]["description"],
          price: products[i]["price"],
          sizes: List<String>.from(products[i]["sizes"] ?? []),
          id: products[i]["id"],
          quantity: products[i]["quantity"],
          imageUrl: products[i]["imageUrl"],
          colors: List<String>.from(products[i]["colors"] ?? []),
          categoryName: products[i]["categoryName"],
          createdAt: products[i]["createdAt"],
          discountAmount: products[i]["discountAmount"],
          isAvailable: products[i]["isAvailable"],
          isDiscount: products[i]["isDiscount"],
          isMale: products[i]["isMale"],
          ratings: products[i]["ratings"],
          reviews: List<String>.from(products[i]["reviews"] ?? []),
          subCategory: products[i]["subCategory"],
        ),
      );
    }

    return foodProductsModel;
  }

  void saveSearchHistory(String searchText) {
    fD.saveSearchHistory(searchText);
  }

  Future<Map<String, dynamic>> fetchSearchHistory() async {
    return await fD.fetchSearchHistory();
  }


  Future<List<String>> fetchFavoriteProductsIds()async {
    return await fD.fetchFavoriteProductsIds();
  }

  Future<void> updateFavoriteProductsIds(String productId)async {
    return await fD.updateFavoriteProductsIds(productId);
  }

  Future<List<Map<String,dynamic>>> fetchCart()async{
    return await fD.fetchCart();
  }
  Future<void> updateCart(Map<String,dynamic> specificCartMap,String operation)async{
    return await fD.updateCart(specificCartMap,operation);
  }

  Future<String> fetchAddress()async{
    return await fD.fetchAddress();
  }

  Future<String> fetchContact()async{
    return await fD.fetchContact();
  }

  Future<void> editAddressContact(String value,String purpose)async {
    return await fD.editAddressContact(value,purpose);
  }


  Future<void> storeOrder(Map<String,dynamic> orderDetails)async{
    return await fD.storeOrder(orderDetails);
  }
  Future<List<Map<String,dynamic>>> fetchDelivery()async{
    return await fD.fetchDelivery();
  }
  Future<List<Map<String,dynamic>>> fetchVoucher()async{
    return await fD.fetchVoucher();
  }

  Future<Map<String,dynamic>> fetchOrdersAndImage()async{
    return await fD.fetchOrdersAndImage();
  }

  Future<Map<String, List<String>>> getSubCategories() async{
    return await fD.getSubCategories();
  }

  Future<bool> deleteUser()async{
    return await fD.deleteUser();
  }

  Future<Map<String,dynamic>> fetchFlashSale() async{
    return await fD.fetchFlashSale();
  }

  Future<void> storeReview(Map<String,dynamic> details) async{
    return await fD.storeReview(details);
  }

}
