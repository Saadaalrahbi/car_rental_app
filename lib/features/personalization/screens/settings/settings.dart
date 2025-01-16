import 'package:auto_access/features/personalization/controllers/user_controller.dart';
import 'package:auto_access/features/personalization/screens/settings/settings_menu.dart';
import 'package:auto_access/features/personalization/screens/settings/upload_data.dart';
import 'package:auto_access/features/rent/screens/home/home.dart';
import 'package:auto_access/features/rent/screens/rental/rental.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/curved_edges/header_container.dart';
import '../../../../common/widgets/images/circular_image.dart';
import '../../../../common/widgets/texts/section_header.dart';
import '../../../../utility/constants/colors.dart';
import '../../../../utility/constants/image_strings.dart';
import '../../../../utility/constants/sizes.dart';
import '../address/address.dart';
import '../profile/profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return PopScope(
        canPop: false,
        // Intercept the back button press and redirect to Home Screen
        onPopInvoked: (value) async => Get.offAll(const HomeScreen()),
    child:  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///header
          HeaderContainer(child: Column(
            children: [
              RAppBar(title: Text('Account', style: Theme.of(context).textTheme.headlineMedium!.apply(color: RColors.white))),
              const SizedBox(height: RSizes.spaceBtwSections),

              ///User profile
           ListTile(
            leading:const CircularImage(
              image: RImages.user,
              width: 50,
              height: 50,
              padding: 0),
            title: Text(controller.user.value.fullName, style: Theme.of(context).textTheme.headlineSmall!.apply(color: RColors.white)),
             subtitle: Text(controller.user.value.email, style: Theme.of(context).textTheme.bodyMedium!.apply(color: RColors.white)),
             trailing: IconButton(onPressed: () => Get.to(()=> const ProfileScreen()), icon: const Icon(Iconsax.edit, color: RColors.white)),
           ),
              const SizedBox(height: RSizes.spaceBtwSections),
  ]
          ),
          ),

            ///list of setting menu
        Padding(padding: const EdgeInsets.all(RSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Title
           const SectionHeadings(title: 'Account Settings', showActionButton: false),
           const SizedBox(height: RSizes.spaceBtwItems),

          SettingMenu(icon: Iconsax.safe_home, title: 'My Addresses',
           subTitle: 'Set delivery address',
            onTap: () => Get.to(() => const UserAddressScreen())),
          SettingMenu(icon: Iconsax.bag_tick, title: 'My Rental',
           subTitle: 'Rental Status',
            onTap: () => Get.to(() => const RentalScreen())),
          const SettingMenu(icon: Iconsax.security_card, title: 'Account Privacy',
              subTitle: 'Manage data usage and connected accounts'),

              ///App Settings
          const SizedBox(height: RSizes.spaceBtwItems),
          const SectionHeadings(title: 'App Settings', showActionButton: false),
          const SizedBox(height: RSizes.spaceBtwItems),
          SettingMenu(icon: Iconsax.document_upload, title: 'Load Data', subTitle: 'Load data to your cloud firebase',
            onTap: () => Get.to(() => const UploadDataScreen()),),



              ///Log out button
            const SizedBox(height: RSizes.spaceBtwSections),
            SizedBox(
             width: double.infinity,
              child: OutlinedButton(onPressed: () => controller.logout(), child: const Text('Logout')),
          ),
              const SizedBox(height: RSizes.spaceBtwSections*2.5),
            ],
          ),
        )
      ]
        )
      ),
    ),
    );
  }
}
