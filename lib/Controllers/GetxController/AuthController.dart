import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:mazzad/Api/dio_helper.dart';
import 'package:mazzad/Models/registerError_Model.dart';
import 'package:mazzad/Utils/Helper.dart';

import '../../Api/api_settings.dart';
import '../../Models/advertisementCategories_Model.dart';
import '../../Models/allAdvertisement_Model.dart';
import '../../Models/boardings_Model.dart';
import '../../Models/homeSlider_Model.dart';
import '../../Models/latestAdvertisements_Model.dart';
import '../../Models/latestAucations_Model.dart';
import '../../Models/login_Model.dart';
import '../../Models/mobile_OTPCode_Model.dart';
import '../../Models/singleAucations_Model.dart';
import '../Api_Controller/Auth_Api.dart';
import '../Api_Controller/home_Api.dart';
import '../Api_Controller/onBordingApi.dart';

class Auth_GetxController extends GetxController {
  Auth_Api_Controller auth_api_controller = Auth_Api_Controller();
  homeSlider_Model? slider_model;
  mobile_OTPCode_Model? mobile_otpCode_Model;
  login_Model? login_model;
  registerError_Model? Register_Model;

  static Auth_GetxController get to => Get.find();

  RxBool isLoading = false.obs;
  RxBool isLoadingOTP = false.obs;
  RxBool isLoadingData = false.obs;
  RxBool isSingingUp = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  getMobile_otpCode({
    required String mobile,
  }) async {
    isLoadingOTP.value = true;
    mobile_otpCode_Model =
        await auth_api_controller.get_OTPCode(mobile: mobile);
    isLoadingOTP.value = false;
    update();
  }

  Login({
    required String mobile,
    required String verify_mobile_code,
  }) async {
    isLoading.value = true;
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    login_model = await auth_api_controller.Login(
      verify_mobile_code: verify_mobile_code,
      mobile: mobile,
      fcm_token: fcmToken.toString(),
    );
    isLoading.value = false;
    update();
  }

  logout() async {
    bool islogout = await auth_api_controller.logout();
    update();
    return islogout;
  }

  SignUp({
    required String name,
    required String mobile,
    required String email,
    required String verify_mobile_code,
    required String address,
    required String city_id,
    required String district,
  }) async {
    isSingingUp.value = true;
    String? fcmToken = await FirebaseMessaging.instance.getToken();

   return DioHelper.postData(url: ApiSettings.register,
    data: {
      'name': name,
      'mobile': mobile,
      'email': email,
      'fcm_token': fcmToken,
      'verify_mobile_code': verify_mobile_code,
      'address': address,
      'city_id': city_id,
      'whatsapp': mobile,
      'district': district
    }
    ).then((value) {
      isSingingUp.value = false;
      Register_Model= registerError_Model.fromJson(value.data);

      update();
      Helper.showSnackBar(Get.context!, text: value.data['message']);
      return Register_Model;

   });
    // Register_Model = await auth_api_controller.SignUp(
    //     name: name,
    //     mobile: mobile,
    //     email: email,
    //     fcm_token: fcmToken.toString(),
    //     verify_mobile_code: verify_mobile_code,
    //     address: address,
    //     city_id: city_id,
    //     district: district);


    update();
    return Register_Model;
  }

  Timer? timer;

  RxInt timeRemaining = 59.obs;

  StartOTPTimer() {
    timeRemaining = 59.obs;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeRemaining.value > 0) {
        timeRemaining.value--;
      } else {
        timeRemaining.value=59;
        timer.cancel();

      }

    });
  }
}
