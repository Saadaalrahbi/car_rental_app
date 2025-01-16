import 'package:flutter/material.dart';

import 'custom_theme/appbar_theme.dart';
import 'custom_theme/bottom_sheet_theme.dart';
import 'custom_theme/checkbox_theme.dart';
import 'custom_theme/chip_theme.dart';
import 'custom_theme/elevated_button_theme.dart';
import 'custom_theme/outlined_button_theme.dart';
import 'custom_theme/text_field_theme.dart';
import 'custom_theme/text_theme.dart';

class RAppTheme{
  RAppTheme._();

  //light theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme:RTextTheme.lightTextTheme,
    chipTheme: RChipTheme.lightTChipTheme,
    appBarTheme: RAppBarTheme.lightAppBarTheme,
    checkboxTheme: RCheckBoxTheme.lightCheckboxTheme,
    bottomSheetTheme: RBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: RElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: ROutlinedButtonTheme.lightTOutlinedButtonTheme,
    inputDecorationTheme: RTextFieldTheme.lightInputDecorationTheme,

  );

  //dark theme
  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.dark,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.black,
      textTheme:RTextTheme.darkTextTheme,
      chipTheme: RChipTheme.darkTChipTheme,
      appBarTheme: RAppBarTheme.darkAppBarTheme,
      checkboxTheme: RCheckBoxTheme.darkCheckboxTheme,
      bottomSheetTheme: RBottomSheetTheme.darkBottomSheetTheme,
      elevatedButtonTheme: RElevatedButtonTheme.darkElevatedButtonTheme,
      outlinedButtonTheme: ROutlinedButtonTheme.darkTOutlinedButtonTheme,
      inputDecorationTheme: RTextFieldTheme.darkInputDecorationTheme,
  );


}
