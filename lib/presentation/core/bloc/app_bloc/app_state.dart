import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoppe_ecommerce_flutter/data/models/food_model.dart';

import '../../../../domain/entities/food.dart';

class AppState{
  final List<Map<String,dynamic>> cart,delivery_methods,voucher;
  final Map<String,dynamic> cartProgress;

  final Widget suffixIcon;

  final bool isAbscure;
  final String profileImage;
  final String email=FirebaseAuth.instance.currentUser!=null ? FirebaseAuth.instance.currentUser!.email! : "";
  final double orderRaiting;
  final bool isSubmitted;
  final String status;
  final Map<String,dynamic> flashSale;
  final List<Map<String,dynamic>> ordersPlaced;
  final int? voucherUsedIndex;
  final int selectedDeliveryIndex;
  final List<String> favoriteProductsIds;
  final List<Food> searchedProducts,fleshSalesProducts,products,topSoldProducts,newArrivalProducts;
  List<String> searchHistory;
  bool isProceed;
  final int flashSaleIndex;
  final List<Map<String,dynamic>> categories;
  Map<String, List<String>> subCategories;
  final String lastSearch;
  final int screenIndex;
  Map<String, String> filters = {
    'category': '',
    'subCategory': '',
    'gender': 'All',
  };

  List<Food> filteredProducts = [];
  final String address,contact;
  final String deliveryDate;

  AppState({
    required this.contact,
    required this.address,
    this.deliveryDate="",
    required this.flashSale,
    this.status="",
    this.flashSaleIndex=0,
    required this.subCategories,
    required this.filteredProducts,
    required this.filters,
    this.isProceed=false,this.isSubmitted=false,
    required this.orderRaiting,
    required this.ordersPlaced,
    required this.profileImage,
    this.voucherUsedIndex=null,
    this.selectedDeliveryIndex=0,
    required this.delivery_methods,
    required this.voucher,

    required this.favoriteProductsIds,
    required this.cartProgress,
    required this.cart,
    required this.lastSearch,
    required this.searchHistory,
    required this.searchedProducts,
    required this.fleshSalesProducts,

    required this.categories,
    required this.newArrivalProducts,
    required this.topSoldProducts,
    required this.products,
    required this.screenIndex,

    required this.suffixIcon,

    required this.isAbscure,
});
}