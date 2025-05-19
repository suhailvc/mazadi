import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../Controllers/GetxController/AdvertisementsController.dart';
import '../Controllers/GetxController/homeController.dart';
import '../Controllers/GetxController/profileController.dart';
import '../Models/singleAdvertisement_Model.dart';
import '../Models/singleAucations_Model.dart';
import '../Screens/BN_Screens/Aucations/mySingleAucation_Screen.dart';
import '../Screens/BN_Screens/Aucations/singleAucation_Screen.dart';
import '../Screens/BN_Screens/advertise/MyAdvertisement_Screen.dart';
import '../Screens/BN_Screens/advertise/singleAdvertisement_Screen.dart';

var _profile_getxController = Get.find<profile_GetxController>();
var _home_getxController = Get.find<home_GetxController>();
Advertisements_GetxController _advertisements_getxController =
    Get.put(Advertisements_GetxController());

class DynamicLinksService {
  static Future<String> createDynamicLink({
    required String parameter,
    required String type,
  }) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String uriPrefix = "https://Mazadi.page.link";

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: uriPrefix,
      link: Uri.parse('https://Mazadi.com/$type/$parameter'),
      androidParameters: AndroidParameters(
        packageName: packageInfo.packageName,
        minimumVersion: 0,
      ),
      iosParameters: IOSParameters(
        bundleId: packageInfo.packageName,
        minimumVersion: packageInfo.version,
        appStoreId: '123456789',
      ),
      /*
      googleAnalyticsParameters: GoogleAnalyticsParameters(
        campaign: 'example-promo',
        medium: 'social',
        source: 'orkut',
      ),
      itunesConnectAnalyticsParameters: ItunesConnectAnalyticsParameters(
        providerToken: '123456',
        campaignToken: 'example-promo',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
          title: 'Example of a Dynamic Link',
          description: 'This link works whether app is installed or not!',
          imageUrl: Uri.parse(
              "https://images.pexels.com/photos/3841338/pexels-photo-3841338.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260")),


       */
    );

    // final Uri dynamicUrl = await parameters.buildUrl();
    final ShortDynamicLink shortLink =
    await FirebaseDynamicLinks.instance.buildShortLink(
      parameters,
    );
    // final ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();
    // final Uri shortUrl = shortDynamicLink.shortUrl;
    return shortLink.shortUrl.toString();
  }

  static void initDynamicLinks() async {
    print('Hello Dynamic ');
    final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();


    FirebaseDynamicLinks.instance.onLink.listen((dynamicLink) {
      _handleDynamicLink(dynamicLink!);
    });
  }

  static _handleDynamicLink(PendingDynamicLinkData? data) async {
    final Uri deepLink = data!.link;

    if (deepLink == null) {
      return;
    }

    if (deepLink.pathSegments.contains('Aucation')) {
      singleAucations_Model? singleAucation = await _home_getxController
          .getAucationByID(ID: deepLink.path.split('/').last);

      if (singleAucation != null) {
        if (singleAucation.data.user!.userId ==
            _profile_getxController.profile_model!.data.userId) {
          Get.to(mySingleAucation_Screen(aucations_model: singleAucation));
        } else {
          await Get.to(singleAucation_Screen(aucations_model: singleAucation));
        }
      }
    } else if (deepLink.pathSegments.contains('Advertisment')) {
      singleAdvertisement_Model? adv = await _advertisements_getxController
          .getAdvertisementByID(ID: deepLink.path.split('/').last,context: null);

      if (adv != null) {
        _advertisements_getxController.getCommentByID(
            ID: deepLink.path.split('/').last);
        if (adv.data.user!.userId ==
            _profile_getxController.profile_model!.data.userId) {
          Get.to(MyAdvertisement_Screen(adv_model: adv));
        } else {
          Get.to(singleAdvertisement_Screen(adv_model: adv));
        }
      }
    }
  }
}
