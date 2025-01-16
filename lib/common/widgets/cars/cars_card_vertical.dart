import 'package:auto_access/common/widgets/cars/rounded_container.dart';
import 'package:auto_access/common/widgets/cars/shadow.dart';
import 'package:auto_access/utility/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../features/rent/models/car_model.dart';
import '../../../features/rent/screens/car_details/car_details.dart';
import '../../../utility/constants/colors.dart';
import '../../../utility/constants/image_strings.dart';
import '../../../utility/constants/sizes.dart';
import '../../../utility/helpers/helper_function.dart';
import '../rounded_image.dart';
import '../texts/shop_title_text_with_ver_icon.dart';

class CarCardVertical extends StatelessWidget {
  const CarCardVertical({super.key, required this.car, this.isNetworkImage = true});

  final CarModel car;
  final bool isNetworkImage;


  @override
  Widget build(BuildContext context) {
    /// container with side paddings, edges, radius, shadow and color. - decoration for the outer side of the card
    return GestureDetector(
      onTap: () => Get.to(() => const CarDetails()),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [ShadowStyle.verticalCarShadow],
          borderRadius: BorderRadius.circular(RSizes.carImageRadius),
          color: RHelperFunctions.isDarkMode(context) ? RColors.darkerGrey : RColors.white,
        ),
        child: Column(
          children: [
            ///box,
            RoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(RSizes.sm),
              backgroundColor: RHelperFunctions.isDarkMode(context) ? RColors.dark : RColors.light,
              ///--- the image in the box created above--
              child: const RoundedImage(imageUrl: RImages.audi, applyImageRadius: true),
            ),

            const SizedBox(height: RSizes.spaceBtwSections/2),

            ///details
        Padding(
            padding: const EdgeInsets.only(left: RSizes.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  car.title, style: Theme.of(context).textTheme.labelLarge,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: RSizes.spaceBtwSections/2),

             ShopTitleTextWithVerIcon(title: car.rentalShop!.name, shopTitleSizes: TextSizes.small),

            Row(
              children: [
                ///--Price--
                Padding(
                  padding: const EdgeInsets.only(left: RSizes.sm),
                  child: Text('10 OMR - 35 OMR', maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.headlineSmall),
                ),
              ],
            )
              ],
            ),
        )

          ]

        ),

      ),
    );
  }
}
