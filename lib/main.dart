import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trianutri_app/app/modules/login/login_binding.dart';
import 'package:trianutri_app/app/modules/routes/app_pages.dart';
import 'package:trianutri_app/app/modules/routes/app_routes.dart';
import 'package:trianutri_app/app/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.LOGIN,
    initialBinding: LoginBinding(),
    theme: appThemeData,
    getPages: AppPages.routes,
  ));
}
