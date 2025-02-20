import 'dart:io';

import 'package:auto_access/data/repositories/authentication/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../features/personalization/models/user_model.dart';
import '../../../utility/exception/firebase_auth_exceptions.dart';
import '../../../utility/exception/firebase_exceptions.dart';
import '../../../utility/exception/format_exceptions.dart';
import '../../../utility/exception/platform_exceptions.dart';


///Repository class for user - related operations
class UserRepository extends GetxController{
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  ///Function for saving user data to the Firestore
 Future<void> saveUserRecord(UserModel user) async {
   try {
     await _db.collection("Users").doc(user.id).set(user.toJson());
   } on FirebaseAuthException catch (e) {
     throw RFirebaseAuthException(e.code).message;
   }  on FirebaseException catch (e) {
     throw RFirebaseException(e.code).message;
   } on FormatException catch (_) {
     throw const RFormatException();
   } on PlatformException catch (e) {
     throw RPlatformException(e.code).message;
   } catch (e) {
     throw 'Something went wrong, Please try again';
   }
 }

 ///Function for fetching user details based on user ID
  Future<UserModel> fetchUserDetails() async {
    try {
     final documentSnapshot = await _db.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).get();
      if(documentSnapshot.exists){
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseAuthException catch (e) {
      throw RFirebaseAuthException(e.code).message;
    }  on FirebaseException catch (e) {
      throw RFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const RFormatException();
    } on PlatformException catch (e) {
      throw RPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }
///Function to update user data in Firestore
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db.collection("Users").doc(updatedUser.id).update(updatedUser.toJson());
    } on FirebaseAuthException catch (e) {
      throw RFirebaseAuthException(e.code).message;
    }  on FirebaseException catch (e) {
      throw RFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const RFormatException();
    } on PlatformException catch (e) {
      throw RPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }
///Updating any field in specific user collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).update(json);
    } on FirebaseAuthException catch (e) {
      throw RFirebaseAuthException(e.code).message;
    }  on FirebaseException catch (e) {
      throw RFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const RFormatException();
    } on PlatformException catch (e) {
      throw RPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }
///function to remove user data from firestore
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("Users").doc(userId).delete();
    } on FirebaseAuthException catch (e) {
      throw RFirebaseAuthException(e.code).message;
    }  on FirebaseException catch (e) {
      throw RFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const RFormatException();
    } on PlatformException catch (e) {
      throw RPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }
///uploading Image
 Future<String> uploadImage(String path, XFile image) async {
 try {
     final ref = FirebaseStorage.instance.ref(path).child(image.name);
     await ref.putFile(File(image.path));
     final url = await ref.getDownloadURL();
     return url;
   }on FirebaseAuthException catch (e) {
     throw RFirebaseAuthException(e.code).message;
   }  on FirebaseException catch (e) {
     throw RFirebaseException(e.code).message;
   } on FormatException catch (_) {
     throw const RFormatException();
   } on PlatformException catch (e) {
     throw RPlatformException(e.code).message;
   } catch (e) {
     throw 'Something went wrong, Please try again';
   }
 }
}
