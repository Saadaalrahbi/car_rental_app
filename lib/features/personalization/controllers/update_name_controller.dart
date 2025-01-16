import 'package:auto_access/common/widgets/loaders/loaders.dart';
import 'package:auto_access/features/personalization/controllers/user_controller.dart';
import 'package:auto_access/features/personalization/screens/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/repositories/personalization/user_repository.dart';
import '../../../utility/constants/image_strings.dart';
import '../../../utility/helpers/network_manager.dart';
import '../../../utility/popups/full_screen_loader.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

 ///Variables
final firstName = TextEditingController();
final lastName = TextEditingController();
final userController = UserController.instance;
final userRepository = Get.put(UserRepository());
GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  ///Fetching user record
 Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
 }

 Future<void> updateUserName() async {
   try {
     //Start loading
     FullScreenLoader.openLoadingDialog('We are updating your information...', RImages.processing);

     //Check for internet connectivity
     final isConnected = await NetworkManager.instance.isConnected();
     if (!isConnected) {
       //Remove Loader
       FullScreenLoader.stopLoading();
       return;
     }

     //Form validation
     if (!updateUserNameFormKey.currentState!.validate()) {
       //Remove Loader
       FullScreenLoader.stopLoading();
       return;
     }
   //Updating user's first name  & last name in firebase firestore
   Map<String, dynamic> name = {'First Name': firstName.text.trim(), 'Last Name': lastName.text.trim()};
     await userRepository.updateSingleField(name);

   //Updating the Rx user value
     userController.user.value.firstName = firstName.text.trim();
     userController.user.value.lastName = lastName.text.trim();

     //Removing the Loader
     FullScreenLoader.stopLoading();

     //Showing the success message
     Loaders.successSnackBar(title: 'Congratulations', message: 'Your Name has been updated');

     //Moving to previous page
     Get.off(() => const ProfileScreen());
   } catch (e) {
     FullScreenLoader.stopLoading();
     Loaders.errorSnackBar(title: 'Oops', message: e.toString());
   }
   }
}