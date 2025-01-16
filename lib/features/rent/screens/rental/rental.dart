import 'package:auto_access/common/widgets/appbar/appbar.dart';
import 'package:auto_access/features/rent/screens/rental/rental_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utility/constants/sizes.dart';
import '../../../personalization/controllers/address_controller.dart';

class RentalScreen extends StatelessWidget {
  const RentalScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      appBar: RAppBar(title: Text('My Rentals', style: Theme.of(context).textTheme.headlineSmall), showBackArrow: true),
      body: const Padding(
        padding: EdgeInsets.all(RSizes.defaultSpace),
        child: RentalList(),
      ),
    );
  }
}