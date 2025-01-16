import 'package:auto_access/common/widgets/loaders/loaders.dart';
import 'package:auto_access/data/repositories/authentication/authentication_repository.dart';
import 'package:auto_access/features/authentication/screens/signup/widgets/verify_email.dart';
import 'package:auto_access/features/personalization/models/user_model.dart';
import 'package:auto_access/utility/constants/image_strings.dart';
import 'package:auto_access/utility/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/personalization/user_repository.dart';
import '../../../../utility/helpers/network_manager.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  ///variables
  final hidePassword = true.obs; //Observable for hiding and showing password
  final email = TextEditingController(); //Controller for Email input
  final lastName = TextEditingController(); //Controller for last name input
  final username = TextEditingController(); //Controller for username input
  final firstName = TextEditingController(); //Controller for first name input
  final phoneNumber = TextEditingController(); //Controller for phone number input
  final password = TextEditingController(); //Controller for password input
  GlobalKey<FormState> signupFormKey = GlobalKey<
      FormState>(); //Form key for form validation


  ///SIGNUP
  void signup() async {
    try {
      //Start loading
      FullScreenLoader.openLoadingDialog(
          'We are processing your information...', RImages.processing);

      //Check for internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //Remove Loader
        FullScreenLoader.stopLoading();
        return;
      }

      //Form validation
      if (!signupFormKey.currentState!.validate()) {
        //Remove Loader
        FullScreenLoader.stopLoading();
        return;
      }


      //Register user in the Firebase Authentication & Save user data in Firebase
      final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());

      //Save Authenticated user data in the Firebase Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      //Remove Loader
      FullScreenLoader.stopLoading();

      //Showing success message
      Loaders.successSnackBar(title: 'Congratulation',
          message: 'Your Account has been created! Verify email to continue.');

      //Moving to verify email screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    }
    catch (e) {
      //Remove Loader
      FullScreenLoader.stopLoading();

      //Show some Generic error to user
      Loaders.errorSnackBar(title: 'Oops!', message: e.toString());
    }
  }
}