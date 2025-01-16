
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FirebaseStorageServices extends GetxController{
  static FirebaseStorageServices get instance => Get.find();

  final _firebaseStorage = FirebaseStorage.instance;

  ///Uploading local assets
///Return a list containing image data
 Future<Uint8List> getImageDataFromAssets(String path) async {
   try{
     final byteData = await rootBundle.load(path);
     final imageData = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
     return imageData;
   }catch(e) {
     //handling exceptions
     throw 'Error loading image data: $e';
   }
 }

 ///uploading image using image data on cloud firebase storage
///return the download url
  Future<String> uploadImageData(String path, Uint8List image, String name) async {
   try {
     final ref = _firebaseStorage.ref(path).child(name);
     await ref.putData(image);
     final url = await ref.getDownloadURL();
     return url;
   }catch(e) {
     //handling exceptions
     throw 'Error loading image data: $e';
   }
  }

}