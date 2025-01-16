
import 'package:auto_access/features/personalization/controllers/user_controller.dart';
import 'package:auto_access/common/widgets/shimmers/shimmer.dart';
import 'package:auto_access/features/personalization/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utility/constants/colors.dart';
import '../../../../../utility/constants/text_strings.dart';
import '../../../../personalization/controllers/settings_controller.dart';

class HomeAppBar extends StatelessWidget {
 const HomeAppBar({super.key});

 @override
 Widget build(BuildContext context) {
   Get.put(SettingsController());
   final controller = Get.put(UserController());
   //Custom (Appbar) Header
   return RAppBar(
     title: GestureDetector(
       onTap: () => Get.to(() => const ProfileScreen()),
       child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Text(RTexts.homeAppbarTitle, style: Theme.of(context).textTheme.headlineSmall!.apply(color: RColors.grey)),
         Obx(() {
           if (controller.profileLoading.value) {
             //Displaying a shimmer loader while user profile i being loaded
             return const ShimmerEffect(width: 80, height: 15);
           } else {
             //Checking id no record found
             if (controller.user.value.id.isEmpty) {
               return Text('Your Name', style: Theme
                   .of(context)
                   .textTheme
                   .headlineSmall!
                   .apply(color: RColors.white),
               );
             } else {
               return Text(controller.user.value.fullName, style: Theme
                   .of(context)
                   .textTheme
                   .headlineSmall!
                   .apply(color: RColors.white)
               );
             }
           }
          }
         ),
       ],
      ),
     ),
    );
  }
}

