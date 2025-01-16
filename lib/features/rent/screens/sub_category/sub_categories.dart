import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/cars/cars_card_horizontal.dart';
import '../../../../common/widgets/shimmers/horizontal_car_shimmer.dart';
import '../../../../common/widgets/texts/section_header.dart';
import '../../../../data/repositories/car/car_repository.dart';
import '../../../../utility/constants/sizes.dart';
import '../../../../utility/helpers/cloud_helper_functions.dart';
import '../../controllers/category_controller.dart';
import '../../models/category_model.dart';
import '../all_vehicles/all_cars.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: RAppBar(showBackArrow: true, title:  Text(category.name)),
      body: SingleChildScrollView(
      child: Padding(padding: const EdgeInsets.all(RSizes.defaultSpace),
          ///Sub-categories
      child: Column(
       children: [
        /// Sub Categories
        FutureBuilder(
           future: controller.getSubCategories(category.id),
            builder: (_, snapshot) {
            /// Handle Loader, No Record, OR Error Message
            const loader = HorizontalCarShimmer();
            final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
            if (widget != null) return widget;

            /// Record found.
            final subCategories = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: subCategories.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                final subCategory = subCategories[index];

                /// Fetch Category cars
                return FutureBuilder(
                  future: controller.getCategoryCars(categoryId: subCategory.id),
                  builder: (_, snapshot) {
                    /// Handle Loader, No Record, OR Error Message
                    final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                    if (widget != null) return widget;

                    /// Congratulations 🎊 Record found.
                    final cars = snapshot.data!;
                    return Column(
                      children: [
                        /// Sub Category Heading
                        SectionHeadings(
                          title: subCategory.name,
                          showActionButton: true,
                          onPressed: () => Get.to(() => AllCars(
                            title: subCategory.name,
                            futureMethod: CarRepository.instance.getCarsForCategory(categoryId: subCategory.id, limit: -1),
                          )),
                        ),
                        const SizedBox(height: RSizes.spaceBtwItems / 2),

                        /// Sub Category Cars
                        SizedBox(
                          height: 120,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: cars.length,
                            separatorBuilder: (context, index) => const SizedBox(width: RSizes.spaceBtwItems),
                            itemBuilder: (context, index) => CarsCardHorizontal(car: cars[index]),
                          ),
                        ),
                        const SizedBox(height: RSizes.spaceBtwSections),
                      ],
                    );
                  },
                );
              },
            );
          },
        )
        ],
        ),
        ),
      ),

    );
  }
}
