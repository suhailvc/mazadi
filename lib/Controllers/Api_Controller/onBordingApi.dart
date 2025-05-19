import 'dart:convert';

import '../../Api/api_mixin.dart';
import '../../Api/api_settings.dart';
import '../../Models/boardings_Model.dart';
import 'package:http/http.dart' as http;

class onBoarding_Api_Controller extends ApiMixin {
  boardings_Model _boardings_model = boardings_Model();

  Future<boardings_Model?> getData() async {

    var response = await http.get(
      getUrl(ApiSettings.get_boardings),
    );

    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body);
      return boardings_Model.fromJson(data);
    }
    return null;
  }
}
