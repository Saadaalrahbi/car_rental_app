import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../features/personalization/models/setting_model.dart';
import '../../../utility/exception/firebase_auth_exceptions.dart';
import '../../../utility/exception/format_exceptions.dart';
import '../../../utility/exception/platform_exceptions.dart';

class SettingsRepository extends GetxController {
  static SettingsRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Function to save setting data to Firestore.
  Future<void> registerSettings(SettingsModel setting) async {
    try {
      await _db.collection("Settings").doc('GLOBAL_SETTINGS').set(setting.toJson());
    } on FirebaseAuthException catch (e) {
      throw RFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const RFormatException();
    } on PlatformException catch (e) {
      throw RPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Function to fetch setting details based on setting ID.
  Future<SettingsModel> getSettings() async {
    try {
      final querySnapshot = await _db.collection("Settings").doc('GLOBAL_SETTINGS').get();
      return SettingsModel.fromSnapshot(querySnapshot);
    } on FirebaseAuthException catch (e) {
      throw RFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const RFormatException();
    } on PlatformException catch (e) {
      throw RPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print('Something Went Wrong: $e');
      throw 'Something Went Wrong: $e';
    }
  }

  /// Function to update setting data in Firestore.
  Future<void> updateSettingDetails(SettingsModel updatedSetting) async {
    try {
      await _db.collection("Settings").doc('GLOBAL_SETTINGS').update(updatedSetting.toJson());
    } on FirebaseAuthException catch (e) {
      throw RFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const RFormatException();
    } on PlatformException catch (e) {
      throw RPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Update any field in specific Settings Collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db.collection("Settings").doc('GLOBAL_SETTINGS').update(json);
    } on FirebaseAuthException catch (e) {
      throw RFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const RFormatException();
    } on PlatformException catch (e) {
      throw RPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}