import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:developer' as developer;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mazzad/Bindings/onBoardingBindings.dart';
import 'package:mazzad/Services/SettingServices.dart';

import 'Api/dio_helper.dart';
import 'Bindings/HomeBindings.dart';
import 'Controllers/GetxController/drawerController.dart';
import 'Database/SharedPreferences/shared_preferences.dart';
import 'Language/app_locale.dart';
import 'Screens/LaunchScreen/launchScreen.dart';
import 'Utils/Themes.dart';
import 'firebase/fb_notifications.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
 await  initalServices();
  Get.put<MyDrawerController>(MyDrawerController());
  HttpOverrides.global = MyHttpOverrides();


  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 812),
        builder: (BuildContext context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: Get.key,
            locale: Locale( SharedPreferencesController().languageCode),
            translations: AppLocale(),
            theme: Mythemes().light,
            darkTheme: Mythemes().dark,
            themeMode: ThemeService().getThemeMode(),
            initialRoute: '/launch',
            getPages: [
              GetPage(
                name: '/launch',
                page: () => LaunchScreen(),
              ),
            ],
          );
        });
  }
}

Future initalServices() async {
  await Get.putAsync(() => SettingServices().init());
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}