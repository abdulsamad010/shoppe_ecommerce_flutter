import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  final String categoryName,description,id,imageUrl,name,subCategory;
  final List<String> colors,reviews,sizes;
  final List<dynamic>ratings;
  final Timestamp createdAt,arrivalDate;
  final int discountAmount,itemsSold,discountPercentage,price,quantity;
  final bool isAvailable,isDiscount,isMale;
  final List<String> relatedTmages;
  final List<String> materials;
  final String origin;
  final List<String> reviewersImages;
  final List<String> reviewersNames;

  Food({
    required this.materials,
    required this.origin,
    required this.relatedTmages,
    required this.reviewersImages,
    required this.reviewersNames,
    required this.arrivalDate,
    required this.discountPercentage,
    required this.itemsSold,
    required this.categoryName,
    required this.description,
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.subCategory,
    required this.colors,
    required this.reviews,
    required this.sizes,
    required this.ratings,
    required this.createdAt,
    required this.discountAmount,
    required this.price,
    required this.quantity,
    required this.isAvailable,
    required this.isDiscount,
    required this.isMale,
  });
}