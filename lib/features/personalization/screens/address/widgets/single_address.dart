import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/widgets/cars/rounded_container.dart';
import '../../../../../common/widgets/icons/circular_icon.dart';
import '../../../../../utility/constants/colors.dart';
import '../../../../../utility/constants/sizes.dart';
import '../../../../../utility/helpers/helper_function.dart';
import '../../../controllers/address_controller.dart';
import '../../../models/address_model.dart';
import '../update_address_screen.dart';

class SingleAddress extends StatelessWidget {
  const SingleAddress({
    super.key,
    required this.address,
    required this.onTap,
    required this.isBillingAddress,
  });

  final AddressModel address;
  final VoidCallback onTap;
  final bool isBillingAddress;

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    final dark = RHelperFunctions.isDarkMode(context);
    return Obx(
          () {
        String selectedAddressId = '';
        selectedAddressId =  controller.selectedAddress.value.id;
        final isAddressSelected = selectedAddressId == address.id;
        return GestureDetector(
          onTap: onTap,
          child: RoundedContainer(
            showBorder: true,
            padding: const EdgeInsets.all(RSizes.md),
            width: double.infinity,
            backgroundColor: isAddressSelected ? RColors.primary.withOpacity(0.1) : Colors.transparent,
            borderColor: isAddressSelected
                ? Colors.transparent
                : dark
                ? RColors.darkerGrey
                : RColors.grey,
            margin: const EdgeInsets.only(bottom: RSizes.spaceBtwItems),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: 0,
                  child: CircularIcon(
                    backgroundColor: RColors.primary.withOpacity(0.6),
                    width: 42,
                    height: 42,
                    size: RSizes.md,
                    color: Colors.white,
                    icon: Iconsax.edit_24,
                    onPressed: () => Get.to(() => UpdateAddressScreen(address: address)),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      isAddressSelected ? Iconsax.tick_circle1 : Iconsax.tick_circle1,
                      color: isAddressSelected
                          ? RColors.primary
                          : dark
                          ? RColors.darkerGrey
                          : RColors.grey,
                    ),
                    const SizedBox(width: RSizes.spaceBtwItems),
                    Expanded(
                      child: SizedBox(
                        height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                address.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            const SizedBox(height: RSizes.sm / 2),
                            Text(address.formattedPhoneNo, maxLines: 1, overflow: TextOverflow.ellipsis),
                            const SizedBox(height: RSizes.sm / 2),
                            Expanded(
                              child: Text(
                                address.toString(),
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}