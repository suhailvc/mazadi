import 'dart:async';

import 'package:get/get.dart';
import 'package:mazzad/Api/api_settings.dart';
import 'package:mazzad/Api/dio_helper.dart';

import '../../Database/SharedPreferences/shared_preferences.dart';
import '../../Models/advertisementCategories_Model.dart';
import '../../Models/advertisementCategoryDetails_Model.dart';
import '../../Models/allAdvertisement_Model.dart';
import '../../Models/boardings_Model.dart';
import '../../Models/homeSlider_Model.dart';
import '../../Models/latestAdvertisements_Model.dart';
import '../../Models/latestAucations_Model.dart';
import '../../Models/settings_model.dart';
import '../../Models/singleAucations_Model.dart';
import '../../Utils/Helper.dart';
import '../Api_Controller/home_Api.dart';
import '../Api_Controller/onBordingApi.dart';
import 'AdvertisementsController.dart';

class home_GetxController extends GetxController {
  // home_Api_Controller _home_api_controller = home_Api_Controller();
  homeSlider_Model? slider_model;
  latestAucations_Model? lastAucations_model;
  latestAdvertisements_Model? advertisements_model;
  latestAdvertisements_Model? LatestAll_Advertisements_model;
  singleAucations_Model? singleAucation;
  allAdvertisement_Model? AllAdvertisement_Categories;
  advertisementCategoryDetails_Model? categories_ID_model;
  Advertisements_GetxController _Advertisements_getxController =
      Get.put(Advertisements_GetxController());

  // advertisementCategories_Model? categories_ID_model;
  static home_GetxController get to => Get.find();

  RxBool isLoading = false.obs;
  RxBool isLoadingData = false.obs;
  RxBool isLoadingSlider = false.obs;
  RxBool isLoadingLastAucation = false.obs;
  RxBool isLoadingLastAdvertisements = false.obs;
  RxBool isLoadingAdvertisements = false.obs;
  RxBool isLoadingCategoryData = false.obs;
  String AucationTime = '';

  @override
  void onInit() {
    super.onInit();
    // if (SharedPreferencesController().getToken.isNotEmpty) {
      getSlider();
      getLastAucations();
      get_advertisements();
      getLatest_advertisements();
      getSettingData();
    // }
  }

  setting_Model? setting_model;

  getSettingData() {
    DioHelper.getData(url: ApiSettings.setting).then((value) {
      setting_model = setting_Model.fromJson(value.data);
    });
  }

  start() async {
    getSlider();
    getLastAucations();
    get_advertisements();

    getLatest_advertisements();
  }

  getSlider() async {
    isLoadingSlider.value = true;
    // slider_model = await _home_api_controller.getSlider();
    DioHelper.getData(url: ApiSettings.get_slider).then((value) {
      isLoadingSlider.value = false;
      slider_model = homeSlider_Model.fromJson(value.data);

      update();
    });
  }

  RxBool isLoadingLastAucation_Pagination = false.obs;

  getLastAucations({
    bool is_Refresh =false
  }) async {
if(!is_Refresh){
  isLoadingLastAucation.value = true;
  DioHelper.getData(url: ApiSettings.latest_auctions + '/${SharedPreferencesController().ADVLanguage}')
      .then((value) {
    isLoadingLastAucation.value = false;
    lastAucations_model = latestAucations_Model.fromJson(value.data);

    update();
  }).catchError((e){
    isLoadingLastAucation.value = false;
    update();

  });

}else{

  if(isLoadingLastAucation_Pagination.isFalse &&lastAucations_model!.data!.nextPageUrl!=null ){
    isLoadingLastAucation_Pagination.value = true;

    DioHelper.getData(url: lastAucations_model!.data!.nextPageUrl!)
        .then((value) {
      isLoadingLastAucation_Pagination.value = false;
      latestAucations_Model   PaginationData = latestAucations_Model.fromJson(value.data);
      lastAucations_model!.data.data.addAll(PaginationData.data.data);
      lastAucations_model!.data!.nextPageUrl!= PaginationData!.data!.nextPageUrl!;

      update();
    }).catchError((e){
      isLoadingLastAucation_Pagination.value = false;
      update();

    });
  }

}





  }

  getAucationByID({required String ID, context}) async {
    isLoadingData.value = true;
   return DioHelper.getData(url: ApiSettings.singleAuction + '$ID').then((value) {
     isLoadingData.value = false;

      if (value.statusCode != 200) {
        Helper.showSnackBar(context,
            text: singleAucation!.messageEn!, error: true);
      }

     singleAucation = singleAucations_Model.fromJson(value.data);

      update();
      return singleAucation;

    }).catchError((e){
     isLoadingData.value = false;

     Helper.showSnackBar(Get.context!,
         text:

         SharedPreferencesController().getToken.isNotEmpty?

         e.toString():
         'you must login'.tr,


         error: true);
     return null;
   });

  }

  RxBool isLoadingLastAdvertisements_Pagination =false.obs;
  getLatest_advertisements({
    bool is_Refresh =false
}) async {
if(!is_Refresh){
  isLoadingLastAdvertisements.value = true;
  DioHelper.getData(
      url: ApiSettings.latest_advertisements + '/${SharedPreferencesController().ADVLanguage}')
      .then((value) {
    isLoadingLastAdvertisements.value = false;

    advertisements_model = latestAdvertisements_Model.fromJson(value.data);
    LatestAll_Advertisements_model=advertisements_model;
    isAllType.value=true;
    update();
  });
}else{
  if(isLoadingLastAdvertisements_Pagination.isFalse && advertisements_model!.data!.nextPageUrl !=null){
  isLoadingLastAdvertisements_Pagination.value=true;
  DioHelper.getData(
      url: advertisements_model!.data!.nextPageUrl!)
      .then((value) {

    isLoadingLastAdvertisements_Pagination.value=false;
    latestAdvertisements_Model   newData = latestAdvertisements_Model.fromJson(value.data);
    advertisements_model!.data!.data2.addAll(newData!.data!.data2);
    advertisements_model!.data!.nextPageUrl=newData.data.nextPageUrl;
    update();
  });
}
}

  }



  getLatest_Alladvertisements({
    bool is_Refresh =false,
    int? category_id
  }) async {
    if(!is_Refresh){
      isLoadingLastAdvertisements.value = true;
      DioHelper.postData(
          url: ApiSettings.latest_advertisements + '/${SharedPreferencesController().ADVLanguage}',
          data: {
            'category_id':category_id
          }
      )
          .then((value) {
        isLoadingLastAdvertisements.value = false;

        LatestAll_Advertisements_model = latestAdvertisements_Model.fromJson(value.data);
        // LatestAll_Advertisements_model=advertisements_model;
        update();
      });
    }else{
      if(isLoadingLastAdvertisements_Pagination.isFalse && LatestAll_Advertisements_model!.data!.nextPageUrl !=null){
        print('Pagni2');

        isLoadingLastAdvertisements_Pagination.value=true;
        DioHelper.postData(
            url: LatestAll_Advertisements_model!.data!.nextPageUrl!,
            data: {
              'category_id':categoryID
            }
        )
            .then((value) {
          isLoadingLastAdvertisements_Pagination.value=false;
          latestAdvertisements_Model   newData = latestAdvertisements_Model.fromJson(value.data);
          LatestAll_Advertisements_model!.data!.data2.addAll(newData!.data!.data2);
          LatestAll_Advertisements_model!.data!.nextPageUrl=newData.data.nextPageUrl;
          update();

        });
      }
    }

  }


  get_advertisements() async {
    isLoadingAdvertisements.value = true;
    // AllAdvertisement = await _home_api_controller.get_advertisements();

    DioHelper.getData(url: ApiSettings.get_advertisements).then((value) {
      isLoadingAdvertisements.value = false;
      AllAdvertisement_Categories = allAdvertisement_Model.fromJson(value.data);


      update();
    });
  }

  get_category_by_id({required String ID}) async {
    isLoadingCategoryData.value = true;
    // categories_ID_model =
    //     await _home_api_controller.get_show_category_by_id(ID: ID);
    return DioHelper.getData(url: ApiSettings.get_show_category_by_id + '$ID')
        .then((value) {
      isLoadingCategoryData.value = false;
      update();
      categories_ID_model = advertisementCategoryDetails_Model.fromJson(value.data);

      return categories_ID_model;
    }).catchError((e){
      isLoadingCategoryData.value = false;

      Helper.showSnackBar(Get.context!,
          text:

          SharedPreferencesController().getToken.isNotEmpty?

          e.toString():
          'you must login'.tr,


          error: true);
      update();
      return null;
    });
  }

  AdvertiseChangeStatus({
    required int index,
    required int ParentIndex,
  }) {
    for (int i = 0; i < AllAdvertisement_Categories!.data.length; i++) {
      for (int x = 0;
          x < AllAdvertisement_Categories!.data[i].subCategories!.length;
          x++) {
        if (i == ParentIndex) {
          if (x == index) {
            AllAdvertisement_Categories!.data[i].subCategories![x].isSelected = true;
          } else {
            AllAdvertisement_Categories!.data[i].subCategories![x].isSelected = false;
          }
        } else {
          AllAdvertisement_Categories!.data[i].subCategories![x].isSelected = false;
        }
      }
    }
    update();
  }

  AdvertisementChangeStatusByID({
    required int Id,
    required int ParentId,
  }) async {
    int? parentIdINDEX;
    int? IdINDEX;
    for (int i = 0; i < AllAdvertisement_Categories!.data.length; i++) {
      parentIdINDEX = await AllAdvertisement_Categories!.data
          .indexWhere((element) => element.id == ParentId);

      // AdvertiseChangeStatus(index: parentIdINDEX);
    }
    for (int x = 0;
        x < AllAdvertisement_Categories!.data[parentIdINDEX!].subCategories!.length;
        x++) {
      IdINDEX = AllAdvertisement_Categories!.data[parentIdINDEX].subCategories!
          .indexWhere((element) => element.id == Id);
    }
    AdvertiseChangeStatus(index: IdINDEX!, ParentIndex: parentIdINDEX);
    update();

    _Advertisements_getxController.getCategoryBYID(
        ID: AllAdvertisement_Categories!.data[parentIdINDEX].subCategories![IdINDEX].id
            .toString());
    _Advertisements_getxController.getCategory_featuresQ(
        ID: AllAdvertisement_Categories!.data[parentIdINDEX].subCategories![IdINDEX].id
            .toString());
    update();
  }

  AdvertiseClearStatus() {
    for (int i = 0; i < AllAdvertisement_Categories!.data.length; i++) {
      for (int x = 0;
          x < AllAdvertisement_Categories!.data[i].subCategories!.length;
          x++) {
        AllAdvertisement_Categories!.data[i].subCategories![x].isSelected = false;
      }
    }
    update();
  }



  RxBool isAllType = true.obs;
  int? categoryID ;
  changeCategoryStatus(id){
    categoryID=id;
    isAllType.value = false;
    getLatest_Alladvertisements(is_Refresh: false,category_id:id );

    if(id==null){
      isAllType.value = true;
    }

      AllAdvertisement_Categories!.data.forEach((element) {
        element.is_Selected=false;
        if(element.id==id){
          element.is_Selected=true;

        }
      });



update();
  }


}
