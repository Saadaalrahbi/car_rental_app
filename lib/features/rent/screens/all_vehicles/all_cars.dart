import 'package:auto_access/features/rent/models/car_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/cars/cars_card_vertical.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/shimmers/vertical_car_shimmer.dart';
import '../../../../utility/constants/sizes.dart';
import '../../../../utility/device/device_utility.dart';
import '../../../../utility/helpers/cloud_helper_functions.dart';
import '../../controllers/all_cars_controller.dart';

class AllCars extends StatelessWidget {
  const AllCars({super.key, required this.title, this.query, this.futureMethod});

  /// The title of the screen.
  final String title;

  /// Represents a query to fetch cars from the database.
  final Query? query;

  /// Represents a function to fetch cars as a future.
  final Future<List<CarModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllCarsController());
    return Scaffold(
      appBar: RAppBar(title: Text(title), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(RSizes.defaultSpace),
          child: FutureBuilder(
            future: futureMethod ?? controller.fetchCarsByQuery(query),
            builder: (_, snapshot) {
              // Check the state of the FutureBuilder snapshot
              const loader = VerticalCarShimmer();
              final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);

              // Return appropriate widget based on snapshot state
              if (widget != null) return widget;

              // Cars found!
              final cars = snapshot.data!;
              return SortableCarList(cars: cars);
            },
          ),
        ),
      ),
    );
  }
}

class SortableCarList extends StatelessWidget {
  const SortableCarList({super.key, required this.cars});

  /// The list of cars to be displayed.
  final List<CarModel> cars;

  @override
  Widget build(BuildContext context) {
    // Initialize controller for managing car sorting
    final controller = Get.put(AllCarsController());
    // Assign the cars to the controller
    controller.assignCars(cars);

    return Column(
      children: [
        /// -- Sort & Filter Section
        Row(
          children: [
            Obx(
              () => Expanded(
                child: DropdownButtonFormField(
                  isExpanded: true,
                  decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
                  value: controller.selectedSortOption.value,
                  onChanged: (value) {
                    // Sort cars based on the selected option
                    controller.sortCars(value!);
                  },
                  items: ['Name', 'Higher Price', 'Lower Price',  'Newest', 'Popularity'].map((option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: RSizes.spaceBtwSections),

        /// Car Grid Section
        Obx(
         () => GridLayout(
            itemCount: controller.cars.length,
            itemBuilder: (_, index) => CarCardVertical(car: controller.cars[index], isNetworkImage: true),
          ),
        ),

        /// Bottom spacing to accommodate the navigation bar
        SizedBox(height: RDeviceUtils.getBottomNavigationBarHeight() + RSizes.defaultSpace),
      ],
    );
  }
}



