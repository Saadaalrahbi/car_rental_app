import 'package:auto_access/common/widgets/loaders/loaders.dart';
import 'package:auto_access/data/repositories/authentication/authentication_repository.dart';
import 'package:auto_access/features/authentication/screens/login/login.dart';
import 'package:auto_access/features/personalization/models/user_model.dart';
import 'package:auto_access/features/personalization/screens/profile/re_authenticate_user_login_form.dart';
import 'package:auto_access/utility/constants/image_strings.dart';
import 'package:auto_access/utility/constants/sizes.dart';
import 'package:auto_access/utility/popups/full_screen_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/repositories/personalization/user_repository.dart';
import '../../../utility/helpers/network_manager.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();


  Rx<UserModel> user = UserModel.empty().obs;
  final profileLoading = false.obs;
  final profileImageUrl = ''.obs;
  final hidePassword = false.obs;
  final imageUploading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();


  @override
  void onInit() {
    fetchUserRecord();
    super.onInit();
  }

  ///Fetching user record
  Future <void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  ///Saving user record from any registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      //Updating the user and checking if the user data is already stored, if not it will store new data
      await fetchUserRecord();

      //if no record is stored
      if(user.value.id.isEmpty){
      if (userCredentials != null) {
        //Converting Name to first and last name
        final nameParts = UserModel.nameParts(
            userCredentials.user!.displayName ?? '');
        final username = UserModel.generateUsername(
            userCredentials.user!.displayName ?? '');

        //Map Data
        final user = UserModel(
          id: userCredentials.user!.uid,
          firstName: nameParts[0],
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
          username: username,
          email: userCredentials.user!.email ?? '',
          phoneNumber: userCredentials.user!.phoneNumber ?? '',
          profilePicture: userCredentials.user!.photoURL ?? '',
        );

        //Saving user data
        await userRepository.saveUserRecord(user);
 }
  }
} catch (e) {
      Loaders.warningSnackBar(title: 'Data not saved',
          message: 'Something went wrong while saving your information. You can re-save your data in your Profile');
    }
  }

  ///Delete Account Warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(RSizes.md),
      title: 'Delete Account',
      middleText: 'Are you sure you want to delete your account permanently? This action cannot be reversed and all of your data will be removed permanently',
      confirm: ElevatedButton(onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
        child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: RSizes.lg),
            child: Text('Delete')),),
      cancel: OutlinedButton(child: const Text('Cancel'),
          onPressed: () => Navigator.of(Get.overlayContext!).pop()),
    );
  }

  ///Delete User Account
  void deleteUserAccount() async {
    try {
      FullScreenLoader.openLoadingDialog('Processing...', RImages.processing);

      ///First re-authenticate user
      final auth = AuthenticationRepository.instance;
      final provider = auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        //Re-verify Auth email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          FullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          FullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oops', message: e.toString());
    }
  }

  ///Re-Authenticate before deleting the account
  Future<void> reAuthenticateEmailAndPassword() async {
    try {
      FullScreenLoader.openLoadingDialog('Processing', RImages.processing);

      //Check for internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //Remove Loader
        FullScreenLoader.stopLoading();
        return;
      }
      if (!reAuthFormKey.currentState!.validate()){
        FullScreenLoader.stopLoading();
        return;
      }
      await AuthenticationRepository.instance.reAuthenticateWithEmailAndPassword(verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      FullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.warningSnackBar(title: 'Oops', message: e.toString());
    }
  }

  ///Uploading Profile Image
 uploadUserProfilePicture() async {
    try {
    //this will allow user to choose a pic from his/her gallery
    final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70, maxHeight: 512, maxWidth: 512);
    if(image != null){
      imageUploading.value = true;
      //uploading image
      final uploadedImage = await userRepository.uploadImage('Users/Images/Profile/', image);
      profileImageUrl.value = uploadedImage;

      //Update user image record
      Map<String, dynamic> json = {'ProfilePicture' : uploadedImage};
      await userRepository.updateSingleField(json);

      user.value.profilePicture = uploadedImage;
      user.refresh();
      imageUploading.value = false;
      Loaders.successSnackBar(title: 'Congratulations', message: 'Your Profile Picture has been updated!');
    }
  } catch (e) {
      imageUploading.value = false;
      Loaders.errorSnackBar(title: 'Oops', message: 'Something went wrong');
  } finally {
      imageUploading.value = false;
    }
 }

  /// Logout Loader Function
  logout() {
    try {
      Get.defaultDialog(
        contentPadding: const EdgeInsets.all(RSizes.md),
        title: 'Logout',
        middleText: 'Are you sure you want to Logout?',
        confirm: ElevatedButton(
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: RSizes.lg),
            child: Text('Confirm'),
          ),
          onPressed: () async {
            onClose();

            await AuthenticationRepository.instance.logout();
          },
        ),
        cancel: OutlinedButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        ),
      );
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}






