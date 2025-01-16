import 'package:auto_access/common/widgets/loaders/loaders.dart';
import 'package:auto_access/data/repositories/categories/category_repository.dart';
import 'package:auto_access/features/rent/models/category_model.dart';
import 'package:get/get.dart';

import '../../../data/repositories/car/car_repository.dart';
import '../models/car_model.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  RxBool isLoading = true.obs;
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel>featuredCategories = <CategoryModel>[].obs;
  final _categoryRepository = Get.put(CategoryRepository());

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  ///Load category data
  Future<void> fetchCategories() async {
    try {
      //Show Loader while loading the categories
      isLoading.value = true;

      //Fetch categories from data source (Firestore, API, etc)
      final categories = await _categoryRepository.getAllCategories();

      //Updating the categories list
      allCategories.assignAll(categories);

      //Filter featured categories
      featuredCategories.assignAll(allCategories.where((category) => category.isFeatured && category.parentId.isEmpty).take(10).toList());
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oops', message: e.toString());
    } finally {
      //Remove loader
      isLoading.value = false;
    }
  }

  /// -- Load selected category data
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    // Fetch all categories where ParentId = categoryId;
    try {
      final subCategories = await _categoryRepository.getSubCategories(categoryId);
      return subCategories;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
  /// Get Category or Sub-Category Cars.
  /// If you want to fetch all the cars in this category SET [limit] to -1
  Future<List<CarModel>> getCategoryCars({required String categoryId, int limit = 4}) async {
    // Fetch limited (4) cars against each subCategory;
    final cars= await CarRepository.instance.getCarsForCategory(categoryId: categoryId, limit: limit);
    return cars;
  }
}