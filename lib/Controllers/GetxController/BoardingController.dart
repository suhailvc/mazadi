

import 'package:get/get.dart';

import '../../Models/boardings_Model.dart';
import '../Api_Controller/onBordingApi.dart';

class boarding_GetxController extends GetxController{

  onBoarding_Api_Controller _boarding_api_controller = onBoarding_Api_Controller();
  boardings_Model? boardings_model;
  static boarding_GetxController get to => Get.find();

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getBoardingData();
  }




getBoardingData()async{
  isLoading.value =true;
   boardings_model=await  _boarding_api_controller.getData() ;
  isLoading.value =false;
  isLoading.value =false;

  update();

}



}