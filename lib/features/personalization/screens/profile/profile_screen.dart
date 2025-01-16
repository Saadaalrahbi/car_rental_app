import 'package:auto_access/features/personalization/controllers/user_controller.dart';
import 'package:auto_access/features/personalization/screens/profile/change_name.dart';
import 'package:auto_access/features/personalization/screens/profile/profile_menu.dart';
import 'package:auto_access/common/widgets/shimmers/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/images/circular_image.dart';
import '../../../../common/widgets/texts/section_header.dart';
import '../../../../utility/constants/image_strings.dart';
import '../../../../utility/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar:  RAppBar(
        showBackArrow: true,
        title: Text('Profile', style: Theme.of(context).textTheme.headlineSmall)),
      ///Body
    body: SingleChildScrollView(
      child: Padding(padding: const EdgeInsets.all(RSizes.defaultSpace),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Profile picture
          SizedBox(
          width: double.infinity,
          child: Column(children: [
            Obx(() {
              final networkImage = controller.user.value.profilePicture;
              final image = networkImage.isNotEmpty ? networkImage : RImages.user;

              return controller.imageUploading.value ? const ShimmerEffect(width: 80, height: 80, radius: 80)
              : CircularImage(image: image, width: 80,height: 80, isNetworkImage: networkImage.isNotEmpty);
            }),
            TextButton(onPressed: controller.imageUploading.value ? () {} : () => controller.uploadUserProfilePicture(),
             child: const Text( 'Change profile picture')
            ),
          ],
          ),
        ),

          ///Profile details
      const SizedBox(height: RSizes.spaceBtwItems/2),
      const Divider(),
      const SizedBox(height: RSizes.spaceBtwItems),
      const SectionHeadings(title: 'Profile Information', showActionButton: false),
      const SizedBox(height: RSizes.spaceBtwItems),

          ProfileMenu(title: 'Name', value: controller.user.value.fullName, onPressed: () => Get.to(() => const ChangeName())),
          ProfileMenu(title: 'Username', value: controller.user.value.username, onPressed: (){}),

       const SizedBox(height: RSizes.spaceBtwItems),
       const Divider(),
       const SizedBox(height: RSizes.spaceBtwItems),

          ///Personal Info
       const SectionHeadings(title: 'Personal Information', showActionButton: false),
       const SizedBox(height: RSizes.spaceBtwItems),

        ProfileMenu(title: 'User ID', value: controller.user.value.id, icon: Iconsax.copy, onPressed: (){}),
        ProfileMenu(title: 'Email', value: controller.user.value.email, onPressed: (){}),
        ProfileMenu(title: 'Phone Number', value: controller.user.value.phoneNumber, onPressed: (){}),
        ProfileMenu(title: 'Gender', value: 'Female', onPressed: (){}),
        ProfileMenu(title: 'Date of birth', value: '07 July 2001', onPressed: (){}),

          const Divider(),
          const SizedBox(height: RSizes.spaceBtwItems),

         ///Delete Account Button
      Center(
        child: TextButton(onPressed: () => controller.deleteAccountWarningPopup(),
          child: const Text('Delete Account', style: TextStyle(color: Colors.red)),
        ),
      ),
        ],
      )

      ),

    ),
    );
  }
}
