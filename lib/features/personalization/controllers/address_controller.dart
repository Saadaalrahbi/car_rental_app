import 'package:auto_access/common/widgets/texts/section_header.dart';
import 'package:auto_access/utility/constants/image_strings.dart';
import 'package:auto_access/utility/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/widgets/loaders/loaders.dart';
import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../data/repositories/personalization/address_repository.dart';
import '../../../utility/helpers/cloud_helper_functions.dart';
import '../../../utility/helpers/network_manager.dart';
import '../../../utility/popups/full_screen_loader.dart';
import '../models/address_model.dart';
import '../screens/address/add_new_address.dart';
import '../screens/address/widgets/single_address.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final addressRepository = Get.put(AddressRepository());
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final Rx<AddressModel> selectedBillingAddress = AddressModel.empty().obs;

  /// Fetch all user specific addresses
  Future<List<AddressModel>> allUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere((element) => element.selectedAddress, orElse: () => AddressModel.empty());
      return addresses;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Address not found', message: e.toString());
      return [];
    }
  }

  Future selectAddress({required AddressModel newSelectedAddress, bool isBillingAddress = false}) async {
    try {
      if (!isBillingAddress) {
        // Clear the "selected" field
        if (selectedAddress.value.id.isNotEmpty) {
          await addressRepository.updateSelectedField(AuthenticationRepository.instance.authUser as String, selectedAddress.value.id, false);
        }

        // Assign selected address
        newSelectedAddress.selectedAddress = true;
        selectedAddress.value = newSelectedAddress;

        // Set the "selected" field to true for the newly selected address
        await addressRepository.updateSelectedField(AuthenticationRepository.instance.authUser as String, selectedAddress.value.id, true);
      } else {
        selectedBillingAddress.value = newSelectedAddress;
      }
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error in Selection', message: e.toString());
    }
  }

  /// Add new Address
  addNewAddresses() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog('Storing Address...', RImages.decor);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!addressFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Save Address Data
      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        selectedAddress: true,
      );
      final id = await addressRepository.addAddress(address, AuthenticationRepository.instance.getUserID);

      // Update Selected Address status
      address.id = id;
      await selectAddress(newSelectedAddress: address);

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show Success Message
      Loaders.successSnackBar(title: 'Congratulations', message: 'Your address has been saved successfully.');

      // Refresh Addresses Data
      refreshData.toggle();

      // Reset fields
      resetFormFields();

      // Redirect
      Navigator.of(Get.context!).pop();
    } catch (e) {
      // Remove Loader
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Address not found', message: e.toString());
    }
  }

  /// Show Addresses ModalBottomSheet at Checkout
  Future<dynamic> selectNewAddressPopup({required BuildContext context, bool isBillingAddress = false}) {
    // If shipping Address is true that means do not show any selected Address but let the user choose his new Shipping address
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(RSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeadings(title: 'Select Address', showActionButton: false),
              const SizedBox(height: RSizes.spaceBtwItems),
              FutureBuilder(
                future: allUserAddresses(),
                builder: (_, snapshot) {
                  /// Helper Function: Handle Loader, No Record, OR ERROR Message
                  final response = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                  if (response != null) return response;

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => SingleAddress(
                      address: snapshot.data![index],
                      isBillingAddress: isBillingAddress,
                      onTap: () async {
                        await selectAddress(newSelectedAddress: snapshot.data![index], isBillingAddress: isBillingAddress);
                        Get.back();
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: RSizes.defaultSpace),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () => Get.to(() => const AddNewAddressScreen()), child: const Text('Add new address')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// INIT Values to text fields
  initUpdateAddressValues(AddressModel address) {
    name.text = address.name;
    phoneNumber.text = address.phoneNumber;
    street.text = address.street;
    postalCode.text = address.postalCode;
    city.text = address.city;
    state.text = address.state;
  }

  /// Update Address
  updateAddress(AddressModel oldAddress) async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog('Updating your Address...', RImages.decor);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!addressFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Save Address Data
      final address = AddressModel(
        id: oldAddress.id,
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        selectedAddress: oldAddress.selectedAddress,
      );
      await addressRepository.updateAddress(address, AuthenticationRepository.instance.authUser as String);

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show Success Message
      Loaders.successSnackBar(title: 'Congratulations', message: 'Your address has been updated successfully.');

      // Refresh Addresses Data
      refreshData.toggle();

      // Reset fields
      resetFormFields();

      // Redirect
      Navigator.of(Get.context!).pop();
    } catch (e) {
      // Remove Loader
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Error Updated Address', message: e.toString());
    }
  }

  /// Function to reset form fields
  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    addressFormKey.currentState?.reset();
  }
}