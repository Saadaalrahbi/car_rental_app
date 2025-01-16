import 'package:auto_access/common/widgets/texts/section_header.dart';
import 'package:auto_access/features/rent/controllers/search_controller.dart';
import 'package:auto_access/features/rent/screens/all_vehicles/all_cars.dart';
import 'package:auto_access/features/rent/screens/rental_shops/shop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/cars/cars_card_vertical.dart';
import '../../../../common/widgets/image_text_widgets/image_text_vertical.dart';
import '../../../../common/widgets/images/circular_image.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/shimmers/category_shimmer.dart';
import '../../../../common/widgets/shimmers/search_category_shimmer.dart';
import '../../../../utility/constants/colors.dart';
import '../../../../utility/constants/sizes.dart';
import '../../../../utility/helpers/helper_function.dart';
import '../../controllers/category_controller.dart';
import '../../controllers/rental_shop_controller.dart';
import '../../models/category_model.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final categoryController = CategoryController.instance;
  final searchController = Get.put(RSearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RAppBar(
        title: Text('Search', style: Theme.of(context).textTheme.headlineMedium),
        actions: [TextButton(onPressed: () => Get.back(), child: const Text('Cancel'))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(RSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Search bar & Filter Button
              Row(
                children: [
                  /// Search
                  Expanded(
                    child: TextFormField(
                      autofocus: true,
                      onChanged: (search) => searchController.searchCars(search),
                      decoration: const InputDecoration(prefixIcon: Icon(Iconsax.search_normal), hintText: 'Search'),
                    ),
                  ),
                  const SizedBox(width: RSizes.spaceBtwItems),

                  /// Filter
                  OutlinedButton(
                    onPressed: () => filterModalBottomSheet(context),
                    style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.grey)),
                    child: const Icon(Iconsax.setting, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: RSizes.spaceBtwSections),

              /// Search
              Obx(
                () => searchController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    :
                // Show search if not Empty
                searchController.searchResults.isNotEmpty
                    ? GridLayout(
                  itemCount: searchController.searchResults.length,
                  itemBuilder: (_, index) => CarCardVertical(car: searchController.searchResults[index]),
                )
                    : rentalShopAndCategories(context),
              ),

              const SizedBox(height: RSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }


  Column rentalShopAndCategories(BuildContext context) {
    final rentalShopController = Get.put(RentalShopController());
    final categoryController = Get.put(CategoryController());
    final isDark = RHelperFunctions.isDarkMode(context);
    return Column(
      children: [

        const SectionHeadings(title: 'RentalShops', showActionButton: false,),

        Obx(
          () {
            // Check if categories are still loading
            if (rentalShopController.isLoading.value) return const CategoryShimmer();

            /// Data Found
            return Wrap(
              children: rentalShopController.allRentalShops
                  .map((rentalShop) => GestureDetector(
                onTap: () => Get.to(RentalShopScreen(rentalShop: rentalShop)),
                child: Padding(
                  padding: const EdgeInsets.only(top: RSizes.md),
                  child: VerticalImageAndText(
                    image: rentalShop.image,
                    title: rentalShop.name,
                    isNetworkImage: true,
                    textColor: RHelperFunctions.isDarkMode(context) ? RColors.white : RColors.dark,
                    backgroundColor: RHelperFunctions.isDarkMode(context) ? RColors.darkerGrey : RColors.light,
                  ),
                ),
              ))
                  .toList(),
            );
          },
        ),
        const SizedBox(height: RSizes.spaceBtwSections),

        /// Categories
        const SectionHeadings(title: 'Categories', showActionButton: false),
        const SizedBox(height: RSizes.spaceBtwItems),

        /// Obx widget for reactive UI updates based on the state of [categoryController].
        /// It displays a shimmer loader while categories are being loaded, shows a message if no data is found,
        /// and renders a horizontal list of featured categories with images and text.
        Obx(
              () {
            // Check if categories are still loading
            if (categoryController.isLoading.value) return const SearchCategoryShimmer();

            // Check if there are no featured categories found
            if (categoryController.allCategories.isEmpty) {
              return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)));
            } else {
              /// Data Found
              // Display a horizontal list of featured categories with images and text
              final categories = categoryController.allCategories;
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (_, __) => const SizedBox(height: RSizes.spaceBtwItems),
                itemCount: categories.length,
                shrinkWrap: true,
                itemBuilder: (_, index) => GestureDetector(
                  onTap: () => Get.to(
                        () => AllCars(
                      title: categories[index].name,
                      futureMethod: categoryController.getCategoryCars(categoryId: categories[index].id),
                    ),
                  ),
                  child: Row(
                    children: [
                      CircularImage(
                        width: 25,
                        height: 25,
                        padding: 0,
                        isNetworkImage: true,
                        overlayColor: isDark ? RColors.white : RColors.dark,
                        image: categories[index].image,
                      ),
                      const SizedBox(width: RSizes.spaceBtwItems / 2),
                      Text(categories[index].name)
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Future<dynamic> filterModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          left: RSizes.defaultSpace,
          right: RSizes.defaultSpace,
          top: RSizes.defaultSpace,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Heading
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SectionHeadings(title: 'Filter', showActionButton: false),
                  IconButton(onPressed: () => Get.back(), icon: const Icon(Iconsax.close_square))
                ],
              ),
              const SizedBox(height: RSizes.spaceBtwSections / 2),

              /// Sort
              Text('Sort by', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: RSizes.spaceBtwItems / 2),

              _buildSortingDropdown(),
              const SizedBox(height: RSizes.spaceBtwSections),

              /// Categories

              Text('Category', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: RSizes.spaceBtwItems),
              _buildCategoryList(),
              const SizedBox(height: RSizes.spaceBtwSections),

              /// Sort by Radios
              Text('Pricing', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: RSizes.spaceBtwItems / 2),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) => searchController.minPrice.value = double.parse(value),
                      decoration: const InputDecoration(hintText: '\$ Lowest'),
                    ),
                  ),
                  const SizedBox(width: RSizes.spaceBtwItems),
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) => searchController.maxPrice.value = double.parse(value),
                      decoration: const InputDecoration(hintText: '\$ Highest'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: RSizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    searchController.search();
                    Get.back();
                  },
                  child: const Text('Apply'),
                ),
              ),
              const SizedBox(height: RSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSortingDropdown() {
    return Obx(
          () => DropdownButton<String>(
        value: searchController.selectedSortingOption.value,
        onChanged: (String? newValue) {
          if (newValue != null) {
            searchController.selectedSortingOption.value = newValue;
            searchController.search(); // Trigger the search when the sorting option changes
          }
        },
           items: searchController.sortingOptions.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCategoryList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: categoryController.allCategories.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _buildCategoryTile(categoryController.allCategories[index]);
      },
    );
  }

  Widget _buildCategoryTile(CategoryModel category) {
    return category.parentId.isEmpty ? Obx(() => _buildParentCategoryTile(category)) : const SizedBox.shrink();
  }

  Widget _buildParentCategoryTile(CategoryModel category) {
    return ExpansionTile(
      title: Text(category.name),
      children: _buildSubCategories(category.id),
    );
  }

  List<Widget> _buildSubCategories(String parentId) {
    List<CategoryModel> subCategories = categoryController.allCategories.where((cat) => cat.parentId == parentId).toList();
    return subCategories.map((subCategory) => _buildSubCategoryTile(subCategory)).toList();
  }

  Widget _buildSubCategoryTile(CategoryModel category) {
    return RadioListTile(
      title: Text(category.name),
      value: category.id,
      groupValue: searchController.selectedCategoryId.value,
      onChanged: (value) {
        searchController.selectedCategoryId.value = value.toString();
      },
    );
  }
}