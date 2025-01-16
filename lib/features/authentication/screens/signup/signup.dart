import 'package:auto_access/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../common/widgets/login_signup/social_buttons.dart';
import '../../../../utility/constants/sizes.dart';
import '../../../../utility/constants/text_strings.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(RSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Title
              Text(RTexts.signupTitle, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: RSizes.spaceBtwSections),

              ///Registration Form
          const SignupForm(),
              ///calling the divider function
           FormDivider(dividerText: RTexts.orSignUpWith.capitalize!),
              const SizedBox(height: RSizes.spaceBtwSections),

              ///adding social buttons
             const SocialButtons(),
            ],
          ),
        ),
      ),

    );
  }
}

