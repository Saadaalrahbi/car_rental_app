import 'package:auto_access/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utility/constants/image_strings.dart';
import '../../../../utility/constants/sizes.dart';
import '../../../../utility/constants/text_strings.dart';
import '../../../../utility/helpers/helper_function.dart';
import '../login/login.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => Get.back(), icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(RSizes.defaultSpace),
        child: Column(
          children: [
            ///image with 60% of screen width
            Image(image: const AssetImage(RImages.deliveredEmail), width: RHelperFunctions.screenWidth() * 0.6,),
             const SizedBox(height: RSizes.spaceBtwSections),

            ///Email, Title and subtitle
            Text(email, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
            const SizedBox(height: RSizes.spaceBtwItems),
            Text(RTexts.resetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
            const SizedBox(height: RSizes.spaceBtwItems),

            Text(RTexts.resetPasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center),
            const SizedBox(height: RSizes.spaceBtwSections),

            ///Buttons
            SizedBox(width: double.infinity,
              child: ElevatedButton(onPressed: () => Get.offAll(() => const LoginScreen()), child:const Text(RTexts.doneButton),
              ),
            ),
            const SizedBox(height: RSizes.spaceBtwItems),
            SizedBox(width: double.infinity,
              child: TextButton(onPressed: () => ForgetPasswordController.instance.resendPasswordResetEmail(email), child:const Text(RTexts.resendEmail),
              ),
            ),

          ],
        ),),
      )

    );
  }
}
