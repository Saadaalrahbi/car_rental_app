import 'package:auto_access/features/rent/models/rental_shops_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'car_attributes_model.dart';
import 'car_variation_model.dart';

class CarModel {
  String id;
  int availability;
  String? sku;
  double price;
  String title;
  DateTime? date;
  String thumbnail;
  bool? isFeatured;
  RentalShopModel? rentalShop;
  String? categoryId;
  String? carType;
  String? description;
  List<String>? images;
  List<CarAttributeModel>? carAttributes;
  List<CarVariationModel>? carVariations;


  CarModel({
    required this.id,
    required this.title,
    required this.availability,
    required this.price,
    required this.thumbnail,
    this.carType,
    this.description,
    this.sku,
    this.rentalShop,
    this.categoryId,
    this.date,
    this.images,
    this.isFeatured,
    this.carAttributes,
    this.carVariations,
  });

  ///Empty function for clean code
 static CarModel empty() => CarModel(id: '', title: '', availability: 0, price: 0.0, thumbnail: '', carType: '');

 toJson() {
   return {
     'SKU' : sku,
     'Title': title,
     'Availability': availability,
     'Price' : price,
     'Images' : images ?? [],
     'Thumbnail' : thumbnail,
     'IsFeatured' : isFeatured,
     'CategoryId': categoryId,
     'RentalShop' : rentalShop!.toJson(),
     'Description' : description,
     'CarAttributes': carAttributes != null? carAttributes!.map((e) => e.toJson()).toList() : [],
     'CarVariations': carVariations != null? carVariations!.map((e) => e.toJson()).toList() : [],
   };
 }

///Mapping Json oriented document snapshot from firebase to usermodel
 factory CarModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
   final data = document.data()!;
   return CarModel(
   id: document.id,
    title: data['Title'],
    availability: data['Availability'] ?? 0,
   price: double.parse((data['Price'] ?? 0.0)),
   thumbnail: data['Thumbnail'] ?? '',
    categoryId: data['CategoryId'] ?? '',
   isFeatured: data['IsFeatured'] ?? false,
    description: data['Description'] ?? '',
     images: data['Images'] != null ? List<String>.from(data['Images']) : [],
     sku: data['SKU'],
     carType: data['CarType'] ?? '',
     carAttributes: (data['CarAttributes'] as List<dynamic>).map((e) => CarAttributeModel.fromJson(e)).toList(),
     carVariations: (data['CarVariations'] as List<dynamic>).map((e) => CarVariationModel.fromJson(e)).toList(),
   );
 }

///Mapping Json oriented document snapshot from firebase to Model
 factory CarModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
   final data = document.data() as Map<String, dynamic>;
   return CarModel(
     id: document.id,
     title: data['Title'],
     availability: data['Availability'] ?? 0,
     price: double.parse((data['Price'] ?? 0.0)),
     thumbnail: data['Thumbnail'] ?? '',
     categoryId: data['CategoryId'] ?? '',
     isFeatured: data['IsFeatured'] ?? false,
     description: data['Description'] ?? '',
     images: data['Images'] != null ? List<String>.from(data['Images']) : [],
     sku: data['SKU'],
     carType: data['CarType'] ?? '',
     carAttributes: (data['CarAttributes'] as List<dynamic>).map((e) => CarAttributeModel.fromJson(e)).toList(),
     carVariations: (data['CarVariations'] as List<dynamic>).map((e) => CarVariationModel.fromJson(e)).toList(),
   );
 }



}