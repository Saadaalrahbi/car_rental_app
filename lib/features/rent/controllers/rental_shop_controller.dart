import 'package:get/get.dart';
import '../../../common/widgets/loaders/loaders.dart';
import '../../../data/repositories/car/car_repository.dart';
import '../../../data/repositories/rental_shop_repository.dart';
import '../models/car_model.dart';
import '../models/rental_shops_model.dart';

class RentalShopController extends GetxController {
  static RentalShopController get instance => Get.find();

  RxBool isLoading = true.obs;
  RxList<RentalShopModel> allRentalShops = <RentalShopModel>[].obs;
  RxList<RentalShopModel> featuredRentalShops = <RentalShopModel>[].obs;
  final rentalShopRepository = Get.put(RentalShopRepository());

  @override
  void onInit() {
    getFeaturedRentalShops();
    super.onInit();
  }

  /// -- Load Rental Shops
  Future<void> getFeaturedRentalShops() async {
    try {
      // Show loader while loading Brands
      isLoading.value = true;

      // Fetch RENTAL SHOPS from your data source (Firestore, API, etc.)
      final fetchedCategories = await rentalShopRepository.getAllRentalShop();

      // Update the rental shop list
      allRentalShops.assignAll(fetchedCategories);

      // Update the featured brands list
      featuredRentalShops.assignAll(allRentalShops.where((rentalShop) => rentalShop.isFeatured ?? false).take(4).toList());

    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// -- Get rental shops For Category
  Future<List<RentalShopModel>> getRentalShopForCategory(String categoryId) async {
    final rentalShops = await rentalShopRepository.getRentalShopForCategory(categoryId);
    return rentalShops;
  }

  /// Get rental shops Specific Cars from your data source
  Future<List<CarModel>> getRentalShopCars(String rentalShopId, int limit) async {
    final cars = await CarRepository.instance.getCarsForRentalShop(rentalShopId, limit);
    return cars;
  }
}
