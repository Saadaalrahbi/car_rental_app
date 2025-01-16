import 'package:auto_access/features/rent/controllers/rental_shop_controller.dart';
import 'package:auto_access/features/rent/screens/rental_shops/shop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/rental_shops/rental_shop_card.dart';
import '../../../../common/widgets/shimmers/rental_shop_shimmer.dart';
import '../../../../common/widgets/texts/section_header.dart';
import '../../../../utility/constants/sizes.dart';

class AllShopsScreen extends StatelessWidget {
  const AllShopsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = RentalShopController.instance;
    return Scaffold(
      appBar: const RAppBar(title: Text('Rental Shops'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(RSizes.defaultSpace),
          child: Column(
            children: [
              /// Sub Categories
              const SectionHeadings(title: 'Rental Shops', showActionButton: false),
              const SizedBox(height: RSizes.spaceBtwItems),

              ///Rental shops
              Obx(
                 () {
                  // Check if categories are still loading
                  if (controller.isLoading.value) return const RentalShopShimmer();

                  // Check if there are no featured categories found
                  if (controller.allRentalShops.isEmpty) {
                    return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)));
                  } else {
                    /// Data Found
                    return GridLayout(
                      itemCount: controller.allRentalShops.length,
                      mainAxisExtent: 80,
                      itemBuilder: (_, index) {
                        final rentalShop = controller.allRentalShops[index];
                        return RentalShopCard(
                          rentalShop: rentalShop,
                          showBorder: true,
                          onTap: () => Get.to(() => RentalShopScreen(rentalShop: rentalShop)),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
