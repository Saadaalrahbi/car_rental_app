import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../utility/constants/colors.dart';
import '../../../../../utility/constants/sizes.dart';
import '../../../../../utility/device/device_utility.dart';
import '../../../../../utility/helpers/helper_function.dart';
import '../../../controllers/onboarding_controller.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;
    final dark = RHelperFunctions.isDarkMode(context);

    return Positioned(
        bottom: RDeviceUtils.getBottomNavigationBarHeight() + 25,
        left: RSizes.defaultSpace,
        child: SmoothPageIndicator(
          controller: controller.pageController,
          count: 3,
          onDotClicked: controller.dotNavigationClick,
          effect: ExpandingDotsEffect(activeDotColor: dark ? RColors.light: RColors.dark, dotHeight: 6),
        )
    );
  }
}