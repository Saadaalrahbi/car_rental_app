import 'package:auto_access/common/widgets/appbar/appbar.dart';
import 'package:auto_access/utility/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utility/constants/sizes.dart';
import '../../../../utility/constants/text_strings.dart';
import '../../controllers/update_name_controller.dart';

class ChangeName extends StatelessWidget {
  const ChangeName ({super.key});

  @override
  Widget build(BuildContext context){
    final controller = Get.put(UpdateNameController());

    return Scaffold(
      ///App bar
      appBar: RAppBar(
        showBackArrow: true,
        title: Text('Change Name', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(padding: const EdgeInsets.all(RSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Heading
          Text('Use a real name for easy verification. This name will appear on several pages',
            style:  Theme.of(context).textTheme.labelMedium,
          ),
        const SizedBox(height: RSizes.spaceBtwSections),
            /// Text field and button
         Form(

         child:Column(
           children: [
             TextFormField(
               controller: controller.firstName,
               validator: (value) => RValidator.validateEmptyText('First Name', value),
               expands: false,
               decoration: const InputDecoration(labelText: RTexts.firstName, prefixIcon: Icon(Iconsax.user)),
             ),
         const SizedBox(height: RSizes.spaceBtwInputFields),
             TextFormField(
               controller: controller.lastName,
               validator: (value) => RValidator.validateEmptyText('Last Name', value),
               expands: false,
               decoration: const InputDecoration(labelText: RTexts.lastName, prefixIcon: Icon(Iconsax.user)),
             ),
          const SizedBox(height: RSizes.spaceBtwSections),
             ///Save Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: () => controller.updateUserName(), child: const Text('Save')),
          )
           ],

         ) )
          ],

        ),
      ),
    );
  }
}