import 'package:auto_access/common/widgets/cars/rounded_container.dart';
import 'package:auto_access/features/rent/models/car_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../features/rent/screens/car_details/car_details.dart';
import '../../../utility/constants/colors.dart';
import '../../../utility/constants/enums.dart';
import '../../../utility/constants/sizes.dart';
import '../../../utility/helpers/helper_function.dart';
import '../rounded_image.dart';
import '../texts/car_title_text.dart';
import '../texts/shop_title_text_with_ver_icon.dart';

class CarsCardHorizontal extends StatelessWidget {
  const CarsCardHorizontal({super.key, required this.car, this.isNetworkImage = true});

  final CarModel car;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    final isDark = RHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(() => const CarDetails()),

      /// Container with side paddings, color, edges, radius and shadow.
      child: Container(
        width: 310,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RSizes.carImageRadius),
          color: RHelperFunctions.isDarkMode(context) ? RColors.darkerGrey : RColors.lightContainer,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Thumbnail
            RoundedContainer(
              height: 120,
              padding: const EdgeInsets.all(RSizes.sm),
              backgroundColor: isDark ? RColors.dark : RColors.light,
              child: Stack(
                children: [
                  /// -- Thumbnail Image
                  RoundedImage(width: 120, height: 120, imageUrl: car.thumbnail, isNetworkImage: isNetworkImage),
                ],
              ),
            ),
            const SizedBox(height: RSizes.spaceBtwItems / 2),

            /// -- Details
            Container(
              padding: const EdgeInsets.only(left: RSizes.sm),
              width: 172,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// -- Details
                  Padding(
                    padding: const EdgeInsets.only(top: RSizes.sm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CarTitleText(
                          title: car.title,
                          smallSize: true,
                          maxLines: 2,
                        ),
                        const SizedBox(height: RSizes.spaceBtwItems / 2),
                        ShopTitleTextWithVerIcon(title: car.rentalShop!.name, shopTitleSizes: TextSizes.small),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
