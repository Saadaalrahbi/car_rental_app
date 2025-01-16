import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utility/constants/colors.dart';
import '../../../../utility/constants/sizes.dart';
import '../../../personalization/screens/address/address.dart';
import '../../controllers/rent_now_controller.dart';

class RentNowScreen extends StatelessWidget {
  const RentNowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final car = RentNowController.instance.selectedCar.value;
    final carPrice = car.price;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rent Now'),
        backgroundColor: RColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(RSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              car.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: RSizes.spaceBtwSections),
            Text(
              'Price: ${carPrice.toStringAsFixed(2)} OMR',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: RSizes.spaceBtwSections),
            const Text(
              'Select Delivery or Pickup:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: RSizes.spaceBtwSections),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Rental pickup logic
                      Get.snackbar(
                        'Rental Confirmed',
                        'Your rental has been confirmed. Please pick up the car from the shop.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                    },
                    child: const Text('Pickup from Shop'),
                  ),
                ),
                const SizedBox(width: RSizes.spaceBtwItems),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => const UserAddressScreen())?.then((_) {
                        // After user selects an address for delivery
                        Get.snackbar(
                          'Rental Confirmed',
                          'Your rental has been confirmed and will be delivered to the selected address.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                      });
                    },
                    child: const Text('Deliver to Address'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: RSizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}