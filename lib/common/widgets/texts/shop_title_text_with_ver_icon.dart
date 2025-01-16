import 'package:auto_access/common/widgets/texts/shop_title_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utility/constants/colors.dart';
import '../../../utility/constants/enums.dart';
import '../../../utility/constants/sizes.dart';

class ShopTitleTextWithVerIcon extends StatelessWidget {
  const ShopTitleTextWithVerIcon({
    super.key,
    this.textColor,
    this.maxLines = 1,
    required this.title,
    this.iconColor = RColors.primary,
    this.textAlign = TextAlign.center,
    this.shopTitleSizes = TextSizes.small,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes shopTitleSizes;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
            child: ShopTitleText(
           title: title,
           color: textColor,
           maxLines: maxLines,
           textAlign: textAlign,
           shopTitleSizes: shopTitleSizes),
        ),
        const SizedBox(width: RSizes.xs),
        const Icon(Iconsax.verify5, color: RColors.primary, size:  RSizes.iconXs),
      ],
    );
  }
}
