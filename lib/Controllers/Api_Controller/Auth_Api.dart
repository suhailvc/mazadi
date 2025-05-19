

import 'dart:convert';

import '../../Api/api_mixin.dart';
import 'package:http/http.dart' as http;

import '../../Api/api_settings.dart';
import '../../Models/login_Model.dart';
import '../../Models/mobile_OTPCode_Model.dart';
import '../../Models/registerError_Model.dart';

class Auth_Api_Controller extends ApiMixin {

  Future<mobile_OTPCode_Model?> get_OTPCode({required String mobile}) async {
    var headers = {
      'Accept': 'application/json'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiSettings.get_code));
    // var request = http.MultipartRequest('POST', Uri.parse('http://admin.mazadistore.com/api/user/get_code'));


    request.fields.addAll({
      'mobile': mobile
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var data = jsonDecode(await response.stream.bytesToString());


    return mobile_OTPCode_Model.fromJson(data);

  }

  Future<login_Model?> Login({required String mobile,required String verify_mobile_code,required String fcm_token,}) async {
    var headers = {
      'Accept': 'application/json'
    };
    // var request = http.MultipartRequest('POST', Uri.parse('http://admin.mazadistore.com/api/user/login'));
    var request = http.MultipartRequest('POST', Uri.parse(ApiSettings.login));
    request.fields.addAll({
      'mobile': mobile,
      'fcm_token': fcm_token,

      'verify_mobile_code': verify_mobile_code
    });

    request.headers.addAll(headers);


    http.StreamedResponse response = await request.send();

    var data = jsonDecode(await response.stream.bytesToString());
    var data2 = login_Model.fromJson(data);


    return login_Model.fromJson(data);

  }


  Future<bool> logout() async {

    var response = await http.get(getUrl(ApiSettings.logout),headers: header);

    if (isSuccessRequest(response.statusCode)) {
      return true;
    }
    return false;
  }


  Future<registerError_Model> SignUp({required String name,required String mobile,required String email,
    required String verify_mobile_code,required String fcm_token,required String address,required String city_id,required String district,}) async {

    var request = http.MultipartRequest('POST', Uri.parse(ApiSettings.register));
    // var request = http.MultipartRequest('POST', Uri.parse('http://admin.mazadistore.com/api/user/register'));
    request.fields.addAll({
      'name': name,
      'mobile': mobile,
      'email': email,
      'fcm_token': fcm_token,
      'verify_mobile_code': verify_mobile_code,
      'address': address,
      'city_id': city_id,
      'whatsapp': mobile,
      'district': district
    });


    http.StreamedResponse response = await request.send();
    print(response.statusCode);

      var data =await jsonDecode(await response.stream.bytesToString());
      print(data);
      return   registerError_Model.fromJson(data);

  }





}