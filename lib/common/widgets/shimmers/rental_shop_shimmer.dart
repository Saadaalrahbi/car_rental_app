import 'package:auto_access/common/widgets/shimmers/shimmer.dart';
import 'package:flutter/material.dart';
import '../layouts/grid_layout.dart';

class RentalShopShimmer extends StatelessWidget {
  const RentalShopShimmer ({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridLayout(
      mainAxisExtent: 80,
      itemCount: itemCount,
      itemBuilder: (_, __) => const ShimmerEffect(width: 300, height: 80),
    );
  }
}