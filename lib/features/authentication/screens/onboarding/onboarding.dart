import 'package:auto_access/features/authentication/screens/onboarding/widget/onboarding_dot_navigation.dart';
import 'package:auto_access/features/authentication/screens/onboarding/widget/onboarding_next_button.dart';
import 'package:auto_access/features/authentication/screens/onboarding/widget/onboarding_page.dart';
import 'package:auto_access/features/authentication/screens/onboarding/widget/onboarding_skip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utility/constants/image_strings.dart';
import '../../../../utility/constants/text_strings.dart';
import '../../controllers/onboarding_controller.dart';


class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ///horizontal scrollable pages
         PageView(
           controller: controller.pageController,
           onPageChanged: controller.updatePageIndicator,
           children: const [
             OnBoardingPage(image: RImages.onBoardingImage1,
        title: RTexts.onBoardingTitle1,
        subTitle: RTexts.onBoardingSubTitle1,),

             OnBoardingPage(image: RImages.onBoardingImage2,
               title: RTexts.onBoardingTitle2,
               subTitle: RTexts.onBoardingSubTitle2,),

             OnBoardingPage(image: RImages.onBoardingImage3,
               title: RTexts.onBoardingTitle3,
               subTitle: RTexts.onBoardingSubTitle3,)
               ]),

          ///skip button
          const OnBoardingSkip(),

          ///dot navigation SmoothPageIndicator
          const OnBoardingDotNavigation(),

          /// circular button
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}












