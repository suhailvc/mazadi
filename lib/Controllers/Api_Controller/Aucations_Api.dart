import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:mazzad/Api/dio_helper.dart';
import 'package:mazzad/Utils/Helper.dart';

import '../../Api/api_mixin.dart';
import '../../Api/api_settings.dart';
import '../../Database/SharedPreferences/shared_preferences.dart';
import '../../Models/AucationsCategory_Model.dart';
import '../../Models/MyWaitingAuctions_model.dart';
import '../../Models/boardings_Model.dart';
import 'package:http/http.dart' as http;

import '../../Models/getCategory_featuresQ_Model.dart';
import '../../Models/homeSlider_Model.dart';
import '../../Models/latestAucations_Model.dart';
import '../../Models/myAuctions_Model.dart';
import '../../Models/myBids_model.dart';
import '../../Models/singleAucationCategory_Model.dart';
import '../../Models/singleAucations_Model.dart';
import '../GetxController/checkNetWorkGetx_Controller.dart';

class Aucations_Api_Controller extends ApiMixin {
  // checkNetWorkGetx_Controller _netWork_getxController =Get.put<checkNetWorkGetx_Controller>(checkNetWorkGetx_Controller());
  var _netWork_getxController = Get.find<checkNetWorkGetx_Controller>();

  Future<AucationsCategory_Model?> getCategories() async {
    try {
      var response = await http.get(getUrl(ApiSettings.get_AuctionCategories),
          headers: header);
      // var response = await http.get(getUrl(ApiSettings.get_AuctionCategories),headers: header).timeout(Duration(seconds: 15));

      if (isSuccessRequest(response.statusCode)) {
        var data = jsonDecode(response.body);

        return AucationsCategory_Model.fromJson(data);
      }
      return null;
    } on TimeoutException catch (e) {
      return null;
    }
  }

  Future complete_auction({required String AucationID}) async {
    try {
      print(AucationID);

      var response = await http.get(
          getUrl(ApiSettings.complete_auction + '${AucationID}'),
          headers: header);
      print(response.statusCode);
      print(response.body);

      if (isSuccessRequest(response.statusCode)) {
        var data = jsonDecode(response.body);
        return true;
      }
      return false;
    } on TimeoutException catch (e) {
      return false;
    }
  }

  Future<MyAuctions_model?> getMyAuctions() async {
    try {
      var response =
          await http.get(getUrl(ApiSettings.my_auctions), headers: header);
      // var response = await http.get(getUrl(ApiSettings.my_auctions),headers: header).timeout(Duration(seconds: 20));

      if (isSuccessRequest(response.statusCode)) {
        var data = jsonDecode(response.body);

        return MyAuctions_model.fromJson(data);
      }
      return null;
    } on TimeoutException catch (e) {
      return null;
    }
  }

  Future<MyAuctions_model?> getMyWaitingAuctions() async {
    try {
      var response = await http.get(getUrl(ApiSettings.my_waiting_auctions),
          headers: header);
      // var response = await http.get(getUrl(ApiSettings.my_waiting_auctions),headers: header).timeout(Duration(seconds: 20));


      if (isSuccessRequest(response.statusCode)) {
        var data = jsonDecode(response.body);

        return MyAuctions_model.fromJson(data);
      }
      return null;
    } on TimeoutException catch (e) {
      return null;
    }
  }

  Future<MyAuctions_model?> getMyCompletedAuctions() async {
    try {
      var response = await http.get(getUrl(ApiSettings.my_completed_auctions),
          headers: header);
      // var response = await http.get(getUrl(ApiSettings.my_completed_auctions),headers: header).timeout(Duration(seconds: 20));

      if (isSuccessRequest(response.statusCode)) {
        var data = jsonDecode(response.body);

        return MyAuctions_model.fromJson(data);
      }
      return null;
    } on TimeoutException catch (e) {
      return null;
    }
  }

  Future<MyAuctions_model?> getMyCanceldAuctions() async {
    try {
      var response = await http.get(getUrl(ApiSettings.my_canceled_auctions),
          headers: header);
      // var response = await http.get(getUrl(ApiSettings.my_canceled_auctions),headers: header).timeout(Duration(seconds: 20));

      if (isSuccessRequest(response.statusCode)) {
        var data = jsonDecode(response.body);

        return MyAuctions_model.fromJson(data);
      }
      return null;
    } on TimeoutException catch (e) {
      return null;
    }
  }

  Future<MyAuctions_model?> getMyEndedAuctions() async {
    try {
      var response = await http.get(getUrl(ApiSettings.my_ended_auctions), headers: header);
      // var response = await http.get(getUrl(ApiSettings.my_ended_auctions),headers: header).timeout(Duration(seconds: 20));

      if (isSuccessRequest(response.statusCode)) {
        var data = jsonDecode(response.body);

        return MyAuctions_model.fromJson(data);
      }
      return null;
    } on TimeoutException catch (e) {
      return null;
    }
  }
/*
  Future<myBids_model?> getMy_win_bids() async {
    try {
      var response =
          await http.get(getUrl(ApiSettings.my_win_bids), headers: header);
      // var response = await http.get(getUrl(ApiSettings.my_win_bids),headers: header).timeout(Duration(seconds: 20));

      if (isSuccessRequest(response.statusCode)) {
        var data = jsonDecode(response.body);

        return myBids_model.fromJson(data);
      }
      return null;
    } on TimeoutException catch (e) {
      return null;
    }
  }

  Future<myBids_model?> getMy_wait_bids() async {
    try {
      var response =
          await http.get(getUrl(ApiSettings.my_wait_bids), headers: header);
      // var response = await http.get(getUrl(ApiSettings.my_wait_bids),headers: header).timeout(Duration(seconds: 20));

      if (isSuccessRequest(response.statusCode)) {
        var data = jsonDecode(response.body);

        return myBids_model.fromJson(data);
      }
      return null;
    } on TimeoutException catch (e) {
      return null;
    }
  }

  Future<myBids_model?> getMy_lose_bids() async {
    try {
      var response =
          await http.get(getUrl(ApiSettings.my_lose_bids), headers: header);
      // var response = await http.get(getUrl(ApiSettings.my_lose_bids),headers: header).timeout(Duration(seconds: 20));

      if (isSuccessRequest(response.statusCode)) {
        var data = jsonDecode(response.body);

        return myBids_model.fromJson(data);
      }
      return null;
    } on TimeoutException catch (e) {
      return null;
    }
  }


 */

  Future<singleAucationCategory_Model?> getCategoryBYID(
      {required String ID}) async {
    try {
      var response = await http.get(
          getUrl(ApiSettings.auction_categoriesBy_id + '$ID'),
          headers: header);
      // var response = await http.get(getUrl(ApiSettings.auction_categoriesBy_id+'$ID'),headers: header).timeout(Duration(seconds: 20));

      if (isSuccessRequest(response.statusCode)) {
        var data = jsonDecode(response.body);

        return singleAucationCategory_Model.fromJson(data);
      }
      return null;
    } on TimeoutException catch (e) {
      return null;
    }
  }

  Future<getCategory_featuresQ_Model?> getCategory_featuresQ(
      {required String ID}) async {
    try {
      var response = await http.get(
          getUrl(ApiSettings.get_Aucation_features + '$ID'),
          headers: header);

      if (isSuccessRequest(response.statusCode)) {
        var data = jsonDecode(response.body);

        return getCategory_featuresQ_Model.fromJson(data);
      }
      return null;
    } on TimeoutException catch (e) {
      return null;
    }
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
    required String description,
    required String description_ar,
    required String photo,
    required List<String?> photos,
    required List features,
    required String language,
    required List<String?> video,
    required String? vedio_thumb,

      }) async {
    // try {
    var request = http.MultipartRequest('POST', Uri.parse(ApiSettings.auctions_add));



    request.fields.addAll({
      'category_id': category_id,
      'type_id': type_id,
      'city_id': city_id,
      'title': title,
      'title_ar': title_ar,
      'description': description,
      'description_ar': description_ar,
      'price': price,
      'min_bid': min_bid,
      'auction_from': auction_from,
      'auction_to': auction_to,
      'language': language,
    });

    request.files.add(await http.MultipartFile.fromPath('photo', photo));

    if(video.isNotEmpty&&vedio_thumb!=null && vedio_thumb!=''  ){
      request.files.add(await http.MultipartFile.fromPath('vedio', video[0]!));
      request.files.add(await http.MultipartFile.fromPath('vedio_thumb', vedio_thumb!));
    }

    if (photos.length > 0) {
      for (int i = 0; i < photos.length; i++) {
        request.files.add(await http.MultipartFile.fromPath('photos[]', photos[i].toString()));
      }
    }

    if (features.length > 0) {
      for (int i = 0; i < features.length; i++) {
        request.fields.addAll({
          'features[$i][key]': features[i]['key'],
          'features[$i][value]': features[i]['value'],
        });
      }
    }

    request.headers.addAll(header);
    http.StreamedResponse response = await request.send();
    var responseBody = await response.stream.bytesToString();
    var responseJson = jsonDecode(responseBody);
    print(response.statusCode);
    print(responseJson);
    if (response.statusCode < 400) {
      return true;
    } else {
      Helper.showSnackBar(context,
          text: SharedPreferencesController().languageCode == 'ar'
              ? responseJson['message_ar']
              : responseJson['message_en'],
          error: true);
      return false;
    }

  }

  Future<bool> UpdateAucation(context,{
    required String category_id,
    required String AucationID,
    required String type_id,
    required String city_id,
    required String price,
    required String title,
    required String title_ar,
    required String min_bid,
    required String auction_from,
    required String auction_to,
    required String description,
    required String description_ar,
    required String photo,
    required String cover_image_id,
    required List<String?> photos,
    required List<String?> deleted_list,
    required List features,
    required String language,
    required String deleteVedio,
    required List<String?> video,
    required String vedio_thumb,
  }) async {
    // try  {
    // var request = http.MultipartRequest('POST', Uri.parse('https://mazaad.fresh-app.com/api/user/auctions/update/$AucationID'));
    var request = http.MultipartRequest('POST', Uri.parse(ApiSettings.auctions_update+'$AucationID'));
    // var request = http.MultipartRequest('POST', Uri.parse('http://admin.mazadistore.com/api/user/auctions/update/$AucationID'));



    request.fields.addAll({
      'category_id': category_id,
      'type_id': type_id,
      'city_id': city_id,
      'title': title,
      'title_ar': title_ar,
      'description': description,
      'description_ar': description_ar,
      'price': price,
      'min_bid': min_bid,
      'auction_from': auction_from,
      'auction_to': auction_to,
      'deleted_list': deleted_list.toString(),
      'cover_image_id': cover_image_id,
      'language': language,
      'deleteVedio': deleteVedio,
    });


    if (cover_image_id == '') {
      request.files.add(await http.MultipartFile.fromPath('photo', photo));
    }

    if( deleteVedio=='true'&& vedio_thumb!=null && vedio_thumb!='' ){
      request.files.add(await http.MultipartFile.fromPath('vedio', video[0]!));
      request.files.add(await http.MultipartFile.fromPath('vedio_thumb', vedio_thumb));

    }

    if (photos.length > 0) {
      for (int i = 0; i < photos.length; i++) {
        request.files.add(await http.MultipartFile.fromPath(
            'photos[]', photos[i].toString()));
        print('${photos[i]!} ::${photos[i]!.runtimeType}');
      }
    }
    if (features.length > 0) {
      for (int i = 0; i < features.length; i++) {
        request.fields.addAll({
          'features[$i][key]': features[i]['key'],
          'features[$i][value]': features[i]['value'],
        });
      }
    }

    request.headers.addAll(header);

    http.StreamedResponse response = await request.send();

    var responseBody = await response.stream.bytesToString();

    var responseJson = jsonDecode(responseBody);
    print(response.statusCode);
    print(responseJson);
    if (response.statusCode < 400) {
      return true;
    } else {
      Helper.showSnackBar(context,
          text: SharedPreferencesController().languageCode == 'ar'
              ? responseJson['message_ar']
              : responseJson['message_en'],
          error: true);
      return false;
    }
    // }on TimeoutException catch (e) {
    // return false;
    //
    //
    // }
  }

  Future<bool> cancelAucation({
    required String AucationID,
  }) async {
    try {
      print(AucationID);

      var request = http.MultipartRequest('DELETE', getUrl(ApiSettings.cancel_Aucation + '$AucationID'));

      request.headers.addAll(header);


      http.StreamedResponse response = await request.send();
      print(response.statusCode);
      if (response.statusCode < 400) {
        return true;
      } else {
        return false;
      }
    } on TimeoutException catch (e) {
      return false;
    }
  }

  Future<bool> deleteAucation({
    required String AucationID,
  }) async {
    try {
      var request = http.MultipartRequest(
          'DELETE', getUrl(ApiSettings.delete_Aucation + '$AucationID'));

      request.headers.addAll(header);

      http.StreamedResponse response = await request.send();

      if (response.statusCode < 400) {

        return true;
      } else {
        return false;
      }
    } on TimeoutException catch (e) {
      return false;
    }
  }

  Future<bool> add_AucationBid(
    context, {
    required String amount,
    required String AucationID,
  }) async {
    return DioHelper.postData(
        url: ApiSettings.add_AucationBid + '$AucationID',
        data: {'amount': amount}).then((value) {
          print(value.statusCode);
          print(value.data);
      Helper.showSnackBar(context,
          text: SharedPreferencesController().languageCode == 'ar'
              ? value.data['message_ar']
              : value.data['message_en'],
          error: !value.data['status']);

      if (value.statusCode! < 400) {
        return true;
      } else {
        return false;
      }
    }).catchError((e){
      Helper.showSnackBar(context,
          text: 'هناك مشكلة !',
          error: true);
      return false;

    });
  }
}
