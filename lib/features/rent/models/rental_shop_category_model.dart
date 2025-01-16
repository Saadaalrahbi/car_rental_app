import 'package:cloud_firestore/cloud_firestore.dart';

class RentalShopCategoryModel {
  final String rentalShopId;
  final String categoryId;

  RentalShopCategoryModel({
    required this.rentalShopId,
    required this.categoryId,
  });

  Map<String, dynamic> toJson() {
    return {
      'rentalShopId': rentalShopId,
      'categoryId': categoryId,
    };
  }

  factory RentalShopCategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return RentalShopCategoryModel(
      rentalShopId: data['rentalShopId'] as String,
      categoryId: data['categoryId'] as String,
    );
  }
}