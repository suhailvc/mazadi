//
//
// import 'dart:async';
// import 'dart:convert';
//
// import 'package:get/get.dart';
// import 'package:mazzad/Controllers/GetxController/checkNetWorkGetx_Controller.dart';
// import 'package:mazzad/Utils/Helper.dart';
//
// import '../../Api/api_mixin.dart';
// import '../../Api/api_settings.dart';
// import '../../Database/SharedPreferences/shared_preferences.dart';
// import '../../Models/advertisementCategories_Model.dart';
// import '../../Models/advertisementCategoryDetails_Model.dart';
// import '../../Models/allAdvertisement_Model.dart';
// import '../../Models/boardings_Model.dart';
// import 'package:http/http.dart' as http;
//
// import '../../Models/homeSlider_Model.dart';
// import '../../Models/latestAdvertisements_Model.dart';
// import '../../Models/latestAucations_Model.dart';
// import '../../Models/singleAucations_Model.dart';
//
// class home_Api_Controller extends ApiMixin  {
//
//   // checkNetWorkGetx_Controller _netWork_getxController =Get.put<checkNetWorkGetx_Controller>(checkNetWorkGetx_Controller());
//   var _netWork_getxController = Get.find<checkNetWorkGetx_Controller>();
//
//   // Future<homeSlider_Model ?> getSlider() async {
//   //
//   //   var response = await http.get(getUrl(ApiSettings.get_slider),);
//   //
//   //   if (isSuccessRequest(response.statusCode)) {
//   //     var data = jsonDecode(response.body);
//   //
//   //     var data2 = homeSlider_Model.fromJson(data);
//   //
//   //
//   //     print(data2.messageAr);
//   //     return homeSlider_Model.fromJson(data);
//   //
//   //   }
//   //   return null;
//   //
//   // }
//
// //   Future<latestAucations_Model ?> getLastAucations() async {
// //
// // // if(await Helper().checkInternet()){
// //
// //
// //   var response = await http.get(getUrl(ApiSettings.latest_auctions+'/${SharedPreferencesController().ADVLanguage}'),headers: header);
// //
// //   if (isSuccessRequest(response.statusCode)) {
// //     var data = jsonDecode(response.body);
// //     SharedPreferencesController().setLastAucations_cache(data.toString());
// //     return latestAucations_Model.fromJson(data);
// //
// //   }
// //   return null;
// //
// // //
// // // }else{
// // //
// // //   var cachedData = jsonDecode(SharedPreferencesController().getLastAucations_cache.toString());
// // // print('cachedData ::$cachedData');
// // //   return latestAucations_Model.fromJson(cachedData);
// // //
// // // }
// //
// //
// //
// //
// //   }
//
//
//
//
// //   Future<singleAucations_Model ?> getAucationByID({required String ID}) async {
// //       try{
// //     var response = await http.get(getUrl(ApiSettings.singleAuction+'$ID'),headers: header);
// //
// //     print(response.statusCode);
// //     print(response.body);
// //     if (isSuccessRequest(response.statusCode)) {
// //
// //       var data = jsonDecode(response.body);
// //
// //       return singleAucations_Model.fromJson(data);
// //
// //     }
// //     return null;
// //   }on TimeoutException catch (e) {
// //   return null;
// //
// //
// // }
// //
// //   }
//
//   // Future<latestAdvertisements_Model ?> getLatest_advertisements() async {
//   //
//   //   var response = await http.get(getUrl(ApiSettings.latest_advertisements+'/${SharedPreferencesController().ADVLanguage}'),headers: header);
//   //
//   //   if (isSuccessRequest(response.statusCode)) {
//   //     var data = jsonDecode(response.body);
//   //
//   //     var data2 = latestAdvertisements_Model.fromJson(data);
//   //
//   //
//   //     print(data2.messageAr);
//   //     return latestAdvertisements_Model.fromJson(data);
//   //
//   //   }
//   //   return null;
//   //
//   //
//   // }
//
//
//
//   // Future<allAdvertisement_Model ?> get_advertisements() async {
//   //
//   //   var response = await http.get(getUrl(ApiSettings.get_advertisements),headers: header);
//   //
//   //   if (isSuccessRequest(response.statusCode)) {
//   //     var data = jsonDecode(response.body);
//   //
//   //     var data2 = allAdvertisement_Model.fromJson(data);
//   //
//   //
//   //     print(data2.messageAr);
//   //     return allAdvertisement_Model.fromJson(data);
//   //
//   //   }
//   //   return null;
//   //
//   // }
// /*
//   Future<advertisementCategories_Model ?> get_category_by_id({required String ID}) async {
//
//     var response = await http.get(getUrl(ApiSettings.get_category_by_id+'$ID'),headers: header);
//
//     if (isSuccessRequest(response.statusCode)) {
//       var data = jsonDecode(response.body);
//
//       var data2 = advertisementCategories_Model.fromJson(data);
//
//
//       return advertisementCategories_Model.fromJson(data);
//
//     }
//     return null;
//   }
//
//
//  */
//
//
// //   Future<advertisementCategoryDetails_Model ?> get_show_category_by_id({required String ID}) async {
// //
// //       try{
// //     var response = await http.get(getUrl(ApiSettings.get_show_category_by_id+'$ID'),headers: header);
// //
// //     if (isSuccessRequest(response.statusCode)) {
// //       var data = jsonDecode(response.body);
// //
// //
// //       return advertisementCategoryDetails_Model.fromJson(data);
// //
// //     }
// //     return null;
// //   }on TimeoutException catch (e) {
// //   return null;
// //
// //
// // }
// //
// //   }
//
//
// }