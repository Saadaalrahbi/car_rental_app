import 'package:auto_access/common/widgets/shimmers/shimmer.dart';
import 'package:flutter/material.dart';

import '../../../utility/constants/sizes.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key, this.itemCount = 10});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child:  ListView.separated(
      shrinkWrap: true,
      itemCount: itemCount,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (_, __) => const SizedBox(width: RSizes.spaceBtwItems),
      itemBuilder: (_, __) {
        return const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Image
         ShimmerEffect(width: 55, height: 55, radius: 55),
         SizedBox(height: RSizes.spaceBtwItems/2),

            ///Text
        ShimmerEffect(width: 55, height: 8),
          ],
        );
      }
      ),
    );
  }
}