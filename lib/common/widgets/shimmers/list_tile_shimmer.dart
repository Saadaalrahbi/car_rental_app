import 'package:auto_access/common/widgets/shimmers/shimmer.dart';
import 'package:flutter/material.dart';
import '../../../utility/constants/sizes.dart';

class ListTileShimmer extends StatelessWidget {
  const ListTileShimmer ({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            ShimmerEffect(width: 50, height: 50, radius: 50),
            SizedBox(width: RSizes.spaceBtwItems),
            Column(
              children: [
                ShimmerEffect(width: 100, height: 15),
                SizedBox(height: RSizes.spaceBtwItems / 2),
                ShimmerEffect(width: 80, height: 12),
              ],
            ),
          ],
        ),
      ],
    );
  }
}