
import 'package:flutter/material.dart';

import '../../../utility/constants/colors.dart';

class ShadowStyle{

  static final verticalCarShadow = BoxShadow(
    color: RColors.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2)
  );


  static final horizontalCarShadow = BoxShadow(
      color: RColors.darkGrey.withOpacity(0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2)
  );

}