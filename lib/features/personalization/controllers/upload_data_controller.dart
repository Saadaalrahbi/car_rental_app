import 'package:auto_access/utility/constants/image_strings.dart';
import 'package:auto_access/utility/popups/full_screen_loader.dart';
import 'package:get/get.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../../../common/widgets/loaders/loaders.dart';
import '../../../data/repositories/banner_repository.dart';
import '../../../data/repositories/car/car_repository.dart';
import '../../../data/repositories/categories/category_repository.dart';
import '../../../data/repositories/rental_shop_repository.dart';
import '../../rent/controllers/dummy_data.dart';
import '../../rent/controllers/banner_controller.dart';
import '../../rent/controllers/car_controller.dart';
import '../../rent/controllers/category_controller.dart';
import '../../rent/controllers/rental_shop_controller.dart';

class UploadDataController extends GetxController{
  static UploadDataController get instance => Get.find();

  Future<void>uploadCategories() async {
    try{
      // The following line will enable the Android and iOS wakelock.
      WakelockPlus.enabled;

      FullScreenLoader.openLoadingDialog('Your CATEGORIES are uploading...', RImages.cloudUploading);
      final controller = Get.put(CategoryRepository());

      // Upload All Categories and replace the Parent IDs in Firebase Console
      await controller.uploadDummyData(DummyData.categories);

      // Re-fetch latest Categories
      await CategoryController.instance.fetchCategories();


      Loaders.successSnackBar(title: 'Congratulations', message: 'All Categories Uploaded Successfully.');
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      // The next line disables the wakelock again.
      WakelockPlus.disable();
      FullScreenLoader.stopLoading();
    }
  }


  Future<void> uploadCarCategories() async {
    try {
      // The following line will enable the Android and iOS wakelock.
      WakelockPlus.enable();

      FullScreenLoader.openLoadingDialog(
        'Sit Tight! Your Car CATEGORIES relationship is uploading...',
        RImages.cloudUploading,
      );

      final controller = Get.put(CategoryRepository());

      // Upload All Categories and replace the Parent IDs in Firebase Console
      await controller.uploadCarCategoryDummyData(DummyData.carCategories);

      Loaders.successSnackBar(title: 'Congratulations', message: 'All Categories Uploaded Successfully.');
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      // The next line disables the wakelock again.
      WakelockPlus.disable();
      FullScreenLoader.stopLoading();
    }
  }


  Future<void> uploadRentalShop() async {
    try {
      // The following line will enable the Android and iOS wakelock.
      WakelockPlus.enable();

      FullScreenLoader.openLoadingDialog('Sit Tight! Your Rental shops are uploading...', RImages.cloudUploading);

      final controller = Get.put(RentalShopRepository());

      // Upload All Categories and replace the Parent IDs in Firebase Console
      await controller.uploadDummyData(DummyData.rentalShop);


      final rentalShopController = Get.put(RentalShopController());
      await rentalShopController.getFeaturedRentalShops();

      Loaders.successSnackBar(title: 'Congratulations', message: 'All Rental Shops Uploaded Successfully.');
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      // The next line disables the wakelock again.
      WakelockPlus.disable();
      FullScreenLoader.stopLoading();
    }
  }

  Future<void> uploadRentalShopCategory() async {
    try {
      // The following line will enable the Android and iOS wakelock.
      WakelockPlus.enable();

      FullScreenLoader.openLoadingDialog(
        'Sit Tight! Your BRANDS & CATEGORIES relationship is uploading...',
        RImages.cloudUploading,
      );

      final controller = Get.put(RentalShopRepository());

      // Upload All Categories and replace the Parent IDs in Firebase Console
      await controller.uploadRentalShopCategoryDummyData(DummyData.rentalShopCategory);

      Loaders.successSnackBar(title: 'Congratulations', message: 'All RentalShop Uploaded Successfully.');
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      // The next line disables the wakelock again.
      WakelockPlus.disable();
      FullScreenLoader.stopLoading();
    }
  }

  Future<void> uploadCar() async {
    try {
      // The following line will enable the Android and iOS wakelock.
      WakelockPlus.enable();

      FullScreenLoader.openLoadingDialog(
        'Sit Tight! Your Cars are uploading. It may take a while...',
        RImages.cloudUploading,
      );

      final controller = Get.put(CarRepository());

      // Upload All Cars and replace the Parent IDs in Firebase Console
      await controller.uploadDummyData(DummyData.cars);

      // Re-fetch latest Featured Cars
      CarController.instance.fetchFeaturedCars();

      Loaders.successSnackBar(title: 'Congratulations', message: 'All Cars Uploaded Successfully.');
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      // The next line disables the wakelock again.
      WakelockPlus.disable();
      FullScreenLoader.stopLoading();
    }
  }

  Future<void> uploadBanners() async {
    try {
      // The following line will enable the Android and iOS wakelock.
      WakelockPlus.enable();

      FullScreenLoader.openLoadingDialog('Sit Tight! Your Banners are uploading. It may take a while...', RImages.cloudUploading);

      final controller = Get.put(BannerRepository());


      await controller.uploadBannersDummyData(DummyData.banners);

      // Re-fetch latest Banners
      final bannerController = Get.put(BannerController());
      await bannerController.fetchBanners();

      Loaders.successSnackBar(title: 'Congratulations', message: 'All Banners Uploaded Successfully.');
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      // The next line disables the wakelock again.
      WakelockPlus.disable();
      FullScreenLoader.stopLoading();
    }
  }
}

