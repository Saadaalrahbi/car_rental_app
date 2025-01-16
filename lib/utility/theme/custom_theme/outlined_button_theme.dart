
import 'package:flutter/material.dart';

class ROutlinedButtonTheme {
  ROutlinedButtonTheme._(); //to avoid creating instances

  static OutlinedButtonThemeData lightTOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.black,
      side: const BorderSide(color: Colors.blue),
        textStyle:const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
    )

  );


  static OutlinedButtonThemeData darkTOutlinedButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.blue),
          textStyle:const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
      )

  );
}
