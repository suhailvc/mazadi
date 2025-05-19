

import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mazzad/firebase/fb_notifications.dart';

import '../Database/SQL/db_controller.dart';
import '../Database/SharedPreferences/shared_preferences.dart';
import '../firebase/firebase_dynamic_links.dart';

class SettingServices extends GetxService{



  Future<SettingServices> init() async{
    // await MobileAds.instance.initialize();

    // await DbController().initDatabase();
    await Firebase.initializeApp();
    await FbNotifications.initNotifications();
    FbNotifications.initializeForegroundNotificationForAndroid();
    FbNotifications.requestNotificationPermissions();
    await SharedPreferencesController().initSharedPreference();
    DynamicLinksService.initDynamicLinks();
    //
    // SecurityContext context = SecurityContext();
    // context.setTrustedCertificatesBytes(certBytes);
    //
    // HttpClient httpClient = HttpClient(context: context);
    // httpClient.badCertificateCallback =
    // ((X509Certificate cert, String host, int port) => true);



    return this;
  }

}