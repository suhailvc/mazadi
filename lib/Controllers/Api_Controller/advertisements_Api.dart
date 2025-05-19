

import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mazzad/Models/Cities_Model.dart';

import '../../Api/api_mixin.dart';
import '../../Api/api_settings.dart';
import '../../Database/SharedPreferences/shared_preferences.dart';
import '../../Models/AucationsCategory_Model.dart';
import '../../Models/CategoryTypes_Model.dart';
import '../../Models/advertisementOfCategory_Model.dart';
import '../../Models/boardings_Model.dart';
import 'package:http/http.dart' as http;

import '../../Models/comments_Model.dart';
import '../../Models/getCategory_featuresQ_Model.dart';
import '../../Models/homeSlider_Model.dart';
import '../../Models/latestAucations_Model.dart';
import '../../Models/myAdvertisements_Model.dart';
import '../../Models/singleAdvertisement_Model.dart';
import '../../Models/singleAucationCategory_Model.dart';
import '../../Models/singleAucations_Model.dart';import 'package:http_parser/http_parser.dart';

import '../GetxController/checkNetWorkGetx_Controller.dart';


class Advertisements_Api_Controller extends ApiMixin  {

  // var _netWork_getxController = Get.find<checkNetWorkGetx_Controller>();

  // Future<myAdvertisements_Model?> myAdvertisements() async {
  //   try{
  //
  //     var response = await http.get(getUrl(ApiSettings.my_advertisements),headers: header);
  //     // var response = await http.get(getUrl(ApiSettings.my_advertisements),headers: header).timeout(Duration(seconds: 10));
  //
  //     if (isSuccessRequest(response.statusCode)) {
  //       var data = jsonDecode(response.body);
  //
  //
  //
  //       return myAdvertisements_Model.fromJson(data);
  //
  //     }
  //     return null;
  //
  //   }on TimeoutException catch (e) {
  //     // _netWork_getxController.isTimeOut.value=true;
  //     return null;
  //
  //
  //   }
  //
  // }



  // Future<Cities_Model?> getMyCities() async {
  //   try{
  //
  //     var response = await http.get(getUrl(ApiSettings.get_cities),);
  //     // var response = await http.get(getUrl(ApiSettings.my_advertisements),headers: header).timeout(Duration(seconds: 10));
  //
  //     if (isSuccessRequest(response.statusCode)) {
  //       var data = jsonDecode(response.body);
  //
  //
  //
  //       return Cities_Model.fromJson(data);
  //
  //     }
  //     return null;
  //
  //   }on TimeoutException catch (e) {
  //     // _netWork_getxController.isTimeOut.value=true;
  //     return null;
  //
  //
  //   }
  //
  // }


  // Future<advertisementOfCategory_Model?> get_advertisement_byCategory({required String ID}) async {
  //   try{
  //     var response = await http.get(getUrl(ApiSettings.get_advertisement_byCategory+'$ID'+'/${SharedPreferencesController().ADVLanguage}'),headers: header);
  //     // var response = await http.get(getUrl(ApiSettings.get_advertisement_byCategory+'$ID'+'/${SharedPreferencesController().ADVLanguage}'),headers: header).timeout(Duration(seconds: 10));
  //     //
  //     if (isSuccessRequest(response.statusCode)) {
  //       var data = jsonDecode(response.body);
  //
  //       var data2 = advertisementOfCategory_Model.fromJson(data);
  //       return data2;
  //     }
  //     return null;
  //   }on TimeoutException catch (e) {
  //     // _netWork_getxController.isTimeOut.value=true;
  //     return null;
  //
  //
  //   }
  //
  // }

  // Future<CategoryTypes_Model?> get_category_types({required String ID}) async {
  //   try{
  //     var response = await http.get(getUrl(ApiSettings.get_category_types+'$ID'),headers: header);
  //     // var response = await http.get(getUrl(ApiSettings.get_advertisement_byCategory+'$ID'+'/${SharedPreferencesController().ADVLanguage}'),headers: header).timeout(Duration(seconds: 10));
  //     //
  //     if (isSuccessRequest(response.statusCode)) {
  //       var data = jsonDecode(response.body);
  //
  //       var data2 = CategoryTypes_Model.fromJson(data);
  //       return data2;
  //     }
  //     return null;
  //   }on TimeoutException catch (e) {
  //     // _netWork_getxController.isTimeOut.value=true;
  //     return null;
  //
  //
  //   }
  //
  // }




  // Future<myAdvertisements_Model?> my_waiting_advertisements() async {
  //   try{
  //     var response = await http.get(getUrl(ApiSettings.my_waiting_advertisements),headers: header);
  //     // var response = await http.get(getUrl(ApiSettings.my_waiting_advertisements),headers: header).timeout(Duration(seconds: 20));
  //
  //     if (isSuccessRequest(response.statusCode)) {
  //       var data = jsonDecode(response.body);
  //
  //
  //
  //       return myAdvertisements_Model.fromJson(data);
  //
  //     }
  //     return null;
  //
  //   }on TimeoutException catch (e) {
  //     // _netWork_getxController.isTimeOut.value=true;
  //     return null;
  //
  //
  //   }
  //
  // }

//   Future<singleAdvertisement_Model?> getAdvertisementByID({required String ID}) async {
// try{
//     var response = await http.get(getUrl(ApiSettings.singleAdvertisements+'$ID'),headers: header);
//     // var response = await http.get(getUrl(ApiSettings.singleAdvertisements+'$ID'),headers: header).timeout(Duration(seconds: 10));
//
//     if (isSuccessRequest(response.statusCode)) {
//       var data = jsonDecode(response.body);
//
//
//       return singleAdvertisement_Model.fromJson(data);
//
//     }
//     return null;
//
//   }on TimeoutException catch (e) {
//   // _netWork_getxController.isTimeOut.value=true;
//   return null;
//
//
//   }
//   }

//   Future<comments_Model?> getCommentByID({required String ID}) async {
// try{
//
//   var response = await http.get(getUrl(ApiSettings.CommentByID+'$ID'),headers: header);
//
//     if (isSuccessRequest(response.statusCode)) {
//       var data = jsonDecode(response.body);
//
//
//       return comments_Model.fromJson(data);
//
//     }
//     return null;
//
//   }on TimeoutException catch (e) {
//   return null;
//
//
//   }
//   }


  Future<AucationsCategory_Model?> getCategories() async {
    try{

      var response = await http.get(getUrl(ApiSettings.get_advertisementCategories),headers: header);
      // var response = await http.get(getUrl(ApiSettings.get_advertisementCategories),headers: header).timeout(Duration(seconds: 10));

      if (isSuccessRequest(response.statusCode)) {
        var data = jsonDecode(response.body);



        return AucationsCategory_Model.fromJson(data);

      }
      return null;
    }on TimeoutException catch (e) {
      // _netWork_getxController.isTimeOut.value=true;
      return null;


    }

  }


//   Future<getCategory_featuresQ_Model?> getCategory_featuresQ({required String ID}) async {
//     try{
//       var response = await http.get(getUrl(ApiSettings.get_category_features+'$ID'),headers: header);
//       print('getCategory_featuresQ :: ${response.statusCode} ');
//
//       if (isSuccessRequest(response.statusCode)) {
//         var data = jsonDecode(response.body);
//
//
// print('getCategory_featuresQ :: $data ');
//         return getCategory_featuresQ_Model.fromJson(data);
//
//       }
//       return null;
//
//     }on TimeoutException catch (e) {
//       // _netWork_getxController.isTimeOut.value=true;
//       return null;
//
//
//     }
//
//   }


  // Future<singleAucationCategory_Model?> getCategoryBYID({ required String ID}) async {
  //   try{
  //     var response = await http.get(getUrl(ApiSettings.get_category_by_id+'$ID'),headers: header);
  //     // var response = await http.get(getUrl(ApiSettings.get_category_by_id+'$ID'),headers: header).timeout(Duration(seconds: 20));
  //
  //     if (isSuccessRequest(response.statusCode)) {
  //       var data = jsonDecode(response.body);
  //
  //
  //
  //       return singleAucationCategory_Model.fromJson(data);
  //
  //     }
  //     return null;
  //   }on TimeoutException catch (e) {
  //     return null;
  //
  //
  //   }
  // }


  Future<bool> AddNewAdvertisements({
    required String category_id,
    required String type_id,
    required String city_id,
    required String price,
    required String title,
    required String title_ar,
    required String description,
    required String description_ar,
    required String photo,
    required List<String?> photos,
    required List features,
    required String language,
})async{
  // try  {
      var request = http.MultipartRequest('POST', Uri.parse(ApiSettings.add_advertisement));
      // var request = http.MultipartRequest('POST', Uri.parse('http://admin.mazadistore.com/api/user/advertisements/add'));
      request.fields.addAll({
        'category_id': category_id,
        'type_id': type_id,
        'city_id': city_id,
        'title': title,
        'title_ar': title_ar,
        'description': description,
        'description_ar': description_ar,
        'price': price,
        'language': language
      });

      if (features.length > 0) {
        for (int i = 0; i < features.length; i++) {
          request.fields.addAll({
            'features[$i][key]': features[i]['key'],
            'features[$i][value]': features[i]['value'],
          });
        }
      }

      request.files.add(await http.MultipartFile.fromPath('photo', photo));



      if(photos.length>0){
      for(int i=0; i<photos.length;i++) {

        request.files.add(await http.MultipartFile.fromPath('photos[]', photos[i].toString()));
        print('${photos[i]!} ::${photos[i]!.runtimeType}');
      }
      }

      request.headers.addAll(header);
      http.StreamedResponse response = await request.send();

      // http.StreamedResponse response = await request.send().timeout(Duration(minutes: 2));
      if (response.statusCode < 400) {
        print(await response.stream.bytesToString());        print(response.reasonPhrase);

        return true;
      } else {
        print(await response.stream.bytesToString());

        print(response.reasonPhrase);
        return false;
      }
    // }on TimeoutException catch (e) {
    // return false;
    //
    //
    // }
  }


  Future<bool> EditAdvertisements({
    required String advID,
    required String category_id,
    required String type_id,
    required String city_id,
    required String price,
    required String title,
    required String title_ar,
    required String cover_image_id,
    required String description,
    required String description_ar,
    required String photo,
    required List<String?> photos,
    required List<String?> deleted_list,
    required List features,
    required String language,
})async{
    // try{

      var request = http.MultipartRequest(
          'POST',
          Uri.parse(ApiSettings.update_advertisements));
          // Uri.parse('http://admin.mazadistore.com/api/user/advertisements/update'));
      request.fields.addAll({
        'advertisement_id': advID,
        'category_id': category_id,
        'type_id': type_id,
        'city_id': city_id,
        'title': title,
        'title_ar': title_ar,
        'description': description,
        'description_ar': description_ar,
        'price': price,
        'cover_image_id': cover_image_id,
        'deleted_list': deleted_list.toString(),
        'language': language
      });

      if (features.length > 0) {
        for (int i = 0; i < features.length; i++) {
          request.fields.addAll({
            'features[$i][key]': features[i]['key'],
            'features[$i][value]': features[i]['value'],
          });
        }
      }
if(cover_image_id=='') {
  request.files.add(await http.MultipartFile.fromPath('photo', photo));
  print(photo);

}


      if(photos.length>0){
        for(int i=0; i<photos.length;i++) {

          request.files.add(await http.MultipartFile.fromPath('photos[]', photos[i].toString()));
          print('${photos[i]!} ::${photos[i]!.runtimeType}');
        }
      }


      request.headers.addAll(header);

      http.StreamedResponse response = await request.send();
      print(response.statusCode);
      if (response.statusCode < 400) {
        print(await response.stream.bytesToString());
        return true;
      } else {
        print(response.reasonPhrase);
        print(await response.stream.bytesToString());

        return false;
      }
    // }on TimeoutException catch (e) {
    //   // _netWork_getxController.isTimeOut.value=true;
    //   return false;
    //
    //
    // }
  }


  Future<bool> delete_Advertisement({
    required String ID,

  })async{
    try{
      var request = http.MultipartRequest('DELETE', getUrl(ApiSettings.delete_advertisement+'$ID'));

      request.headers.addAll(header);

      http.StreamedResponse response = await request.send();




      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        return true;
      }
      else {
        print(await response.stream.bytesToString());

      }

      return false;

    }on TimeoutException catch (e) {
      // _netWork_getxController.isTimeOut.value=true;
      return false;


    }


  }


  Future<bool> stop_active_advertisement({
    required String ID,
  })async{
    try{

      var request = http.MultipartRequest('PUT', getUrl(ApiSettings.stop_active_advertisement+'$ID'));

      request.headers.addAll(header);

      http.StreamedResponse response = await request.send();




      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        return true;
      }
      else {
        print(response.reasonPhrase);
      }

      return false;
    }on TimeoutException catch (e) {
      // _netWork_getxController.isTimeOut.value=true;
      return false;


    }


  }

  // Future addAdvertisementComment({
  //   required String Advertisement_ID,
  //   required String comment,
  //
  // })async{
  //   try{
  //     var request = http.MultipartRequest('POST', Uri.parse(ApiSettings.addAdvertisementComment+'${Advertisement_ID}'));
  //     request.fields.addAll({
  //       'comment': comment,
  //     });
  //
  //     request.headers.addAll(header);
  //     http.StreamedResponse response = await request.send();
  //     if (response.statusCode < 400) {
  //
  //       print(await response.stream.bytesToString());
  //
  //       return true;
  //     }
  //     else {
  //       print(response.reasonPhrase);
  //       return false;
  //
  //     }
  //
  //   }on TimeoutException catch (e) {
  //     // _netWork_getxController.isTimeOut.value=true;
  //     return false;
  //
  //
  //   }
  //
  //
  //
  // }

  Future<bool> updateAdvertisementComment({
    required String Advertisement_ID,
    required String comment,

  })async{
    try{
      var request = http.MultipartRequest('POST', Uri.parse(ApiSettings.update_CommentReplay+'${Advertisement_ID}'));
      // var request = http.MultipartRequest('POST', Uri.parse('http://admin.mazadistore.com/api/user/advertisement_comments/update/${Advertisement_ID}'));
      request.fields.addAll({
        'comment': comment,
      });

      request.headers.addAll(header);
      http.StreamedResponse response = await request.send();

      if (response.statusCode < 400) {
        print(await response.stream.bytesToString());
        return true;
      }
      else {
        print(response.reasonPhrase);
        return false;

      }

    }on TimeoutException catch (e) {
      // _netWork_getxController.isTimeOut.value=true;
      return false;


    }



  }

  Future<bool> deleteAdvertisementComment({
    required String Advertisement_ID,

  })async{
    try{
      var request = http.MultipartRequest('DELETE', Uri.parse(ApiSettings.delete_CommentReplay+'${Advertisement_ID}'));
      // var request = http.MultipartRequest('DELETE', Uri.parse('http://admin.mazadistore.com/api/user/advertisement_comments/delete/${Advertisement_ID}'));

      request.headers.addAll(header);
      http.StreamedResponse response = await request.send();
      if (response.statusCode < 400) {
        print(await response.stream.bytesToString());
        return true;
      }
      else {
        print(response.reasonPhrase);
        return false;

      }

    }on TimeoutException catch (e) {
      // _netWork_getxController.isTimeOut.value=true;
      return false;


    }



  }


  // Future<bool> addCommentReplay({
  //   required String comment_ID,
  //   required String Replay,
  //
  // })async{
  //   try{
  //     var request = http.MultipartRequest('POST', Uri.parse(ApiSettings.add_CommentReplay+'${comment_ID}'));
  //     // var request = http.MultipartRequest('POST', Uri.parse('http://admin.mazadistore.com/api/user/advertisement_comments_reply/add/${comment_ID}'));
  //     request.fields.addAll({
  //       'comment': Replay,
  //     });
  //
  //     request.headers.addAll(header);
  //     http.StreamedResponse response = await request.send();
  //     if (response.statusCode < 400) {
  //       print(await response.stream.bytesToString());
  //       return true;
  //     }
  //     else {
  //       print(response.reasonPhrase);
  //       return false;
  //
  //     }
  //
  //   }on TimeoutException catch (e) {
  //     // _netWork_getxController.isTimeOut.value=true;
  //     return false;
  //
  //
  //   }
  //
  //
  //
  // }
}