import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:mazzad/Api/api_settings.dart';
import 'package:mazzad/Api/dio_helper.dart';
import 'package:mazzad/Models/Cities_Model.dart';
import 'package:mazzad/Utils/Helper.dart';

import '../../Database/SharedPreferences/shared_preferences.dart';
import '../../Models/CategoryTypes_Model.dart';
import '../../Models/advertisementOfCategory_Model.dart';
import '../../Models/comments_Model.dart';
import '../../Models/getCategory_featuresQ_Model.dart';
import '../../Models/latestAdvertisements_Model.dart';
import '../../Models/myAdvertisements_Model.dart';
import '../../Models/singleAdvertisement_Model.dart';
import '../../Models/singleAucationCategory_Model.dart';
import '../Api_Controller/advertisements_Api.dart';

class Advertisements_GetxController extends GetxController {
  Advertisements_Api_Controller _advertisements_api_controller =
      Advertisements_Api_Controller();

  myAdvertisements_Model? advertisements_model;
  myAdvertisements_Model? Waiting_advertisements;
  myAdvertisements_Model? advertisements;
  singleAdvertisement_Model? singleAdvertisement;
  comments_Model? comments_model;
  getCategory_featuresQ_Model? category_featuresQ_Model;
  advertisementOfCategory_Model? advOfCategory_model;
  singleAucationCategory_Model? singleAdvertisementCategory_model;
  CategoryTypes_Model? category_types;
  Cities_Model? cities_model;

  RxList<AdvertiseModel> advOfCategory_List = <AdvertiseModel>[].obs;
  RxList<AdvertiseModel> advOfCategory_ListCopy = <AdvertiseModel>[].obs;

  static Advertisements_GetxController get to => Get.find();

  RxBool isLoading = false.obs;
  RxBool isLoadingMyAdvertisements = false.obs;
  RxBool isLoadingMyWaitingAdvertisements = false.obs;
  RxBool isLoadingCategory_types = false.obs;
  RxBool isLoadingData = false.obs;
  RxBool isLoadingIDData = false.obs;
  RxBool isLoadingQuestions = false.obs;
  RxBool isSavingAdv = false.obs;
  RxBool isDeletingAdv = false.obs;
  RxBool isLoadingCategoryAdvertisements = false.obs;
  RxBool isLoadingMyCities = false.obs;

  RxBool isRunningAdv = true.obs;

  @override
  void onInit() {
    super.onInit();

    getMyCities();

    if (SharedPreferencesController().getToken.isNotEmpty) {
      getMyAdvertisements();
      getMyWaiting_advertisements();
    }
  }

  RxBool isLoadingMyAdvertisements_Pagination = false.obs;

  getMyAdvertisements({bool is_Refresh = false}) async {
    if (!is_Refresh) {
      isLoadingMyAdvertisements.value = true;
      DioHelper.getData(url: ApiSettings.my_advertisements).then((value) {
        isLoadingMyAdvertisements.value = false;
        advertisements_model = myAdvertisements_Model.fromJson(value.data);
        update();
      });
    } else {
      if (isLoadingMyAdvertisements_Pagination.isFalse &&
          advertisements_model!.data!.nextPageUrl != null) {
        isLoadingMyAdvertisements_Pagination.value = true;
        DioHelper.getData(url: advertisements_model!.data!.nextPageUrl!)
            .then((value) {
          isLoadingMyAdvertisements_Pagination.value = false;
          myAdvertisements_Model PaginationData =
              myAdvertisements_Model.fromJson(value.data);
          advertisements_model!.data.data.addAll(PaginationData.data.data);
          advertisements_model!.data!.nextPageUrl =
              PaginationData!.data!.nextPageUrl;
          update();
        });
      }
    }
  }

  getMyCities() async {
    isLoadingMyCities.value = true;
    DioHelper.getData(url: ApiSettings.get_cities).then((value) {
      isLoadingMyCities.value = false;
      cities_model = Cities_Model.fromJson(value.data);
      update();
    });
  }

  RxBool isLoadingMyWaitingAdvertisements_Pagination = false.obs;

  getMyWaiting_advertisements({bool is_Refresh = false}) async {
    if (!is_Refresh) {
      isLoadingMyWaitingAdvertisements.value = true;
      DioHelper.getData(url: ApiSettings.my_waiting_advertisements)
          .then((value) {
        isLoadingMyWaitingAdvertisements.value = false;
        Waiting_advertisements = myAdvertisements_Model.fromJson(value.data);

        update();
      });
    } else {
      if (isLoadingMyWaitingAdvertisements_Pagination.isFalse &&
          Waiting_advertisements!.data!.nextPageUrl != null) {
        isLoadingMyWaitingAdvertisements_Pagination.value = true;
        DioHelper.getData(url: Waiting_advertisements!.data!.nextPageUrl!)
            .then((value) {
          isLoadingMyWaitingAdvertisements_Pagination.value = false;
          myAdvertisements_Model PaginationData =
              myAdvertisements_Model.fromJson(value.data);
          Waiting_advertisements!.data.data.addAll(PaginationData.data.data);
          Waiting_advertisements!.data!.nextPageUrl =
              PaginationData!.data!.nextPageUrl;
          update();
        });
      }
    }
  }

  get_category_types({required String ID}) async {
    isLoadingCategory_types.value = true;
    DioHelper.getData(url: ApiSettings.get_category_types + '$ID')
        .then((value) {
      isLoadingCategory_types.value = false;
      category_types = CategoryTypes_Model.fromJson(value.data);

      update();
    });
  }

  get_advertisement_byCategory({required String ID, int? TypeID}) async {
    isLoadingCategoryAdvertisements.value = true;

    DioHelper.getData(
            url: ApiSettings.get_advertisement_byCategory +
                '$ID' +
                '/${SharedPreferencesController().ADVLanguage}')
        .then((value) {
      advOfCategory_model = advertisementOfCategory_Model.fromJson(value.data);

      if (advOfCategory_model!.data!.data!.isNotEmpty) {
        advOfCategory_List.value = advOfCategory_model!.data!.data!;
      } else {
        advOfCategory_List.value = <AdvertiseModel>[].obs;
      }
      if (TypeID != null) {
        changeTypeStatus(TypeID: TypeID);
      } else {
        changeTypeStatus();
      }
      isLoadingCategoryAdvertisements.value = false;
      update();
    });
  }

  RxBool isLoadingCategory_Pagination = false.obs;
  int? selectedTypeID;

  get_advertisement_byCategory_Pagination() {

    if (isLoadingCategory_Pagination.isFalse&&advOfCategory_model!.data!.nextPageUrl!=null) {
      isLoadingCategory_Pagination.value = true;


      DioHelper.getData(url: advOfCategory_model!.data!.nextPageUrl!)
          .then((value) {
        isLoadingCategory_Pagination.value = false;

        if (value.statusCode == 200) {
          advertisementOfCategory_Model PaginationData = advertisementOfCategory_Model.fromJson(value.data);
          // advOfCategory_model!.data!.data!.addAll(PaginationData!.data!.data!);
          advOfCategory_model!.data!.nextPageUrl =PaginationData!.data!.nextPageUrl;
          if (PaginationData!.data!.data!.isNotEmpty) {
            advOfCategory_List.value.addAll(PaginationData!.data!.data!);
          } else {
            advOfCategory_List.value = <AdvertiseModel>[].obs;
          }
          if (selectedTypeID != null) {
            changeTypeStatus(TypeID: selectedTypeID);
          } else {
            changeTypeStatus();
          }
          update();
        }
      });
    }
  }

  // getAlarmByType(int? type) {
  //   if (type == null) {
  //     advOfCategory_modelCopy!.data = advOfCategory_model!.data;
  //   } else {
  //     advOfCategory_modelCopy!.data!.data = advOfCategory_model!.data!.data!
  //         .where((p0) => p0.typeId == type)
  //         .toList();
  //   }
  // }

  changeTypeStatus({int? TypeID}) {
    selectedTypeID =TypeID;
    if (TypeID != null) {
      advOfCategory_ListCopy!.value =
          advOfCategory_List!.where((p0) => p0!.typeId == TypeID).toList();

      for (int i = 0; i < category_types!.data!.length; i++) {
        if (category_types!.data![i].id == TypeID) {
          category_types!.data![i].isSelected = true;
        } else {
          category_types!.data![i].isSelected = false;
        }
      }
    } else {
      advOfCategory_ListCopy.value = advOfCategory_List;
      ClearTypeStatus();
    }

    update();
  }

  ClearTypeStatus() {
    for (int i = 0; i < category_types!.data!.length; i++) {
      category_types!.data![i].isSelected = false;

      update();
    }
  }

  Future<singleAdvertisement_Model?> getAdvertisementByID(
      {required String ID, required context}) async {
    isLoadingData.value = true;

    return DioHelper.getData(url: ApiSettings.singleAdvertisements + '$ID')
        .then((value) {
      singleAdvertisement = singleAdvertisement_Model.fromJson(value.data);

      if (singleAdvertisement!.status == false && context != null) {
        Helper.showSnackBar(context,
            text: SharedPreferencesController().languageCode == 'ar'
                ? singleAdvertisement!.messageAr!
                : singleAdvertisement!.messageEn!,
            error: true);
      }
      isLoadingData.value = false;
      return singleAdvertisement;
    }).catchError((e) {
      isLoadingData.value = false;

      Helper.showSnackBar(context,
          text: SharedPreferencesController().getToken.isNotEmpty
              ? e.toString()
              : 'you must login'.tr,
          error: true);
      update();
      return null;
    });
  }

  RxBool isLoadingComments = false.obs;

  Future<comments_Model?> getCommentByID({required String ID}) async {
    isLoadingComments.value = true;

    DioHelper.getData(url: ApiSettings.CommentByID + '$ID').then((value) {
      isLoadingComments.value = false;
      comments_model = comments_Model.fromJson(value.data);

      update();
      return comments_model;
    });
  }

  getCategoryBYID({required String ID}) async {
    isLoadingIDData.value = true;

    DioHelper.getData(url: ApiSettings.get_category_by_id + '$ID')
        .then((value) {
      singleAdvertisementCategory_model =
          singleAucationCategory_Model.fromJson(value.data);
      isLoadingIDData.value = false;
      update();
    });
    // singleAdvertisementCategory_model =
    //     await _advertisements_api_controller.getCategoryBYID(ID: ID);

    // update();
  }

  getCategory_featuresQ({required String ID}) async {
    SharedPreferencesController().features.clear();

    isLoadingQuestions.value = true;
    DioHelper.getData(url: ApiSettings.get_category_features + '$ID')
        .then((value) async {
      category_featuresQ_Model =
          getCategory_featuresQ_Model.fromJson(value.data);
      SharedPreferencesController().features.clear();
      for (int i = 0; i < await category_featuresQ_Model!.data.length; i++) {
        SharedPreferencesController().features.add({
          'key': category_featuresQ_Model!.data[i].title,
          'value': category_featuresQ_Model!.data[i].textEditingController.text
        });
      }

      isLoadingQuestions.value = false;

      update();
    });
  }

  Future<bool> AddNewAdvertisements({
    required String category_id,
    required String type_id,
    required String city_id,
    required String price,
    required String title,
    required String title_ar,
    required String photo,
    required String description,
    required String description_ar,
    required String language,
    required List<String?> photos,
    required List features,
  }) async {
    isSavingAdv.value = true;
    bool isSaved = await _advertisements_api_controller.AddNewAdvertisements(
        photos: photos,
        language: language,
        category_id: category_id,
        type_id: type_id,
        city_id: city_id,
        price: price,
        title: title,
        title_ar: title_ar,
        description: description,
        description_ar: description_ar,
        photo: photo,
        features: features);

    isSavingAdv.value = false;
    update();
    if (isSaved) {
      getMyAdvertisements();
    }
    return isSaved;
  }

  Future<bool> EditAdvertisements({
    required String advID,
    required String category_id,
    required String type_id,
    required String city_id,
    required String price,
    required String title,
    required String title_ar,
    required String photo,
    required String description,
    required String description_ar,
    required String language,
    required String cover_image_id,
    required List<String?> photos,
    required List<String?> deleted_list,
    required List features,
  }) async {
    isSavingAdv.value = true;
    bool isSaved = await _advertisements_api_controller.EditAdvertisements(
        photos: photos,
        advID: advID,
        language: language,
        category_id: category_id,
        cover_image_id: cover_image_id,
        type_id: type_id,
        city_id: city_id,
        price: price,
        title: title,
        title_ar: title_ar,
        description: description,
        description_ar: description_ar,
        photo: photo,
        deleted_list: deleted_list,
        features: features);

    isSavingAdv.value = false;
    update();
    if (isSaved) {
      getMyAdvertisements();
    }
    return isSaved;
  }

  Future<bool> delete_Advertisement({
    required String ID,
  }) async {
    isDeletingAdv.value = true;
    bool isSaved =
        await _advertisements_api_controller.delete_Advertisement(ID: ID);
    if (isSaved) {
      advertisements_model!.data.data
          .removeWhere((element) => element.id.toString() == ID);
      Waiting_advertisements!.data.data
          .removeWhere((element) => element.id.toString() == ID);
    }
    isDeletingAdv.value = false;
    update();

    return isSaved;
  }

  Future<bool> stop_active_advertisement({
    required String ID,
  }) async {
    bool isSaved =
        await _advertisements_api_controller.stop_active_advertisement(ID: ID);
    update();

    return isSaved;
  }

  RxBool isAddingComment = false.obs;

  Future addAdvertisementComment(
    context, {
    required String Advertisement_ID,
    required String comment,
  }) async {
    isAddingComment.value = true;
    // comments_model = await _advertisements_api_controller.addAdvertisementComment(Advertisement_ID: Advertisement_ID, comment: comment);
    return DioHelper.postData(
        url: ApiSettings.addAdvertisementComment + '${Advertisement_ID}',
        // 'http://admin.mazadistore.com/api/user/advertisement_comments/add/${Advertisement_ID}',
        data: {
          'comment': comment,
        }).then((value) {
      if (value.statusCode == 200) {
        comments_model = comments_Model.fromJson(value.data);
        isAddingComment.value = false;

        update();
        return comments_model!.status;
      } else {
        isAddingComment.value = false;

        update();
        return comments_model!.status;
      }
    });
  }

  Future<bool> updateAdvertisementComment({
    required String Advertisement_ID,
    required String comment,
  }) async {
    isAddingComment.value = true;

    bool isSaved =
        await _advertisements_api_controller.updateAdvertisementComment(
            Advertisement_ID: Advertisement_ID, comment: comment);
    isAddingComment.value = false;

    update();

    return isSaved;
  }

  Future<bool> deleteAdvertisementComment({
    required String Advertisement_ID,
  }) async {
    bool isSaved =
        await _advertisements_api_controller.deleteAdvertisementComment(
      Advertisement_ID: Advertisement_ID,
    );

    update();

    return isSaved;
  }

  Future<bool> addCommentReplay({
    required String comment_ID,
    required String Replay,
  }) async {
    isAddingComment.value = true;

    return DioHelper.postData(
        url: ApiSettings.add_CommentReplay + '${comment_ID}',
        data: {
          'comment': Replay,
        }).then((value) {
      isAddingComment.value = false;

      update();
      if (value.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    });
  }

  selectType() {
    if (isRunningAdv.isTrue) {
      advertisements = advertisements_model;
    } else {
      advertisements = Waiting_advertisements;
    }
  }

  RxBool isGettingUserAD = false.obs;
  latestAdvertisements_Model? userAdvertisment_Model;
  RxBool isGettingUserAD_Pagination = false.obs;

  getUserAdvertisment(id, {bool is_Pagination = false}) {
    if (!is_Pagination) {
      isGettingUserAD.value = true;
      DioHelper.getData(
        url: ApiSettings.user_advertisements + '$id',
      ).then((value) {
        userAdvertisment_Model =
            latestAdvertisements_Model.fromJson(value.data);

        isGettingUserAD.value = false;
        update();
      });
    } else {
      if (isGettingUserAD_Pagination.isFalse &&
          userAdvertisment_Model!.data.nextPageUrl != null) {
        isGettingUserAD_Pagination.value = true;
        DioHelper.getData(
          url: userAdvertisment_Model!.data.nextPageUrl!,
        ).then((value) {
          isGettingUserAD_Pagination.value = false;
          if (value.statusCode == 200) {
            latestAdvertisements_Model PaginationData =
                latestAdvertisements_Model.fromJson(value.data);
            userAdvertisment_Model!.data.data2
                .addAll(PaginationData.data.data2);
            userAdvertisment_Model!.data.nextPageUrl =
                PaginationData.data.nextPageUrl;
            update();
          }
        });
      }
    }
  }

  latestAdvertisements_Model? searchADV_model;
  RxBool isGettingSearchAD = false.obs;
  RxBool isGettingSearchAD_Pagination = false.obs;

  getSearchAdvertisment({required String title, bool is_Pagination = false}) {
    if (!is_Pagination) {
      isGettingSearchAD.value = true;
      DioHelper.getData(
        url: ApiSettings.latest_advertisements +
            '/${SharedPreferencesController().ADVLanguage}' +
            '/${title}',
      ).then((value) {
        isGettingSearchAD.value = false;

        searchADV_model = latestAdvertisements_Model.fromJson(value.data);

        update();
      });
    } else {
      if (isGettingSearchAD_Pagination.isFalse &&
          searchADV_model!.data.nextPageUrl != null) {
        isGettingSearchAD_Pagination.value = true;
        DioHelper.getData(
          url: searchADV_model!.data.nextPageUrl!,
        ).then((value) {
          isGettingSearchAD_Pagination.value = false;

          latestAdvertisements_Model PaginationData =
              latestAdvertisements_Model.fromJson(value.data);
          searchADV_model!.data.data2.addAll(PaginationData.data.data2);
          searchADV_model!.data.nextPageUrl = PaginationData.data.nextPageUrl;
          update();
        });
      }
    }
  }

  String getCityName(id) {
    cityData? city =
        cities_model!.data!.firstWhereOrNull((element) => element.id==id);

    if (city != null) {
      if (SharedPreferencesController().languageCode != 'ar') {
        return city!.name!;
      } else {
        return city.nameAr!;

      }
    } else {
      return '';
    }
  }
}
