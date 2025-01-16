import 'package:auto_access/common/widgets/cars/sortable/sortable_cars.dart';
import 'package:auto_access/common/widgets/rental_shops/rental_shop_card.dart';
import 'package:auto_access/common/widgets/texts/section_header.dart';
import 'package:auto_access/features/rent/controllers/rental_shop_controller.dart';
import 'package:auto_access/features/rent/models/rental_shops_model.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/shimmers/vertical_car_shimmer.dart';
import '../../../../utility/constants/sizes.dart';
import '../../../../utility/helpers/cloud_helper_functions.dart';

class RentalShopScreen extends StatelessWidget {
  const RentalShopScreen({super.key, required this.rentalShop});

  final RentalShopModel rentalShop;

  @override
  Widget build(BuildContext context) {
    final controller = RentalShopController.instance;
    return Scaffold(
      appBar: const RAppBar(showBackArrow: true, title: Text('Rental Shop')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(RSizes.defaultSpace),
          child: Column(
            children: [
              RentalShopCard(rentalShop: rentalShop, showBorder: true),
              const SizedBox(height: RSizes.spaceBtwSections),

              const SectionHeadings(title: 'Cars', showActionButton: false),
              const SizedBox(height: RSizes.spaceBtwItems),

              FutureBuilder(
                future: controller.getRentalShopCars(rentalShop.id, -1),
                builder: (context, snapshot){
                  /// Handle Loader, No Record, OR Error Message
                  const loader = VerticalCarShimmer();
                  final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                  if (widget != null) return widget;

                  /// Record Found!
                  final rentalShopCars = snapshot.data!;
                  return SortableCars(cars: rentalShopCars);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
