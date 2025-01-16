import 'package:auto_access/utility/constants/colors.dart';
import 'package:auto_access/utility/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({super.key,
    required this.width,
    required this.height,
    this.radius = 15,
    this.color});

  final double width, height, radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);
    return Shimmer.fromColors(
      baseColor: dark? Colors.grey [850]! : Colors.grey[300]!,
      highlightColor: dark? Colors.grey[700]! : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? (dark ? RColors.darkerGrey : RColors.white),
          borderRadius: BorderRadius.circular(radius),
        ),


      ),
    );
  }
}