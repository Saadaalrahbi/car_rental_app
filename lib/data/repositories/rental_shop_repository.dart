import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import '../../features/rent/models/rental_shop_category_model.dart';
import '../../features/rent/models/rental_shops_model.dart';
import '../../utility/constants/enums.dart';
import '../services/firebase_storage_service.dart';


class RentalShopRepository extends GetxController {
  static RentalShopRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;


  /// Get all categories
  Future<List<RentalShopModel>> getAllRentalShop() async {
    try {
      final snapshot = await _db.collection("RentalShop").get();
      final result = snapshot.docs.map((e) => RentalShopModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Something Went Wrong! Please try again.';
    }
  }

  /// Get all categories
  Future<RentalShopModel?> getSingleRentalShop(String id) async {
    try {
      final snapshot = await _db.collection("RentalShop").where('Id', isEqualTo: id).get();
      final result = snapshot.docs.map((e) => RentalShopModel.fromSnapshot(e)).toList();
      return result.firstOrNull;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Something Went Wrong! Please try again.';
    }
  }


  /// Get Featured categories
  Future<List<RentalShopModel>> getFeaturedRentalShops() async {
    try {
      final snapshot = await _db.collection("RentalShop").where('IsFeatured', isEqualTo: true).limit(4).get();
      final result = snapshot.docs.map((e) => RentalShopModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Something Went Wrong! Please try again.';
    }
  }


  /// Get Featured categories
  Future<List<RentalShopModel>> getRentalShopForCategory(String categoryId) async {
    try {
      // Query to get all documents where categoryId matches the provided categoryId
      QuerySnapshot rentalShopCategoryQuery = await _db.collection('RentalShopCategory').where('categoryId', isEqualTo: categoryId).get();

      // Extract brandIds from the documents
      List<String> rentalShopIds = rentalShopCategoryQuery.docs.map((doc) => doc['rentalShopId'] as String).toList();

      // Query to get all documents where the brandId is in the list of brandIds, FieldPath.documentId to query documents in Collection
      final rentalShopsQuery = await _db.collection('RentalShop').where(FieldPath.documentId, whereIn: rentalShopIds).limit(2).get();

      // Extract brand names or other relevant data from the documents
      List<RentalShopModel> rentalShops = rentalShopsQuery.docs.map((doc) => RentalShopModel.fromSnapshot(doc)).toList();

      return rentalShops;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Something Went Wrong! Please try again.';
    }
  }



  /// Upload Categories to the Cloud Firebase
  Future<void> uploadDummyData(List<RentalShopModel> rentalShops) async {
    try {
      // Upload all the Categories along with their Images
      final storage = Get.put(TFirebaseStorageService());

      // Loop through each brand
      for (var rentalShop in rentalShops) {

        // Get ImageData link from the local assets
        final file = await storage.getImageDataFromAssets(rentalShop.image);

        // Upload Image and Get its URL
        final url = await storage.uploadImageData('RentalShops', file, path.basename(rentalShop.name), MediaCategory.rentalShops.name);


        rentalShop.image = url;


        await _db.collection("RentalShops").doc(rentalShop.id).set(rentalShop.toJson());
      }

    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }


  /// Upload BrandCategory to the Cloud Firebase
  Future<void> uploadRentalShopCategoryDummyData(List<RentalShopCategoryModel> rentalShopCategory) async {
    try {
      // Loop through each category
      for (var entry in rentalShopCategory) {
        // Store Category in Firestore
        await _db.collection("RentalShopCategory").doc().set(entry.toJson());
      }
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

}
