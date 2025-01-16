import 'package:auto_access/features/rent/controllers/rental_controller.dart';
import 'package:auto_access/features/rent/screens/home/home.dart';
import 'package:auto_access/utility/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/cars/rounded_container.dart';
import '../../../../common/widgets/loaders/animation_loader.dart';
import '../../../../utility/constants/colors.dart';
import '../../../../utility/constants/sizes.dart';
import '../../../../utility/helpers/cloud_helper_functions.dart';
import '../../../../utility/helpers/helper_function.dart';

class RentalList extends StatelessWidget {
  const RentalList ({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RentalController());
    return FutureBuilder(
        future: controller.fetchUserRentals(),
        builder: (_, snapshot) {
          /// Nothing Found Widget
          final emptyWidget = AnimationLoaderWidget(
            text: 'Whoops! No Orders Yet!',
            animation: RImages.nothingFound,
            showAction: true,
            actionText: 'Let\'s fill it',
            onActionPressed: () => Get.off(() => const HomeScreen()),
          );

       /// Helper Function: Handle Loader, No Record, OR ERROR Message
       final response = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, nothingFound: emptyWidget);
       if (response != null) return response;

       /// Congratulations Record found.
       final rentals = snapshot.data!;
       return ListView.separated(
         shrinkWrap: true,
         itemCount: rentals.length,
         separatorBuilder: (_, index) => const SizedBox(height: RSizes.spaceBtwItems),
         itemBuilder: (_, index) {
           final rental = rentals[index];
           return RoundedContainer(
             showBorder: true,
             backgroundColor: RHelperFunctions.isDarkMode(context) ? RColors.dark : RColors.light,
             child: Column(
               children: [
                 /// -- Top Row
                 Row(
                   children: [
                     /// 1 - Image
                     const Icon(Iconsax.ship),
                     const SizedBox(width: RSizes.spaceBtwItems / 2),

                     /// 2 - Status & Date
                     Expanded(
                       child: Column(
                         mainAxisSize: MainAxisSize.min,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                             rental.rentalStatusText,
                             overflow: TextOverflow.ellipsis,
                             style: Theme.of(context).textTheme.bodyLarge!.apply(color: RColors.primary, fontWeightDelta: 1),
                           ),
                           Text(rental.formattedRentDate, style: Theme.of(context).textTheme.headlineSmall),
                         ],
                       ),
                     ),

                     /// 3 - Icon
                     IconButton(onPressed: () {}, icon: const Icon(Iconsax.arrow_right_34, size: RSizes.iconSm)),
                   ],
                 ),
                 const SizedBox(height: RSizes.spaceBtwItems),

                 /// -- Bottom Row
                 Row(
                   children: [
                     Expanded(
                       child: Row(
                         children: [
                           /// 1 - Icon
                           const Icon(Iconsax.tag),
                           const SizedBox(width: RSizes.spaceBtwItems / 2),

                           /// Rental
                           Flexible(
                             child: Column(
                               mainAxisSize: MainAxisSize.min,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(
                                   'Rental',
                                   maxLines: 1,
                                   overflow: TextOverflow.ellipsis,
                                   style: Theme.of(context).textTheme.labelMedium,
                                 ),
                                 Text(
                                   rental.id,
                                   maxLines: 1,
                                   overflow: TextOverflow.ellipsis,
                                   style: Theme.of(context).textTheme.titleMedium,
                                 ),
                               ],
                             ),
                           ),
                         ],
                       ),
                     ),

                     /// Delivery Date
                     Expanded(
                       child: Row(
                         children: [
                           /// 1 - Icon
                           const Icon(Iconsax.calendar),
                           const SizedBox(width: RSizes.spaceBtwItems / 2),

                           /// Status & Date
                           Flexible(
                             child: Column(
                               mainAxisSize: MainAxisSize.min,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(
                                   'Received Date',
                                   maxLines: 1,
                                   overflow: TextOverflow.ellipsis,
                                   style: Theme.of(context).textTheme.labelMedium,
                                 ),
                                 Text(
                                   rental.formattedDeliveryDate,
                                   maxLines: 1,
                                   overflow: TextOverflow.ellipsis,
                                   style: Theme.of(context).textTheme.titleMedium,
                                 ),
                               ],
                             ),
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
               ],
             ),
           );
         },
       );
     });
  }
}