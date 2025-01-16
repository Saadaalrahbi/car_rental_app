import 'package:flutter/material.dart';

import '../../../../../utility/constants/sizes.dart';
import '../../../../../utility/device/device_utility.dart';
import '../../../controllers/onboarding_controller.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: RDeviceUtils.getAppBarHeight(),
        right: RSizes.defaultSpace,
        child: TextButton(onPressed: () => OnboardingController.instance.skipPage(),
            child: const Text('Skip')));
  }
}