import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utility/constants/colors.dart';
import '../../../utility/constants/text_strings.dart';
import '../../../utility/helpers/helper_function.dart';

class FormDivider extends StatelessWidget {
  const FormDivider({super.key, required this.dividerText});

  final String dividerText;

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(child: Divider(color: dark ? RColors.darkGrey: RColors.grey, thickness: 0.5, indent: 60, endIndent: 5)),
        Text(RTexts.orSignInWith.capitalize!, style: Theme.of(context).textTheme.labelMedium),
        Flexible(child: Divider(color: dark ? RColors.darkGrey: RColors.grey, thickness: 0.5, indent: 5, endIndent: 60)),
      ],
    );
  }
}

