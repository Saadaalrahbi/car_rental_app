import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../personalization/models/address_model.dart';
import '../models/car_model.dart';

class RentNowController extends GetxController {
  static RentNowController get instance => Get.find();

  final Rx<CarModel> selectedCar = CarModel.empty().obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;  // Track the selected address
  final RxBool isDeliveryOptionSelected = false.obs;  // Track if delivery is selected

  // Function to set the selected car details
  void setCarDetails(Map<String, dynamic> carDetails) {
    selectedCar.value = CarModel.fromSnapshot(carDetails as DocumentSnapshot<Map<String, dynamic>>);
  }

      // Function to select address
  Future<void> selectAddress(AddressModel newSelectedAddress) async {
    selectedAddress.value = newSelectedAddress;
  }

       // Function to select delivery or pickup option
  void setDeliveryOption(bool isDelivery) {
    isDeliveryOptionSelected.value = isDelivery;
    if (!isDelivery) {
      selectedAddress.value = AddressModel.empty();  // Clear selected address if pickup is chosen
    }
  }
}