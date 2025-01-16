import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utility/constants/colors.dart';
import '../../../utility/constants/sizes.dart';
import '../../../utility/device/device_utility.dart';
import '../../../utility/helpers/helper_function.dart';

class RAppBar extends StatelessWidget implements PreferredSizeWidget{
  const RAppBar ({
    super.key,
    this.title,
    this.actions,
    this.leadingIcon,
    this.showBackArrow = false,
    this.leadingOnPressed,

  });

  final Widget? title;  ///title of the app bar
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;



  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);
    return Padding(
    padding: const EdgeInsets.symmetric(horizontal: RSizes.md),
    child: AppBar(
      automaticallyImplyLeading: false,
        ///if show back arrow is true displaying the back arrow else
      leading: showBackArrow ?
       IconButton(onPressed: () => Get.back(), icon: Icon(Iconsax.arrow_left, color: dark? RColors.white: RColors.dark))
              ///if the leading icon is not equal to null then we will display the back button, the leading icon that has been passed and the on press event of the button else returning null
        : leadingIcon != null  ? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon)) : null,
        title: title,
        actions: actions,

      ),
    );
  }

  @override
  // TODO: implement preferredSize
 Size get preferredSize => Size.fromHeight(RDeviceUtils.getAppBarHeight());
}