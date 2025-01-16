import 'package:auto_access/common/widgets/images/circular_image.dart';
import 'package:auto_access/common/widgets/texts/shop_title_text.dart';
import 'package:flutter/material.dart';
import '../../../utility/constants/colors.dart';
import '../../../utility/constants/sizes.dart';
import '../../../utility/helpers/helper_function.dart';

class VerticalImageAndText extends StatelessWidget {
  const VerticalImageAndText({super.key,
    required this.image,
    required this.title,
    this.textColor = RColors.white,
    this.backgroundColor,
    this.isNetworkImage = true,
    this.onTap});

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final bool isNetworkImage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: RSizes.spaceBtwItems),
        child: Column(
          children: [
            CircularImage(
              image: image,
              fit: BoxFit.fitWidth,
              padding: RSizes.sm * 1.4,
              isNetworkImage: isNetworkImage,
              backgroundColor: backgroundColor,
              overlayColor: RHelperFunctions.isDarkMode(context) ? RColors.light : RColors.dark,
            ),
            const SizedBox(height: RSizes.spaceBtwItems / 2),
            SizedBox(width: 55, child: ShopTitleText(title: title, color: textColor)),
          ],
        ),
      ),
    );
  }
}