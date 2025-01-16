import 'package:auto_access/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:auto_access/utility/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utility/constants/sizes.dart';
import '../../../../utility/constants/text_strings.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
          body:Padding(
          padding: const EdgeInsets.all(RSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Screen Heading
          Text(RTexts.forgetPasswordTitle, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: RSizes.spaceBtwItems),
          Text(RTexts.forgetPasswordSubTitle, style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: RSizes.spaceBtwSections *2),
              ///Text field
          Form(
            key: controller.forgetPasswordFormKey,
            child: TextFormField(
              controller: controller.email,
              validator: RValidator.validateEmail,
              decoration: const InputDecoration(labelText: RTexts.email, prefixIcon: Icon(Iconsax.direct_right)
              ),
            ),
          ),
            const SizedBox(height: RSizes.spaceBtwSections),

              ///Submit button
          SizedBox(width: double.infinity,
              child: ElevatedButton(onPressed: () => controller.sendPasswordResetEmail(),
                  child: const Text(RTexts.submitButton),
              ),
          ),

            ],
          ),
        )
      );
  }
}



