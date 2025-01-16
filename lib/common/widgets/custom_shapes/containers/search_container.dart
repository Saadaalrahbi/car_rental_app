import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../features/rent/screens/search/search.dart';
import '../../../../utility/constants/colors.dart';
import '../../../../utility/constants/sizes.dart';
import '../../../../utility/device/device_utility.dart';
import '../../../../utility/helpers/helper_function.dart';

class SearchButtonContainer extends StatelessWidget {
  const SearchButtonContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: RSizes.defaultSpace),
  });


  /// the below properties is for making text, the background, and the border color not fixed
  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final  dark = RHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(() => SearchScreen()),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: RSizes.defaultSpace),
        child: Container(
          ///assigning full width
          width: RDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(RSizes.md),
          decoration: BoxDecoration(
              color: showBackground ? dark ? RColors.dark : RColors.light : Colors.transparent,
              borderRadius: showBorder ? BorderRadius.circular(RSizes.cardRadiusLg) : null,
              border: Border.all(color: RColors.grey)
          ),
          child: Row(
            children: [
              Icon(icon, color: RColors.darkerGrey),
              const SizedBox(width: RSizes.spaceBtwItems),
              Text(text, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
