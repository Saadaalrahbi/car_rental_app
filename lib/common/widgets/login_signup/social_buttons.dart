import 'package:auto_access/features/authentication/controllers/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utility/constants/colors.dart';
import '../../../utility/constants/image_strings.dart';
import '../../../utility/constants/sizes.dart';


class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(color: RColors.grey), borderRadius: BorderRadius.circular(100)),
          child: IconButton(onPressed: () => controller.googleSignIn(),
              icon: const Image (
                width: RSizes.iconMd,
                height: RSizes.iconMd,
                image: AssetImage(RImages.google),
              )
          ),
        ),

        const SizedBox(width: RSizes.spaceBtwItems),

        Container(
          decoration: BoxDecoration(border: Border.all(color: RColors.grey), borderRadius: BorderRadius.circular(100)),
          child: IconButton(onPressed: (){},
              icon: const Image (
                width: RSizes.iconMd,
                height: RSizes.iconMd,
                image: AssetImage(RImages.facebook),
              )
          ),
        ),
      ],
    );
  }
}
