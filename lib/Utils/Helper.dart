import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mazzad/Utils/asset_images.dart';
import 'package:url_launcher/url_launcher.dart';

import 'AppColors.dart';
import 'CustomText.dart';

class Helper {
  static void showSnackBar(
    BuildContext context, {
    required String text,
    bool error = false,
    Color color = AppColors.main_color,
    String? actionTitle,
    Function()? onPressed,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AppText(
          text: text,
        ),
        // width: 300,
        backgroundColor:error? AppColors.red : color,
        behavior: SnackBarBehavior.floating,
        margin:  EdgeInsets.only(right: 50, bottom: (Get.height!)-100, left: 50),
        elevation: 5,
        dismissDirection: DismissDirection.horizontal,
        duration: const Duration(milliseconds: 3000),
        action: actionTitle != null
            ? SnackBarAction(
                onPressed: onPressed ?? () {},
                label: actionTitle,
                textColor: Colors.yellow,
              )
            : null,
        onVisible: () {},
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomRight: Radius.circular(5),
                bottomLeft: Radius.circular(5))),
        // padding: EdgeInsets.all(15),
      ),
    );
  }

  Future show_Dialog({
    required BuildContext context,
    required String title,
    required String img,
    required String subTitle,
  }) async {
    await showDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Color(0xff242424).withOpacity(0.5),
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                width: 314.w,
                constraints: BoxConstraints(
                  maxHeight: 550.h,
                  minHeight: 314.h
                ),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Stack(
                      children: [
                        Image.asset(
                          AppImages.win,
                          color: Colors.white.withOpacity(0.3),
                          colorBlendMode: BlendMode.modulate,
                        ),
                        Positioned(
                            bottom: 45.h,
                            right: 70.w,
                            left: 70.w,
                            child: Image.asset(
                              img,
                              height: 128.h,
                              width: 128.w,
                            )),
                      ],
                    ),
                    Text(
                      title,
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black_color),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        subTitle,
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black_color),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  Future<bool> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      return true;
    }
    return true;
  }

  static double childAspectRatio(double ratio) {
    return MediaQuery.of(Get.context!).size.width / (MediaQuery.of(Get.context!).size.height / ratio);
  }


  Future show_SuccessDialog({
    required BuildContext context,
    bool isAuction =false,

  }) async {

    await showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Color(0xff242424).withOpacity(0.5),
        builder: (context) {
          Future.delayed(
            Duration(seconds: 3),
                () {
              Navigator.of(context).pop(true);
            },
          );
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              child:  Container(
                width: 314.w,
                constraints: BoxConstraints(
                  minHeight: 340.h,
                  maxHeight: 550.h
                ),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(15)

                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Stack(
                      children: [
                        Image.asset(AppImages.win, color: Colors.white.withOpacity(0.3), colorBlendMode: BlendMode.modulate,),
                        Positioned(
                            bottom: 25.h,
                            right: 65.w,
                            child: Image.asset(AppImages.advSucces,)),
                      ],
                    ),


                    Text(
                      isAuction?
                      'Your Aucation has been published successfully'.tr
                      : 'Your ad has been published successfully'.tr

                      ,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Cairo',

                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black_color),
                    ),
                    Text(
                      'Please wait until the announcement is reviewed '.tr,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Cairo',

                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black_color),
                    ),



                  ],
                ),

              ),

            );
          });
        });
  }

  void send_Whatsapp({
    required String phoneNum,
    required String massege,
  }) async {
    if (phoneNum.startsWith('00')) phoneNum = '+' + phoneNum.split('00').last;
    String url = "whatsapp://send?phone='$phoneNum'&text=$massege";
    await launchUrl(Uri.parse(url));
  }

  static openDialoge(context, {required Function() onTap,title,String subTitle= ''}) {
    Get.defaultDialog(
      title: title,

      titleStyle: Theme.of(context).textTheme.titleMedium,
      content: Column(
        children: [
       if(subTitle!='')   Text(
            subTitle,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Cairo',

                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.black_color),
          ),
          SizedBox(
            height: 45.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: onTap,
                  child: Text(
                    'yes'.tr,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                VerticalDivider(),
                SizedBox(
                  width: 15.w,
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    'no'.tr,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      radius: 10,
      titlePadding: EdgeInsets.all(15),
    );
  }

  static String formatDuration(Duration d) {
    var seconds = d.inSeconds;
    final days = seconds ~/ Duration.secondsPerDay;
    seconds -= days * Duration.secondsPerDay;
    final hours = seconds ~/ Duration.secondsPerHour;
    seconds -= hours * Duration.secondsPerHour;
    final minutes = seconds ~/ Duration.secondsPerMinute;
    seconds -= minutes * Duration.secondsPerMinute;

    final List<String> tokens = [];
    if (days != 0) {
      tokens.add('${days}d');
    }
    if (tokens.isNotEmpty || hours != 0) {
      tokens.add('${hours}h');
    }
    if (tokens.isNotEmpty || minutes != 0) {
      tokens.add('${minutes}m');
    }
    tokens.add('${seconds}s');

    return tokens.join('-');
  }



}
