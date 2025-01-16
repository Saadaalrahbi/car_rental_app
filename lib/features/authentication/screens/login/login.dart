import 'package:auto_access/features/authentication/screens/login/widgets/login_form.dart';
import 'package:auto_access/features/authentication/screens/login/widgets/login_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/styles/spacing_styles.dart';
import '../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../common/widgets/login_signup/social_buttons.dart';
import '../../../../utility/constants/sizes.dart';
import '../../../../utility/constants/text_strings.dart';
import '../../../../utility/helpers/helper_function.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);   ///checking if its dark mode

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: RSpacingStyle.paddingWithAppBarHeight,
            child: Column(
              children: [
                ///Logo, title and subtitle
                const LoginHeader(),

                ///Login Form
                const LoginForm(),

                 ///divider - it divides the page and has a sign in with text
                FormDivider(dividerText: RTexts.orSignInWith.capitalize!),
                const SizedBox(height: RSizes.spaceBtwSections),

                ///footer - contains the social buttons
                const SocialButtons(),

              ],
            ),
        ),
      ),
    );
  }
}
