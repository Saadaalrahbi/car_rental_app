import 'package:auto_access/data/repositories/car/car_repository.dart';
import 'package:auto_access/features/rent/models/car_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';


class RSearchController extends GetxController {
  static RSearchController get instance => Get.find();

  RxList<CarModel> searchResults = <CarModel>[].obs;
  RxBool isLoading = false.obs;
  RxString lastSearchQuery = ''.obs;
  final RxString searchQuery = ''.obs;
  final RxString selectedCategoryId = ''.obs;
  RxDouble minPrice = 0.0.obs;
  RxDouble maxPrice = double.infinity.obs;
  List<String> sortingOptions = ['Name', 'Lowest Price', 'Highest Price', 'Popular', 'Newest', 'Suitable'];
  RxString selectedSortingOption = 'Name'.obs; // Default sorting option

 void search(){
   searchCars(
     searchQuery.value,
     categoryId: selectedCategoryId.value.isNotEmpty ? selectedCategoryId.value : null,
     minPrice: minPrice.value != 0.0 ? minPrice.value : null,
     maxPrice: maxPrice.value != double.infinity ? maxPrice.value : null,
   );
 }

 void searchCars(String query, {String? categoryId, String? rentalShopId, double? minPrice, double? maxPrice}) async {
   lastSearchQuery.value = query;
   isLoading.value = true;

   try {
     final result = await CarRepository.instance.searchCars(query, categoryId: categoryId, rentalShopId:rentalShopId, maxPrice: maxPrice, minPrice: minPrice);

     ///Applying sorting
     switch(selectedSortingOption.value){
       case 'Name':
       // Sort by name
         result.sort((a, b) => a.title.compareTo(b.title));
         break;
       case 'Lowest Price':
       // Sort by price in ascending order
         result.sort((a, b) => a.price.compareTo(b.price));
         break;
       case 'Highest Price':
       // Sort by price in descending order
         result.sort((a, b) => b.price.compareTo(a.price));
         break;
     }
     /// Update searchResults with sorted results
     searchResults.assignAll(result);
   }catch (e) {
     if (kDebugMode) {
       print('Error fetching data: $e');
     }
   } finally {
     isLoading.value = false;
   }
 }
}