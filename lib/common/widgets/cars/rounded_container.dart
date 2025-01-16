
import 'package:flutter/material.dart';

import '../../../utility/constants/colors.dart';
import '../../../utility/constants/sizes.dart';


///- the background(container) of the car card
class RoundedContainer extends StatelessWidget{
  const RoundedContainer({
    super.key,
    this.child,
    this.height,
    this.width,
    this.margin,
    this.padding,
    this.showBorder = false,
    this.radius = RSizes.cardRadiusLg,
    this.backgroundColor = RColors.white,
    this.borderColor = RColors.borderPrimary,
  });

  final double? width;
  final double? height;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context){
    return Container(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}
