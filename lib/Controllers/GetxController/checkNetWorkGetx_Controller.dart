import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mazzad/Utils/Helper.dart';

class checkNetWorkGetx_Controller extends GetxController with Helper{
  var connectionType = 0.obs;
  //0 = No Internet, 1 = WIFI Connected ,2 = Mobile Data Connected.

  RxBool isTimeOut=false.obs;
  RxBool isTimeOutPage=false.obs;
  final Connectivity _connectivity = Connectivity();

  // late StreamSubscription _streamSubscription;

  @override
  void onInit() {
    super.onInit();
    getConnectivityType();
    // _streamSubscription = _connectivity.onConnectivityChanged.listen((status){
    //
    //   if(status==ConnectivityResult.wifi || status==ConnectivityResult.mobile  ){
    //     print('-------Internet--------');
    //     // Helper.showSnackBar(Get.context!, text: 'تم الاتصال بالانترنت مجدداً',);
    //
    //   }else{
    //     print('-------No Internet--------');
    //     Helper.showSnackBar(Get.context!, text: 'تأكد من اتصالك بالانترنت !',error: true);
    //
    //   }
    //
    //   print('-------getConnectivityType--------');
    //
    //   print(status);
    //       print('-------------------');
    //     });
  }

  Future<void> getConnectivityType() async {
    late ConnectivityResult connectivityResult;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return _updateState(connectivityResult);
  }

  _updateState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionType.value = 1;
        break;
      case ConnectivityResult.mobile:
        connectionType.value = 2;

        break;
      case ConnectivityResult.none:
        connectionType.value = 0;
        break;
      default:

        break;
    }
  }


  @override
  void onClose() {
    // _streamSubscription.cancel();
  }
}
