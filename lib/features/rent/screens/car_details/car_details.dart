import 'package:auto_access/features/rent/screens/rent_now/rent_now.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/curved_edges/curved_edge_widgets.dart';
import '../../../../common/widgets/images/circular_image.dart';
import '../../../../common/widgets/rounded_image.dart';
import '../../../../common/widgets/texts/car_title_text.dart';
import '../../../../common/widgets/texts/shop_title_text_with_ver_icon.dart';
import '../../../../utility/constants/colors.dart';
import '../../../../utility/constants/enums.dart';
import '../../../../utility/constants/image_strings.dart';
import '../../../../utility/constants/sizes.dart';
import '../../../../utility/helpers/helper_function.dart';

class CarDetails extends StatefulWidget {
  const CarDetails({super.key});

  @override
  _CarDetailsState createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  final List<String> imageList = [
    'assets/images/cars/audi1.png',
    'assets/images/cars/audi2.png',
    'assets/images/cars/audi3.png',
    'assets/images/cars/audi4.png',
    'assets/images/cars/audi5.png'
  ];

  String currentImage = 'assets/images/cars/audi1.png';

  // Price per day in OMR
  final double pricePerDay = 15.0;

  // Selected rental duration
  int selectedDays = 1;

  @override
  Widget build(BuildContext context) {
    double totalPrice = pricePerDay * selectedDays;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CurvedEdgeWidget(
              child: Stack(
                children: [
                  // Main image display
                  SizedBox(
                    height: 400,
                    child: Padding(
                      padding: const EdgeInsets.all(RSizes.carImageRadius * 2),
                      child: Center(
                        child: Image.asset(currentImage),
                      ),
                    ),
                  ),

                  // Image slider
                  Positioned(
                    right: 0,
                    bottom: 30,
                    left: RSizes.defaultSpace,
                    child: SizedBox(
                      height: 80,
                      child: ListView.separated(
                        itemCount: imageList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const AlwaysScrollableScrollPhysics(),
                        separatorBuilder: (_, __) =>
                        const SizedBox(width: RSizes.spaceBtwItems),
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                currentImage = imageList[index];
                              });
                            },
                            child: RoundedImage(
                              width: 80,
                              backgroundColor: RHelperFunctions.isDarkMode(context)
                                  ? RColors.dark
                                  : RColors.white,
                              border: Border.all(
                                color: currentImage == imageList[index]
                                    ? RColors.primary
                                    : RColors.grey,
                              ),
                              padding: const EdgeInsets.all(RSizes.sm),
                              imageUrl: imageList[index],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const RAppBar(showBackArrow: true),
                ],
              ),
            ),

            // Car details section
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: RSizes.defaultSpace,
                vertical: RSizes.defaultSpace,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rating and Share Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Iconsax.star5, color: Colors.amber, size: 24),
                          const SizedBox(width: RSizes.spaceBtwItems / 2),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '5.0 ',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const TextSpan(
                                  text: '(50)',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.share, size: RSizes.iconMd),
                      ),
                    ],
                  ),

                  // Car title
                  const CarTitleText(title: 'Blue Audi'),
                  const SizedBox(height: RSizes.spaceBtwItems / 1.5),

                  // Shop details
                  Row(
                    children: [
                      CircularImage(
                        image: RImages.mas,
                        width: 32,
                        height: 32,
                        overlayColor: RHelperFunctions.isDarkMode(context)
                            ? RColors.white
                            : RColors.black,
                      ),
                      const ShopTitleTextWithVerIcon(
                        title: 'Mas Rent A Car',
                        shopTitleSizes: TextSizes.medium,
                      ),
                    ],
                  ),

                  const SizedBox(height: RSizes.spaceBtwItems),

                  // Price and duration selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Price per day: $pricePerDay OMR',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      DropdownButton<int>(
                        value: selectedDays,
                        items: List.generate(
                          7 ,
                              (index) => DropdownMenuItem(
                            value: index + 1,
                            child: Text('${index + 1} day${index > 0 ? "s" : ""}'),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            selectedDays = value!;
                          });
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: RSizes.spaceBtwItems / 1.5),

                  // Total price display
                  Text(
                    'Total Price: $totalPrice OMR',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: RSizes.spaceBtwSections),

                  // Rent Now Button
                  SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Get.to(const RentNowScreen()),
                      child: const Text('Rent Now')))

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}