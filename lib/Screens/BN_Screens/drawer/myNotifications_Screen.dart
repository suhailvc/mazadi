import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../Controllers/GetxController/AdvertisementsController.dart';
import '../../../Controllers/GetxController/homeController.dart';
import '../../../Controllers/GetxController/profileController.dart';
import '../../../Models/singleAdvertisement_Model.dart';
import '../../../Models/singleAucations_Model.dart';
import '../../../Utils/AppColors.dart';
import '../../../Utils/Helper.dart';
import '../../../Utils/asset_images.dart';
import '../../../Utils/customElevatedButton.dart';
import '../Aucations/mySingleAucation_Screen.dart';
import '../Aucations/singleAucation_Screen.dart';
import '../advertise/MyAdvertisement_Screen.dart';
import '../advertise/singleAdvertisement_Screen.dart';
import '../home/home_Screen.dart';

class myNotifications_Screen extends StatefulWidget {
  const myNotifications_Screen({Key? key}) : super(key: key);

  @override
  State<myNotifications_Screen> createState() => _myNotifications_ScreenState();
}

class _myNotifications_ScreenState extends State<myNotifications_Screen> {
  // var _auth_getxController = Get.find<Auth_GetxController>();
  var _profile_getxController = Get.find<profile_GetxController>();
  var _home_getxController = Get.find<home_GetxController>();
  var _adv_getxController = Get.find<Advertisements_GetxController>();

  bool isAdvertise = true;

  String commentTime(String time) {
    DateTime now = DateTime.now();
    DateTime dt1 = DateTime.parse(time);
    Duration diff = now.difference(dt1);

    if (diff.inDays > 0) {
      return 'since'.tr + diff.inDays.toString() + 'day'.tr;
    } else if (diff.inHours > 0) {
      return 'since'.tr + diff.inHours.toString() + 'hour'.tr;
    } else {
      return 'since'.tr + diff.inMinutes.toString() + 'minute'.tr;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      onRefresh: () async {
        await _profile_getxController.get_myNotifications();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0.2,
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: AppColors.darkgray_color),
              onPressed: () {
                Get.back();
              }),
          title: Text(
            'Notifications'.tr,
            style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black_color),
          ),
          actions: [
            GetBuilder<profile_GetxController>(
                builder: (profile_GetxController controller) {
              return controller.myNotifications!.data!.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        Helper.openDialoge(context, onTap: () {
                          controller..deleteAllNotification(context);
                        }, title: 'هل انت متأكد من حذف الاشعارات!');
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ))
                  : IconButton(
                      onPressed: () {
                        _profile_getxController.get_myNotifications();
                      },
                      icon: Icon(
                        Icons.refresh,
                        color: Colors.black,
                      ));
            }),
          ],
        ),
        body: Padding(
          padding:
              EdgeInsets.only(top: 35.h, left: 10.w, right: 10.w, bottom: 10.h),
          child: GetX<profile_GetxController>(
              builder: (profile_GetxController controller) {
            return (controller.isLoadingMyNotifications.isTrue)
                ? Center(
                    child: Container(
                      height: 60.h,
                      width: 60.w,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.main_color),
                      child: LoadingAnimationWidget.fourRotatingDots(
                        color: AppColors.white,
                        size: 40,
                      ),
                    ),
                  )
                : controller.myNotifications != null
                    ? controller.myNotifications!.data!.isNotEmpty
                        ? GetBuilder<profile_GetxController>(
                            builder: (profile_GetxController controller) {
                            return ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                // itemCount: 10,
                                itemCount:
                                    controller.myNotifications!.data!.length,
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 14.h,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () async {
                                      if (controller.myNotifications!
                                              .data![index].advertisement_id !=
                                          null) {
                                        if (await Helper().checkInternet()) {
                                          singleAdvertisement_Model? adv =
                                              await _adv_getxController
                                                  .getAdvertisementByID(
                                                      context: context,
                                                      ID: controller
                                                          .myNotifications!
                                                          .data![index]
                                                          .advertisement_id!);

                                          if (adv != null) {
                                            _adv_getxController.getCommentByID(
                                                ID: controller
                                                    .myNotifications!
                                                    .data![index]
                                                    .advertisement_id!);
                                            if (adv.data.user!.userId ==
                                                _profile_getxController
                                                    .profile_model!
                                                    .data
                                                    .userId) {
                                              Get.to(MyAdvertisement_Screen(
                                                  adv_model: adv));
                                            } else {
                                              Get.to(singleAdvertisement_Screen(
                                                  adv_model: adv));
                                            }
                                          } else {}
                                        } else {
                                          Helper().show_Dialog(
                                              context: context,
                                              title: 'No Internet'.tr,
                                              img: AppImages.no_internet,
                                              subTitle: 'Try Again'.tr);
                                        }
                                      } else if (controller.myNotifications!
                                              .data![index].auction_id !=
                                          null) {
                                        singleAucations_Model? singleAucation =
                                            await _home_getxController
                                                .getAucationByID(
                                                    context: context,
                                                    ID: controller
                                                        .myNotifications!
                                                        .data![index]
                                                        .auction_id!);

                                        if (singleAucation != null) {
                                          if (singleAucation.data.user!.id ==
                                              _profile_getxController
                                                  .profile_model!.data.userId) {
                                            Get.to(mySingleAucation_Screen(
                                                aucations_model:
                                                    singleAucation));
                                          } else {
                                            await Get.to(singleAucation_Screen(
                                                aucations_model:
                                                    singleAucation));
                                          }
                                        }
                                      }
                                    },
                                    child: Container(
                                      width: width,
                                      decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8.h, horizontal: 15.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                controller
                                                    .myNotifications!
                                                    .data![index]
                                                    .data![0]
                                                    .title,
                                                style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        AppColors.black_color),
                                              ),
                                              Spacer(),
                                              Text(
                                                controller.myNotifications!
                                                    .data![index].time!,
                                                style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        AppColors.black_color),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            controller.myNotifications!
                                                .data![index].data![0].body,
                                            style: TextStyle(
                                                fontFamily: 'Cairo',
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.black_color),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          })
                        : Center(
                            child: Text(
                              'noNotificationYet'.tr,
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black_color),
                            ),
                          )
                    : Center(
                        child: Text(
                          'noNotificationYet'.tr,
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black_color),
                        ),
                      );
          }),
        ),
      ),
    );
  }
}
