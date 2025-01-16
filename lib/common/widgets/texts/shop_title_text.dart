import 'package:flutter/material.dart';

import '../../../utility/constants/enums.dart';

class ShopTitleText extends StatelessWidget {
  const ShopTitleText({
    super.key,
    this.color,
    this.maxLines = 1,
    required this.title,
    this.textAlign = TextAlign.center,
    this.shopTitleSizes = TextSizes.small,
  });


  final String title;
  final int maxLines;
  final Color? color;
  final TextAlign? textAlign;
  final TextSizes shopTitleSizes;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: shopTitleSizes ==TextSizes.small
      ? Theme.of(context).textTheme.bodyMedium!.apply(color: color)
      : shopTitleSizes == TextSizes.medium
          ? Theme.of(context).textTheme.bodyLarge!.apply(color: color)
      : shopTitleSizes == TextSizes.large
          ? Theme.of(context).textTheme.bodyLarge!.apply(color: color)
       :   Theme.of(context).textTheme.bodyMedium!.apply(color: color),
    );
  }
}
