import 'package:flutter/material.dart';

import '../../../utility/constants/sizes.dart';

class GridLayout extends StatelessWidget {
  const GridLayout({super.key,
  required this.itemCount,
  required this.itemBuilder,
  this.mainAxisExtent = 288,});

  final int itemCount;
  final double? mainAxisExtent;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),   /// the grind isnt goin to scroll its children
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: RSizes.grindViewSpacing,   ///vertical
        crossAxisSpacing: RSizes.grindViewSpacing,    ///horizontal
        mainAxisExtent: mainAxisExtent,     ///how much large one child of grid is going to be
      ),
      itemBuilder: itemBuilder,
    );
  }
}
