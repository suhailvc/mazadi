import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mazzad/Database/SharedPreferences/shared_preferences.dart';
import 'package:mazzad/Models/blockAuction_Model.dart';
import 'package:mazzad/Utils/Helper.dart';

import '../../Api/api_settings.dart';
import '../../Api/dio_helper.dart';
import '../../Bindings/onBoardingBindings.dart';
import '../../Models/AucationsCategory_Model.dart';
import '../../Models/Notifications_Model.dart';
import '../../Models/boardings_Model.dart';
import '../../Models/card_Model.dart';
import '../../Models/addBalance_Model.dart';
import '../../Models/homeSlider_Model.dart';
import '../../Models/latestAucations_Model.dart';
import '../../Models/myAddress_Model.dart';
import '../../Models/myAdvertisement_wishlists_Model.dart';
import '../../Models/myAuctions_wishlists_Model.dart';
import '../../Models/myTransactions_Model.dart';
import '../../Models/myWallet_Model.dart';
import '../../Models/profile_Model.dart';
import '../../Models/sendCard_Model.dart';
import '../../Models/singleAucations_Model.dart';
import '../../Screens/onBoarding/onBoarding_Screen.dart';
import '../Api_Controller/Aucations_Api.dart';
import '../Api_Controller/profile_Api.dart';
import '../Api_Controller/home_Api.dart';
import '../Api_Controller/onBordingApi.dart';

class profile_GetxController extends GetxController {
  profile_Api_Controller _auth_api_controller = profile_Api_Controller();
  profile_Model? profile_model;

  // profile_Model2? profileDetails_model;
  myAddress_Model? address_model;
  myWallet_Model? wallet_model;

  // myTransactions_Model? transactions_model;
  myAdvertisement_wishlists_Model? advertisement_wishlists_model;
  myAuctions_wishlists_Model? auctions_wishlists_model;
  Notifications_Model? myNotifications;
  blockAuction_Model? myBlockAuction_Model;

  static profile_GetxController get to => Get.find();

  RxBool isLoading = false.obs;
  RxBool isLoadingProfile = false.obs;
  RxBool isLoadingAddress = false.obs;
  RxBool isLoadingMyNotifications = false.obs;
  RxBool isLoadingMyTransactions = false.obs;
  RxBool isLoadingMyWallet = false.obs;
  RxBool isLoadingAuctions_wishlists = false.obs;
  RxBool isLoadingAdvertisement_wishlists = false.obs;
  RxBool isLoadingMyblockAuction = false.obs;

  RxBool isLoadingData = false.obs;
  RxBool isAddingContact = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (SharedPreferencesController().getToken.isNotEmpty) {
      get_profile();
      get_my_advertisement_wishlists();
      get_myNotifications();
      get_MyBalance();
      // get_MyTransactions();
      get_myAddress();
      get_my_auction_wishlists();
      // get_blockAuction();
      // get_AllCard();
    }
  }

  get_profile() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    isLoadingProfile.value = true;
    // profile_model = await _auth_api_controller.get_profile();
    DioHelper.getData(url: ApiSettings.get_profile).then((value) {
      isLoadingProfile.value = false;

      profile_model = profile_Model.fromJson(value.data);
      update();
    });
  }

  get_myNotifications() async {
    isLoadingMyNotifications.value = true;
    myNotifications = await _auth_api_controller.get_MyNotifications();
    isLoadingMyNotifications.value = false;

    update();
  }

  get_myAddress() async {
    isLoadingAddress.value = true;
    address_model = await _auth_api_controller.get_myAddress();
    isLoadingAddress.value = false;

    update();
  }

  get_MyBalance() async {
    isLoadingMyWallet.value = true;
    wallet_model = await _auth_api_controller.get_MyBalance();
    isLoadingMyWallet.value = false;

    update();
  }

  get_blockAuction() async {
    isLoadingMyblockAuction.value = true;
    myBlockAuction_Model = await _auth_api_controller.get_blockAuction();

    isLoadingMyblockAuction.value = false;

    update();
  }

  // get_MyTransactions()async{
  //   isLoadingMyTransactions.value =true;
  //   transactions_model=await  _auth_api_controller.get_MyTransactions() ;
  //
  //   isLoadingMyTransactions.value =false;
  //
  //   update();
  //
  // }

  // RxBool isLoadingAdv_wishlists_Pagination = false.obs;

  get_my_advertisement_wishlists() async {

      isLoadingAdvertisement_wishlists.value = true;
      DioHelper.getData(url: ApiSettings.get_my_advertisement_wishlists).then((value) {
        isLoadingAdvertisement_wishlists.value = false;
        if(value.statusCode==200){
          advertisement_wishlists_model =myAdvertisement_wishlists_Model.fromJson(value.data);
        }
        update();

      });






  }

  get_my_auction_wishlists() async {
    isLoadingAuctions_wishlists.value = true;
    auctions_wishlists_model =
        await _auth_api_controller.get_my_auction_wishlists();
    isLoadingAuctions_wishlists.value = false;

    update();
  }

  ChangeAdvertisement_wishlistsStatus({
    required String ID,
  }) async {
    isLoading.value = true;
    return DioHelper.putData(
            url: ApiSettings.add_or_remove_from_advertisement_wishlists + '$ID')
        .then((value) {
      isLoading.value = false;
      //
      // advertisement_wishlists_model!.data =
      //     myAdvertisement_wishlists_Model.fromJson(value.data).data;

      update();

      return value.data['status'];
    });
  }

  ChangeAuction_wishlistsStatus({required String ID}) async {
    isLoading.value = true;
    return DioHelper.putData(
            url: ApiSettings.add_or_remove_from_auction_wishlists + '$ID')
        .then((value) {
      isLoading.value = false;

      // auctions_wishlists_model!.data = myAuctions_wishlists_Model.fromJson(value.data).data;

      update();

      return value.data['status'];
    });

    // bool requestDone = await _auth_api_controller.aucation_ChangeWishlists(ID: ID);
    // if (requestDone == true) {
    get_my_auction_wishlists();
    // }
  }

  add_contact({
    required String name,
    required String mobile,
    required String title,
    String fcm_token = '',
    required String message,
  }) async {
    isAddingContact.value = true;
    bool successRequest = await _auth_api_controller.add_contact(
        name: name, mobile: mobile, title: title, message: message);
    isAddingContact.value = false;

    update();
    return successRequest;
  }

  RxBool IsUpdatingProfile = false.obs;

  update_profile({
    required String name,
    required String mobile,
    required String email,
    required String city_id,
    required String address,
    required String whatsapp,
  }) async {
    IsUpdatingProfile.value = true;
  return   DioHelper.putData(url: ApiSettings.update_profile, data: {
      'name': name,
      'mobile': mobile,
      'email': email,
      'city_id': city_id,
      'address': address,
      'whatsapp': whatsapp
    }).then((value) {

      IsUpdatingProfile.value = false;

      if (value.statusCode == 200) {
        profile_model!.data.name = name;
        profile_model!.data.mobile = mobile;
        profile_model!.data.email = email;
        profile_model!.data.email = email;
        profile_model!.data.address = address;
        profile_model!.data.whatsapp = whatsapp;
        profile_model!.data.cityId = int.parse(city_id);
      }

      update();
    });
  }

  add_address({
    required String name,
    required String mobile,
    required String district,
    required String city_id,
    required String address,
  }) async {
    await _auth_api_controller.add_address(
        name: name,
        mobile: mobile,
        district: district,
        city_id: city_id,
        address: address);

    await get_myAddress();

    update();
  }

  delete_address({
    required String addressID,
  }) async {
    await _auth_api_controller.delete_address(addressID: addressID);
    address_model!.data.removeWhere((element) => element.id == addressID);

    update();
  }

  update_photo({
    required File file,
  }) async {
    isLoading.value = true;
    await _auth_api_controller.update_photo(file: file);
    await get_profile();

    isLoading.value = false;

    update();
  }

  addBalance_model? addBalance_Model;
  RxBool isAddingBalance = false.obs;

  add_balance(
    context, {
    required String amount,
  }) async {
    isAddingBalance.value = true;
    addBalance_Model = await _auth_api_controller.add_balance(amount: amount);
    Helper.showSnackBar(
      context,
      text: SharedPreferencesController().languageCode == 'ar'
          ? addBalance_Model!.messageAr
          : addBalance_Model!.messageEn,
      error: !addBalance_Model!.status,
    );
    if (addBalance_Model!.code == 200) {
      wallet_model!.data = addBalance_Model!.data;

      update();
      Get.back();
    }

    // await start();

    isAddingBalance.value = false;

    update();
  }

  card_Model? allCard_model;
  RxBool isGettingAllCards = false.obs;

  get_AllCard() {
    isGettingAllCards.value = true;
    DioHelper.getData(url: ApiSettings.get_card_categories).then((value) {
      allCard_model = card_Model.fromJson(value.data);
    });
    isGettingAllCards.value = false;
    update();
  }

  RxBool isSendingCard = false.obs;
  sendCard_Model? sendCard_model;
  TextEditingController phoneController = TextEditingController();

  Send_Card(
    context, {
    required String cardAmount,
  }) {
    isSendingCard.value = true;
    DioHelper.postData(url: ApiSettings.charg_amount, data: {
      'mobile': phoneController.text,
      'amount': cardAmount,
    }).then((value) {
      sendCard_model = sendCard_Model.fromJson(value.data);
      Helper.showSnackBar(context,
          text: SharedPreferencesController().languageCode == 'ar'
              ? sendCard_model!.messageAr
              : sendCard_model!.messageEn,
          error: !sendCard_model!.status);
      isSendingCard.value = false;
      if (sendCard_model!.code == 200) {
        phoneController.clear();
      }
      update();

      return sendCard_model;
    }).catchError((e) {
      Helper.showSnackBar(context, text: e.toString(), error: true);
      isSendingCard.value = false;
      update();
    });
  }

  deleteAllNotification(context) {
    DioHelper.deleteData(url: ApiSettings.delete_all_notifications)
        .then((value) {
      Helper.showSnackBar(context,
          text: SharedPreferencesController().languageCode == 'ar'
              ? value.data['message_ar']
              : value.data['message_en'],
          error: !value.data['status']);
      if (value.statusCode == 200) {
        myNotifications!.data!.clear();
        update();
        Get.back();
      }
    });
  }

  remove_myAccount() {
    DioHelper.getData(url: ApiSettings.removeProfile).then((value) {
      print('delete Profile ${value.statusCode}');
      print('delete Profile ${value.data}');
      if (value.statusCode == 200) {
        SharedPreferencesController().setToken('');
        profile_model = null;
        SharedPreferencesController().setFirstLoggin(false);
        update();
        Get.offAll(OnBoardingScreen(), binding: onBoardingBindings());
      }
    });
  }
}
