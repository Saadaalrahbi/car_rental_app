import 'package:auto_access/common/widgets/shimmers/category_shimmer.dart';
import 'package:auto_access/common/widgets/texts/section_header.dart';
import 'package:auto_access/features/rent/controllers/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/image_text_widgets/image_text_vertical.dart';
import '../../../../../utility/constants/colors.dart';
import '../../../../../utility/constants/sizes.dart';
import '../../sub_category/sub_categories.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    return Padding(
      padding: const EdgeInsets.only(left: RSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Heading
          const SectionHeadings(title: 'Categories', textColor: RColors.white, showActionButton: false),
          const SizedBox(height: RSizes.spaceBtwItems),

          Obx(
            () {
              ///Checking if categories are still loading
              if(categoryController.isLoading.value) return const CategoryShimmer();

              ///Checking if there are no featured categories
              if (categoryController.featuredCategories.isEmpty) {
                return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)));
              }else {
                return SizedBox(
                  height: 80,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: categoryController.featuredCategories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                    final category = categoryController.featuredCategories[index];
                     return VerticalImageAndText(
                        title: category.name,
                        image: category.image,
                        onTap: () => Get.to(() => SubCategoriesScreen(category: category)),
                      );
                    },
                  ),
                );
              }
            }
          )
        ],
      ),
    );
   }
}