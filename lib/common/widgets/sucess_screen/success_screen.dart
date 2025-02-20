import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utility/constants/sizes.dart';
import '../../../utility/constants/text_strings.dart';
import '../../styles/spacing_styles.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.image, required this.title, required this.subtitle, required this.onPressed});

  final String image, title, subtitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: RSpacingStyle.paddingWithAppBarHeight * 2,
        child: Column(
          children: [
            ///image
            Lottie.asset(image, width: MediaQuery.of(context).size.width * 0.6),
            const SizedBox(height: RSizes.spaceBtwSections),
            
            ///Title and subtitle
        Text(title,
            style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
            const SizedBox(height: RSizes.spaceBtwItems),

        Text(subtitle,
            style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center),
            const SizedBox(height: RSizes.spaceBtwSections),

            ///buttons
            SizedBox(width: double.infinity,
                child: ElevatedButton(onPressed: onPressed, child:const Text(RTexts.continueButton),
                ),
            ),
          ],
        ),),
      )
    );
  }
}
