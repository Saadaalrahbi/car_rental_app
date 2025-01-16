import 'package:auto_access/features/rent/models/car_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utility/constants/sizes.dart';

class ImageController extends GetxController{
  static ImageController get instance => Get.find();


  /// Variables
  RxString selectedCarImage = ''.obs;

  /// -- Get All Images from car and Variations
  List<String> getAllCarImages(CarModel car) {
    // Use Set to add unique images only
    Set<String> images = {};

    // Load thumbnail image
    images.add(car.thumbnail);
    // Assign Thumbnail as Selected Image
    selectedCarImage.value = car.thumbnail;

    // Get all images from the Product Model if not null.
    if (car.images != null) {
      images.addAll(car.images!);
    }

    // Get all images from the CAR Variations if not null.
    if (car.carVariations != null || car.carVariations!.isNotEmpty) {
      images.addAll(car.carVariations!.map((variation) => variation.image));
    }

    return images.toList();
  }

  /// -- Show Image Popup
  void showEnlargedImage(String image) {
    Get.to(
      fullscreenDialog: true,
        () => Dialog.fullscreen(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: RSizes.defaultSpace * 2, horizontal: RSizes.defaultSpace),
                child: CachedNetworkImage(imageUrl: image),
              ),
              const SizedBox(height: RSizes.spaceBtwSections),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 150,
                  child: OutlinedButton(onPressed: () => Get.back(), child: const Text('Close')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}