import 'package:auto_access/utility/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/widgets/loaders/animation_loader.dart';
import '../constants/colors.dart';

///A utility class for managing a full screen loading dialog.
class FullScreenLoader{
  ///Open a full-screen loading dialog with a given text and animation
  ///This method doesn't return anything.
  ///
  /// Parameters
  ///  - text: The text to be displayed in the loading dialog
  ///  - animation: The animation to be shown
  static void openLoadingDialog(String text, String animation){
    showDialog(
     context: Get.overlayContext!, //using Get.overlayContext for overlay dialogs
    barrierDismissible: false, //dialogs cant be dismissed by tapping outside it
    builder:(_) => PopScope(
      canPop: false, //Disable popping with back button
     child: Container(
      color: RHelperFunctions.isDarkMode(Get.context!) ? RColors.dark : RColors.white,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 250),
          AnimationLoaderWidget(text: text, animation: animation),
        ]
     ),
   ),
    ),
    );
  }
  ///Stopping the currently opened loading dialog
  static stopLoading(){
    Navigator.of(Get.overlayContext!).pop(); //Closing the dialog using navigator
  }
}

