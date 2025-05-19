
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:mazzad/Database/SharedPreferences/shared_preferences.dart';

class AuthMiddelware extends GetMiddleware{

  @override
  //هنا نضع الأفضلية لهذا ال Middelware بالنسبة لغيره

  int? get Priority =>1;


  @override
  RouteSettings? redirect(String? route){

    //هنا نضع الشرط الذي نحتاج التأكد من تحقيقه قبل الإنتقال إلى الصفحة التالية
    if(SharedPreferencesController().languageCode=='')return RouteSettings(name: '/home');
  }
}