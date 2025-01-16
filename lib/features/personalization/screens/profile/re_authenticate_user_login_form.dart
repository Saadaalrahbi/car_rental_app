import 'package:auto_access/features/personalization/controllers/user_controller.dart';
import 'package:auto_access/utility/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utility/constants/sizes.dart';
import '../../../../utility/constants/text_strings.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
   final controller = UserController.instance;
   return Scaffold(
     appBar: AppBar(title: const Text('Re-Authenticate User')),
     body: SingleChildScrollView(
       child: Padding(padding: const EdgeInsets.all(RSizes.defaultSpace),
        child: Form(
        key: controller.reAuthFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Email
         TextFormField(
           controller: controller.verifyEmail,
           validator: RValidator.validateEmail,
           decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct_right), labelText: RTexts.email),
         ),
        const SizedBox(height: RSizes.spaceBtwInputFields),
        ///Password
        Obx(
            () => TextFormField(
              obscureText: controller.hidePassword.value,
              controller: controller.verifyPassword,
              validator: (value) => RValidator.validateEmptyText('Password', value),
              decoration: InputDecoration(
                labelText: RTexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                icon: const Icon(Iconsax.eye_slash),),
              ),

            )
        ),
        const SizedBox(height: RSizes.spaceBtwSections),

            ///Login button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(onPressed: () => controller.reAuthenticateEmailAndPassword(), child: const Text('Verify')),
        )
          ],
        )),

       ),
     ),
   );
  }



}