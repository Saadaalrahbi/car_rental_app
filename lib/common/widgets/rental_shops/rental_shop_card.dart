import 'package:auto_access/features/rent/models/rental_shops_model.dart';
import 'package:auto_access/utility/constants/colors.dart';
import 'package:flutter/material.dart';
import '../../../utility/constants/enums.dart';
import '../../../utility/constants/sizes.dart';
import '../../../utility/helpers/helper_function.dart';
import '../cars/rounded_container.dart';
import '../images/circular_image.dart';
import '../texts/shop_title_text_with_ver_icon.dart';

class RentalShopCard extends StatelessWidget {
  const RentalShopCard ({
    super.key,
    required this.rentalShop,
    required this.showBorder,
    this.onTap,
  });

  final RentalShopModel rentalShop;
  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = RHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      /// Container Design
      child: RoundedContainer(
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(RSizes.sm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// -- Icon
            Flexible(
              child: CircularImage(
                image: rentalShop.image,
                isNetworkImage: true,
                backgroundColor: Colors.transparent,
                overlayColor: isDark ? RColors.white : RColors.black,
              ),
            ),
            const SizedBox(width: RSizes.spaceBtwItems / 2),

            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShopTitleTextWithVerIcon(title: rentalShop.name, shopTitleSizes: TextSizes.large),
                  Text(
                    '${rentalShop.carCount ?? 0} cars',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
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