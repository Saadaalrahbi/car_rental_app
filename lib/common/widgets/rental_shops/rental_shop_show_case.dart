import 'package:auto_access/common/widgets/rental_shops/rental_shop_card.dart';
import 'package:auto_access/features/rent/models/rental_shops_model.dart';
import 'package:auto_access/features/rent/screens/rental_shops/shop.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utility/constants/colors.dart';
import '../../../utility/constants/sizes.dart';
import '../../../utility/helpers/helper_function.dart';
import '../cars/rounded_container.dart';
import '../shimmers/shimmer.dart';

class RentalShopShowcase extends StatelessWidget {
  const RentalShopShowcase ({super.key, required this.rentalShop, required this.images});

  final RentalShopModel rentalShop;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(RentalShopScreen(rentalShop: rentalShop)),
      child: RoundedContainer(
        margin: const EdgeInsets.only(bottom: RSizes.spaceBtwItems),
        showBorder: true,
        borderColor: RColors.darkGrey,
        backgroundColor: Colors.transparent,
        child: Column(
          children: [
            /// rental shop with cars Count
            RentalShopCard(showBorder: false, rentalShop: rentalShop),
            const SizedBox(height: RSizes.spaceBtwItems / 2),

            /// RS Top 3 cars Images
            Row(children: images.map((e) => brandTopProductImageWidget(e, context)).toList()),
          ],
        ),
      ),
    );
  }

  /// Widget to display a top car image for the RS.
  Widget brandTopProductImageWidget(String image, context) {
    return Expanded(
      child: RoundedContainer(
        height: 100,
        padding: const EdgeInsets.all(RSizes.md),
        margin: const EdgeInsets.only(right: RSizes.sm),
        backgroundColor: RHelperFunctions.isDarkMode(context) ? RColors.darkerGrey : RColors.light,
        child: CachedNetworkImage(
          fit: BoxFit.contain,
          imageUrl: image,
          progressIndicatorBuilder: (context, url, downloadProgress) => const ShimmerEffect(width: 100, height: 100),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}