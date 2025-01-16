import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/texts/section_header.dart';
import '../../../../utility/constants/colors.dart';
import '../../../../utility/constants/sizes.dart';
import '../../controllers/upload_data_controller.dart';

class UploadDataScreen extends StatelessWidget {
  const UploadDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UploadDataController());
    return Scaffold(
      appBar: const RAppBar(title: Text('Upload Data'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// -- Profile Body
            Padding(
              padding: const EdgeInsets.all(RSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeadings(title: 'Main Record', showActionButton: false),
                  const SizedBox(height: RSizes.spaceBtwItems),
                  ListTile(
                    leading: const Icon(Iconsax.category, size: 28, color: RColors.primary),
                    title: Text('Upload Categories', style: Theme.of(context).textTheme.titleMedium),
                    trailing: IconButton(
                      onPressed: () => controller.uploadCategories(),
                      icon: const Icon(Iconsax.arrow_up_1, size: 28, color: RColors.primary),
                    ),
                  ),
                  const SizedBox(height: RSizes.spaceBtwItems),
                  ListTile(
                    leading: const Icon(Iconsax.shop, size: 28, color: RColors.primary),
                    title: Text('Upload RentalShops', style: Theme.of(context).textTheme.titleMedium),
                    trailing: IconButton(
                      onPressed: () => controller.uploadRentalShop(),
                      icon: const Icon(Iconsax.arrow_up_1, size: 28, color: RColors.primary),
                    ),
                  ),
                  const SizedBox(height: RSizes.spaceBtwItems),
                  ListTile(
                    leading: const Icon(Iconsax.car, size: 28, color: RColors.primary),
                    title: Text('Upload Cars', style: Theme.of(context).textTheme.titleMedium),
                    trailing: IconButton(
                      onPressed:() => controller.uploadCar(),
                      icon: const Icon(Iconsax.arrow_up_1, size: 28, color: RColors.primary),
                    ),
                  ),
                  const SizedBox(height: RSizes.spaceBtwItems),
                  ListTile(
                    leading: const Icon(Iconsax.image, size: 28, color: RColors.primary),
                    title: Text('Upload Banners', style: Theme.of(context).textTheme.titleMedium),
                    trailing: IconButton(
                      onPressed: () => controller.uploadBanners(),
                      icon: const Icon(Iconsax.arrow_up_1, size: 28, color: RColors.primary),
                    ),
                  ),
                  const SizedBox(height: RSizes.spaceBtwSections),
                  const SectionHeadings(title: 'Relationships', showActionButton: false),
                  const Text('Make sure you have already uploaded all the content above.'),
                  const SizedBox(height: RSizes.spaceBtwItems),
                  ListTile(
                    leading: const Icon(Iconsax.link, size: 28, color: RColors.primary),
                    title: Text('Upload RentalShop & Categories Relation Data', style: Theme.of(context).textTheme.titleMedium),
                    trailing: IconButton(
                      onPressed: () => controller.uploadRentalShopCategory(),
                      icon: const Icon(Iconsax.arrow_up_1, size: 28, color: RColors.primary),
                    ),
                  ),
                  const SizedBox(height: RSizes.spaceBtwItems),
                  ListTile(
                    leading: const Icon(Iconsax.link, size: 28, color: RColors.primary),
                    title: Text('Upload Car Categories Relational Data', style: Theme.of(context).textTheme.titleMedium),
                    trailing: IconButton(
                      onPressed: () => controller.uploadCarCategories(),
                      icon: const Icon(Iconsax.arrow_up_1, size: 28, color: RColors.primary),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
