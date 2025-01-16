import 'package:auto_access/features/rent/models/rental_model.dart';
import 'package:get/get.dart';
import '../../../common/widgets/loaders/loaders.dart';
import '../../../data/repositories/rental_repository.dart';
import '../../personalization/controllers/address_controller.dart';

class RentalController extends GetxController {
  static RentalController get instance => Get.find();

  /// Variables
  final addressController = AddressController.instance;
  final rentalRepository = Get.put(RentalRepository());

  /// Fetch user's rental history
  Future<List<RentalModel>> fetchUserRentals() async {
    try {
      final userRentals = await rentalRepository.fetchUserRentals();
      return userRentals;
    } catch (e) {
      Loaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }



}