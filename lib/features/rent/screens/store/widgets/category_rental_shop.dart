import 'package:flutter/material.dart';
import '../../../../../common/widgets/rental_shops/rental_shop_show_case.dart';
import '../../../../../common/widgets/shimmers/box_shimmer.dart';
import '../../../../../common/widgets/shimmers/list_tile_shimmer.dart';
import '../../../../../utility/constants/sizes.dart';
import '../../../../../utility/helpers/cloud_helper_functions.dart';
import '../../../controllers/rental_shop_controller.dart';
import '../../../models/category_model.dart';

class CategoryRentalShops extends StatelessWidget {
  const CategoryRentalShops ({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = RentalShopController.instance;
    return FutureBuilder(
      future: RentalShopController.instance.getRentalShopForCategory(category.id),
      builder: (_, snapshot) {
        /// Handle Loader, No Record, OR Error Message
        const loader = Column(
          children: [
            ListTileShimmer(),
            SizedBox(height: RSizes.spaceBtwItems),
            BoxesShimmer(),
            SizedBox(height: RSizes.spaceBtwItems),
          ],
        );
        final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
        if (widget != null) return widget;

        /// Record Found!
        final rentalShops = snapshot.data!;
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: rentalShops.length,
          itemBuilder: (_, index) {
            final rentalShop = rentalShops[index];

            /// Load rental shops cars
            return FutureBuilder(
              future: controller.getRentalShopCars(rentalShop.id, 3),
              builder: (_, snapshot) {
                /// Handle Loader, No Record, OR Error Message
                final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                if (widget != null) return widget;

                /// Record Found!
                final cars = snapshot.data!;
                return RentalShopShowcase(
                  rentalShop: rentalShop,
                  images: cars.map((e) => e.thumbnail).toList(),
                );
              },
            );
          },
        );
      },
    );
  }
}
