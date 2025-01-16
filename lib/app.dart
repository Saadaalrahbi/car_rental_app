import 'package:auto_access/bindings/general_bidings.dart';
import 'package:auto_access/routes/app_routes.dart';
import 'package:auto_access/utility/constants/colors.dart';
import 'package:auto_access/utility/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


///used this class for setting up the application theme

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: RAppTheme.lightTheme,
      darkTheme: RAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      getPages: AppRoutes.pages,
      ///showing loader or circular progress indicator meanwhile authentication repository is deciding to show relevant screen
      home: const Scaffold(backgroundColor: RColors.primary, body: Center(child: CircularProgressIndicator(color: Colors.white))),
    );
  }}
