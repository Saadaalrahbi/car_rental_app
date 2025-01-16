import 'package:auto_access/features/authentication/controllers/signup/signup_controller.dart';
import 'package:auto_access/utility/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utility/constants/sizes.dart';
import '../../../../../utility/constants/text_strings.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) => RValidator.validateEmptyText('First Name', value),
                  expands: false,
                  decoration: const InputDecoration(labelText: RTexts.firstName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(width: RSizes.spaceBtwInputFields),
              Flexible(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) => RValidator.validateEmptyText('Last Name', value),
                  expands: false,
                  decoration: const InputDecoration(labelText: RTexts.lastName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
            ],
          ),
          const SizedBox(height: RSizes.spaceBtwInputFields),

          ///username
          TextFormField(
            controller: controller.username,
            validator: (value) => RValidator.validateEmptyText('Username', value),
            expands: false,
            decoration: const InputDecoration(labelText: RTexts.username,
                prefixIcon: Icon(Iconsax.user_edit)),
          ),
          const SizedBox(height: RSizes.spaceBtwInputFields),

          ///Email
          TextFormField(
            controller: controller.email,
            validator: (value) => RValidator.validateEmail(value),
            expands: false,
            decoration: const InputDecoration(
                labelText: RTexts.email, prefixIcon: Icon(Iconsax.direct)),
          ),
          const SizedBox(height: RSizes.spaceBtwInputFields),

          ///phone number
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => RValidator.validatePhoneNumber(value),
            expands: false,
            decoration: const InputDecoration(
                labelText: RTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
          ),

          const SizedBox(height: RSizes.spaceBtwInputFields),

          ///password
        Obx(
          () => TextFormField(
              controller: controller.password,
              validator: (value) => RValidator.validatePassword(value),
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: RTexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye),)
              ),
            ),
          ),
          const SizedBox(height: RSizes.spaceBtwSections),

          ///signup button
          SizedBox(width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.signup(),
                  child: const Text(RTexts.createAccount))),
          const SizedBox(height: RSizes.spaceBtwSections),
        ],
      ),
    );
  }
}