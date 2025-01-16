import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../utility/constants/enums.dart';
import '../../../utility/helpers/helper_function.dart';
import '../../personalization/models/address_model.dart';

class RentalModel {
  final String id;
  final String userId;
  final RentalStatus status;
  final double totalAmount;
  final DateTime rentDate;
  final AddressModel? deliveredAddress;
  final DateTime? deliveryDate;


  RentalModel({
    required this.id,
    this.userId = '',
    required this.status,
    required this.totalAmount,
    required this.rentDate,
    this.deliveredAddress,
    this.deliveryDate,
  });

  String get formattedRentDate => RHelperFunctions.getFormattedDate(rentDate);

  String get formattedDeliveryDate => deliveryDate != null ? RHelperFunctions.getFormattedDate(deliveryDate!) : '';

  String get rentalStatusText => status == RentalStatus.delivered
      ? 'Delivered'
      : status == RentalStatus.returned
      ? 'Car has been returned'
      : 'Processing';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.toString(), // Enum to string
      'totalAmount': totalAmount,
      'rentDate': rentDate,
      'shippingAddress': deliveredAddress?.toJson(), // Convert AddressModel to map
      'deliveryDate': deliveryDate,
    };
  }

  factory RentalModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return RentalModel(
      id: data.containsKey('id') ? data['id'] as String : '',
      userId: data.containsKey('userId') ? data['userId'] as String : '',
      status: data.containsKey('status') ? RentalStatus.values.firstWhere((e) => e.toString() == data['status']) : RentalStatus.pending, // Default status
      totalAmount: data.containsKey('totalAmount') ? data['totalAmount'] as double : 0.0,
      rentDate: data.containsKey('rentDate') ? (data['rentDate'] as Timestamp).toDate() : DateTime.now(), // Default to current time
      deliveredAddress: data.containsKey('deliveredAddress') ? AddressModel.fromMap(data['deliveredAddress'] as Map<String, dynamic>) : AddressModel.empty(),
      deliveryDate: data.containsKey('deliveryDate') && data['deliveryDate'] != null ? (data['deliveryDate'] as Timestamp).toDate() : null,
    );
  }

}
