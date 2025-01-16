import 'package:flutter/material.dart';
import '../../../../../common/widgets/shimmers/box_shimmer.dart';
import '../../../../../common/widgets/shimmers/list_tile_shimmer.dart';
import '../../../../../common/widgets/shimmers/rental_shop_shimmer.dart';
import '../../../../../common/widgets/shimmers/shimmer.dart';
import '../../../../../common/widgets/shimmers/vertical_car_shimmer.dart';
import '../../../../../utility/constants/sizes.dart';

class StoreShimmerLoader extends StatelessWidget {
  const StoreShimmerLoader ({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(RSizes.defaultSpace),
        child: Column(
          children: [
            SizedBox(height: RSizes.spaceBtwSections),
            // AppBar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerEffect(width: 100, height: 15),
                ShimmerEffect(width: 55, height: 55, radius: 55),
              ],
            ),
            SizedBox(height: RSizes.spaceBtwSections * 2),
            // Search
            ShimmerEffect(width: double.infinity, height: 55),
            SizedBox(height: RSizes.spaceBtwSections),

            // Heading
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerEffect(width: 100, height: 15),
                ShimmerEffect(width: 80, height: 12),
              ],
            ),
            SizedBox(height: RSizes.spaceBtwSections),

            // rental shops
            RentalShopShimmer(),
            SizedBox(height: RSizes.spaceBtwSections * 2),

            // Categories
            Row(
              children: [
                Expanded(child: ShimmerEffect(width: 100, height: 15)),
                SizedBox(width: RSizes.spaceBtwItems),
                Expanded(child: ShimmerEffect(width: 100, height: 15)),
                SizedBox(width: RSizes.spaceBtwItems),
                Expanded(child: ShimmerEffect(width: 100, height: 15)),
                SizedBox(width: RSizes.spaceBtwItems),
                Expanded(child: ShimmerEffect(width: 100, height: 15)),
              ],
            ),
            SizedBox(height: RSizes.spaceBtwSections),

            // Category rental shops
            ListTileShimmer(),
            SizedBox(height: RSizes.spaceBtwSections),
            BoxesShimmer(),
            SizedBox(height: RSizes.spaceBtwSections),

            // Cars
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerEffect(width: 100, height: 15),
                ShimmerEffect(width: 80, height: 12),
              ],
            ),
            SizedBox(height: RSizes.spaceBtwSections),

            VerticalCarShimmer(),
            SizedBox(height: RSizes.spaceBtwSections * 3),
          ],
        ),
      ),
    );
  }
}