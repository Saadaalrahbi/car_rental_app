import 'package:auto_access/data/repositories/car/car_repository.dart';
import 'package:auto_access/features/rent/models/car_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../common/widgets/loaders/loaders.dart';

class AllCarsController extends GetxController {
  static AllCarsController get instance => Get.find();

  final repository = CarRepository.instance;
  final RxString selectedSortOption = 'Name'.obs;
  final RxList<CarModel> cars = <CarModel>[].obs;

  Future<List<CarModel>> fetchCarsByQuery(Query? query) async {
    try {
      if(query == null) return [];
      return await repository.fetchCarsByQuery(query);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  void assignCars(List<CarModel> cars) {
    // Assign cars to the 'cars' list
    this.cars.assignAll(cars);
    sortCars('Name');
  }

  void sortCars(String sortOption) {
    selectedSortOption.value = sortOption;

    switch (sortOption) {
      case 'Name':
        cars.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Higher Price':
        cars.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Lower Price':
        cars.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Newest':
        cars.sort((a, b) => a.date!.compareTo(b.date!));
        break;
      default:
      // Default sorting option: Name
        cars.sort((a, b) => a.title.compareTo(b.title));
    }
  }
}