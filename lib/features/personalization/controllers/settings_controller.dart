import 'package:get/get.dart';

import '../../../common/widgets/loaders/loaders.dart';
import '../../../data/repositories/personalization/setting_repository.dart';
import '../models/setting_model.dart';


class SettingsController extends GetxController {
  static SettingsController get instance => Get.find();

  // Observable variables
  RxBool loading = false.obs;
  Rx<SettingsModel> settings = SettingsModel().obs;
  final settingRepository = Get.put(SettingsRepository());

  @override
  void onInit() {
    // Fetch setting details on controller initialization
    fetchSettingDetails();
    super.onInit();
  }
  /// Fetches setting details from the repository
  Future<void> fetchSettingDetails() async {
    try {
      loading.value = true;
      final settings = await settingRepository.getSettings();
      this.settings.value = settings;
      loading.value = false;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Something went wrong.', message: e.toString());
    }
  }

}

