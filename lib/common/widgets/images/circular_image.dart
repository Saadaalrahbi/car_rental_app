import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../utility/constants/colors.dart';
import '../shimmers/shimmer.dart';
import '../../../utility/constants/sizes.dart';
import '../../../utility/helpers/helper_function.dart';

class CircularImage extends StatelessWidget {
  const CircularImage({
    super.key,
    this.width = 56,
    this.height = 56,
    this.overlayColor,
    this.backgroundColor,
    required this.image,
    this.fit = BoxFit.cover,
    this.padding = RSizes.sm,
    this.isNetworkImage = false,
   });

   final BoxFit? fit;
   final String image;
   final Color? overlayColor;
   final Color? backgroundColor;
   final double width, height, padding;
   final bool isNetworkImage;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        //if image background is null then switch to light and dark mode color design
        color: backgroundColor ?? (RHelperFunctions.isDarkMode(context) ? RColors.black : RColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
       borderRadius: BorderRadius.circular(100),
        child: Center(
          child: isNetworkImage ? CachedNetworkImage(fit: fit,color: overlayColor, imageUrl: image,
           progressIndicatorBuilder: (context, url, downloadProgress) => const ShimmerEffect(width: 55, height: 55, radius: 55),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          )
         : Image(
          fit: fit,
          image: AssetImage(image), color: overlayColor),
        ),
      ),
    );
  }
}
