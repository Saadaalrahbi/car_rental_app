import 'package:flutter/material.dart';
import '../../utility/constants/sizes.dart';

class RSpacingStyle{
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: RSizes.appBarHeight,
    left: RSizes.defaultSpace,
    bottom: RSizes.defaultSpace,
    right: RSizes.defaultSpace,
  );
}