import 'dart:io';
import 'package:auto_access/data/repositories/rental_shop_repository.dart';
import 'package:path/path.dart' as path;
import 'package:auto_access/features/rent/models/car_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../utility/constants/enums.dart';
import '../../../utility/exception/firebase_exceptions.dart';
import '../../../utility/exception/format_exceptions.dart';
import '../../../utility/exception/platform_exceptions.dart';
import '../../services/firebase_storage_service.dart';

///Repository for managing car-related data and operations
class CarRepository extends GetxController {
  static CarRepository get instance => Get.find();

  ///firebase instance for database operations
 final _db = FirebaseFirestore.instance;

 ///Getting limited cars
  Future<List<CarModel>> getFeaturedCars() async {
    try {
      final snapshot = await _db.collection('Cars').where('IsFeatured', isEqualTo: true).limit(4).get();
      return snapshot.docs.map((querySnapshot) => CarModel.fromSnapshot(querySnapshot)).toList();
    } on FirebaseException catch (e) {
      throw RFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw RPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get limited featured cars.
  Future<CarModel> getSingleCar(String carId) async {
    try {
      final snapshot = await _db.collection('Cars').doc(carId).get();
      return CarModel.fromSnapshot(snapshot);
    } on FirebaseException catch (e) {
      throw RFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw RPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get all featured cars using Stream.
  Future<List<CarModel>> getAllFeaturedCars() async {
    final snapshot = await _db.collection('Cars').where('IsFeatured', isEqualTo: true).get();
    return snapshot.docs.map((querySnapshot) => CarModel.fromSnapshot(querySnapshot)).toList();
  }

  /// Get cars based on the rental shop
  Future<List<CarModel>> fetchCarsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<CarModel> carList = querySnapshot.docs.map((doc) => CarModel.fromQuerySnapshot(doc)).toList();
      return carList;
    } on FirebaseException catch (e) {
      throw RFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw RPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }


  /// Fetches cars for a specific category.
  /// If the limit is -1, retrieves all cars for the category; otherwise, limits the result based on the provided limit.
  /// Returns a list of [CarModel] objects.
  Future<List<CarModel>> getCarsForCategory({required String categoryId, int limit = 4}) async {
    try {
      // Query to get all documents where carId matches the provided categoryId & Fetch limited or unlimited based on limit
      QuerySnapshot carCategoryQuery = limit == -1
          ? await _db.collection('CarCategory').where('categoryId', isEqualTo: categoryId).get()
          : await _db.collection('CarCategory').where('categoryId', isEqualTo: categoryId).limit(limit).get();

      // Extract car Ids from the documents
      List<String> carIds = carCategoryQuery.docs.map((doc) => doc['carId'] as String).toList();

      // Query to get all documents where the rentalShop Id is in the list of rentalShopIds, FieldPath.documentId to query documents in Collection
      final carsQuery = await _db.collection('Cars').where(FieldPath.documentId, whereIn: carIds).get();

      // Extract rental shop names or other relevant data from the documents
      List<CarModel> cars = carsQuery.docs.map((doc) => CarModel.fromSnapshot(doc)).toList();

      return cars;
    } on FirebaseException catch (e) {
      throw RFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw RPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Fetches cars for a specific rental shop.
  /// If the limit is -1, retrieves all cars for the rental shop; otherwise, limits the result based on the provided limit.
  /// Returns a list of [CarModel] objects.
  Future<List<CarModel>> getCarsForRentalShop(String rentalShopId, int limit) async {
    try {
      // Query to get all documents where carId matches the provided categoryId & Fetch limited or unlimited based on limit
      QuerySnapshot<Map<String, dynamic>> querySnapshot = limit == -1
          ? await _db.collection('Cars').where('RentalShop.Id', isEqualTo: rentalShopId).get()
          : await _db.collection('Cars').where('RentalShop.Id', isEqualTo: rentalShopId).limit(limit).get();

      // Map cars
      final cars = querySnapshot.docs.map((doc) => CarModel.fromSnapshot(doc)).toList();

      return cars;
    } on FirebaseException catch (e) {
      throw RFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw RPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<CarModel>> searchCars(String query, {String? categoryId, String? rentalShopId, double? minPrice, double? maxPrice}) async {
    try {
      // Reference to the 'cars' collection in Firestore
      CollectionReference carsCollection = FirebaseFirestore.instance.collection('Cars');

      // Start with a basic query to search for cars where the name contains the query
      Query queryRef = carsCollection;

      // Apply the search filter
      if (query.isNotEmpty) {
        queryRef = queryRef.where('Title', isGreaterThanOrEqualTo: query).where('Title', isLessThanOrEqualTo: '$query\uf8ff');
      }

      // Apply filters
      if (categoryId != null) {
        queryRef = queryRef.where('CategoryId', isEqualTo: categoryId);
      }

      if (rentalShopId != null) {
        queryRef = queryRef.where('RentalShop.Id', isEqualTo: rentalShopId);
      }

      if (minPrice != null) {
        queryRef = queryRef.where('Price', isGreaterThanOrEqualTo: minPrice);
      }

      if (maxPrice != null) {
        queryRef = queryRef.where('Price', isLessThanOrEqualTo: maxPrice);
      }

      // Execute the query
      QuerySnapshot querySnapshot = await queryRef.get();

      final cars = querySnapshot.docs.map((doc) => CarModel.fromQuerySnapshot(doc)).toList();
      return cars;
    } on FirebaseException catch (e) {
      throw RFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw RPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Update any field in specific Collection
  Future<void> updateSingleField(String docId, Map<String, dynamic> json) async {
    try {
      await _db.collection("Cars").doc(docId).update(json);
    } on FirebaseException catch (e) {
      throw RFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const RFormatException();
    } on PlatformException catch (e) {
      throw RPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Update car.
  Future<void> updateCar(CarModel car) async {
    try {
      await _db.collection('Cars').doc(car.id).update(car.toJson());
    } on FirebaseException catch (e) {
      throw RFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const RFormatException();
    } on PlatformException catch (e) {
      throw RPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Upload dummy data to the Cloud Firebase.
  Future<void> uploadDummyData(List<CarModel> cars) async {
    try {

      final storage = Get.put(TFirebaseStorageService());

      final rentalShopRepository = Get.put(RentalShopRepository());

      for (var car in cars) {
        final rentalShop = await rentalShopRepository.getSingleRentalShop(car.rentalShop!.id);


        if (rentalShop == null || rentalShop.image.isEmpty) {
          throw 'No Rental Shops found. Please upload Rental Shops first.';
        } else {
          car.rentalShop!.image = rentalShop.image;
        }

        // Get image data link from local assets
        final thumbnail = await storage.getImageDataFromAssets(car.thumbnail);

        // Upload image and get its URL
        final url = await storage.uploadImageData('Cars', thumbnail, path.basename(car.thumbnail), MediaCategory.cars.name);

        car.thumbnail = url;


        if (car.images != null && car.images!.isNotEmpty) {
          List<String> imagesUrl = [];
          for (var image in car.images!) {
            // Get image data link from local assets
            final assetImage = await storage.getImageDataFromAssets(image);

            // Upload image and get its URL
            final url = await storage.uploadImageData('Cars', assetImage, path.basename(image), MediaCategory.cars.name);

            imagesUrl.add(url);
          }
          car.images!.clear();
          car.images!.addAll(imagesUrl);
        }

        // Upload Variation Images
        if (car.carType == CarType.variable.toString()) {
          for (var variation in car.carVariations!) {
            // Get image data link from local assets
            final assetImage = await storage.getImageDataFromAssets(variation.image);

            // Upload image and get its URL
            final url = await storage.uploadImageData('Cars', assetImage, path.basename(variation.image), MediaCategory.cars.name);

            // Assign URL to variation.image attribute
            variation.image = url;
          }
        }

        // Store product in Firestore
        await _db.collection("Cars").doc(car.id).set(car.toJson());
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