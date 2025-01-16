import 'package:auto_access/data/repositories/authentication/authentication_repository.dart';
import 'package:auto_access/features/authentication/controllers/signup/verify_email_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utility/constants/image_strings.dart';
import '../../../../../utility/constants/sizes.dart';
import '../../../../../utility/constants/text_strings.dart';
import '../../../../../utility/helpers/helper_function.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,   //removing the back arrow in the screen
        //cross button at the top right
        actions: [
          IconButton(onPressed: () => AuthenticationRepository.instance.logout(), icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        //padding to give default equal space on all sides in all screens
        child: Padding(padding: const EdgeInsets.all(RSizes.defaultSpace),
        child: Column(
          children: [
            ///image
        Image(image: const AssetImage(RImages.deliveredEmail), width: RHelperFunctions.screenWidth() * 0.9,),
            const SizedBox(height: RSizes.spaceBtwSections),
            //Title and sub
        Text(RTexts.confirmEmail, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
            const SizedBox(height: RSizes.spaceBtwItems),


        Text(email ?? '', style: Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center),
            const SizedBox(height: RSizes.spaceBtwItems),

        Text(RTexts.confirmEmailSubTitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center),
            const SizedBox(height: RSizes.spaceBtwSections),

            //Buttons
        SizedBox(
          width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.checkEmailVerificationStatus(),
              child:const Text(RTexts.continueButton),
            ),
        ),
            const SizedBox(height: RSizes.spaceBtwItems),
        SizedBox(width: double.infinity, child: TextButton(onPressed: () => controller.sendEmailVerification(), child:const Text(RTexts.resendEmail))),
          ],
        ),
        ),
        ),
    );
   }
 }
