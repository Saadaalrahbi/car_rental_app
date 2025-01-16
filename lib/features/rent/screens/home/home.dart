import 'package:auto_access/data/repositories/car/car_repository.dart';
import 'package:auto_access/features/rent/controllers/car_controller.dart';
import 'package:auto_access/features/rent/screens/home/widgets/home_appbar.dart';
import 'package:auto_access/features/rent/screens/home/widgets/home_categories.dart';
import 'package:auto_access/features/rent/screens/home/widgets/promo_slider.dart';
import 'package:auto_access/utility/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/cars/cars_card_vertical.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/custom_shapes/curved_edges/header_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/shimmers/vertical_car_shimmer.dart';
import '../../../../common/widgets/texts/section_header.dart';
import '../../../../utility/constants/sizes.dart';
import '../../../../utility/device/device_utility.dart';
import '../all_vehicles/all_cars.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CarController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
        children: [
          ///Custom (Appbar) Header
          const HeaderContainer(
            child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
              HomeAppBar (),
              SizedBox(height: RSizes.spaceBtwSections),

              ///Search Box
              SearchButtonContainer(text: 'Search'),
              SizedBox(height: RSizes.spaceBtwSections),

               ///Scrollable categories
                HomeCategories(),
               SizedBox(height: RSizes.spaceBtwSections * 2),
                        ],
                      ),
                    ),
          ///The body of the home page
          Container(
            padding:  const EdgeInsets.all(RSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Promo slider
                const PromoSlider(),
                const SizedBox(height: RSizes.spaceBtwSections),

                ///Car heading
              SectionHeadings(title: RTexts.availableCars,
              onPressed: () => Get.to(() => AllCars(
               title: RTexts.availableCars,
               futureMethod: CarRepository.instance.getAllFeaturedCars()
                 ),
                ),
               ),
                const SizedBox(height: RSizes.spaceBtwItems),


                /// Car Section
                Obx(
                  () {
                    if (controller.isLoading.value) return const VerticalCarShimmer();

                    // Check if no featured cars are found
                    if (controller.featuredCars.isEmpty) {
                      return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium));
                    } else {
                      // Featured Cars Found!
                      return GridLayout(
                        itemCount: controller.featuredCars.length,
                        itemBuilder: (_, index) =>
                        CarCardVertical(car: controller.featuredCars[index], isNetworkImage: true),
                      );
                    }
                  },
                ),
                SizedBox(height: RDeviceUtils.getBottomNavigationBarHeight() + RSizes.defaultSpace),
              ],
            ),
           )
          ]
        ),
       ),
    );
  }
}
