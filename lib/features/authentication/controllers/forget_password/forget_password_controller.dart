import 'package:auto_access/common/widgets/loaders/loaders.dart';
import 'package:auto_access/data/repositories/authentication/authentication_repository.dart';
import 'package:auto_access/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:auto_access/utility/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utility/constants/image_strings.dart';
import '../../../../utility/helpers/network_manager.dart';

class ForgetPasswordController extends GetxController{
  static ForgetPasswordController get instance => Get.find();

  ///Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  ///Sending Reset Password Email
 sendPasswordResetEmail() async {
   try {
     //Start loading
     FullScreenLoader.openLoadingDialog('Processing your request...', RImages.processing);

     //Check Internet Connectivity
     final isConnected = await NetworkManager.instance.isConnected();
     if(!isConnected) {
       FullScreenLoader.stopLoading();
       return;
     }

     //Form validation
     if (!forgetPasswordFormKey.currentState!.validate()) {
       FullScreenLoader.stopLoading();
       return;}
     //Sending email resent link
     await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

     //Remove the loader
     FullScreenLoader.stopLoading();

     Loaders.successSnackBar(title: 'Email Sent', message: 'Password Reset Link has been sent'.tr);

     //Redirect
     Get.to(() => ResetPasswordScreen(email: email.text.trim()));
   } catch (e) {
     //Remove the loader
     FullScreenLoader.stopLoading();
     Loaders.errorSnackBar(title: 'Oops', message: e.toString());
   }
 }

 resendPasswordResetEmail(String email) async {
   try {
     //Start loading
     FullScreenLoader.openLoadingDialog('Processing your request...', RImages.processing);

     //Check Internet Connectivity
     final isConnected = await NetworkManager.instance.isConnected();
     if(!isConnected) {
       FullScreenLoader.stopLoading();
       return;
     }
     //Sending email resent link
     await AuthenticationRepository.instance.sendPasswordResetEmail(email);

     //Remove the loader
     FullScreenLoader.stopLoading();

     Loaders.successSnackBar(title: 'Email Sent', message: 'Password Reset Link has been sent'.tr);
   } catch (e) {
     //Remove the loader
     FullScreenLoader.stopLoading();
     Loaders.errorSnackBar(title: 'Oops', message: e.toString());
   }
 }
}