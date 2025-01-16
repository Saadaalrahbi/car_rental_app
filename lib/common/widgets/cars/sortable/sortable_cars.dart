import 'package:auto_access/features/rent/controllers/all_cars_controller.dart';
import 'package:auto_access/features/rent/models/car_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utility/constants/sizes.dart';
import '../../../../utility/device/device_utility.dart';
import '../../layouts/grid_layout.dart';
import '../cars_card_vertical.dart';

class SortableCars extends StatelessWidget {
  const SortableCars({super.key, required this.cars });

  final List<CarModel> cars;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllCarsController());
    controller.assignCars(cars);
    return Column(
      children: [
        ///Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          onChanged: (value){},
          items: ['Name', 'Higher Price', 'Lower Price''Newest', 'Popularity'].map((option) => DropdownMenuItem(value: option, child: Text(option))).toList(),
        ),
        const SizedBox(height: RSizes.spaceBtwItems),
        ///Cars
        Obx(
        () => GridLayout(
            itemCount: controller.cars.length,
            itemBuilder: (_, index) => CarCardVertical(car: controller.cars[index], isNetworkImage: true),
          ),
        ),
        SizedBox(height: RDeviceUtils.getBottomNavigationBarHeight() + RSizes.defaultSpace),
      ],
    );
  }
}