import 'dart:async';

import 'package:auto_access/common/widgets/loaders/loaders.dart';
import 'package:auto_access/common/widgets/sucess_screen/success_screen.dart';
import 'package:auto_access/data/repositories/authentication/authentication_repository.dart';
import 'package:auto_access/utility/constants/image_strings.dart';
import 'package:auto_access/utility/constants/text_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  ///Sending email whenever verify screen appears and a timer for auto redirect
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  ///Sending Email Verification Link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      Loaders.successSnackBar(
          title: 'Email Sent',
          message: 'Please check your inbox and verify your email.');
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oops!', message: e.toString());
    }
  }

  ///Timer to automatically redirect on Email verification.
  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() =>
            SuccessScreen(image: RImages.successfullyRegistered,
                title: RTexts.yourAccountCreatedTitle,
                subtitle: RTexts.yourAccountCreatedSubTitle,
                onPressed: () => AuthenticationRepository.instance.screenRedirect()
            ),
        );
      }
    }
    );
  }

///Manually Check if Email is Verified
 checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if(currentUser != null && currentUser.emailVerified){
      Get.off(() =>
          SuccessScreen(
              image: RImages.successfullyRegistered,
              title: RTexts.yourAccountCreatedTitle,
              subtitle: RTexts.yourAccountCreatedSubTitle,
              onPressed: () => AuthenticationRepository.instance.screenRedirect()
          ),
      );
    }
 }
}
