import 'dart:async';
import 'dart:convert';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mazzad/Models/singleAdvertisement_Model.dart';
import 'package:mazzad/Screens/BN_Screens/advertise/singleAdvertisement_Screen.dart';
import 'package:mazzad/Utils/asset_images.dart';

import '../../Bindings/HomeBindings.dart';
import '../../Bindings/onBoardingBindings.dart';
import '../../Controllers/GetxController/AdvertisementsController.dart';
import '../../Controllers/GetxController/BoardingController.dart';
import '../../Controllers/GetxController/homeController.dart';
import '../../Database/SharedPreferences/shared_preferences.dart';
import '../../Models/singleAucations_Model.dart';
import '../../Utils/AppColors.dart';
import '../BN_Screens/Aucations/singleAucation_Screen.dart';
import '../BN_Screens/advertise/MyAdvertisement_Screen.dart';
import '../BN_Screens/main_Screen.dart';
import '../onBoarding/onBoarding_Screen.dart';


class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  // var _advertisements_getxController = Get.find<Advertisements_GetxController>();
  // var _home_getxController = Get.find<home_GetxController>();

  // boarding_GetxController _boarding_getxController =Get.put(boarding_GetxController());
  // Auth_GetxController _auth_getxController =Get.put(Auth_GetxController());
  Advertisements_GetxController _advertisements_getxController =
  Get.put(Advertisements_GetxController());
  home_GetxController _home_getxController =Get.put<home_GetxController>(home_GetxController());
  /*
  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
          final Uri deepLink = dynamicLink!.link;
          print("deeplink found");
          if (deepLink != null) {
            if(deepLink.path.contains('Advertisment')){

              singleAdvertisement_Model? adv=       await _advertisements_getxController
                  .getAdvertisementByID(ID: deepLink.path.split('/').last);


              Get.to(singleAdvertisement_Screen(adv_model:adv));


            }else if(deepLink.path.contains('Aucation')){
              singleAucations_Model singleAucation = await _home_getxController.getAucationByID(ID: deepLink.path.split('/').last);

              await Get.to(singleAucation_Screen(aucations_model: singleAucation));


            }



          }
        }, onError: (OnLinkErrorException e) async {
      print(e.message);
    });
  }


   */
  @override
  void initState() {
    super.initState();
    // initDynamicLinks();
    Future.delayed(Duration(seconds: 1), () {
      SharedPreferencesController().getFirstLoggin!=true ?
      Get.offAll(OnBoardingScreen(),binding: onBoardingBindings()):

      Get.offAll(main_Screen(),binding: HomeBindings(),);

    });

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.white,
       body: Center(

         child: Image.asset(AppImages.logo,width: 250.w,height: 250.h,)),

    );
  }
}
