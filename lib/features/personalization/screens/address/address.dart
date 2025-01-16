import 'package:auto_access/features/personalization/screens/address/widgets/single_address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/loaders/circular_loader.dart';
import '../../../../utility/constants/colors.dart';
import '../../../../utility/constants/sizes.dart';
import '../../../../utility/helpers/cloud_helper_functions.dart';
import '../../controllers/address_controller.dart';
import 'add_new_address.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      appBar: RAppBar(
        showBackArrow: true,
        title: Text('Addresses', style: Theme.of(context).textTheme.headlineSmall)
      ),
      body: Padding(
        padding: const EdgeInsets.all(RSizes.defaultSpace),
        child: Obx(
           () => FutureBuilder(
            // Use key to trigger refresh
            key: Key(controller.refreshData.value.toString()),
            future: controller.allUserAddresses(),
            builder: (_, snapshot) {
              /// Helper Function: Handle Loader, No Record, OR ERROR Message
              final response = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
              if (response != null) return response;

              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => SingleAddress(
                  isBillingAddress: false,
                  address: snapshot.data![index],
                  onTap: () async {
                    Get.defaultDialog(
                      title: '',
                      onWillPop: () async {
                        return false;
                      },
                      barrierDismissible: false,
                      backgroundColor: Colors.transparent,
                      content: const TCircularLoader(),
                    );
                    await controller.selectAddress(newSelectedAddress: snapshot.data![index]);
                    Get.back();
                  },
                ),
              );
            },
          ),
        ),
      ),
            ///Adding new address button
         floatingActionButton: FloatingActionButton(
          backgroundColor: RColors.primary,
          onPressed: () => Get.to(() => const AddNewAddressScreen()),
          child: const Icon(Iconsax.add, color: RColors.white) ,
         ),
    );
  }
}
