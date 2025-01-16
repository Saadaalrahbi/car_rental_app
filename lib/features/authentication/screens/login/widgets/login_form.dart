import 'package:auto_access/features/authentication/controllers/login/login_controller.dart';
import 'package:auto_access/utility/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utility/constants/sizes.dart';
import '../../../../../utility/constants/text_strings.dart';
import '../../password_configuration/forget_password.dart';
import '../../signup/signup.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: RSizes.spaceBtwSections),
        child: Column(
          children: [
            ///email
            TextFormField(
              controller: controller.email,
              validator: (value) => RValidator.validateEmail(value),
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: RTexts.email),
            ),
            const SizedBox(height: RSizes.spaceBtwInputFields),

            ///Password
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

            ///Remember me & Forget Password

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///Remember me
                Row(
                  children: [
                    Obx(() => Checkbox(value: controller.rememberMe.value,
                        onChanged: (value) => controller.rememberMe.value = !controller.rememberMe.value)),
                    const Text(RTexts.rememberMe),
                  ],
                ),
                ///Forget Password
                TextButton(onPressed: () => Get.to(const ForgetPasswordScreen()), child: const Text(RTexts.forgetPassword),)
              ],
            ),
            const SizedBox(height: RSizes.spaceBtwSections),

            ///Sign In button

            SizedBox(width: double.infinity, child:ElevatedButton(onPressed: () => controller.emailAndPasswordSignIn(), child: const Text(RTexts.signIn))),
            const SizedBox(height: RSizes.spaceBtwItems),

            ///Create Account button

            SizedBox(width: double.infinity,
                child:OutlinedButton(onPressed: () => Get.to(() => const SignupScreen()), child: const Text(RTexts.createAccount))),

          ],
        ),
      ),
    );
  }
}
