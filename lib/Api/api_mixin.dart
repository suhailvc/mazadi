import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../Database/SharedPreferences/shared_preferences.dart';
import '../Utils/Helper.dart';


class ApiMixin with Helper {

  Uri getUrl(String url) {
    return Uri.parse(url);
  }

  bool isSuccessRequest(int statusCode) {
    return statusCode < 400;
  }

  void handleServerError(context) {
    Helper.showSnackBar(context, text: 'هناك عطل بالخادم !', error: true);
  }

  void showMessage(context, Response response,
      {bool error = false}) {
    Helper.showSnackBar(
        context, text: jsonDecode(response.body)['message'], error: error);
  }

  Map<String, String> get header {
    return {
      // HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      // OSAMA Token
      // 'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNGU4NmE4MjZhYmRiODZiYzQ4OTdlNzNmNGZmMmMwYmY3NTZhZWRmYTE0ZjA2ODE4MDI5ZjUxNDAyNDRmZjgwZmE3MTE1NWZjYTgzYjBiZTgiLCJpYXQiOjE2NjQ5OTc5NzUuODIzNTE3LCJuYmYiOjE2NjQ5OTc5NzUuODIzNTIxLCJleHAiOjE2OTY1MzM5NzUuODE1Nzc4LCJzdWIiOiI4Iiwic2NvcGVzIjpbXX0.Xn-lL23Z4c5G0NCm27CVGkLYwqiBUP_USc1mKK9i7Ig8hv9G2OxLfOw5BJjY0_lX34HummQxTUI5VhsXyDr-2EjiRbvDF_SiZRZlEwkpZYPduFqtlpIM1ExbhfBEeSHwY3MOe03z_UhnbbGGA184luutyMWZ7B32TroC6i4kDLFfETp7zxfDzFY-u7jJuyNmUJ8pAeOP27HlOEkw3YtOJKaQn78rfkcDNpp7NyKq5TZEO1sRAVBQBJFT0103nOJKqGnbJDzqJj0ol2Ezzj2CKJBED3sEmPVLCI2xP8HVWpKNtDQ55J2uv7NyHgyQkBmqHmUKU2-a19caV_CFm2xUY_oP0GPiwEG9RdRAF9Iy8XmK,
      // Sharef Token

      // 'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMGZhZmM4YmFiY2QxNjFiMTJlMjg3MGQ2YWM4NTJlYzk5YzQxYzAyNjUzZDY2YWYyNTg4MjljNWIzNmVjY2U3NmI1NTc0ZDYzYjZmZjJhMWQiLCJpYXQiOjE2NjM1Mjc4NDQuMjkzMTIxLCJuYmYiOjE2NjM1Mjc4NDQuMjkzMTI1LCJleHAiOjE2OTUwNjM4NDQuMjg3MjIyLCJzdWIiOiI3Iiwic2NvcGVzIjpbXX0.izRd_zrjChZ3lxsnSdad-lsk0_CjPBf90AAslHkZwBzx74qcDQ6Zob3ZIkLVoMG4UKKksETV2HJuNjfsSemx7lMoZOYrtnVcjAZtqZ5ttlvoyjR8aoyVyhabbrXeEjrD0T7r_q9BEvgVOdpLr9tlVq9odwKjPtHiL2XeUW3HZEGU5hylHZY4yVoWmWGTPdzNCi1E6tBCQqqAW-A6CVQlwd7y6_SvtxCV4RyUDqZTEfMHHhKdWHkkEWwofUKGtspj66qKmVIkoE3QyDpVdkmD_EayABdbr248qnnhY54s01z8UII30Q9vJy26AnFoukCS_KyXoXSXOXvuazKxJVdRPxVmy85OfrdWY4E83rORIRuNJszz1iYjqVIoMewz5-czatW64hFhRAfCeiWaPzUypQy8I9lJaIwkjKtIO4GeXji6_maszWf-wWn7HgO7_2_nFcZvuJSAAZ4DkNUodcthdnlyb1IYtt7VdEy4QNhulv7DJnVro45EECxZUqZAo2Zu5d0AfTYrdOotP3_lphivD7bBxBayytCuu3TwyJXe7Ws3cIPdneDtKC0nT5dZigoHtYFNOcP8F3agdOBorvYaIkwbEpHBpKDypJqzx6q7jSrkVi_QQtO5yaAM-8xKyeM-I5nsrd6nn2DVddgoFkzfwTcwYvCPB72nYifwfTPXUlY',
      'Authorization': SharedPreferencesController().getToken,

      'X-Requested-With': 'XMLHttpRequest',

    };
  }

  //
  // Map<String, String> get testHeder {
  //   return {
  //     HttpHeaders.authorizationHeader:
  //     'Bearer bcfb0889-6899-438c-b34d-ea13d29c167f',
  //     'X-Requested-With': 'XMLHttpRequest',
  //   };
  // }



  Map<String, String> get baseHeader {
    return {
      'X-Requested-With': 'XMLHttpRequest',
    };
  }


  // void handleUnauthorisedRequest() {
  //   Get.offAll(LoginScreen());
  //   AuthGetxController.to.lo
  //   SharedPreferencesController().logout();
  // }


}
