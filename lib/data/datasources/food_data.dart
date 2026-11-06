import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FoodData {

 Future<List<Map<String, dynamic>>> foodData() async {
  final List<Map<String, dynamic>> products = [];


  final snapshot = await FirebaseFirestore.instance
      .collection("products")
      .get();

  for (int i = 0; i < snapshot.docs.length; i++) {
   products.add(snapshot.docs[i].data() as Map<String, dynamic>);
  }

  return products;
 }


 void saveSearchHistory(String searchText) async {
  await FirebaseFirestore.instance.collection("users_data").doc(
      FirebaseAuth.instance.currentUser!.uid).update(
      {
       'searchHistory': FieldValue.arrayUnion([searchText]),
      }
  );
 }




 Future<Map<String, dynamic>> fetchSearchHistory() async {
  final snapshot=await FirebaseFirestore.instance.collection("users_data").doc(
      FirebaseAuth.instance.currentUser!.uid).get();
  return snapshot.data() ?? {};
 }






 Future<List<String>> fetchFavoriteProductsIds() async {
  final snapshot = await FirebaseFirestore.instance
      .collection("users_data")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();

  final data = snapshot.data();

  return List<String>.from(data?["favoriteProductsIds"] ?? []);
 }

 Future<void> updateFavoriteProductsIds(String productId)async {
  final favorite=await fetchFavoriteProductsIds();

  if(favorite.contains(productId)){

   favorite.remove(productId);

   await FirebaseFirestore.instance
       .collection("users_data")
       .doc(FirebaseAuth.instance.currentUser!.uid).update({
     "favoriteProductsIds":favorite,
   });
  }
  else{
   favorite.add(productId);
   await FirebaseFirestore.instance
       .collection("users_data")
       .doc(FirebaseAuth.instance.currentUser!.uid).update({
    "favoriteProductsIds":favorite,
   });

  }
 }





 Future<List<Map<String, dynamic>>> fetchCart() async {


  final snapshot = await FirebaseFirestore.instance
      .collection("users_data")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();

  final data = snapshot.data();

  return List<Map<String, dynamic>>.from(
   (data?["cart"] ?? []).map(
        (item) => Map<String, dynamic>.from(item),
   ),
  );
 }


 Future<void> updateCart(
     Map<String, dynamic> specificCartMap, String operation) async {
  final cart = await fetchCart();

  if (operation == "add") {
   cart.add(specificCartMap);
  }

  else if (operation == "remove") {


   cart.removeWhere((item) =>
   item["productId"] == specificCartMap["productId"] &&
       item["size"] == specificCartMap["size"] &&
       item["color"] == specificCartMap["color"]);
  }
  else if (operation == "increase") {

   for (int i = 0; i < cart.length; i++) {


    if (cart[i]["productId"] == specificCartMap["productId"] &&
        cart[i]["size"] == specificCartMap["size"] &&
        cart[i]["color"] == specificCartMap["color"]) {
     cart[i]["quantity"] = cart[i]["quantity"] + 1;
    }
   }


  }

  else if (operation == "decrease") {
   for (int i = 0; i < cart.length; i++) {
    if (cart[i]["productId"] == specificCartMap["productId"] &&
        cart[i]["size"] == specificCartMap["size"] &&
        cart[i]["color"] == specificCartMap["color"]) {
     if (cart[i]["quantity"] > 1) {
      cart[i]["quantity"] = cart[i]["quantity"] - 1;
     } else {
      cart.removeAt(i);
     }
     break;
    }
   }
  }

  await FirebaseFirestore.instance
      .collection("users_data")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({
   "cart": cart,
  });
 }





 Future<String> fetchAddress()async{

  final snapshot=await FirebaseFirestore.instance.collection("users_data").doc(FirebaseAuth.instance.currentUser!.uid).get();
  final data=snapshot.data()?["address"] ?? "";
  return data.toString();



 }

 Future<String> fetchContact()    async{



  final snapshot=await FirebaseFirestore.instance.collection("users_data").doc(FirebaseAuth.instance.currentUser!.uid).get();
  final data=snapshot.data()?["phone"] ?? "";
  return data.toString();
 }

 Future<void> editAddressContact(String value,String purpose)async {
  if(purpose=="address"){
   print("$value");
   await FirebaseFirestore.instance.collection("users_data").doc(FirebaseAuth.instance.currentUser!.uid).update({
    "address":value
   });
  }
  else if(purpose=="contact"){
   await FirebaseFirestore.instance.collection("users_data").doc(FirebaseAuth.instance.currentUser!.uid).update({
    "phone":value
   });
  }
 }


 Future<Map<String,dynamic>> fetchFlashSale() async{

  final snapshot = await FirebaseFirestore.instance
      .collection("app_events")
      .doc("flash_sale")
      .get();





  final data = snapshot.data();

  return data ?? {};
 }



 Future<void> storeOrder(Map<String,dynamic> orderDetails)async {
  final ref = await FirebaseFirestore.instance.collection("app_orders").add(
      orderDetails);

  await FirebaseFirestore.instance.collection("app_orders").doc(ref.id).update({
   "order_id":ref.id
  });


  await FirebaseFirestore.instance.collection("users_data").doc(
      FirebaseAuth.instance.currentUser!.uid).update({
   "orders_ids_placed": FieldValue.arrayUnion([ref.id]),
  });

  if (orderDetails["isUsedVoucher"]==true) {
   final collectionSnapshot = await FirebaseFirestore.instance.collection(
       "voucher").get();

   List<Map<String,dynamic>> documents=[];
   List<String> docIds=[];
   for (int i = 0; i < collectionSnapshot.docs.length; i++) {
     documents.add(collectionSnapshot.docs[i].data());
     docIds.add(collectionSnapshot.docs[i].id);
   }
   int index=documents.indexWhere((item)=>item["id"]==orderDetails["voucher_details"]["id"]);
   if(index!=-1){
    await FirebaseFirestore.instance.collection("voucher").doc(docIds[index]).update({"users_ids_used_voucher":FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])});
   }
  }

  await FirebaseFirestore.instance
      .collection("users_data")
      .doc(FirebaseAuth.instance.currentUser!.uid).update({
   "cart":[]
  });


  for (int i = 0; i < orderDetails["cart_items"].length; i++) {
   final snapshot = await FirebaseFirestore.instance
       .collection("products")



       .where(
    "id",
    isEqualTo: orderDetails["cart_items"][i]["productId"],
   )
       .get();

   if (snapshot.docs.isNotEmpty) {
    await snapshot.docs.first.reference.update({
     "quantity": FieldValue.increment(



      -orderDetails["cart_items"][i]["quantity"],
     ),
    });
   }
  }

 }


 Future<List<Map<String, dynamic>>> fetchDelivery() async {





  final snapshot = await FirebaseFirestore.instance
      .collection("delivery_methods")
      .get();





  List<Map<String, dynamic>> delivery = [];

  for (var doc in snapshot.docs) {
   delivery.add(doc.data());
  }

  return delivery;
 }

 Future<List<Map<String, dynamic>>> fetchVoucher() async {
  final snapshot = await FirebaseFirestore.instance
      .collection("voucher")
      .get();

  List<Map<String, dynamic>> vouchers = [];

  for (var doc in snapshot.docs) {
   vouchers.add(doc.data());
  }

  return vouchers;
 }

 Future<Map<String, dynamic>> fetchOrdersAndImage() async {
  try {



   final String uid = FirebaseAuth.instance.currentUser!.uid;

   DocumentSnapshot userDoc = await FirebaseFirestore.instance
       .collection("users_data")
       .doc(uid)
       .get();

   String profileImage = "";
   if (userDoc.exists && userDoc.data() != null) {


    Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
    profileImage = userData["profileImageUrl"] ?? "";



   }

   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
       .collection("app_orders")
       .where("user_id", isEqualTo: uid)
       .get();

   List<Map<String, dynamic>> ordersList = [];
   for (var doc in querySnapshot.docs) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    ordersList.add(data);
   }

   return {
    "orders": ordersList,
    "profileImageUrl": profileImage,
   };
  } catch (e) {
   return {
    "orders": [],
    "profileImageUrl": "",
   };
  }
 }



 Future<void> storeReview(Map<String, dynamic> details) async {

  print("Storing ${details}");



  String email = await FirebaseAuth.instance.currentUser!.email!.split('@')[0];

  var products = await FirebaseFirestore.instance.collection("products").get();

  for (var product in products.docs) {
   await product.reference.update({
    "ratings": FieldValue.arrayUnion([details["rating"]]),

    "reviews": FieldValue.arrayUnion([details["review"]]),


    "reviewersImage": FieldValue.arrayUnion([details["reviewerImage"]]),
    "reviewersNames": FieldValue.arrayUnion([email]),
    "reviewersUid": FieldValue.arrayUnion([
     FirebaseAuth.instance.currentUser!.uid





    ]),
   });
  }


  await FirebaseFirestore.instance
      .collection("app_orders")
      .doc(details["order_id"])
      .update({
   "order_rating": {
    "ratings": details["rating"],
    "reviews": details["review"],
    "reviewersImage": details["reviewerImage"],
    "reviewersNames": [email],
    "reviewersUid": FirebaseAuth.instance.currentUser!.uid,
   },
  });

  print("Stored ${details}");

 }

 Future<Map<String, List<String>>> getSubCategories() async {
  Map<String, List<String>> subCategories = {};

  DocumentSnapshot document = await FirebaseFirestore.instance
      .collection('app_data')
      .doc('sub_categories')
      .get();

  if (document.exists) {
   List<dynamic> data = document.get('categories');

   for (int i = 0; i < data.length; i++) {
    Map<String, dynamic> item = data[i];

    String category = item.keys.first;




    List<String> subCategoryList = [];

    for (int j = 0; j < item[category].length; j++) {



     subCategoryList.add(item[category][j].toString());
    }

    subCategories[category] = subCategoryList;
   }
  }

  return subCategories;
 }

 Future<bool> deleteUser() async {
  final user = FirebaseAuth.instance.currentUser;

  if (user != null) {

   try {

    await user.delete();

    await FirebaseFirestore.instance
        .collection("users_data")
        .doc(user.uid)
        .delete();




    return false;

   }
   catch(e){
    print(e);
    return true;
   }

  }
  return true;
 }


 }


