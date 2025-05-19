import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mazzad/Api/api_settings.dart';

import '../Database/SharedPreferences/shared_preferences.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: ApiSettings.baseUrl,
          receiveDataWhenStatusError: true,
          /*connectTimeout: ,*/
          validateStatus: (_) => true),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    //String lang = 'en',
  }) async {
    dio!.options.headers = {
      // 'lang':SharedPreferencesController().languageCode,
      'Authorization': SharedPreferencesController().getToken,
      'Content-Type': 'application/json',
    };

    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    var data,
    var onSendProgress,
    Map<String, dynamic>? query,
  }) async {
    dio!.options.headers = {
      // 'lang':SharedPreferencesController().languageCode,
      'Authorization': SharedPreferencesController().getToken,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    return dio!.post(
      url,
      queryParameters: query,
      data: data,
      onSendProgress: onSendProgress,
    );
  }



  static Future<Response> putData({
    required String url,
    var data,
    var onSendProgress,
    Map<String, dynamic>? query,
  }) async {
    dio!.options.headers = {
      // 'lang':SharedPreferencesController().languageCode,
      'Authorization': SharedPreferencesController().getToken,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    return dio!.put(
      url,
      queryParameters: query,
      data: data,
      onSendProgress: onSendProgress,
    );
  }


  static Future<Response> deleteData({
    required String url,
    var data,
    var onSendProgress,
    Map<String, dynamic>? query,
  }) async {
    dio!.options.headers = {
      // 'lang':SharedPreferencesController().languageCode,
      'Authorization': SharedPreferencesController().getToken,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    return dio!.delete(
      url,
      queryParameters: query,
      data: data,
    );
  }


// static Future<Response> uploadData({
  //   var onSendProgress,
  //   String? attachmentCategory,
  //   String? attachmentType,
  //   required String attachmentName,
  //   required String attachmentPath,
  //   //String lang = 'en',
  // }) async {
  //   FormData formData = FormData.fromMap({
  //     'category': attachmentCategory,
  //     'type': attachmentType,
  //     'name': attachmentName,
  //     'image': await MultipartFile.fromFile(attachmentPath,
  //         filename: attachmentName)
  //   });
  //
  //   dio!.options.headers = {
  //     'lang':SharedPreferencesController().languageCode,
  //     'Authorization': SharedPreferencesController().getToken,
  //     'Content-Type': 'application/json',
  //     'Content-Type': 'multipart/form-data',
  //     'Accept': 'application/json',
  //     'Accept': '*/*',
  //   };
  //   return dio!.post(
  //     ApiSettings.add_attachment,
  //     data: formData,
  //     onSendProgress: onSendProgress,
  //   );
  // }
}
