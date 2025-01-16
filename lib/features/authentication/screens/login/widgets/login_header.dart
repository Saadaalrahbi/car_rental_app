import 'package:flutter/material.dart';

import '../../../../../utility/constants/image_strings.dart';
import '../../../../../utility/constants/sizes.dart';
import '../../../../../utility/constants/text_strings.dart';
import '../../../../../utility/helpers/helper_function.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          height: 150,
          image: AssetImage(dark ? RImages.lightAppLogo:RImages.darkAppLogo),
        ),
        Text(RTexts.loginTitle, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: RSizes.sm),
        Text(RTexts.loginSubTitle, style: Theme.of(context).textTheme.bodyMedium),
      ],);
  }
}
