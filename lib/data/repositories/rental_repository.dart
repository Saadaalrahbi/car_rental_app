import 'package:auto_access/features/rent/models/rental_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'authentication/authentication_repository.dart';

class RentalRepository extends GetxController {
  static RentalRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  /// Get all rentals related to current User
  Future<List<RentalModel>> fetchUserRentals() async {
    try {
      final userId = AuthenticationRepository.instance.getUserID;
      if (userId.isEmpty) throw 'Unable to find user information. Try again in few minutes.';

      // final result = await _db.collection('Users').doc(userId).collection('Orders').get();
      final result = await _db.collection('Rentals').where('userId', isEqualTo: userId).get();
      return result.docs.map((documentSnapshot) => RentalModel.fromSnapshot(documentSnapshot)).toList();
    } catch (e) {
      throw 'Something went wrong while fetching Order Information. Try again later';
    }
  }
       /// Store new user rental
  Future<void> saveRental(RentalModel rental, String userId) async {
    try {
      await _db.collection('Rentals').add(rental.toJson());
    } catch (e) {
      throw 'Something went wrong while saving Order Information. Try again later';
    }
  }

}