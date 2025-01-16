import 'package:auto_access/features/rent/models/car_model.dart';
import 'package:auto_access/features/rent/models/car_variation_model.dart';
import 'package:get/get.dart';

import 'image_controller.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  /// Variables
  RxMap selectedAttributes = {}.obs;
  RxString variationAvailabilityStatus = ''.obs;
  Rx<CarVariationModel> selectedVariation = CarVariationModel.empty().obs;

  /// -- Check car Variation Stock Status
  void getCarVariationStockStatus() {
    variationAvailabilityStatus.value = selectedVariation.value.availability > 0 ? 'Available' : 'Not Available';
  }

  void resetSelectedAttributes() {
    selectedAttributes.clear();
    variationAvailabilityStatus.value = '';
    selectedVariation.value = CarVariationModel.empty();
  }

  // -- Select Attribute, and Variation
  void onAttributeSelected(CarModel car, attributeName, attributeValue) {
    // When attribute is selected we will first add that attribute to the selectedAttributes
    final selectedAttributes = Map<String, dynamic>.from(this.selectedAttributes);
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;

    final CarVariationModel selectedVariation = car.carVariations!.firstWhere(
          (variation) => _isSameAttributeValues(variation.attributeValues, selectedAttributes),
      orElse: () => CarVariationModel.empty(),
    );

    // Show the selected Variation image as a Main Image
    if (selectedVariation.image.isNotEmpty) {
      ImageController.instance.selectedCarImage.value = selectedVariation.image;
    }

    this.selectedVariation.value = selectedVariation;

    // Update selected car variation status
    getCarVariationStockStatus();
  }

  /// -- Check If selected attributes matches any variation attributes
  bool _isSameAttributeValues(Map<String, dynamic> variationAttributes, Map<String, dynamic> selectedAttributes) {
    // If selectedAttributes contains 3 attributes and current variation contains 2 then return.
    if (variationAttributes.length != selectedAttributes.length) return false;


    for (final key in variationAttributes.keys) {
      if (variationAttributes[key] != selectedAttributes[key]) return false;
    }

    return true;
  }

  /// -- Check Attribute availability / Stock in Variation
  Set<String?> getAttributesAvailabilityInVariation(List<CarVariationModel> variations, String attributeName) {
    // Pass the variations to check which attributes are available
    final availableVariationAttributeValues = variations
        .where((variation) =>
    // Check Empty / Out of Stock Attributes
    variation.attributeValues[attributeName] != null && variation.attributeValues[attributeName]!.isNotEmpty && variation.availability > 0)
    // Fetch all non-empty attributes of variations
        .map((variation) => variation.attributeValues[attributeName])
        .toSet();

    return availableVariationAttributeValues;
  }



}