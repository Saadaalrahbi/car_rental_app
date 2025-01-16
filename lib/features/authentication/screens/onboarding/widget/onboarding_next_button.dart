import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utility/constants/colors.dart';
import '../../../../../utility/constants/sizes.dart';
import '../../../../../utility/device/device_utility.dart';
import '../../../../../utility/helpers/helper_function.dart';
import '../../../controllers/onboarding_controller.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);
    return Positioned(
      right: RSizes.defaultSpace,
      bottom:  RDeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: () => OnboardingController.instance.nextPage(),
        style: ElevatedButton.styleFrom(shape: const CircleBorder(), backgroundColor: dark ? RColors.primary
            : Colors.black),
        child:  const Icon(Iconsax.arrow_right_3),
      ),
    );
  }
}