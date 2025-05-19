import 'dart:developer';

import 'package:get/get.dart';
import 'package:mazzad/Api/dio_helper.dart';
import 'package:mazzad/Utils/Helper.dart';
import 'package:path/path.dart';

import '../../Api/api_settings.dart';
import '../../Database/SharedPreferences/shared_preferences.dart';
import '../../Models/AucationsCategory_Model.dart';
import '../../Models/MyWaitingAuctions_model.dart';
import '../../Models/boardings_Model.dart';
import '../../Models/getCategory_featuresQ_Model.dart';
import '../../Models/homeSlider_Model.dart';
import '../../Models/latestAucations_Model.dart';
import '../../Models/myAuctions_Model.dart';
import '../../Models/myBids_model.dart';
import '../../Models/singleAucationCategory_Model.dart';
import '../../Models/singleAucations_Model.dart';
import '../../firebase/fb_firestore_controller.dart';
import '../Api_Controller/Aucations_Api.dart';
import '../Api_Controller/home_Api.dart';
import '../Api_Controller/onBordingApi.dart';
import 'homeController.dart';

var _home_getxController = Get.find<home_GetxController>();

class Aucations_GetxController extends GetxController {
  Aucations_Api_Controller _aucations_api_controller =
      Aucations_Api_Controller();

  AucationsCategory_Model? category_model;
  MyAuctions_model? MyActiveAuctions_model;
  singleAucationCategory_Model? singleAucationCategory_model;
  RxList<auction_model> auctionOfCategory_List = <auction_model>[].obs;
  RxList<auction_model> auctionOfCategory_ListCopy = <auction_model>[].obs;
  MyAuctions_model? myWaitingAuctions_model;
  MyAuctions_model? myCompletedAuctions_model;
  MyAuctions_model? myCanceledAuctions_model;
  MyAuctions_model? myEndedAuctions_model;

  // MyWaitingAuctions_model? myAuctionsPreview_model;

  myBids_model? myWinBids_model;
  myBids_model? myLoseBids_model;
  myBids_model? myWaitingBids_model;

  getCategory_featuresQ_Model? category_featuresQ_Model;

  static Aucations_GetxController get to => Get.find();

  RxBool isLoading = false.obs;
  RxBool isLoadingMyWaitingAuctions = false.obs;
  RxBool isLoadingMyActiveAuctions = false.obs;
  RxBool isLoadingMyCompletedAuctions = false.obs;
  RxBool isLoadingMyCanceledAuctions = false.obs;
  RxBool isLoadingMyEndedAuctions = false.obs;
  RxBool isLoadingMyWinBids = false.obs;
  RxBool isLoadingMyLoseBids = false.obs;
  RxBool isLoadingMyWaitingBids = false.obs;
  RxBool isLoadingData = false.obs;
  RxBool isLoadingSingleAucation = false.obs;
  RxBool isLoadingQuestions = false.obs;
  RxBool isSavingAdv = false.obs;
  RxBool isDeletingAucation = false.obs;
  RxBool isAddingBID = false.obs;

  @override
  void onInit() {
    super.onInit();
      start();

  }

  start() async {

      getCategories();
      if (SharedPreferencesController().getToken.isNotEmpty) {
        getMyActiveAuctions();

        getMyWaitingAuctions();
        getMyCompletedAuctions();
        getMyCanceldAuctions();
        getMyEndedAuctions();
        getMy_win_bids();
        getMy_wait_bids();
        getMy_lose_bids();
      }
  }

  getCategories() async {
    isLoading.value = true;
    category_model = await _aucations_api_controller.getCategories();
    isLoading.value = false;

    update();
  }




  RxBool isLoadingMyActiveAuctions_Pagination =false.obs;
  getMyActiveAuctions({bool is_Pagination =false}) async {
    // MyActiveAuctions_model = await _aucations_api_controller.getMyAuctions();

    if(!is_Pagination){
      isLoadingMyActiveAuctions.value = true;
      DioHelper.getData(url: ApiSettings.my_auctions).then((value) {
        isLoadingMyActiveAuctions.value = false;
        MyActiveAuctions_model= MyAuctions_model.fromJson(value.data);
        update();

      });
    }else{

      if(isLoadingMyActiveAuctions_Pagination.isFalse &&MyActiveAuctions_model!.data!.nextPageUrl!=null ){
        isLoadingMyActiveAuctions_Pagination.value = true;
        DioHelper.getData(url: MyActiveAuctions_model!.data!.nextPageUrl!).then((value) {
          isLoadingMyActiveAuctions_Pagination.value = false;
          MyAuctions_model PaginationData = MyAuctions_model.fromJson(value.data);
          MyActiveAuctions_model!.data!.data.addAll(PaginationData.data!.data) ;
          MyActiveAuctions_model!.data!.nextPageUrl=PaginationData!.data!.nextPageUrl;
          update();

        });
      }


    }



  }

  RxBool isLoadingMyWaitingAuctions_Pagination =false.obs;

  getMyWaitingAuctions({isRefresh = false,bool is_Pagination =false}) async {
    // MyActiveAuctions_model = await _aucations_api_controller.getMyAuctions();

    if(!is_Pagination){
      if (!isRefresh) {
        isLoadingMyWaitingAuctions.value = true;
      }

      DioHelper.getData(url: ApiSettings.my_waiting_auctions).then((value) {
        isLoadingMyWaitingAuctions.value = false;
        myWaitingAuctions_model= MyAuctions_model.fromJson(value.data);
        update();

      });
    }else{

      if(isLoadingMyWaitingAuctions_Pagination.isFalse &&myWaitingAuctions_model!.data!.nextPageUrl!=null ){
        isLoadingMyWaitingAuctions_Pagination.value = true;
        DioHelper.getData(url: myWaitingAuctions_model!.data!.nextPageUrl!).then((value) {
          isLoadingMyWaitingAuctions_Pagination.value = false;
          MyAuctions_model PaginationData = MyAuctions_model.fromJson(value.data);
          myWaitingAuctions_model!.data!.data.addAll(PaginationData.data!.data) ;
          myWaitingAuctions_model!.data!.nextPageUrl=PaginationData!.data!.nextPageUrl;
          update();

        });
      }


    }



  }




  // getMyWaitingAuctions({isRefresh = false}) async {
  //   if (isRefresh) {
  //     myWaitingAuctions_model =
  //         await _aucations_api_controller.getMyWaitingAuctions();
  //   } else {
  //     isLoadingMyWaitingAuctions.value = true;
  //     myWaitingAuctions_model =
  //         await _aucations_api_controller.getMyWaitingAuctions();
  //
  //     isLoadingMyWaitingAuctions.value = false;
  //   }
  //
  //   update();
  // }
  RxBool isLoadingMyCompletedAuctions_Pagination =false.obs;

  getMyCompletedAuctions({isRefresh = false,bool is_Pagination =false}) async {
    // MyActiveAuctions_model = await _aucations_api_controller.getMyAuctions();

    if(!is_Pagination){
      if (!isRefresh) {
        isLoadingMyCompletedAuctions.value = true;
      }

      DioHelper.getData(url: ApiSettings.my_waiting_auctions).then((value) {
        isLoadingMyCompletedAuctions.value = false;
        myCompletedAuctions_model= MyAuctions_model.fromJson(value.data);
        update();

      });
    }else{

      if(isLoadingMyCompletedAuctions_Pagination.isFalse &&myCompletedAuctions_model!.data!.nextPageUrl!=null ){
        isLoadingMyCompletedAuctions_Pagination.value = true;
        DioHelper.getData(url: myCompletedAuctions_model!.data!.nextPageUrl!).then((value) {
          isLoadingMyCompletedAuctions_Pagination.value = false;
          MyAuctions_model PaginationData = MyAuctions_model.fromJson(value.data);
          myCompletedAuctions_model!.data!.data.addAll(PaginationData.data!.data) ;
          myCompletedAuctions_model!.data!.nextPageUrl=PaginationData!.data!.nextPageUrl;
          update();

        });
      }


    }



  }

  // getMyCompletedAuctions({isRefresh = false}) async {
  //   if (isRefresh) {
  //     myCompletedAuctions_model =
  //         await _aucations_api_controller.getMyCompletedAuctions();
  //   } else {
  //     isLoadingMyCompletedAuctions.value = true;
  //     myCompletedAuctions_model =
  //         await _aucations_api_controller.getMyCompletedAuctions();
  //     isLoadingMyCompletedAuctions.value = false;
  //   }
  //
  //   update();
  // }

  complete_auction(context, {required String AucationID}) async {
    // bool isComplete = await _aucations_api_controller.complete_auction(AucationID: AucationID);
    return DioHelper.getData(
            url: ApiSettings.complete_auction + '${AucationID}')
        .then((value) {
          print(value.statusCode);
          print(value.data);

      Helper.showSnackBar(context,
          text: SharedPreferencesController().languageCode == 'ar'
              ? value.data['message_ar']
              : value.data['message_en'],
          error: value.statusCode != 200);

      if (value.statusCode == 200) {
        getMyActiveAuctions();
        getMyWaitingAuctions();
        getMyCompletedAuctions();
        getMyCanceldAuctions();
        getMyEndedAuctions();
      }
    }).catchError((e) {
      Helper.showSnackBar(context, text: e.toString(), error: true);
    });
  }



  RxBool isLoadingMyCanceledAuctions_Pagination =false.obs;

  getMyCanceldAuctions({isRefresh = false,bool is_Pagination =false}) async {
    // MyActiveAuctions_model = await _aucations_api_controller.getMyAuctions();

    if(!is_Pagination){
      if (!isRefresh) {
        isLoadingMyCanceledAuctions.value = true;
      }

      DioHelper.getData(url: ApiSettings.my_waiting_auctions).then((value) {
        isLoadingMyCanceledAuctions.value = false;
        myCanceledAuctions_model= MyAuctions_model.fromJson(value.data);
        update();

      });
    }else{

      if(isLoadingMyCanceledAuctions_Pagination.isFalse &&myCanceledAuctions_model!.data!.nextPageUrl!=null ){
        isLoadingMyCanceledAuctions_Pagination.value = true;
        DioHelper.getData(url: myCanceledAuctions_model!.data!.nextPageUrl!).then((value) {
          isLoadingMyCanceledAuctions_Pagination.value = false;
          MyAuctions_model PaginationData = MyAuctions_model.fromJson(value.data);
          myCanceledAuctions_model!.data!.data.addAll(PaginationData.data!.data) ;
          myCanceledAuctions_model!.data!.nextPageUrl=PaginationData!.data!.nextPageUrl;
          update();

        });
      }


    }



  }



  // getMyCanceldAuctions({isRefresh = false}) async {
  //   if (isRefresh) {
  //     myCanceledAuctions_model =
  //         await _aucations_api_controller.getMyCanceldAuctions();
  //   } else {
  //     isLoadingMyCanceledAuctions.value = true;
  //     myCanceledAuctions_model =
  //         await _aucations_api_controller.getMyCanceldAuctions();
  //     isLoadingMyCanceledAuctions.value = false;
  //   }
  //
  //   update();
  // }

  RxBool isLoadingMyEndedAuctions_Pagination =false.obs;

  getMyEndedAuctions({isRefresh = false,bool is_Pagination =false}) async {
    // MyActiveAuctions_model = await _aucations_api_controller.getMyAuctions();

    if(!is_Pagination){
      if (!isRefresh) {
        isLoadingMyEndedAuctions.value = true;
      }

      DioHelper.getData(url: ApiSettings.my_waiting_auctions).then((value) {
        isLoadingMyEndedAuctions.value = false;
        myEndedAuctions_model= MyAuctions_model.fromJson(value.data);
        update();

      });
    }else{

      if(isLoadingMyEndedAuctions_Pagination.isFalse &&myEndedAuctions_model!.data!.nextPageUrl!=null ){
        isLoadingMyEndedAuctions_Pagination.value = true;
        DioHelper.getData(url: myEndedAuctions_model!.data!.nextPageUrl!).then((value) {
          isLoadingMyEndedAuctions_Pagination.value = false;
          MyAuctions_model PaginationData = MyAuctions_model.fromJson(value.data);
          myEndedAuctions_model!.data!.data.addAll(PaginationData.data!.data) ;
          myEndedAuctions_model!.data!.nextPageUrl=PaginationData!.data!.nextPageUrl;
          update();

        });
      }


    }



  }

  // getMyEndedAuctions({isRefresh = false}) async {
  //
  //   if (isRefresh) {
  //
  //     myEndedAuctions_model = await _aucations_api_controller.getMyEndedAuctions();
  //   } else {
  //     isLoadingMyEndedAuctions.value = true;
  //     myEndedAuctions_model = await _aucations_api_controller.getMyEndedAuctions();
  //     isLoadingMyEndedAuctions.value = false;
  //   }
  //
  //   update();
  // }
  RxBool isLoadingMyWinBids_Pagination=false.obs;

  getMy_win_bids({is_Pagination =false}) async {
    if(!is_Pagination){
      isLoadingMyWinBids.value = true;
      DioHelper.getData(url: ApiSettings.my_win_bids).then((value) {
        isLoadingMyWinBids.value = false;
        if (value.statusCode == 200) {
          myWinBids_model = myBids_model.fromJson(value.data);
        }
        update();
      });
    }else{
      if( myWinBids_model!.data.nextPageUrl!=null&&isLoadingMyWinBids_Pagination.isFalse){
        isLoadingMyWinBids_Pagination.value = true;

        DioHelper.getData(url: myWinBids_model!.data.nextPageUrl!).then((value) {
          isLoadingMyWinBids_Pagination.value = false;
          if (value.statusCode == 200) {
            myBids_model  PaginationData = myBids_model.fromJson(value.data);
            myWinBids_model!.data.data!.addAll(PaginationData.data.data!);
            myWinBids_model!.data.nextPageUrl= PaginationData!.data.nextPageUrl;
          }
          update();
        });
      }

    }




  }

  RxBool isLoadingMyWaitingBids_Pagination=false.obs;

  getMy_wait_bids({is_Pagination =false}) async {
    if(!is_Pagination){
      isLoadingMyWaitingBids.value = true;
      DioHelper.getData(url: ApiSettings.my_win_bids).then((value) {
        isLoadingMyWaitingBids.value = false;
        if (value.statusCode == 200) {
          myWaitingBids_model = myBids_model.fromJson(value.data);
        }
        update();
      });
    }else{
      if( myWaitingBids_model!.data.nextPageUrl!=null&&isLoadingMyWaitingBids_Pagination.isFalse){
        isLoadingMyWaitingBids_Pagination.value = true;

        DioHelper.getData(url: myWaitingBids_model!.data.nextPageUrl!).then((value) {
          isLoadingMyWaitingBids_Pagination.value = false;
          if (value.statusCode == 200) {
            myBids_model  PaginationData = myBids_model.fromJson(value.data);
            myWaitingBids_model!.data.data!.addAll(PaginationData.data.data!);
            myWaitingBids_model!.data.nextPageUrl= PaginationData!.data.nextPageUrl;
          }
          update();
        });
      }

    }




  }
  // getMy_wait_bids() async {
  //   isLoadingMyWaitingBids.value = true;
  //
  //   DioHelper.getData(url: ApiSettings.my_wait_bids).then((value) {
  //     log('myWaitingBids_model::${value.data}');
  //
  //     if (value.statusCode == 200) {
  //       print('myWaitingBids_model');
  //
  //       myWaitingBids_model = myBids_model.fromJson(value.data);
  //       print(myWaitingBids_model!.messageAr);
  //     }
  //
  //     isLoadingMyWaitingBids.value = false;
  //     update();
  //   });
  // }

  RxBool isLoadingMyLoseBids_Pagination=false.obs;

  getMy_lose_bids({is_Pagination =false}) async {
    if(!is_Pagination){
      isLoadingMyLoseBids.value = true;
      DioHelper.getData(url: ApiSettings.my_win_bids).then((value) {
        isLoadingMyLoseBids.value = false;
        if (value.statusCode == 200) {
          myLoseBids_model = myBids_model.fromJson(value.data);
        }
        update();
      });
    }else{
      if( myLoseBids_model!.data.nextPageUrl!=null&&isLoadingMyLoseBids_Pagination.isFalse){
        isLoadingMyLoseBids_Pagination.value = true;

        DioHelper.getData(url: myLoseBids_model!.data.nextPageUrl!).then((value) {
          isLoadingMyLoseBids_Pagination.value = false;
          if (value.statusCode == 200) {
            myBids_model  PaginationData = myBids_model.fromJson(value.data);
            myLoseBids_model!.data.data!.addAll(PaginationData.data.data!);
            myLoseBids_model!.data.nextPageUrl= PaginationData!.data.nextPageUrl;
          }
          update();
        });
      }

    }




  }

  // getMy_lose_bids() async {
  //   isLoadingMyLoseBids.value = true;
  //
  //   DioHelper.getData(url: ApiSettings.my_lose_bids).then((value) {
  //     if (value.statusCode == 200) {
  //       myLoseBids_model = myBids_model.fromJson(value.data);
  //     }
  //
  //     isLoadingMyLoseBids.value = false;
  //     update();
  //   }).catchError((e) {
  //     isLoadingMyLoseBids.value = false;
  //     update();
  //   });
  // }

  // getMy_lose_bids() async {
  //   isLoadingMyLoseBids.value = true;
  //   myLoseBids_model = await _aucations_api_controller.getMy_lose_bids();
  //   isLoadingMyLoseBids.value = false;
  //
  //   update();
  // }

  // ChangePreview({required String Type}) {
  //   if (Type == 'myWaitingAuctions') {
  //     myAuctionsPreview_model=myWaitingAuctions_model;
  //
  //
  //
  //   } else if (Type == 'myCanceledAuctions') {
  //     myAuctionsPreview_model=myCanceledAuctions_model;
  //
  //   } else if (Type == 'myCompletedAuctions') {
  //     myAuctionsPreview_model=myCompletedAuctions_model;
  //
  //   } else if (Type == 'myEndedAuctions') {
  //     myAuctionsPreview_model=myEndedAuctions_model;
  //
  //   }
  //   update();
  // }

  getCategoryBYID({required String ID}) async {
    isLoadingSingleAucation.value = true;
    singleAucationCategory_model =
        await _aucations_api_controller.getCategoryBYID(ID: ID);
    if (singleAucationCategory_model!.data!.auctions!.isNotEmpty) {
      auctionOfCategory_List.value =
          singleAucationCategory_model!.data!.auctions!;
    } else {
      auctionOfCategory_List.value = <auction_model>[].obs;
    }
    changeTypeStatus();

    isLoadingSingleAucation.value = false;

    update();
    return singleAucationCategory_model;
  }

  getCategory_featuresQ({required String ID}) async {
    SharedPreferencesController().features.clear();
    isLoadingQuestions.value = true;
    category_featuresQ_Model =
        await _aucations_api_controller.getCategory_featuresQ(ID: ID);
    SharedPreferencesController().features.clear();

    for (int i = 0; i < await category_featuresQ_Model!.data.length; i++) {
      SharedPreferencesController().features.add({
        'key': category_featuresQ_Model!.data[i].title,
        'value': category_featuresQ_Model!.data[i].textEditingController.text
      });
    }

    isLoadingQuestions.value = false;

    update();
  }

  Future<bool> AddNewAucation(
    context, {
    required String category_id,
    required String type_id,
    required String city_id,
    required String price,
    required String title,
    required String title_ar,
    required String min_bid,
    required String auction_from,
    required String auction_to,
    required String photo,
    required String description,
    required String description_ar,
    required String language,
    required String? vedio_thumb,
    required List<String?> photos,
    required List<String?> videos,
    required List features,
  }) async {
    isSavingAdv.value = true;
    Get.back();
    bool isSaved = await _aucations_api_controller.AddNewAucation(context,
        video: videos,
        vedio_thumb: vedio_thumb,
        auction_from: auction_from,
        auction_to: auction_to,
        min_bid: min_bid,
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
    if (isSaved) {

    }
    isSavingAdv.value = false;
    update();

    return isSaved;
  }

  Future<bool> UpdateAucation(
    context, {
    required String AucationID,
    required String category_id,
    required String type_id,
    required String city_id,
    required String price,
    required String title,
    required String title_ar,
    required String min_bid,
    required String auction_from,
    required String auction_to,
    required String photo,
    required String description,
    required String description_ar,
    required String cover_image_id,
    required String language,
    required List<String?> photos,
    required List<String?> deleted_list,
    required String deleteVedio,
    required List<String?> video,
    required String vedio_thumb,
    required List features,
  }) async {
    isSavingAdv.value = true;
    bool isSaved = await _aucations_api_controller.UpdateAucation(context,
        auction_from: auction_from,
        AucationID: AucationID,
        auction_to: auction_to,
        cover_image_id: cover_image_id,
        deleted_list: deleted_list,
        min_bid: min_bid,
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
        video: video,
        vedio_thumb: vedio_thumb,
        deleteVedio: deleteVedio,
        features: features);

    isSavingAdv.value = false;
    update();

    return isSaved;
  }

  cancelAucation(
    context, {
    required String AucationID,
  }) async {
    isDeletingAucation.value = true;

    return DioHelper.deleteData(
            url: ApiSettings.cancel_Aucation + '$AucationID')
        .then((value) {
      Helper.showSnackBar(context,
          text: SharedPreferencesController().languageCode == 'ar'
              ? value.data['message_ar']
              : value.data['message_en'],
          error: value.statusCode != 200);

      if (value.statusCode == 200) {
        // getMyAuctions();
        // getMyWaitingAuctions();
        // getMyCompletedAuctions();
        getMyCanceldAuctions();
        getMyEndedAuctions();
      }
    }).catchError((e) {
      Helper.showSnackBar(context, text: e.toString(), error: true);
    });
  }

  Future<bool> deleteAucation(
    context, {
    required String AucationID,
  }) async {
    isDeletingAucation.value = true;

    return DioHelper.deleteData(
            url: ApiSettings.delete_Aucation + '$AucationID')
        .then((value) {
          print(value.statusCode);
          print(value.data);
      isDeletingAucation.value = false;
      Helper.showSnackBar(context,
          text: SharedPreferencesController().languageCode == 'ar'
              ? value.data['message_ar']
              : value.data['message_en'],
          error: value.statusCode != 200);

      if (value.statusCode == 200) {
        myWaitingAuctions_model!.data!.data
            .removeWhere((element) => element.id.toString() == AucationID);
        myCompletedAuctions_model!.data!.data
            .removeWhere((element) => element.id.toString() == AucationID);
        myCanceledAuctions_model!.data!.data
            .removeWhere((element) => element.id.toString() == AucationID);
        myEndedAuctions_model!.data!.data
            .removeWhere((element) => element.id.toString() == AucationID);
        update();
        _home_getxController.lastAucations_model!.data.data
            .removeWhere((element) => element.id.toString() == AucationID);
        _home_getxController.update();
        return true;
      } else {
        return false;
      }
    }).catchError((e) {
      Helper.showSnackBar(context, text: e.toString(), error: true);
      return false;
    });
  }

  Future<singleAucations_Model> add_AucationBid(
    context, {
    required String amount,
    required String AucationID,
  }) async {
    isAddingBID.value = true;
    return DioHelper.postData(
        url: ApiSettings.add_AucationBid + '$AucationID',
        data: {'amount': amount}).then((value) {
      isAddingBID.value = false;

      if (value.statusCode != 200) {
        Helper.showSnackBar(context,
            text: SharedPreferencesController().languageCode == 'ar'
                ? value.data['message_ar']
                : value.data['message_en'],
            error: value.statusCode != 200);
      }
      singleAucations_Model data = singleAucations_Model.fromJson(value.data);
      if (value.statusCode == 200) {
        //todo=> check this
        FbFireStoreController().AddNewBid(
            aucationID: num.parse(AucationID), BidAmount: num.parse(amount));
      }

      update();
      return data;
    }).catchError((e) {
      isAddingBID.value = false;
      Helper.showSnackBar(context, text: e.toString(), error: true);
      update();
    });
  }

  AucationChangeStatus({required int index}) {
    for (int i = 0; i < category_model!.data.length; i++) {
      if (i == index) {
        category_model!.data[i].isSelected = true;
      } else {
        category_model!.data[i].isSelected = false;
      }

      update();
    }
  }

  AucationChangeStatusByID({required int ID}) {
    int inedx = category_model!.data.indexWhere((element) => element.id == ID);
    AucationChangeStatus(index: inedx);
    getCategoryBYID(ID: category_model!.data[inedx].id.toString());
    getCategory_featuresQ(ID: category_model!.data[inedx].id.toString());
  }

  changeTypeStatus({int? TypeID}) {
    if (TypeID != null) {
      auctionOfCategory_ListCopy!.value =
          auctionOfCategory_List!.where((p0) => p0!.typeId == TypeID).toList();

      for (int i = 0;
          i < singleAucationCategory_model!.data!.typeCategories!.length;
          i++) {
        if (singleAucationCategory_model!.data!.typeCategories![i].id ==
            TypeID) {
          singleAucationCategory_model!.data!.typeCategories![i].isSelected =
              true;
        } else {
          singleAucationCategory_model!.data!.typeCategories![i].isSelected =
              false;
        }
      }
    } else {
      auctionOfCategory_ListCopy.value = auctionOfCategory_List;
      ClearTypeStatus();
    }

    update();
  }

  ClearTypeStatus() {
    for (int i = 0;
        i < singleAucationCategory_model!.data!.typeCategories!.length;
        i++) {
      singleAucationCategory_model!.data!.typeCategories![i].isSelected = false;

      update();
    }
  }
}
