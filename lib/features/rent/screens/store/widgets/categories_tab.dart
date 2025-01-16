import 'package:auto_access/common/widgets/texts/section_header.dart';
import 'package:auto_access/features/rent/screens/all_vehicles/all_cars.dart';
import 'package:auto_access/features/rent/screens/store/widgets/category_rental_shop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/cars/cars_card_vertical.dart';
import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/shimmers/vertical_car_shimmer.dart';
import '../../../../../utility/constants/sizes.dart';
import '../../../../../utility/helpers/cloud_helper_functions.dart';
import '../../../controllers/category_controller.dart';
import '../../../models/category_model.dart';


class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children:  [
        Padding(padding: const EdgeInsets.all(RSizes.defaultSpace),
        child: Column(
        children: [
          CategoryRentalShops(category: category),
          const SizedBox(height: RSizes.spaceBtwSections * 2),

          /// -- Category CARs You May Like
          FutureBuilder(
            future: controller.getCategoryCars(categoryId: category.id),
            builder: (context, snapshot) {
              /// Helper Function: Handle Loader, No Record, OR ERROR Message
              final response = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: const VerticalCarShimmer());
              if (response != null) return response;

              /// Record Found!
              final cars = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeadings(
                    title: 'You might like',
                    showActionButton: true,
                    onPressed: () => Get.to(AllCars(
                      title: category.name,
                      futureMethod: controller.getCategoryCars(categoryId: category.id, limit: -1),
                    )),
                  ),
                  const SizedBox(height: RSizes.spaceBtwItems),
                  GridLayout(
                    itemCount: cars.length < 4 ? cars.length : 4,
                    itemBuilder: (_, index) => CarCardVertical(car: cars[index], isNetworkImage: true),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: RSizes.spaceBtwSections),
        ],
      ),
    ),
      ]
    );
  }
}
