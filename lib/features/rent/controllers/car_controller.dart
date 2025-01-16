import 'package:auto_access/data/repositories/car/car_repository.dart';
import 'package:auto_access/features/rent/models/car_model.dart';
import 'package:get/get.dart';
import '../../../common/widgets/loaders/loaders.dart';
import '../../../utility/constants/enums.dart';

class CarController extends GetxController {
  static CarController get instance => Get.find();


  final isLoading = false.obs;
  final carRepository = Get.put(CarRepository());
  RxList<CarModel> featuredCars = <CarModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedCars();
    super.onInit();
  }

  void fetchFeaturedCars() async {
    try {
      //Loader while loading the cars
      isLoading.value = true;

      // Fetch cars
      final cars = await carRepository.getFeaturedCars();

      // Assign cars
      featuredCars.assignAll(cars);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oops', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Get the car price or price range for variations.
  String getCarPrice(CarModel car) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

      // Calculate the smallest and largest prices among variations
      for (var variation in car.carVariations!) {
        double priceToConsider = variation.price;

        // Update smallest and largest prices
        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }

        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }
      // If smallest and largest prices are the same, return a single price
      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toString();
      } else {
        // Otherwise, return a price range
        return '$smallestPrice - \$$largestPrice';
      }
    }

  /// -- Check car Stock Status
  String getCarAvailabilityStatus(CarModel car) {
    if (car.carType == CarType.variable.toString()) {
      return car.availability > 0 ? 'Available' : 'Not Available';
    } else {
      final availability = car.carVariations?.fold(0, (previousValue, element) => previousValue + element.availability);
      return availability != null && availability > 0 ? 'In Stock' : 'Out of Stock';
    }
  }

  }
