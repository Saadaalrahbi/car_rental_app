import 'package:auto_access/common/widgets/loaders/loaders.dart';
import 'package:auto_access/data/repositories/authentication/authentication_repository.dart';
import 'package:auto_access/features/personalization/controllers/user_controller.dart';
import 'package:auto_access/utility/constants/image_strings.dart';
import 'package:auto_access/utility/helpers/network_manager.dart';
import 'package:auto_access/utility/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController{

  ///Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  ///Email and Password Sign in
Future<void>emailAndPasswordSignIn() async {
  try {
    //start loading
    FullScreenLoader.openLoadingDialog('Logging you in... ', RImages.decor);

    //Check Internet Connectivity
    final isConnected = await NetworkManager.instance.isConnected();
    if(!isConnected) {
      FullScreenLoader.stopLoading();
      return;
    }

    //Form validation
    if(!loginFormKey.currentState!.validate()) {
      FullScreenLoader.stopLoading();
      return;
    }

    //Save data if remember me is selected
    if (rememberMe.value) {
      localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
      localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
    }

    //Login user using email and password authentication
    final userCredentials = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

    //Remove loader
    FullScreenLoader.stopLoading();

    //Redirect
    AuthenticationRepository.instance.screenRedirect();
  } catch (e) {
    FullScreenLoader.stopLoading();
    Loaders.errorSnackBar(title: 'Oops!', message: e.toString());
  }

}

///---Google sign in Authentication
 Future<void> googleSignIn() async {
    try {
      //start loading
      FullScreenLoader.openLoadingDialog('Logging you in... ', RImages.decor);

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }
      //Google Authentication
      final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

      //Saving the user record
     await userController.saveUserRecord(userCredentials);

     //Remove the loader
      FullScreenLoader.stopLoading();

      //Redirect
      AuthenticationRepository.instance.screenRedirect();
    }catch (e){
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oops', message: e.toString());
    }
 }

  /// Facebook SignIn Authentication
  Future<void> facebookSignIn() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog('Logging you in...', RImages.decor);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Facebook Authentication
      final userCredentials = await AuthenticationRepository.instance.signInWithFacebook();

      // Save Authenticated user data in the Firebase Firestore
      await userController.saveUserRecord(userCredentials);

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

}