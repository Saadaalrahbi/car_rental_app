 import 'package:auto_access/common/widgets/appbar/appbar.dart';
import 'package:auto_access/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:auto_access/common/widgets/layouts/grid_layout.dart';
import 'package:auto_access/common/widgets/rental_shops/rental_shop_card.dart';
import 'package:auto_access/common/widgets/shimmers/rental_shop_shimmer.dart';
import 'package:auto_access/common/widgets/texts/section_header.dart';
import 'package:auto_access/features/rent/controllers/category_controller.dart';
import 'package:auto_access/features/rent/controllers/rental_shop_controller.dart';
import 'package:auto_access/features/rent/screens/home/home.dart';
import 'package:auto_access/features/rent/screens/rental_shops/all_shops.dart';
import 'package:auto_access/features/rent/screens/rental_shops/shop.dart';
import 'package:auto_access/features/rent/screens/store/widgets/categories_tab.dart';
import 'package:auto_access/utility/constants/sizes.dart';
import 'package:auto_access/utility/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utility/constants/colors.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = CategoryController.instance.featuredCategories;
    final rentalShopController = Get.put(RentalShopController());
    final dark = RHelperFunctions.isDarkMode(context);
    return PopScope(
      canPop: false,
      ///Intercept the back button press and redirect to Home Screen
      onPopInvoked:  (value) async => Get.offAll(const HomeScreen()),
      child: DefaultTabController(
        length: categories.length,
        child: Scaffold(
          appBar: RAppBar(title: Text('Store', style: Theme.of(context).textTheme.headlineMedium),
          ),
          body: NestedScrollView(headerSliverBuilder: (_, innerBoxIsScrolled) {
            return[
              SliverAppBar(
                pinned: true,
                floating: true,
                expandedHeight: 440,
                automaticallyImplyLeading: false,
                backgroundColor: dark? RColors.black : RColors.white,


                ///Search & Featured Rental shops
               flexibleSpace: Padding(
                 padding: const EdgeInsets.all(RSizes.defaultSpace),
                 child: ListView(
                   shrinkWrap: true,
                   physics: const NeverScrollableScrollPhysics(),
                   children: [
                     ///Search Bar
                     const SizedBox(height: RSizes.spaceBtwItems),
                     const SearchButtonContainer(text: 'Search in Store', showBorder: true, showBackground: false, padding: EdgeInsets.zero),
                     const SizedBox(height: RSizes.spaceBtwSections),

                     ///Featured Rental Shops
                     SectionHeadings(title: 'Featured RentalShops', onPressed: () => Get.to(() => const AllShopsScreen())),
                     const SizedBox(height: RSizes.spaceBtwItems/1.5),

                     ///Rental Shops
                     Obx(
                       () {
                         /// Check if categories are still loading
                         if(rentalShopController.isLoading.value) return const RentalShopShimmer();

                         ///Check if there are no featured categories found
                        if(rentalShopController.featuredRentalShops.isEmpty){
                          return Center(
                            child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)),
                          );
                        } else {
                          return GridLayout(
                           itemCount: 4,
                           mainAxisExtent: 80,
                           itemBuilder: (_, index) {
                             final rentalShop = rentalShopController.featuredRentalShops[index];
                             return RentalShopCard(
                               rentalShop: rentalShop,
                               showBorder: true,
                               onTap: () => Get.to(() => RentalShopScreen(rentalShop: rentalShop)),
                             );
                          }
                          );
                        }
                       }
                     ),
                     const SizedBox(height: RSizes.spaceBtwSections),
                   ],
                 ),
               ),
                                    ///TABS
               bottom: TabBar(
                   tabs: categories.map((category) => Tab(child: Text(category.name))).toList()),
              ),
            ];
          },
              body: TabBarView(
                  children: categories.map((category) => CategoryTab(category: category)).toList()),
          ),
        ),
      ),
    );
  }
}