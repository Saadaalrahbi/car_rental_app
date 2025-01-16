import 'package:auto_access/features/personalization/controllers/address_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utility/constants/sizes.dart';


class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(appBar: const RAppBar(showBackArrow: true,title: Text('Add new Address')),
      body: SingleChildScrollView(
        child: Padding(
         padding: const EdgeInsets.all(RSizes.defaultSpace),
        child: Form(
          child: Column(
            children: [
              TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: 'Name')),
              const SizedBox(height: RSizes.spaceBtwInputFields),
              TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.mobile), labelText: 'Phone Number')),
              const SizedBox(height: RSizes.spaceBtwInputFields),
          Row(
            children: [
              Expanded(child: TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.building_31), labelText: 'Street'))),
              const SizedBox(width: RSizes.spaceBtwInputFields),
              Expanded(child: TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.code), labelText: 'Postal code '))),
            ]
          ),
              const SizedBox(height: RSizes.spaceBtwInputFields),
          Row(
            children: [
              Expanded(child: TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.building), labelText: 'State'))),
              Expanded(child: TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.activity), labelText: 'Area'))),
            ],
          ),
              const SizedBox(height: RSizes.defaultSpace),
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => controller.addNewAddresses(), child: const Text('Save')),)

            ],
          ),
        ),
        ),
      )
    );
  }
}
