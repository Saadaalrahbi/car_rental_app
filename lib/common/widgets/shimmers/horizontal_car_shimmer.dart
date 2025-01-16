import 'package:auto_access/common/widgets/shimmers/shimmer.dart';
import 'package:flutter/material.dart';
import '../../../utility/constants/sizes.dart';

class HorizontalCarShimmer  extends StatelessWidget {
  const HorizontalCarShimmer ({super.key,this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: RSizes.spaceBtwSections),
      height: 120,
      child: ListView.separated(
        itemCount: itemCount,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: RSizes.spaceBtwItems),
        itemBuilder: (_, __) => const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Image
            ShimmerEffect(width: 120, height: 120),
            SizedBox(width: RSizes.spaceBtwItems),

            /// Text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: RSizes.spaceBtwItems / 2),
                ShimmerEffect(width: 160, height: 15),
                SizedBox(height: RSizes.spaceBtwItems / 2),
                ShimmerEffect(width: 110, height: 15),
                SizedBox(height: RSizes.spaceBtwItems / 2),
                ShimmerEffect(width: 80, height: 15),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

