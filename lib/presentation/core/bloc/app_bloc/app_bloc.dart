import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_event.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_state.dart';

import '../../../../domain/entities/food.dart';
import '../../colors/app_colors.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final getFoodsObject;
  AppBloc({required this.getFoodsObject}) : super(AppState(
    cart: [],
    flashSale: {},
      cartProgress: {},
    filteredProducts: [],
    filters: {},
      subCategories: {},
    orderRaiting: 0.0,
    ordersPlaced: [],
    profileImage: "",
      contact: "",
      address: "",
    delivery_methods: [],
    voucher: [],

    favoriteProductsIds: [],
    lastSearch: "",
    searchHistory: [],
    searchedProducts: [],
    fleshSalesProducts: [],

      categories: [
      {
        "name": "Clothing",
        "img1":"",
        "img2":"",
        "img3":"",
        "img4":""
      },

      {
        "name": "Shoes",
        "img1":"",
        "img2":"",
        "img3":"",
        "img4":""
      },

      {
        "name": "Bags",
        "img1":"",
        "img2":"",
        "img3":"",
        "img4":""
      },

      {
        "name": "Lingerie",
        "img1":"",
        "img2":"",
        "img3":"",
        "img4":""
      },

      {
        "name": "Watch",
        "img1":"",
        "img2":"",
        "img3":"",
        "img4":""
      },

      {
        "name": "Hoodies",
        "img1":"",
        "img2":"",
        "img3":"",
        "img4":""
      }

    ],
      newArrivalProducts: [],
    topSoldProducts: [],
    products: [],
      screenIndex: 0,
     isAbscure: false,suffixIcon :Icon(Icons.visibility_off,color: grey,))) {




    on<GetProducts>((event, emit)async {
      final flashSale1=await getFoodsObject.fetchFlashSale();

      final vouchers1=await getFoodsObject.fetchVoucher();
      final delivery1=await getFoodsObject.fetchDelivery();

      Map<String, List<String>> subCategories =
      await getFoodsObject.getSubCategories();

      List<Food> productsOrg = await getFoodsObject.callFoodData();

      List<String> favoriteProductsIds1=await getFoodsObject.fetchFavoriteProductsIds();

      List<Map<String,dynamic>> cart1=await getFoodsObject.fetchCart();

      List<Map<String, dynamic>> categories1 = [
        {
          "name": "Clothing",
          "img1":"",
          "img2":"",
          "img3":"",
          "img4":""
        },

        {
          "name": "Shoes",
          "img1":"",
          "img2":"",
          "img3":"",
          "img4":""
        },

        {
          "name": "Bags",
          "img1":"",
          "img2":"",
          "img3":"",
          "img4":""
        },

        {
          "name": "Lingerie",
          "img1":"",
          "img2":"",
          "img3":"",
          "img4":""
        },

        {
          "name": "Watch",
          "img1":"",
          "img2":"",
          "img3":"",
          "img4":""
        },

        {
          "name": "Hoodies",
          "img1":"",
          "img2":"",
          "img3":"",
          "img4":""
        }

      ];

      for(int j=0;j<state.categories.length;j++){
      for (int i = 0; i < productsOrg.length; i++) {
        if (productsOrg[i].categoryName == state.categories[j]["name"]) {
          if (categories1[j]["img1"] == "") {
            categories1[j]["img1"] = productsOrg[i].imageUrl;
          }
          else if (categories1[j]["img2"] == "") {
            categories1[j]["img2"] = productsOrg[i].imageUrl;
          }
          else if (categories1[j]["img3"] == "") {
            categories1[j]["img3"] = productsOrg[i].imageUrl;
          }
          else if (categories1[j]["img4"] == "") {
            categories1[j]["img4"] = productsOrg[i].imageUrl;
          }
          else {
            break;
          }
        }
      }
    }




      int index;
      int products1;

      List<Food> topSoldProducts1=[];
      for(int k=0;k<productsOrg.length;k++) {
        index=-1;
        products1=-1;
        for (int i = 0; i < productsOrg.length; i++) {
          if (products1 < productsOrg[i].itemsSold && !(topSoldProducts1.contains(productsOrg[i]))) {
            products1 = productsOrg[i].itemsSold;
            index = i;
          }
        }

        if(products1==-1){
          break;
        }
        topSoldProducts1.add(productsOrg[index]);

      }



      int index2;
      DateTime products2;
      List<Food> newArrivalProducts1 = [];

      for (int k = 0; k < productsOrg.length; k++) {
        index2 = -1;
        products2 = DateTime(2000);

        for (int i = 0; i < productsOrg.length; i++) {
          if (products2.isBefore(
            productsOrg[i].arrivalDate.toDate(),
          ) &&
              !newArrivalProducts1.contains(productsOrg[i])) {
            products2 = productsOrg[i].arrivalDate.toDate();
            index2 = i;
          }
        }

        if (index2 == -1) {
          break;
        }

        newArrivalProducts1.add(productsOrg[index2]);

        if (newArrivalProducts1.length == 5) {
          break;
        }
      }




      int index3;
      int products3;

      List<Food> fleshSalesProducts1=[];
      for(int k=0;k<productsOrg.length;k++) {
        index3=-1;
        products3=0;
        for (int i = 0; i < productsOrg.length; i++) {
          if (products3 < productsOrg[i].discountPercentage && !(fleshSalesProducts1.contains(productsOrg[i]))) {
            products3 = productsOrg[i].discountPercentage;
            index3 = i;
          }
        }

        if(products3==0){
          break;
        }
        fleshSalesProducts1.add(productsOrg[index3]);

      }




      emit(AppState(
        flashSale: flashSale1,
          subCategories: subCategories,
          filters: state.filters,
          cartProgress:state.cartProgress,
          filteredProducts: state.filteredProducts,
          orderRaiting: state.orderRaiting,
          ordersPlaced: state.ordersPlaced,
          profileImage: state.profileImage,
          contact: state.contact,
          delivery_methods: delivery1,
          voucher: vouchers1,
          address: state.address,
        favoriteProductsIds:favoriteProductsIds1,
        cart: cart1,
          lastSearch: state.lastSearch,
          searchHistory: state.searchHistory,
          searchedProducts: state.searchedProducts,
          fleshSalesProducts:fleshSalesProducts1,
          categories: categories1,
          topSoldProducts: topSoldProducts1,
          newArrivalProducts: newArrivalProducts1,
        products: productsOrg,
          screenIndex: state.screenIndex,
          isAbscure: state.isAbscure,
          suffixIcon: state.suffixIcon));
    });


    on<SelectedFlashSalesDiscount>((event, emit) async{

      List<Food> productsOrg = await getFoodsObject.callFoodData();


      int index3;
      int products3;

      List<Food> fleshSalesProducts1=[];

      if(event.percentSelected=="All") {
        for (int k = 0; k < productsOrg.length; k++) {
          index3 = -1;
          products3 = -1;
          for (int i = 0; i < productsOrg.length; i++) {
            if (products3 < productsOrg[i].discountPercentage &&
                !(fleshSalesProducts1.contains(productsOrg[i]))) {
              products3 = productsOrg[i].discountPercentage;
              index3 = i;
            }
          }

          if (products3 == -1) {
            break;
          }
          fleshSalesProducts1.add(productsOrg[index3]);
        }
      }
      else {
        for (int k = 0; k < productsOrg.length; k++) {
          index3 = -1;
          products3 = -1;
          for (int i = 0; i < productsOrg.length; i++) {
            if (int.parse(event.percentSelected.toString()) == productsOrg[i].discountPercentage &&
                !(fleshSalesProducts1.contains(productsOrg[i]))) {
              products3 = productsOrg[i].discountPercentage;
              index3 = i;
            }
          }

          if (products3 == -1) {
            break;
          }
          fleshSalesProducts1.add(productsOrg[index3]);
        }
      }


      emit(AppState(
        flashSale: state.flashSale,
        flashSaleIndex: state.flashSaleIndex,
        subCategories: state.subCategories,
        filters: state.filters,
        filteredProducts: state.filteredProducts,
        orderRaiting: state.orderRaiting,
        ordersPlaced: state.ordersPlaced,
        profileImage: state.profileImage,
        delivery_methods: state.delivery_methods,
        voucher: state.voucher,
        contact: state.contact,
        address: state.address,
        favoriteProductsIds: state.favoriteProductsIds,
        cart: state.cart,
        cartProgress:state.cartProgress,
        lastSearch: state.lastSearch,
        searchHistory: state.searchHistory,
        searchedProducts: state.searchedProducts,
        fleshSalesProducts: fleshSalesProducts1,
        categories: state.categories,
        topSoldProducts: state.topSoldProducts,
        newArrivalProducts: state.newArrivalProducts,
        products: state.products,
        screenIndex: state.screenIndex,
       isAbscure:state.isAbscure,
        suffixIcon: state.suffixIcon,
      ));
    });


    on<SelectFlashSales>((event, emit) {
      emit(AppState(
        flashSale: state.flashSale,
        flashSaleIndex: event.percentIndex,
        subCategories: state.subCategories,
        filters: state.filters,
        filteredProducts: state.filteredProducts,
        orderRaiting: state.orderRaiting,
        ordersPlaced: state.ordersPlaced,
        profileImage: state.profileImage,
        delivery_methods: state.delivery_methods,
        voucher: state.voucher,
        cartProgress:state.cartProgress,
        contact: state.contact,
        address: state.address,
        favoriteProductsIds: state.favoriteProductsIds,
        cart: state.cart,
        lastSearch: state.lastSearch,
        searchHistory: state.searchHistory,
        searchedProducts: state.searchedProducts,
        fleshSalesProducts: state.fleshSalesProducts,
        categories: state.categories,
        topSoldProducts: state.topSoldProducts,
        newArrivalProducts: state.newArrivalProducts,
        products: state.products,
        screenIndex: state.screenIndex,
       isAbscure:state.isAbscure,
        suffixIcon: state.suffixIcon,
      ));
    });




    on<UpdateFilters>((event, emit) async {
      Map<String, List<String>> subCategories =
      await getFoodsObject.getSubCategories();

      List<Food> filteredProducts = [];

      for (int i = 0; i < state.products.length; i++) {
        Food food = state.products[i];

        bool categoryMatch = event.filters['category']!.isEmpty ||
            food.categoryName == event.filters['category'];

        bool subCategoryMatch =
            event.filters['subCategory']!.isEmpty ||
                food.subCategory == event.filters['subCategory'];

        bool genderMatch = event.filters['gender'] == 'All' ||
            (event.filters['gender'] == 'Male' && food.isMale) ||
            (event.filters['gender'] == 'Female' && !food.isMale);

        if (categoryMatch && subCategoryMatch && genderMatch) {
          filteredProducts.add(food);
        }
      }

      emit(AppState(
        flashSale: state.flashSale,
         orderRaiting: state.orderRaiting,
        deliveryDate: state.deliveryDate,
        ordersPlaced: state.ordersPlaced,
        profileImage: state.profileImage,
        voucherUsedIndex: state.voucherUsedIndex,
        selectedDeliveryIndex: state.selectedDeliveryIndex,
        delivery_methods: state.delivery_methods,
        voucher: state.voucher,
        contact: state.contact,
        cartProgress:state.cartProgress,
        address: state.address,
        favoriteProductsIds: state.favoriteProductsIds,
        cart: state.cart,
        lastSearch: state.lastSearch,
        searchHistory: state.searchHistory,
        searchedProducts: state.searchedProducts,
        fleshSalesProducts: state.fleshSalesProducts,
        categories: state.categories,
        topSoldProducts: state.topSoldProducts,
        newArrivalProducts: state.newArrivalProducts,
        products: state.products,
        screenIndex: state.screenIndex,
        isAbscure: state.isAbscure,
        suffixIcon: state.suffixIcon,

        filters: event.filters,
        filteredProducts: filteredProducts,
        subCategories: subCategories,
      ));
    });



    on<ClearFilter>((event, emit) async {

      emit(AppState(
        flashSale: state.flashSale,
        orderRaiting: state.orderRaiting,
        deliveryDate: state.deliveryDate,
        ordersPlaced: state.ordersPlaced,
        profileImage: state.profileImage,
        cartProgress:state.cartProgress,
        voucherUsedIndex: state.voucherUsedIndex,
        selectedDeliveryIndex: state.selectedDeliveryIndex,
        delivery_methods: state.delivery_methods,
        voucher: state.voucher,
        contact: state.contact,
        address: state.address,
        favoriteProductsIds: state.favoriteProductsIds,
        cart: state.cart,
        lastSearch: state.lastSearch,
        searchHistory: state.searchHistory,
        searchedProducts: state.searchedProducts,
        fleshSalesProducts: state.fleshSalesProducts,
        categories: state.categories,
        topSoldProducts: state.topSoldProducts,
        newArrivalProducts: state.newArrivalProducts,
        products: state.products,
        screenIndex: state.screenIndex,
        isAbscure: state.isAbscure,
        suffixIcon: state.suffixIcon,
        filters: {},
        filteredProducts: [],
        subCategories: state.subCategories,
      ));
    });


    on<ChangeVisibility>((event, emit) {
      emit(AppState(
        flashSale: state.flashSale,
        subCategories: state.subCategories,
        filters: state.filters,
        filteredProducts: state.filteredProducts,
        orderRaiting: state.orderRaiting,
        ordersPlaced: state.ordersPlaced,
        profileImage: state.profileImage,
        delivery_methods: state.delivery_methods,
        voucher: state.voucher,
        contact: state.contact,
        cartProgress:state.cartProgress,
        address: state.address,
        favoriteProductsIds: state.favoriteProductsIds,
        cart: state.cart,
        lastSearch: state.lastSearch,
        searchHistory: state.searchHistory,
        searchedProducts: state.searchedProducts,
        fleshSalesProducts: state.fleshSalesProducts,
        categories: state.categories,
        topSoldProducts: state.topSoldProducts,
        newArrivalProducts: state.newArrivalProducts,
        products: state.products,
        screenIndex: state.screenIndex,
       isAbscure: event.isAbscure,
      suffixIcon: event.suffixIcon,
      ));
    });



    on<ChangeDeliveryIndex>((event, emit) {
      String deliveryDate1=DateTime.now().add(Duration(days: state.delivery_methods[event.index]["max_days"])).toString().substring(0,10);
      emit(AppState(
        flashSale: state.flashSale,
        subCategories: state.subCategories,
        filters: state.filters,
        cartProgress:state.cartProgress,
        filteredProducts: state.filteredProducts,
        orderRaiting: state.orderRaiting,
        deliveryDate: deliveryDate1,
        ordersPlaced: state.ordersPlaced,
        profileImage: state.profileImage,
        voucherUsedIndex: state.voucherUsedIndex,
        selectedDeliveryIndex: event.index,
        delivery_methods: state.delivery_methods,
        voucher: state.voucher,
        contact: state.contact,
        address: state.address,
        favoriteProductsIds: state.favoriteProductsIds,
        cart: state.cart,
        lastSearch: state.lastSearch,
        searchHistory: state.searchHistory,
        searchedProducts: state.searchedProducts,
        fleshSalesProducts: state.fleshSalesProducts,
        categories: state.categories,
        topSoldProducts: state.topSoldProducts,
        newArrivalProducts: state.newArrivalProducts,
        products: state.products,
        screenIndex: state.screenIndex,
        isAbscure: state.isAbscure,
        suffixIcon: state.suffixIcon,
      ));
    });


    on<ChangeRating>((event, emit) {

      print("change raiing bloc${event.value}");

      double rating1=0.0;
      try {
        rating1 = event.value;
      }
      catch(e) {
        print(e);
      }

      print("after change raiing bloc${event.value}");

        emit(AppState(
          flashSale: state.flashSale,
          cartProgress:state.cartProgress,
          subCategories: state.subCategories,
          filters: state.filters,
          filteredProducts: state.filteredProducts,
          orderRaiting: rating1,
          ordersPlaced: state.ordersPlaced,
          profileImage: state.profileImage,
          voucherUsedIndex: state.voucherUsedIndex,
          selectedDeliveryIndex: state.selectedDeliveryIndex,
          delivery_methods: state.delivery_methods,
          voucher: state.voucher,
          contact: state.contact,
          address: state.address,
          favoriteProductsIds: state.favoriteProductsIds,
          cart: state.cart,
          lastSearch: state.lastSearch,
          searchHistory: state.searchHistory,
          searchedProducts: state.searchedProducts,
          fleshSalesProducts: state.fleshSalesProducts,
          categories: state.categories,
          topSoldProducts: state.topSoldProducts,
          newArrivalProducts: state.newArrivalProducts,
          products: state.products,
          screenIndex: state.screenIndex,
          isAbscure: state.isAbscure,
          suffixIcon: state.suffixIcon,
        ));

      print("after emit raiing bloc${state.orderRaiting}");


    }
    );


    on<SaveRating>((event, emit) async{

      print("****bloc");

      emit(AppState(
        flashSale: state.flashSale,
        isProceed: true,
        cartProgress:state.cartProgress,
        subCategories: state.subCategories,
        filters: state.filters,
        filteredProducts: state.filteredProducts,
        orderRaiting: state.orderRaiting,
        ordersPlaced: state.ordersPlaced,
        profileImage: state.profileImage,
        voucherUsedIndex: state.voucherUsedIndex,
        selectedDeliveryIndex: state.selectedDeliveryIndex,
        delivery_methods: state.delivery_methods,
        voucher: state.voucher,
        contact: state.contact,
        address: state.address,
        favoriteProductsIds: state.favoriteProductsIds,
        cart: state.cart,
        lastSearch: state.lastSearch,
        searchHistory: state.searchHistory,
        searchedProducts: state.searchedProducts,
        fleshSalesProducts: state.fleshSalesProducts,
        categories: state.categories,
        topSoldProducts: state.topSoldProducts,
        newArrivalProducts: state.newArrivalProducts,
        products: state.products,
        screenIndex: state.screenIndex,
        isAbscure: state.isAbscure,
        suffixIcon: state.suffixIcon,
      ));





      try {
        await getFoodsObject.storeReview({
          "rating": state.orderRaiting,
          "review": event.ratingValue,
          "reviewerImage": state.profileImage,
          "order_id": state.ordersPlaced[event.ordersPlacedIndex]["order_id"]
        });
      }
      catch(e) {
        print(e);
      }

        print("bloc completed");

        add(GetProducts());

        emit(AppState(
          flashSale: state.flashSale,
          isProceed: false,
          isSubmitted: true,
          subCategories: state.subCategories,
          filters: state.filters,
          filteredProducts: state.filteredProducts,
          orderRaiting: state.orderRaiting,
          ordersPlaced: state.ordersPlaced,
          profileImage: state.profileImage,
          voucherUsedIndex: state.voucherUsedIndex,
          selectedDeliveryIndex: state.selectedDeliveryIndex,
          delivery_methods: state.delivery_methods,
          voucher: state.voucher,
          cartProgress:state.cartProgress,
          contact: state.contact,
          address: state.address,
          favoriteProductsIds: state.favoriteProductsIds,
          cart: state.cart,
          lastSearch: state.lastSearch,
          searchHistory: state.searchHistory,
          searchedProducts: state.searchedProducts,
          fleshSalesProducts: state.fleshSalesProducts,
          categories: state.categories,
          topSoldProducts: state.topSoldProducts,
          newArrivalProducts: state.newArrivalProducts,
          products: state.products,
          screenIndex: state.screenIndex,
          isAbscure: state.isAbscure,
          suffixIcon: state.suffixIcon,
        ));

    });



    on<StoreOrder>((event, emit) async{


      emit(AppState(
        flashSale: state.flashSale,
        isProceed: true,
        cartProgress:state.cartProgress,
        subCategories: state.subCategories,
        filters: state.filters,
        filteredProducts: state.filteredProducts,
        ordersPlaced: state.ordersPlaced,
        profileImage: state.profileImage,
        voucherUsedIndex: null,
        delivery_methods: state.delivery_methods,
        voucher: state.voucher,
        contact: state.contact,
        address: state.address,
        favoriteProductsIds: state.favoriteProductsIds,
        cart: state.cart,
        orderRaiting: state.orderRaiting,
        lastSearch: state.lastSearch,
        searchHistory: state.searchHistory,
        searchedProducts: state.searchedProducts,
        fleshSalesProducts: state.fleshSalesProducts,
        categories: state.categories,
        topSoldProducts: state.topSoldProducts,
        newArrivalProducts: state.newArrivalProducts,
        products: state.products,
        screenIndex: state.screenIndex,
        isAbscure: state.isAbscure,
        suffixIcon:state.suffixIcon,
      ));



      await getFoodsObject.storeOrder({
        "total_cost":event.totalCost,
        "user_id":FirebaseAuth.instance.currentUser!.uid,
        "isUsedVoucher":state.voucherUsedIndex!=null ? true : false,
        "voucher_details":state.voucher[state.selectedDeliveryIndex],
        "cart_items":state.cart,
        "delivery_method":state.delivery_methods[state.selectedDeliveryIndex],
        "order_status":["Packed"],
        "order_status_date":[DateTime.now()],
        "status_note":["Your parcel is packed and will be handed over to our delivery partner."],
        "order_date":DateTime.now(),
        "last_delivery_date":DateTime.now().add(Duration(days: state.delivery_methods[state.selectedDeliveryIndex]["max_days"])),
        "payment_method":"cash",
        "address":state.address,
        "phone_number":state.contact,
        "email":FirebaseAuth.instance.currentUser!.email
      });


      final vouchers1=await getFoodsObject.fetchVoucher();

      List<Map<String,dynamic>> cart1=await getFoodsObject.fetchCart();

      emit(AppState(
        flashSale: state.flashSale,
        isProceed: false,
        cartProgress:state.cartProgress,
        subCategories: state.subCategories,
        filters: state.filters,
        filteredProducts: state.filteredProducts,
        ordersPlaced: state.ordersPlaced,
        profileImage: state.profileImage,
        voucherUsedIndex: null,
        delivery_methods: state.delivery_methods,
        voucher: vouchers1,
        contact: state.contact,
        address: state.address,
        favoriteProductsIds: state.favoriteProductsIds,
        cart: cart1,
        orderRaiting: state.orderRaiting,
        lastSearch: state.lastSearch,
        searchHistory: state.searchHistory,
        searchedProducts: state.searchedProducts,
        fleshSalesProducts: state.fleshSalesProducts,
        categories: state.categories,
        topSoldProducts: state.topSoldProducts,
        newArrivalProducts: state.newArrivalProducts,
        products: state.products,
        screenIndex: state.screenIndex,
        isAbscure: state.isAbscure,
        suffixIcon:state.suffixIcon,
      ));
    });



    on<StoreVoucherInApp>((event, emit) async{
      emit(AppState(
        flashSale: state.flashSale,
        cartProgress:state.cartProgress,
        subCategories: state.subCategories,
        filters: state.filters,
        filteredProducts: state.filteredProducts,
        ordersPlaced: state.ordersPlaced,
        profileImage: state.profileImage,
        voucherUsedIndex:event.voucherIndex,
        delivery_methods: state.delivery_methods,
        voucher: state.voucher,
        orderRaiting: state.orderRaiting,
        contact: state.contact,
        address: state.address,
        favoriteProductsIds: state.favoriteProductsIds,
        cart: state.cart,
        lastSearch: state.lastSearch,
        searchHistory: state.searchHistory,
        searchedProducts: state.searchedProducts,
        fleshSalesProducts: state.fleshSalesProducts,
        categories: state.categories,
        topSoldProducts: state.topSoldProducts,
        newArrivalProducts: state.newArrivalProducts,
        products: state.products,
        screenIndex: state.screenIndex,
        isAbscure:state.isAbscure,
        suffixIcon:state.suffixIcon,
      ));
    });



    on<RemoveVoucherInApp>((event, emit) async{
      emit(AppState(
        flashSale: state.flashSale,
        subCategories: state.subCategories,
        filters: state.filters,
        filteredProducts: state.filteredProducts,
        orderRaiting: state.orderRaiting,
        cartProgress:state.cartProgress,
        ordersPlaced: state.ordersPlaced,
        profileImage: state.profileImage,
        voucherUsedIndex:null,
        delivery_methods: state.delivery_methods,
        voucher: state.voucher,
        contact: state.contact,
        address: state.address,
        favoriteProductsIds: state.favoriteProductsIds,
        cart: state.cart,
        lastSearch: state.lastSearch,
        searchHistory: state.searchHistory,
        searchedProducts: state.searchedProducts,
        fleshSalesProducts: state.fleshSalesProducts,
        categories: state.categories,
        topSoldProducts: state.topSoldProducts,
        newArrivalProducts: state.newArrivalProducts,
        products: state.products,
        screenIndex: state.screenIndex,
        isAbscure:state.isAbscure,
        suffixIcon:state.suffixIcon,
      ));
    });




    on<UpdateCart>((event, emit) {


      var cart1 = List<Map<String, dynamic>>.from(state.cart);
      cart1[event.cartIndex]["quantity"] = event.quantity;

      emit(AppState(
        flashSale: state.flashSale,
        subCategories: state.subCategories,
        filters: state.filters,
        filteredProducts: state.filteredProducts,
        ordersPlaced: state.ordersPlaced,
        profileImage: state.profileImage,
        contact: state.contact,
        delivery_methods: state.delivery_methods,
        voucher: state.voucher,
        orderRaiting: state.orderRaiting,
        address: state.address,
        favoriteProductsIds: state.favoriteProductsIds,
        cartProgress: state.cartProgress,
        cart: cart1,
        lastSearch: state.lastSearch,
        searchHistory: state.searchHistory,
        searchedProducts: state.searchedProducts,
        fleshSalesProducts: state.fleshSalesProducts,
        categories: state.categories,
        topSoldProducts: state.topSoldProducts,
        newArrivalProducts: state.newArrivalProducts,
        products: state.products,
        screenIndex: state.screenIndex,
       isAbscure: state.isAbscure,
        suffixIcon: state.suffixIcon,
      ));
    });




    on<UpdateCartProgress>((event, emit) {

      var cartProgress1=Map<String, dynamic>.from(state.cartProgress);
      cartProgress1.addAll({
        "productId":event.productId,
        "quantity":event.quantity,
        "size":event.size,
        "color":event.color
      });

print("${event.quantity}");
      emit(AppState(
        flashSale: state.flashSale,
        subCategories: state.subCategories,
        filters: state.filters,

        filteredProducts: state.filteredProducts,
        ordersPlaced: state.ordersPlaced,
        profileImage: state.profileImage,
        contact: state.contact,
        delivery_methods: state.delivery_methods,
        voucher: state.voucher,
        address: state.address,
        favoriteProductsIds: state.favoriteProductsIds,
        cartProgress: cartProgress1,
        cart: state.cart,
        orderRaiting: state.orderRaiting,
        lastSearch: state.lastSearch,
        searchHistory: state.searchHistory,
        searchedProducts: state.searchedProducts,
        fleshSalesProducts: state.fleshSalesProducts,
        categories: state.categories,
        topSoldProducts: state.topSoldProducts,
        newArrivalProducts: state.newArrivalProducts,
        products: state.products,
        screenIndex: state.screenIndex,
        isAbscure: state.isAbscure,
        suffixIcon: state.suffixIcon,
      ));
    });





    on<AddToFavourite>((event, emit) async{

      await getFoodsObject.updateFavoriteProductsIds(event.productId);

      final favoriteProductsIds1=await getFoodsObject.fetchFavoriteProductsIds();


      emit(AppState(
        flashSale: state.flashSale,
        subCategories: state.subCategories,
        filters: state.filters,
        filteredProducts: state.filteredProducts,
        ordersPlaced: state.ordersPlaced,
        profileImage: state.profileImage,
        contact: state.contact,
        delivery_methods: state.delivery_methods,
        voucher: state.voucher,
        address: state.address,
        orderRaiting: state.orderRaiting,
        favoriteProductsIds:favoriteProductsIds1,
        cartProgress: state.cartProgress,
        cart: state.cart,
        lastSearch: state.lastSearch,
        searchHistory: state.searchHistory,
        searchedProducts: state.searchedProducts,
        fleshSalesProducts: state.fleshSalesProducts,
        categories: state.categories,
        topSoldProducts: state.topSoldProducts,
        newArrivalProducts: state.newArrivalProducts,
        products: state.products,
        screenIndex: state.screenIndex,
        isAbscure: state.isAbscure,
        suffixIcon: state.suffixIcon,
      ));
    });


    on<RemoveFromFavourite>((event, emit) async{

      await getFoodsObject.updateFavoriteProductsIds(event.productId);

      final favoriteProductsIds1=await getFoodsObject.fetchFavoriteProductsIds();


      emit(AppState(
        flashSale: state.flashSale,
        subCategories: state.subCategories,
        filters: state.filters,
        filteredProducts: state.filteredProducts,
        ordersPlaced: state.ordersPlaced,
        orderRaiting: state.orderRaiting,
        profileImage: state.profileImage,
        contact: state.contact,
        delivery_methods: state.delivery_methods,
        voucher: state.voucher,
        address: state.address,
        favoriteProductsIds:favoriteProductsIds1,
        cartProgress: state.cartProgress,
        cart: state.cart,
        lastSearch: state.lastSearch,
        searchHistory: state.searchHistory,
        searchedProducts: state.searchedProducts,
        fleshSalesProducts: state.fleshSalesProducts,
        categories: state.categories,
        topSoldProducts: state.topSoldProducts,
        newArrivalProducts: state.newArrivalProducts,
        products: state.products,
        screenIndex: state.screenIndex,
        isAbscure: state.isAbscure,
        suffixIcon: state.suffixIcon,
      ));
    });



    on<AddToCart>((event, emit) async{

      var cart1=List<Map<String, dynamic>>.from(state.cart);

      cart1.add(Map<String, dynamic>.from(state.cartProgress));

      await getFoodsObject.updateCart(cart1[cart1.length-1],"add");

      final cart2=await getFoodsObject.fetchCart();

      emit(AppState(
        flashSale: state.flashSale,
        subCategories: state.subCategories,
        filters: state.filters,
        filteredProducts: state.filteredProducts,
        ordersPlaced: state.ordersPlaced,
        profileImage: state.profileImage,
        contact: state.contact,
        orderRaiting: state.orderRaiting,
        delivery_methods: state.delivery_methods,
        voucher: state.voucher,
        address: state.address,
        favoriteProductsIds: state.favoriteProductsIds,
        cart: cart2,
        cartProgress:state.cartProgress,
        lastSearch: state.lastSearch,
        searchHistory: state.searchHistory,
        searchedProducts: state.searchedProducts,
        fleshSalesProducts: state.fleshSalesProducts,
        categories: state.categories,
        topSoldProducts: state.topSoldProducts,
        newArrivalProducts: state.newArrivalProducts,
        products: state.products,
        screenIndex: state.screenIndex,
        isAbscure: state.isAbscure,
        suffixIcon:state.suffixIcon,
      ));
    });


    on<RemoveFromCart>((event, emit) async{

      var cart1=List<Map<String, dynamic>>.from(state.cart);

      await getFoodsObject.updateCart(cart1[event.removeIndex],"remove");

      final cart2=await getFoodsObject.fetchCart();

      emit(AppState(
        flashSale: state.flashSale,
        subCategories: state.subCategories,
        filters: state.filters,
        filteredProducts: state.filteredProducts,
        ordersPlaced: state.ordersPlaced,
        orderRaiting: state.orderRaiting,
        profileImage: state.profileImage,
        contact: state.contact,
        delivery_methods: state.delivery_methods,
        voucher: state.voucher,
        address: state.address,
        favoriteProductsIds: state.favoriteProductsIds,
        cart: cart2,
        cartProgress:state.cartProgress,
        lastSearch: state.lastSearch,
        searchHistory: state.searchHistory,
        searchedProducts: state.searchedProducts,
        fleshSalesProducts: state.fleshSalesProducts,
        categories: state.categories,
        topSoldProducts: state.topSoldProducts,
        newArrivalProducts: state.newArrivalProducts,
        products: state.products,
        screenIndex: state.screenIndex,
        isAbscure: state.isAbscure,
        suffixIcon:state.suffixIcon,
      ));
    });


    on<IncreaseQuantityFromCart>((event, emit) async{

      var cart1=List<Map<String, dynamic>>.from(state.cart);

      await getFoodsObject.updateCart(cart1[event.increaseIndex],"increase");

      final cart2=await getFoodsObject.fetchCart();

      emit(AppState(
        flashSale: state.flashSale,
        subCategories: state.subCategories,
        filters: state.filters,
        cartProgress:state.cartProgress,
        filteredProducts: state.filteredProducts,
        ordersPlaced: state.ordersPlaced,
        profileImage: state.profileImage,
        contact: state.contact,
        delivery_methods: state.delivery_methods,
        orderRaiting: state.orderRaiting,
        voucher: state.voucher,
        address: state.address,
        favoriteProductsIds: state.favoriteProductsIds,
        cart: cart2,
        lastSearch: state.lastSearch,
        searchHistory: state.searchHistory,
        searchedProducts: state.searchedProducts,
        fleshSalesProducts: state.fleshSalesProducts,
        categories: state.categories,
        topSoldProducts: state.topSoldProducts,
        newArrivalProducts: state.newArrivalProducts,
        products: state.products,
        screenIndex: state.screenIndex,
        isAbscure: state.isAbscure,
        suffixIcon:state.suffixIcon,
      ));
    });


    on<DecreaseQuantityFromCart>((event, emit) async{

      var cart1=List<Map<String, dynamic>>.from(state.cart);

      await getFoodsObject.updateCart(cart1[event.decreaseIndex],"decrease");

      final cart2=await getFoodsObject.fetchCart();

      emit(AppState(
        flashSale: state.flashSale,
        subCategories: state.subCategories,
        filters: state.filters,
        cartProgress:state.cartProgress,
        filteredProducts: state.filteredProducts,
        ordersPlaced: state.ordersPlaced,
        profileImage: state.profileImage,
        contact: state.contact,
        delivery_methods: state.delivery_methods,
        voucher: state.voucher,
        address: state.address,
        orderRaiting: state.orderRaiting,
        favoriteProductsIds: state.favoriteProductsIds,
        cart: cart2,
        lastSearch: state.lastSearch,
        searchHistory: state.searchHistory,
        searchedProducts: state.searchedProducts,
        fleshSalesProducts: state.fleshSalesProducts,
        categories: state.categories,
        topSoldProducts: state.topSoldProducts,
        newArrivalProducts: state.newArrivalProducts,
        products: state.products,
        screenIndex: state.screenIndex,
        isAbscure: state.isAbscure,
        suffixIcon:state.suffixIcon,
      ));
    });



    on<LoadAddress>((event, emit) async{

      String deliveryDate1=DateTime.now().add(Duration(days: state.delivery_methods[state.selectedDeliveryIndex]["max_days"])).toString().substring(0,10);


      String address1=await getFoodsObject.fetchAddress();

      emit(AppState(
        flashSale: state.flashSale,
        subCategories: state.subCategories,
        filters: state.filters,
        filteredProducts: state.filteredProducts,
        deliveryDate: deliveryDate1,
        ordersPlaced: state.ordersPlaced,
        profileImage: state.profileImage,
        voucherUsedIndex: state.voucherUsedIndex,
        selectedDeliveryIndex: state.selectedDeliveryIndex,
        contact: state.contact,
        cartProgress:state.cartProgress,
        orderRaiting: state.orderRaiting,
        delivery_methods: state.delivery_methods,
        voucher: state.voucher,
        address: address1,
        favoriteProductsIds: state.favoriteProductsIds,
        cart: state.cart,
        lastSearch: state.lastSearch,
        searchHistory: state.searchHistory,
        searchedProducts: state.searchedProducts,
        fleshSalesProducts: state.fleshSalesProducts,
        categories: state.categories,
        topSoldProducts: state.topSoldProducts,
        newArrivalProducts: state.newArrivalProducts,
        products: state.products,
        screenIndex: state.screenIndex,
        isAbscure: state.isAbscure,
        suffixIcon: state.suffixIcon,
      ));
    });


    on<LoadContact>((event, emit) async{

      String deliveryDate1=DateTime.now().add(Duration(days: state.delivery_methods[state.selectedDeliveryIndex]["max_days"])).toString().substring(0,10);

      String contact1=await getFoodsObject.fetchContact();

      emit(AppState(
        flashSale: state.flashSale,
        subCategories: state.subCategories,
        filters: state.filters,
        filteredProducts: state.filteredProducts,
        deliveryDate: deliveryDate1,
        ordersPlaced: state.ordersPlaced,
        profileImage: state.profileImage,
        voucherUsedIndex: state.voucherUsedIndex,
        selectedDeliveryIndex: state.selectedDeliveryIndex,
        orderRaiting: state.orderRaiting,
        delivery_methods: state.delivery_methods,
        voucher: state.voucher,
        contact:contact1,
        address: state.address,
        favoriteProductsIds: state.favoriteProductsIds,
        cart: state.cart,
        lastSearch: state.lastSearch,
        searchHistory: state.searchHistory,
        searchedProducts: state.searchedProducts,
        fleshSalesProducts: state.fleshSalesProducts,
        cartProgress:state.cartProgress,
        categories: state.categories,
        topSoldProducts: state.topSoldProducts,
        newArrivalProducts: state.newArrivalProducts,
        products: state.products,
        screenIndex: state.screenIndex,
        isAbscure: state.isAbscure,
        suffixIcon: state.suffixIcon,
      ));
    });

    on<EditAddress>((event, emit) async {
      await getFoodsObject.editAddressContact(event.value, event.purpose);

      if (event.purpose == "contact"){
        String contact1 = await getFoodsObject.fetchContact();

        emit(AppState(
          flashSale: state.flashSale,
          cartProgress:state.cartProgress,
          subCategories: state.subCategories,
          filters: state.filters,
          filteredProducts: state.filteredProducts,
          ordersPlaced: state.ordersPlaced,
          profileImage: state.profileImage,
          selectedDeliveryIndex: state.selectedDeliveryIndex,
          voucherUsedIndex: state.voucherUsedIndex,
          contact: contact1,
          delivery_methods: state.delivery_methods,
          voucher: state.voucher,
          address: state.address,
          orderRaiting: state.orderRaiting,
          favoriteProductsIds: state.favoriteProductsIds,
          cart: state.cart,
          lastSearch: state.lastSearch,
          searchHistory: state.searchHistory,
          searchedProducts: state.searchedProducts,
          fleshSalesProducts: state.fleshSalesProducts,
          categories: state.categories,
          topSoldProducts: state.topSoldProducts,
          newArrivalProducts: state.newArrivalProducts,
          products: state.products,
          screenIndex: state.screenIndex,
          isAbscure: state.isAbscure,
          suffixIcon: state.suffixIcon,
        ));
      }else{
        String address1 = await getFoodsObject.fetchAddress();

        emit(AppState(
          flashSale: state.flashSale,
          subCategories: state.subCategories,
          filters: state.filters,
          filteredProducts: state.filteredProducts,
          ordersPlaced: state.ordersPlaced,
          profileImage: state.profileImage,
          selectedDeliveryIndex: state.selectedDeliveryIndex,
          voucherUsedIndex: state.voucherUsedIndex,
          contact: state.contact,
          delivery_methods: state.delivery_methods,
          voucher: state.voucher,
          address: address1,
          orderRaiting: state.orderRaiting,
          favoriteProductsIds: state.favoriteProductsIds,
          cart: state.cart,
          lastSearch: state.lastSearch,
          searchHistory: state.searchHistory,
          searchedProducts: state.searchedProducts,
          fleshSalesProducts: state.fleshSalesProducts,
          categories: state.categories,
          topSoldProducts: state.topSoldProducts,
          newArrivalProducts: state.newArrivalProducts,
          products: state.products,
          cartProgress:state.cartProgress,
          screenIndex: state.screenIndex,
          isAbscure: state.isAbscure,
          suffixIcon: state.suffixIcon,
        ));
      }

    });



    on<AddFavorateToCart>((event, emit) async{

      var cart1=List<Map<String, dynamic>>.from(state.cart);



      int productIndex=state.products.indexWhere((item){
        return item.id==event.productId;
      });

      if(productIndex!=-1){
        cart1.add({
          "productId":event.productId,
          "quantity":1,
          "size":state.products[productIndex].sizes[0],
          "color":state.products[productIndex].colors[0]
        });
      }

      await getFoodsObject.updateCart(cart1[cart1.length-1],"add");

      final cart2=await getFoodsObject.fetchCart();

      emit(AppState(
        flashSale: state.flashSale,
        cartProgress:state.cartProgress,
        subCategories: state.subCategories,
        filters: state.filters,
        filteredProducts: state.filteredProducts,
        ordersPlaced: state.ordersPlaced,
        profileImage: state.profileImage,
        contact: state.contact,
        delivery_methods: state.delivery_methods,
        voucher: state.voucher,
        address: state.address,
        favoriteProductsIds: state.favoriteProductsIds,
        cart: cart2,
        orderRaiting: state.orderRaiting,
        lastSearch: state.lastSearch,
        searchHistory: state.searchHistory,
        searchedProducts: state.searchedProducts,
        fleshSalesProducts: state.fleshSalesProducts,
        categories: state.categories,
        topSoldProducts: state.topSoldProducts,
        newArrivalProducts: state.newArrivalProducts,
        products: state.products,
        screenIndex: state.screenIndex,
        isAbscure: state.isAbscure,
        suffixIcon:state.suffixIcon,
      ));
    });




    on<SearchProducts>((event, emit) async{


      getFoodsObject.callSaveSearchHistory(
          event.searchText.trim().toLowerCase());

      List<Food> searchedProducts1=[];
      for(int i=0;i<state.products.length;i++){


        if(state.products[i].name.trim().toLowerCase()==event.searchText.trim().toLowerCase()){
          searchedProducts1.add(state.products[i]);
        }

        if(state.products[i].categoryName.trim().toLowerCase()==event.searchText.trim().toLowerCase()){
          searchedProducts1.add(state.products[i]);
        }

        if(state.products[i].discountPercentage.toString()==event.searchText){
          searchedProducts1.add(state.products[i]);
        }

        if(state.products[i].price.toString()==event.searchText){
          searchedProducts1.add(state.products[i]);
        }

        if(state.products[i].subCategory.trim().toLowerCase()==event.searchText.trim().toLowerCase()){
          searchedProducts1.add(state.products[i]);
        }

        if(state.products[i].colors.contains(event.searchText)){
          searchedProducts1.add(state.products[i]);
        }

        if(state.products[i].sizes.contains(event.searchText)){
          searchedProducts1.add(state.products[i]);
        }
      }

      emit(AppState(
          flashSale: state.flashSale,
          cartProgress:state.cartProgress,
          subCategories: state.subCategories,
          filters: state.filters,
          filteredProducts: state.filteredProducts,
          ordersPlaced: state.ordersPlaced,
          profileImage: state.profileImage,
          contact: state.contact,
          orderRaiting: state.orderRaiting,
          delivery_methods: state.delivery_methods,
          voucher: state.voucher,
          address: state.address,
          favoriteProductsIds: state.favoriteProductsIds,
          cart: state.cart,
          lastSearch: state.lastSearch,
          searchHistory: state.searchHistory,
          searchedProducts: searchedProducts1,
          fleshSalesProducts: state.fleshSalesProducts,
          categories: state.categories,
          topSoldProducts: state.topSoldProducts,
          newArrivalProducts: state.newArrivalProducts,
          products: state.products,
          screenIndex: state.screenIndex,
          isAbscure: state.isAbscure,suffixIcon: state.suffixIcon));


      final searchHistory1 = List<String>.from(
        (await getFoodsObject.callFetchSearchHistory())["searchHistory"] ?? [],
      );


      emit(AppState(
          cartProgress:state.cartProgress,
          flashSale: state.flashSale,
          subCategories: state.subCategories,
          filters: state.filters,
          filteredProducts: state.filteredProducts,
          ordersPlaced: state.ordersPlaced,
          profileImage: state.profileImage,
          contact: state.contact,
          orderRaiting: state.orderRaiting,
          delivery_methods: state.delivery_methods,
          voucher: state.voucher,
          address: state.address,
          favoriteProductsIds: state.favoriteProductsIds,
          cart: state.cart,
        lastSearch: event.searchText,
          searchHistory: searchHistory1,
          searchedProducts: searchedProducts1,
          fleshSalesProducts: state.fleshSalesProducts,
          categories: state.categories,
          topSoldProducts: state.topSoldProducts,
          newArrivalProducts: state.newArrivalProducts,
          products: state.products,
          screenIndex: state.screenIndex,
          isAbscure: state.isAbscure,suffixIcon: state.suffixIcon));



    });






    on<LoadSearchHistory>((event, emit) async{
      final searchHistory1 = List<String>.from(
        (await getFoodsObject.callFetchSearchHistory())["searchHistory"] ?? [],
      );
      emit(AppState(
          flashSale: state.flashSale,
          cartProgress:state.cartProgress,
          subCategories: state.subCategories,
          filters: state.filters,
          filteredProducts: state.filteredProducts,
          ordersPlaced: state.ordersPlaced,
          profileImage: state.profileImage,
          contact: state.contact,
          delivery_methods: state.delivery_methods,
          voucher: state.voucher,
          orderRaiting: state.orderRaiting,
          address: state.address,
          favoriteProductsIds: state.favoriteProductsIds,
          cart: state.cart,
          lastSearch: state.lastSearch,
        searchHistory: searchHistory1,
          searchedProducts: state.searchedProducts,
          fleshSalesProducts: state.fleshSalesProducts,
          categories: state.categories,
          topSoldProducts: state.topSoldProducts,
          newArrivalProducts: state.newArrivalProducts,
          products: state.products,
          screenIndex: state.screenIndex,
          isAbscure: state.isAbscure,suffixIcon: state.suffixIcon));


    });




    on<ClearSearch>((event, emit) {


      emit(AppState(
          flashSale: state.flashSale,
          subCategories: state.subCategories,
          filters: state.filters,
          filteredProducts: state.filteredProducts,
          ordersPlaced: state.ordersPlaced,
          profileImage: state.profileImage,
          contact: state.contact,
          cartProgress:state.cartProgress,
          delivery_methods: state.delivery_methods,
          voucher: state.voucher,
          address: state.address,
          orderRaiting: state.orderRaiting,
          favoriteProductsIds: state.favoriteProductsIds,
          cart: state.cart,
          lastSearch: state.lastSearch,
          searchHistory: state.searchHistory,
          searchedProducts:[],
          fleshSalesProducts: state.fleshSalesProducts,
          categories: state.categories,
          topSoldProducts: state.topSoldProducts,
          newArrivalProducts: state.newArrivalProducts,
          products: state.products,
          screenIndex: state.screenIndex,
          isAbscure: state.isAbscure,suffixIcon: state.suffixIcon));

    });







    on<ScreensNavigation>((event, emit) async{

      emit(AppState(
        cartProgress:state.cartProgress,
        subCategories: state.subCategories,
        filters: state.filters,
        filteredProducts: state.filteredProducts,
        orderRaiting: state.orderRaiting,
        ordersPlaced: state.ordersPlaced,
        profileImage: state.profileImage,
        contact: state.contact,
        delivery_methods: state.delivery_methods,
        voucher: state.voucher,
        address: state.address,
        favoriteProductsIds: state.favoriteProductsIds,
        cart: state.cart,
        flashSale: state.flashSale,
        lastSearch: state.lastSearch,
        searchHistory: state.searchHistory,
        searchedProducts: state.searchedProducts,
        fleshSalesProducts: state.fleshSalesProducts,
        categories: state.categories,
        topSoldProducts: state.topSoldProducts,
        newArrivalProducts: state.newArrivalProducts,
        products: state.products,
        screenIndex: event.index,
        isAbscure: state.isAbscure,
        suffixIcon: state.suffixIcon,
      ));
    });










    on<LoadOrdersAndProfileImage>((event, emit) async{

      Map<String, dynamic> result = await getFoodsObject.fetchOrdersAndImage();
      List<Map<String, dynamic>> ordersPlaced1 = result["orders"];
      String profileImage1 = result["profileImageUrl"];

      emit(AppState(
        flashSale: state.flashSale,
        subCategories: state.subCategories,
        filters: state.filters,
        filteredProducts: state.filteredProducts,
        orderRaiting: state.orderRaiting,
        ordersPlaced: ordersPlaced1,
        profileImage: profileImage1,
        contact: state.contact,
        delivery_methods: state.delivery_methods,
        voucher: state.voucher,
        address: state.address,
        favoriteProductsIds: state.favoriteProductsIds,
        cart: state.cart,
        lastSearch: state.lastSearch,
        searchHistory: state.searchHistory,
        searchedProducts: state.searchedProducts,
        fleshSalesProducts: state.fleshSalesProducts,
        cartProgress:state.cartProgress,
        categories: state.categories,
        topSoldProducts: state.topSoldProducts,
        newArrivalProducts: state.newArrivalProducts,
        products: state.products,
        screenIndex: state.screenIndex,
        isAbscure: state.isAbscure,
        suffixIcon: state.suffixIcon,
      ));
    });


  }
}
