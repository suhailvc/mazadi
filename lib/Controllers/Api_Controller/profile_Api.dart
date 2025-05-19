import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mazzad/Models/blockAuction_Model.dart';

import '../../Api/api_mixin.dart';
import '../../Api/api_settings.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../Api/dio_helper.dart';
import '../../Models/Notifications_Model.dart';
import '../../Models/card_Model.dart';
import '../../Models/addBalance_Model.dart';
import '../../Models/myAddress_Model.dart';
import '../../Models/myAdvertisement_wishlists_Model.dart';
import '../../Models/myAdvertisements_Model.dart';
import '../../Models/myAuctions_wishlists_Model.dart';
import '../../Models/myTransactions_Model.dart';
import '../../Models/myWallet_Model.dart';
import '../../Models/profile_Model.dart';
import '../../Models/singleAdvertisement_Model.dart';

class profile_Api_Controller extends ApiMixin {
  Future<profile_Model?> get_profile() async {
    var response =
        await http.get(getUrl(ApiSettings.get_profile), headers: header);

    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body);

      return profile_Model.fromJson(data);
    }

    return null;
  }

  Future<bool> update_profile({
    required String name,
    required String mobile,
    required String email,
    required String city_id,
    required String address,
    required String whatsapp,
  }) async {
    var request = http.Request('PUT', getUrl(ApiSettings.update_profile));
    request.bodyFields = {
      'name': name,
      'mobile': mobile,
      'email': email,
      'city_id': city_id,
      'address': address,
      'whatsapp': whatsapp
    };
    request.headers.addAll(header);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;

    }
  }

  Future update_photo({
    required File file,
  }) async {
    var dio = Dio();

    FormData formData = FormData.fromMap({
      'photo': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
        contentType: MediaType('image', 'png'),
      ),
    });
    DioHelper.postData(url: ApiSettings.update_photo,data: formData).then((value) {
print(value.statusCode);
print(value.data);
    });
    //
    // var response = await dio.post(ApiSettings.update_photo,
    //     data: formData, options: Options(headers: header));
  }

  Future<myAddress_Model?> get_myAddress() async {
    var response =
        await http.get(getUrl(ApiSettings.get_my_address), headers: header);

    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body);

      return myAddress_Model.fromJson(data);
    }

    return null;
  }

  Future add_address({
    required String name,
    required String mobile,
    required String district,
    required String city_id,
    required String address,
  }) async {
    var headers = header;
    var request = http.Request('POST', getUrl(ApiSettings.add_address));
    request.bodyFields = {
      'name': name,
      'address': address,
      'mobile': mobile,
      'district': district,
      'city_id': city_id,
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode < 400) {
    } else {}
  }

  Future<addBalance_model?> add_balance({
    required String amount,
  }) async {
    return DioHelper.postData(
            url: ApiSettings.add_balance, data: {'card_code': amount})
        .then((value) {
          return addBalance_model.fromJson(value.data);
        });
  }

  Future delete_address({
    required String addressID,
  }) async {
    var headers = header;
    var request = http.Request(
        'DELETE',
        Uri.parse(ApiSettings.delete_address+'$addressID'));
        // Uri.parse('http://admin.mazadistore.com/api/user/address/delete_address/$addressID'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
    } else {}
  }

  Future<myWallet_Model?> get_MyBalance() async {
    var response =
        await http.get(getUrl(ApiSettings.my_balance), headers: header);

    print(response.statusCode);
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body);
      ;
      return myWallet_Model.fromJson(data);
    }

    return null;
  }

  Future<blockAuction_Model?> get_blockAuction() async {
    var response =
        await http.get(getUrl(ApiSettings.block_auction), headers: header);

    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body);

      return blockAuction_Model.fromJson(data);
    }

    return null;
  }

  Future<myTransactions_Model?> get_MyTransactions() async {
    var response =
        await http.get(getUrl(ApiSettings.my_transactions), headers: header);

    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body);

      return myTransactions_Model.fromJson(data);
    }

    return null;
  }

  Future<myAdvertisement_wishlists_Model?>
      get_my_advertisement_wishlists() async {
    var response = await http.get(
        getUrl(ApiSettings.get_my_advertisement_wishlists),
        headers: header);
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body);
      return myAdvertisement_wishlists_Model.fromJson(data);
    }

    return null;
  }

  Future<myAuctions_wishlists_Model?> get_my_auction_wishlists() async {
    var response = await http.get(getUrl(ApiSettings.get_my_auction_wishlists),
        headers: header);
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body);
      return myAuctions_wishlists_Model.fromJson(data);
    }

    return null;
  }

  Future add_contact({
    required String name,
    required String mobile,
    required String title,
    String fcm_token = '',
    required String message,
  }) async {
    var headers = header;

    var request =
        http.MultipartRequest('POST', getUrl(ApiSettings.add_contact));
    request.fields.addAll({
      'name': name,
      'mobile': mobile,
      'title': title,
      'message': message,
      'fcm_token': fcm_token
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode < 400) {
      return true;
    } else {
      return false;
    }
  }

  Future<Notifications_Model?> get_MyNotifications() async {
    var response =
        await http.get(getUrl(ApiSettings.my_notification), headers: header);

    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body);
      return Notifications_Model.fromJson(data);
    }

    return null;
  }
}
