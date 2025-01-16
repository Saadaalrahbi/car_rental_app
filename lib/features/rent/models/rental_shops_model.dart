import 'package:cloud_firestore/cloud_firestore.dart';

class RentalShopModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? carCount;

  RentalShopModel({required this.id, required this.image, required this.name, this.isFeatured, this.carCount});

  ///Empty Helper function
 static RentalShopModel empty() => RentalShopModel(id: '', image: '', name: '');

 ///Converting model to Json structure so it can be stored in firebase
 toJson() {
   return {
     'Id': id,
     'Name': name,
     'Image': image,
     'CarCount': carCount,
     'IsFeatured': isFeatured,
   };
 }

 ///Mapping Json oriented document snapshot from firebase to usermodel
factory RentalShopModel.fromJson(Map<String, dynamic> document){
   final data = document;
   if(data.isEmpty) return RentalShopModel.empty();
   return RentalShopModel(
    id: data['Id'] ?? '',
    image: data['Image'] ?? '',
    name: data['Name'] ?? '',
    isFeatured: data['IsFeatured'] ?? false,
    carCount: int.parse((data['CarCount'] ?? 0).toString()),
  );
}

  factory RentalShopModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      // Map JSON Record to the Model
      return RentalShopModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        carCount: data['CarsCount'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
      );
    } else {
      return RentalShopModel.empty();
    }
  }


}
