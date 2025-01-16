import 'package:flutter/material.dart';
import '../../../../../utility/constants/sizes.dart';
import '../../../../../utility/helpers/helper_function.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key, required this.image, required this.title, required this.subTitle,
  });

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(RSizes.defaultSpace),
      child: Column(
        children: [
          Image(
              width: RHelperFunctions.screenWidth() * 0.8,
              height: RHelperFunctions.screenHeight() * 0.6,
              image:  AssetImage(image)
          ),
          Text(title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),

          const  SizedBox(height: RSizes.spaceBtwItems),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}