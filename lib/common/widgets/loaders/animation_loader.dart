import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utility/constants/colors.dart';
import '../../../utility/constants/sizes.dart';

///A widget for displaying an animation loading indicator with optional text and action button
class AnimationLoaderWidget extends StatelessWidget{

  ///Default constructor for the AnimationLoaderWidget
  ///
  /// Parameters:
  ///  - text: The text to be displayed below the animation.
  ///  - animation: The path to the Lottie animation file.
  ///  - showAction: whether to show an action button below the text
  ///  - actionText: the text to be displayed on the action button
  ///  - onActionPressed: callback function to be executed when the action button is pressed.

  const AnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
});

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animation, width: MediaQuery.of(context).size.width * 0.8), //Displaying Lottie animation
          const SizedBox(height: RSizes.defaultSpace),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: RSizes.defaultSpace),
          showAction
          ? SizedBox(
            width: 250,
            child: OutlinedButton(onPressed: onActionPressed,
                style: OutlinedButton.styleFrom(backgroundColor: RColors.dark),
                child: Text(
                  actionText!,
                  style: Theme.of(context).textTheme.bodyMedium!.apply(color: RColors.light),
                ),
            ),
          )
      : const SizedBox(),
        ],
      ),
    );
  }

  }