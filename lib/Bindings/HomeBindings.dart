

import 'package:get/get.dart';

import '../Controllers/GetxController/AdvertisementsController.dart';
import '../Controllers/GetxController/AucationsController.dart';
import '../Controllers/GetxController/AuthController.dart';
import '../Controllers/GetxController/BoardingController.dart';
import '../Controllers/GetxController/checkNetWorkGetx_Controller.dart';
import '../Controllers/GetxController/homeController.dart';
import '../Controllers/GetxController/profileController.dart';

class HomeBindings implements Bindings{
  // يتم إستخدامها عند الحاجة لعمل init لمجموعة من الكونترولر المستخدمين في صفحة معينة و للحفاظ على ترتيب الكود

  @override
  void dependencies() {
    Get.put<checkNetWorkGetx_Controller>(checkNetWorkGetx_Controller());

    Get.put<home_GetxController>(home_GetxController());
    Get.put<profile_GetxController>(profile_GetxController());


    Get.put<Aucations_GetxController>(Aucations_GetxController());
    Get.put<Advertisements_GetxController>(Advertisements_GetxController());
    Get.put<boarding_GetxController>(boarding_GetxController());
    Get.put<Auth_GetxController>(Auth_GetxController());

  }



}