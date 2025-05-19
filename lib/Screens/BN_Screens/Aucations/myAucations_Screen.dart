import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mazzad/Controllers/GetxController/profileController.dart';
import 'package:mazzad/Database/SharedPreferences/shared_preferences.dart';
import 'package:mazzad/Screens/BN_Screens/Aucations/singleAucation_Screen.dart';
import 'package:mazzad/Utils/Helper.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Controllers/GetxController/AucationsController.dart';
import '../../../Controllers/GetxController/homeController.dart';
import '../../../Models/singleAucations_Model.dart';
import '../../../Utils/AppColors.dart';
import '../../../Utils/asset_images.dart';
import '../../../Utils/customElevatedButton.dart';
import '../../../firebase/firebase_dynamic_links.dart';
import '../home/home_Screen.dart';
import '../home/widget/lastAucations.dart';
import '../newAdvertise/chooseAdvType_Screen.dart';
import 'myBids_Screen.dart';
import 'mySingleAucation_Screen.dart';
import 'dart:ui' as UI;

class myAucations_Screen extends StatefulWidget {
  const myAucations_Screen({Key? key}) : super(key: key);

  @override
  State<myAucations_Screen> createState() => _myAucations_ScreenState();
}

class _myAucations_ScreenState extends State<myAucations_Screen> {
  bool isWaitingsAucations = true;
  bool isActiveAucations = false;
  bool isEndedAucations = false;
  bool isCompletedAucations = false;
  bool isCanceldAucations = false;

  // var  _home_getxController = Get.find<home_GetxController>();
  var _aucations_getxController = Get.find<Aucations_GetxController>();
  var _home_getxController = Get.find<home_GetxController>();
  var _profile_getxController = Get.find<profile_GetxController>();
  Duration diff = Duration();
  DateTime now = DateTime.now();
  UI.TextDirection direction = UI.TextDirection.ltr;




  late ScrollController scrollController ;


  Future scrollListen() async {

    scrollController.addListener(() async {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent) {
        if(isWaitingsAucations == true){
          _aucations_getxController.getMyWaitingAuctions(is_Pagination: true);

        }else if(isActiveAucations == true){
          _aucations_getxController.getMyActiveAuctions(is_Pagination: true);

        }else if(isCompletedAucations == true){
          _aucations_getxController.getMyCompletedAuctions(is_Pagination: true);

        }else if(isCanceldAucations == true){
          _aucations_getxController.getMyCanceldAuctions(is_Pagination: true);

        }else if(isEndedAucations == true){
          _aucations_getxController.getMyEndedAuctions(is_Pagination: true);

        }

      }
    });




  }
  @override
  void initState() {
    super.initState();
    scrollController= ScrollController();

    scrollListen();

  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }





  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background_color,
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
          'My Aucations'.tr,
          style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black_color),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 25.h, right: 10.w, left: 10.w),
            child: RefreshIndicator(
              onRefresh: () async {

                if(isWaitingsAucations == true){
                  _aucations_getxController.getMyWaitingAuctions();

                }else if(isActiveAucations == true){
                  _aucations_getxController.getMyActiveAuctions();

                }else if(isCompletedAucations == true){
                  _aucations_getxController.getMyCompletedAuctions();

                }else if(isCanceldAucations == true){
                  _aucations_getxController.getMyCanceldAuctions();

                }else if(isEndedAucations == true){
                  _aucations_getxController.getMyEndedAuctions();

                }



              },
              child: SingleChildScrollView(
                controller: scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60.h,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  isWaitingsAucations = true;
                                  isEndedAucations = false;
                                  isCompletedAucations = false;
                                  isCanceldAucations = false;
                                  isActiveAucations = false;

                                  setState(() {});
                                },
                                child: Container(
                                  height: 60.h,
                                  width: 150.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: isWaitingsAucations
                                          ? AppColors.main_color
                                          : AppColors.white),
                                  child: Center(
                                    child: Text(
                                      'waiting'.tr,
                                      style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                          color: isWaitingsAucations
                                              ? AppColors.white
                                              : AppColors.gray_color),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  isActiveAucations = true;

                                  isWaitingsAucations = false;
                                  isEndedAucations = false;
                                  isCompletedAucations = false;
                                  isCanceldAucations = false;

                                  setState(() {});
                                },
                                child: Container(
                                  height: 60.h,
                                  width: 150.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: isActiveAucations
                                          ? AppColors.main_color
                                          : AppColors.white),
                                  child: Center(
                                    child: Text(
                                      'Active'.tr,
                                      style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                          color: isActiveAucations
                                              ? AppColors.white
                                              : AppColors.gray_color),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  isWaitingsAucations = false;
                                  isEndedAucations = true;
                                  isCompletedAucations = false;
                                  isCanceldAucations = false;
                                  isActiveAucations = false;

                                  setState(() {});
                                },
                                child: Container(
                                  height: 60.h,
                                  width: 150.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: isEndedAucations
                                          ? AppColors.main_color
                                          : AppColors.white),
                                  child: Center(
                                    child: Text(
                                      'Ended'.tr,
                                      style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                          color: isEndedAucations
                                              ? AppColors.white
                                              : AppColors.gray_color),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  isWaitingsAucations = false;
                                  isEndedAucations = false;
                                  isCompletedAucations = true;
                                  isCanceldAucations = false;
                                  isActiveAucations = false;

                                  setState(() {});
                                },
                                child: Container(
                                  height: 60.h,
                                  width: 150.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: isCompletedAucations
                                          ? AppColors.main_color
                                          : AppColors.white),
                                  child: Center(
                                    child: Text(
                                      'Completed'.tr,
                                      style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                          color: isCompletedAucations
                                              ? AppColors.white
                                              : AppColors.gray_color),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  isWaitingsAucations = false;
                                  isEndedAucations = false;
                                  isCompletedAucations = false;
                                  isCanceldAucations = true;
                                  isActiveAucations = false;

                                  setState(() {});
                                },
                                child: Container(
                                  height: 60.h,
                                  width: 150.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: isCanceldAucations
                                          ? AppColors.main_color
                                          : AppColors.white),
                                  child: Center(
                                    child: Text(
                                      'Closed'.tr,
                                      style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                          color: isCanceldAucations
                                              ? AppColors.white
                                              : AppColors.gray_color),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),


                      Visibility(
                        visible: isActiveAucations,
                        child: GetX<Aucations_GetxController>(
                            builder: (Aucations_GetxController controller) {
                          return (controller.isLoadingMyActiveAuctions.isTrue)
                              ? shimmer_Auction_ListView(width: width,)
                              : controller.MyActiveAuctions_model!.data!.data
                                      .isNotEmpty
                                  ? GetBuilder<Aucations_GetxController>(
                                      builder: (Aucations_GetxController
                                          controller) {
                                      return SizedBox(
                                        child: ListView.separated(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            itemCount: controller
                                                .MyActiveAuctions_model!
                                                .data!
                                                .data
                                                .length,
                                            separatorBuilder: (context, index) {
                                              return SizedBox(
                                                height: 14.h,
                                              );
                                            },
                                            itemBuilder: (context, index) {
                                              DateTime now = DateTime.now();
                                              DateTime dt1 = DateTime.parse(
                                                  controller
                                                      .MyActiveAuctions_model!
                                                      .data!
                                                      .data[index]
                                                      .auctionTo
                                                      .toString());
                                              Duration diff =
                                                  dt1.difference(now);
                                              return GestureDetector(
                                                onTap: () async {
                                                  if (await Helper()
                                                      .checkInternet()) {
                                                    singleAucations_Model?
                                                        singleAucation =
                                                        await _home_getxController
                                                            .getAucationByID(
                                                                context:
                                                                    context,
                                                                ID: controller
                                                                    .MyActiveAuctions_model!
                                                                    .data!
                                                                    .data![
                                                                        index]
                                                                    .id
                                                                    .toString());
                                                    if (singleAucation !=
                                                        null) {
                                                      if (singleAucation.data
                                                              .user!.userId ==
                                                          _profile_getxController
                                                              .profile_model!
                                                              .data
                                                              .userId) {
                                                        Get.to(mySingleAucation_Screen(
                                                            aucations_model:
                                                                singleAucation));
                                                      } else {
                                                        await Get.to(
                                                            singleAucation_Screen(
                                                                aucations_model:
                                                                    singleAucation));
                                                        print('no');
                                                      }
                                                    } else {}
                                                  } else {
                                                    Helper().show_Dialog(
                                                        context: context,
                                                        title: 'No Internet'.tr,
                                                        img: AppImages
                                                            .no_internet,
                                                        subTitle:
                                                            'Try Again'.tr);
                                                  }
                                                },
                                                child: Container(
                                                  width: width,
                                                  decoration: BoxDecoration(
                                                      color: AppColors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  padding: EdgeInsets.only(
                                                      top: 12.h,
                                                      right: 8.w,
                                                      left: 8.w,
                                                      bottom: 12.h),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            clipBehavior:
                                                                Clip.antiAlias,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                            child:
                                                                CachedNetworkImage(
                                                              fit: BoxFit.cover,
                                                              width: 135.w,
                                                              height: 135.h,
                                                              imageUrl: controller
                                                                  .MyActiveAuctions_model!
                                                                  .data!
                                                                  .data[index]
                                                                  .photo
                                                                  .toString(),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 10.w,
                                                                    left: 10.w),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width: 150.w,
                                                                  // height: 50.h,
                                                                  child: Text(
                                                                    SharedPreferencesController().languageCode ==
                                                                            'en'
                                                                        ? controller
                                                                            .MyActiveAuctions_model!
                                                                            .data!
                                                                            .data[
                                                                                index]
                                                                            .title
                                                                            .toString()
                                                                        : controller
                                                                            .MyActiveAuctions_model!
                                                                            .data!
                                                                            .data[index]
                                                                            .titleAr
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Cairo',
                                                                        fontSize: 12
                                                                            .sp,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: AppColors
                                                                            .black_color),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 150.w,
                                                                  child: Text(
                                                                    SharedPreferencesController().languageCode ==
                                                                            'en'
                                                                        ? controller
                                                                            .MyActiveAuctions_model!
                                                                            .data!
                                                                            .data[
                                                                                index]
                                                                            .description
                                                                            .toString()
                                                                        : controller
                                                                            .MyActiveAuctions_model!
                                                                            .data!
                                                                            .data[index]
                                                                            .descriptionAr
                                                                            .toString(),
                                                                    maxLines: 2,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Cairo',
                                                                        fontSize: 9
                                                                            .sp,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: AppColors
                                                                            .black_color
                                                                            .withOpacity(0.54)),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10.h,
                                                                ),
                                                                SizedBox(
                                                                  width: 181.w,
                                                                  child: Row(
                                                                    children: [
                                                                      SvgPicture
                                                                          .asset(
                                                                        diff.inSeconds <=
                                                                                0
                                                                            ? AppImages.red_clock
                                                                            : AppImages.greenclock,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            5.w,
                                                                      ),
                                                                      Text(
                                                                        diff.inSeconds <=
                                                                                0
                                                                            ? 'Aucation Ended'.tr
                                                                            : '${Helper.formatDuration(diff)}',
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Cairo',
                                                                            fontSize: 12
                                                                                .sp,
                                                                            overflow: TextOverflow
                                                                                .clip,
                                                                            fontWeight: FontWeight
                                                                                .w500,
                                                                            color: diff.inSeconds <= 0
                                                                                ? AppColors.red
                                                                                : AppColors.messageColor),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 181.w,
                                                                  child: Row(
                                                                    children: [
                                                                      Image.asset(
                                                                          AppImages
                                                                              .price),
                                                                      SizedBox(
                                                                        width:
                                                                            5.w,
                                                                      ),
                                                                      Text(
                                                                        controller.MyActiveAuctions_model!.data!.data[index].price.toString() +
                                                                            ' ' +
                                                                            'Qar'.tr,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Cairo',
                                                                            fontSize:
                                                                                14.sp,
                                                                            overflow: TextOverflow.clip,
                                                                            fontWeight: FontWeight.bold,
                                                                            color: AppColors.main_color),
                                                                      ),
                                                                      Spacer(),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () async {
                                                                          String
                                                                              shortUrl =
                                                                              await DynamicLinksService.createDynamicLink(
                                                                            type:
                                                                                'Aucation',
                                                                            parameter:
                                                                                controller.MyActiveAuctions_model!.data!.data[index].id.toString(),
                                                                          );

                                                                          Share.share(
                                                                              shortUrl);
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'share'
                                                                              .tr,
                                                                          style: TextStyle(
                                                                              fontFamily: 'Cairo',
                                                                              fontSize: 12.sp,
                                                                              overflow: TextOverflow.clip,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: AppColors.gray_color),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            5.w,
                                                                      ),
                                                                      SvgPicture.asset(
                                                                          AppImages
                                                                              .share,
                                                                          width:
                                                                              20.w),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 15.h,
                                                      ),
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 100.w,
                                                            child:
                                                                customElevatedButton(
                                                              onTap: () async {
                                                                Helper
                                                                    .openDialoge(
                                                                  context,
                                                                  onTap:
                                                                      () async { await controller
                                                                        .deleteAucation(
                                                                      context,
                                                                      AucationID: controller
                                                                          .MyActiveAuctions_model!
                                                                          .data!
                                                                          .data[
                                                                              index]
                                                                          .id
                                                                          .toString(),
                                                                    );

                                                                    Get.back();
                                                                  },
                                                                  title:
                                                                      'aucationsDeleteSure'
                                                                          .tr,
                                                                  subTitle: controller
                                                                              .MyActiveAuctions_model!
                                                                              .data!
                                                                              .data[
                                                                                  index]
                                                                              .bidsCount !=
                                                                          0
                                                                      ? 'remove_Auction_message'.tr
                                                                      : '',
                                                                );
                                                              },
                                                              color:
                                                                  AppColors.red,
                                                              height: 40.h,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  SvgPicture.asset(
                                                                      AppImages
                                                                          .trash),
                                                                  SizedBox(
                                                                    width: 5.w,
                                                                  ),
                                                                  Text(
                                                                    'delete'.tr,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Cairo',
                                                                        fontSize: 10
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        color: AppColors
                                                                            .white),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5.w,
                                                          ),
                                                          Spacer(),
                                                          Text(
                                                            'View'.tr,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Cairo',
                                                                fontSize: 10.sp,
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: AppColors
                                                                    .black_color),
                                                          ),
                                                          SvgPicture.asset(
                                                              AppImages.view,
                                                              width: 20.w),
                                                          SizedBox(
                                                            width: 13.w,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                      );
                                    })
                                  : SizedBox(
                                      height: 630.h,
                                      width: width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 200.h,
                                          ),
                                          Image.asset(AppImages.matte),
                                          SizedBox(
                                            height: 35.h,
                                          ),
                                          Text(
                                            'No Aucation yet'.tr,
                                            style: TextStyle(
                                                fontFamily: 'Cairo',
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.black_color),
                                          ),
                                          Spacer(),
                                          customElevatedButton(
                                            onTap: () {
                                              Get.to(chooseAdvType_Screen());
                                            },
                                            color: AppColors.main_color,
                                            child: Text(
                                              'Add your aucation'.tr,
                                              style: TextStyle(
                                                  fontFamily: 'Cairo',
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.white),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35.h,
                                          ),
                                        ],
                                      ),
                                    );
                        }),
                      ),
                      Visibility(
                        visible: isWaitingsAucations,
                        child: GetX<Aucations_GetxController>(
                            builder: (Aucations_GetxController controller) {
                          return (controller.isLoadingMyWaitingAuctions.isTrue)
                              ? shimmer_Auction_ListView(width: width,)
                              : controller.myWaitingAuctions_model!.data!.data
                                      .isNotEmpty
                                  ? GetBuilder<Aucations_GetxController>(
                                      builder: (Aucations_GetxController
                                          controller) {
                                      return SizedBox(
                                        child: ListView.separated(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            itemCount: controller
                                                .myWaitingAuctions_model!
                                                .data!
                                                .data
                                                .length,
                                            separatorBuilder: (context, index) {
                                              return SizedBox(
                                                height: 14.h,
                                              );
                                            },
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () async {
                                                  if (await Helper()
                                                      .checkInternet()) {
                                                    singleAucations_Model?
                                                        singleAucation =
                                                        await _home_getxController
                                                            .getAucationByID(
                                                                context:
                                                                    context,
                                                                ID: controller
                                                                    .myWaitingAuctions_model!
                                                                    .data!
                                                                    .data![
                                                                        index]
                                                                    .id
                                                                    .toString());
                                                    if (singleAucation !=
                                                        null) {
                                                      if (singleAucation.data
                                                              .user!.userId ==
                                                          _profile_getxController
                                                              .profile_model!
                                                              .data
                                                              .userId) {
                                                        Get.to(mySingleAucation_Screen(
                                                            aucations_model:
                                                                singleAucation));
                                                        print('my');
                                                      } else {
                                                        await Get.to(
                                                            singleAucation_Screen(
                                                                aucations_model:
                                                                    singleAucation));
                                                        print('no');
                                                      }
                                                    } else {}
                                                  } else {
                                                    Helper().show_Dialog(
                                                        context: context,
                                                        title: 'No Internet'.tr,
                                                        img: AppImages
                                                            .no_internet,
                                                        subTitle:
                                                            'Try Again'.tr);
                                                  }
                                                },
                                                child: Container(
                                                  width: width,
                                                  decoration: BoxDecoration(
                                                      color: AppColors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  padding: EdgeInsets.only(
                                                      top: 12.h,
                                                      right: 8.w,
                                                      left: 8.w,
                                                      bottom: 12.h),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            clipBehavior:
                                                                Clip.antiAlias,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                            child:
                                                                CachedNetworkImage(
                                                              fit: BoxFit.cover,
                                                              width: 135.w,
                                                              height: 135.h,
                                                              imageUrl: controller
                                                                  .myWaitingAuctions_model!
                                                                  .data!
                                                                  .data[index]
                                                                  .photo
                                                                  .toString(),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 10.w,
                                                                    left: 10.w),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width: 150.w,
                                                                  // height: 50.h,
                                                                  child: Text(
                                                                    SharedPreferencesController().languageCode ==
                                                                            'en'
                                                                        ? controller
                                                                            .myWaitingAuctions_model!
                                                                            .data!
                                                                            .data[
                                                                                index]
                                                                            .title
                                                                            .toString()
                                                                        : controller
                                                                            .myWaitingAuctions_model!
                                                                            .data!
                                                                            .data[index]
                                                                            .titleAr
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Cairo',
                                                                        fontSize: 12
                                                                            .sp,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: AppColors
                                                                            .black_color),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 150.w,
                                                                  child: Text(
                                                                    SharedPreferencesController().languageCode ==
                                                                            'en'
                                                                        ? controller
                                                                            .myWaitingAuctions_model!
                                                                            .data!
                                                                            .data[
                                                                                index]
                                                                            .description
                                                                            .toString()
                                                                        : controller
                                                                            .myWaitingAuctions_model!
                                                                            .data!
                                                                            .data[index]
                                                                            .descriptionAr
                                                                            .toString(),
                                                                    maxLines: 2,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Cairo',
                                                                        fontSize: 9
                                                                            .sp,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: AppColors
                                                                            .black_color
                                                                            .withOpacity(0.54)),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10.h,
                                                                ),
                                                                SizedBox(
                                                                  width: 181.w,
                                                                  child: Row(
                                                                    children: [
                                                                      SvgPicture
                                                                          .asset(
                                                                        AppImages
                                                                            .greenclock,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            5.w,
                                                                      ),
                                                                      Text(
                                                                        'waiting confirm'
                                                                            .tr,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Cairo',
                                                                            fontSize:
                                                                                12.sp,
                                                                            overflow: TextOverflow.clip,
                                                                            fontWeight: FontWeight.w500,
                                                                            color: AppColors.black_color),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 181.w,
                                                                  child: Row(
                                                                    children: [
                                                                      Image.asset(
                                                                          AppImages
                                                                              .price),
                                                                      SizedBox(
                                                                        width:
                                                                            5.w,
                                                                      ),
                                                                      Text(
                                                                        controller.myWaitingAuctions_model!.data!.data[index].price.toString() +
                                                                            ' ' +
                                                                            'Qar'.tr,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Cairo',
                                                                            fontSize:
                                                                                14.sp,
                                                                            overflow: TextOverflow.clip,
                                                                            fontWeight: FontWeight.bold,
                                                                            color: AppColors.main_color),
                                                                      ),
                                                                      Spacer(),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          show_ErrorDialog(
                                                                            context:
                                                                                context,
                                                                            title:
                                                                                'The ad has not been published'.tr,
                                                                            subTitle:
                                                                                'Still waiting for approval'.tr,
                                                                          );
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'share'
                                                                              .tr,
                                                                          style: TextStyle(
                                                                              fontFamily: 'Cairo',
                                                                              fontSize: 12.sp,
                                                                              overflow: TextOverflow.clip,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: AppColors.gray_color),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            5.w,
                                                                      ),
                                                                      SvgPicture.asset(
                                                                          AppImages
                                                                              .share,
                                                                          width:
                                                                              20.w),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 15.h,
                                                      ),
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 100.w,
                                                            child:
                                                                customElevatedButton(
                                                              onTap: () async {
                                                                Helper
                                                                    .openDialoge(
                                                                  context,
                                                                  onTap:
                                                                      () async {
                                                                    bool
                                                                        isDeleted =
                                                                        await controller
                                                                            .deleteAucation(
                                                                      context,
                                                                      AucationID: controller
                                                                          .myWaitingAuctions_model!
                                                                          .data!
                                                                          .data[
                                                                              index]
                                                                          .id
                                                                          .toString(),
                                                                    );

                                                                    Get.back();

                                                                    setState(
                                                                        () {});
                                                                  },
                                                                  title:
                                                                      'aucationsDeleteSure'
                                                                          .tr,
                                                                );
                                                              },
                                                              color:
                                                                  AppColors.red,
                                                              height: 40.h,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  SvgPicture.asset(
                                                                      AppImages
                                                                          .trash),
                                                                  SizedBox(
                                                                    width: 5.w,
                                                                  ),
                                                                  Text(
                                                                    'delete'.tr,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Cairo',
                                                                        fontSize: 10
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        color: AppColors
                                                                            .white),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5.w,
                                                          ),
                                                          Spacer(),
                                                          Text(
                                                            'View'.tr,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Cairo',
                                                                fontSize: 10.sp,
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: AppColors
                                                                    .black_color),
                                                          ),
                                                          SvgPicture.asset(
                                                              AppImages.view,
                                                              width: 20.w),
                                                          SizedBox(
                                                            width: 13.w,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                      );
                                    })
                                  : SizedBox(
                                      height: 630.h,
                                      width: width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 200.h,
                                          ),
                                          Image.asset(AppImages.matte),
                                          SizedBox(
                                            height: 35.h,
                                          ),
                                          Text(
                                            'No Aucation yet'.tr,
                                            style: TextStyle(
                                                fontFamily: 'Cairo',
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.black_color),
                                          ),
                                          Spacer(),
                                          customElevatedButton(
                                            onTap: () {
                                              Get.to(chooseAdvType_Screen());
                                            },
                                            color: AppColors.main_color,
                                            child: Text(
                                              'Add your aucation'.tr,
                                              style: TextStyle(
                                                  fontFamily: 'Cairo',
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.white),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35.h,
                                          ),
                                        ],
                                      ),
                                    );
                        }),
                      ),

                      Visibility(
                        visible: isCompletedAucations,
                        child: GetX<Aucations_GetxController>(
                            builder: (Aucations_GetxController controller) {
                          return (controller
                                  .isLoadingMyCompletedAuctions.isTrue)
                              ? shimmer_Auction_ListView(width: width,)
                              : controller.myCompletedAuctions_model!.data!.data
                                      .isNotEmpty
                                  ? GetBuilder<Aucations_GetxController>(
                                      builder: (Aucations_GetxController
                                          controller) {
                                      return SizedBox(
                                        child: ListView.separated(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            itemCount: controller
                                                .myCompletedAuctions_model!
                                                .data!
                                                .data
                                                .length,
                                            separatorBuilder: (context, index) {
                                              return SizedBox(
                                                height: 14.h,
                                              );
                                            },
                                            itemBuilder: (context, index) {
                                              DateTime now = DateTime.now();
                                              DateTime dt1 = DateTime.parse(
                                                  controller
                                                      .myCompletedAuctions_model!
                                                      .data!
                                                      .data[index]
                                                      .auctionTo
                                                      .toString());
                                              Duration diff =
                                                  dt1.difference(now);
                                              return GestureDetector(
                                                onTap: () async {
                                                  if (await Helper()
                                                      .checkInternet()) {
                                                    singleAucations_Model?
                                                        singleAucation =
                                                        await _home_getxController
                                                            .getAucationByID(
                                                                context:
                                                                    context,
                                                                ID: controller
                                                                    .myCompletedAuctions_model!
                                                                    .data!
                                                                    .data![
                                                                        index]
                                                                    .id
                                                                    .toString());
                                                    if (singleAucation !=
                                                        null) {
                                                      if (singleAucation.data
                                                              .user!.userId ==
                                                          _profile_getxController
                                                              .profile_model!
                                                              .data
                                                              .userId) {
                                                        Get.to(mySingleAucation_Screen(
                                                            aucations_model:
                                                                singleAucation));
                                                      } else {
                                                        await Get.to(
                                                            singleAucation_Screen(
                                                                aucations_model:
                                                                    singleAucation));
                                                      }
                                                    } else {}
                                                  } else {
                                                    Helper().show_Dialog(
                                                        context: context,
                                                        title: 'No Internet'.tr,
                                                        img: AppImages
                                                            .no_internet,
                                                        subTitle:
                                                            'Try Again'.tr);
                                                  }
                                                },
                                                child: Container(
                                                  width: width,
                                                  decoration: BoxDecoration(
                                                      color: AppColors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  padding: EdgeInsets.only(
                                                      top: 12.h,
                                                      right: 8.w,
                                                      left: 8.w,
                                                      bottom: 12.h),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            clipBehavior:
                                                                Clip.antiAlias,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                            child:
                                                                CachedNetworkImage(
                                                              fit: BoxFit.cover,
                                                              width: 135.w,
                                                              height: 135.h,
                                                              imageUrl: controller
                                                                  .myCompletedAuctions_model!
                                                                  .data!
                                                                  .data[index]
                                                                  .photo
                                                                  .toString(),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 10.w,
                                                                    left: 10.w),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width: 150.w,
                                                                  // height: 50.h,
                                                                  child: Text(
                                                                    SharedPreferencesController().languageCode ==
                                                                            'en'
                                                                        ? controller
                                                                            .myCompletedAuctions_model!
                                                                            .data!
                                                                            .data[
                                                                                index]
                                                                            .title
                                                                            .toString()
                                                                        : controller
                                                                            .myCompletedAuctions_model!
                                                                            .data!
                                                                            .data[index]
                                                                            .titleAr
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Cairo',
                                                                        fontSize: 12
                                                                            .sp,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: AppColors
                                                                            .black_color),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 150.w,
                                                                  child: Text(
                                                                    SharedPreferencesController().languageCode ==
                                                                            'en'
                                                                        ? controller
                                                                            .myCompletedAuctions_model!
                                                                            .data!
                                                                            .data[
                                                                                index]
                                                                            .description
                                                                            .toString()
                                                                        : controller
                                                                            .myCompletedAuctions_model!
                                                                            .data!
                                                                            .data[index]
                                                                            .descriptionAr
                                                                            .toString(),
                                                                    maxLines: 2,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Cairo',
                                                                        fontSize: 9
                                                                            .sp,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: AppColors
                                                                            .black_color
                                                                            .withOpacity(0.54)),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10.h,
                                                                ),
                                                                SizedBox(
                                                                  width: 181.w,
                                                                  child: Row(
                                                                    children: [
                                                                      SvgPicture
                                                                          .asset(
                                                                        AppImages
                                                                            .red_clock,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            5.w,
                                                                      ),
                                                                      Text(
                                                                        diff.inSeconds <=
                                                                                0
                                                                            ? 'Aucation Ended'.tr
                                                                            : '${Helper.formatDuration(diff)}',
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Cairo',
                                                                            fontSize:
                                                                                12.sp,
                                                                            overflow: TextOverflow.clip,
                                                                            fontWeight: FontWeight.w500,
                                                                            color: AppColors.red),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 181.w,
                                                                  child: Row(
                                                                    children: [
                                                                      Image.asset(
                                                                          AppImages
                                                                              .price),
                                                                      SizedBox(
                                                                        width:
                                                                            5.w,
                                                                      ),
                                                                      Text(
                                                                        controller.myCompletedAuctions_model!.data!.data[index].price.toString() +
                                                                            ' ' +
                                                                            'Qar'.tr,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Cairo',
                                                                            fontSize:
                                                                                14.sp,
                                                                            overflow: TextOverflow.clip,
                                                                            fontWeight: FontWeight.bold,
                                                                            color: AppColors.main_color),
                                                                      ),
                                                                      Spacer(),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () async {
                                                                          String
                                                                              shortUrl =
                                                                              await DynamicLinksService.createDynamicLink(
                                                                            type:
                                                                                'Aucation',
                                                                            parameter:
                                                                                controller.myCompletedAuctions_model!.data!.data[index].id.toString(),
                                                                          );

                                                                          Share.share(
                                                                              shortUrl);
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'share'
                                                                              .tr,
                                                                          style: TextStyle(
                                                                              fontFamily: 'Cairo',
                                                                              fontSize: 12.sp,
                                                                              overflow: TextOverflow.clip,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: AppColors.gray_color),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            5.w,
                                                                      ),
                                                                      SvgPicture.asset(
                                                                          AppImages
                                                                              .share,
                                                                          width:
                                                                              20.w),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 15.h,
                                                      ),
                                                      Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                              AppImages
                                                                  .green_verify),
                                                          Text(
                                                            'المزاد معتمد',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Cairo',
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: AppColors
                                                                    .messageColor),
                                                          ),
                                                          Spacer(),
                                                          Text(
                                                            'View'.tr,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Cairo',
                                                                fontSize: 10.sp,
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: AppColors
                                                                    .black_color),
                                                          ),
                                                          SvgPicture.asset(
                                                              AppImages.view,
                                                              width: 20.w),
                                                          SizedBox(
                                                            width: 13.w,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 15.h,
                                                      ),
                                                      if (controller
                                                              .myCompletedAuctions_model!
                                                              .data!
                                                              .data[index]
                                                              .topBid !=
                                                          null)
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Divider(
                                                              indent: 15.w,
                                                              endIndent: 15.w,
                                                            ),
                                                            Text(
                                                              'الشخص الذي ربح المزاد',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Cairo',
                                                                  fontSize:
                                                                      12.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: AppColors
                                                                      .black_color),
                                                            ),
                                                            ListTile(
                                                              leading:
                                                                  Container(
                                                                clipBehavior: Clip
                                                                    .antiAlias,
                                                                height: 60.h,
                                                                width: 60.w,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  imageUrl: controller
                                                                      .myCompletedAuctions_model!
                                                                      .data!
                                                                      .data[
                                                                          index]
                                                                      .topBid!
                                                                      .user!
                                                                      .photo
                                                                      .toString(),
                                                                ),
                                                              ),
                                                              title: Row(
                                                                children: [
                                                                  Text(
                                                                    controller
                                                                        .myCompletedAuctions_model!
                                                                        .data!
                                                                        .data[
                                                                            index]
                                                                        .topBid!
                                                                        .user!
                                                                        .name
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Cairo',
                                                                        fontSize: 12
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: AppColors
                                                                            .black_color),
                                                                  ),
                                                                  Spacer(),
                                                                  Text(
                                                                    'المزايدة كانت:',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Cairo',
                                                                        fontSize: 10
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: AppColors
                                                                            .messageColor),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5.w,
                                                                  ),
                                                                  Text(
                                                                    controller
                                                                        .myCompletedAuctions_model!
                                                                        .data!
                                                                        .data[
                                                                            index]
                                                                        .topBid!
                                                                        .amount
                                                                        .toString()+' '+'Qar'.tr,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Cairo',
                                                                        fontSize: 10
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: AppColors
                                                                            .messageColor),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 15.h,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                SizedBox(
                                                                  width: SharedPreferencesController()
                                                                              .languageCode ==
                                                                          'ar'
                                                                      ? 90.w
                                                                      : 105.w,
                                                                  height: 35.h,
                                                                  child:
                                                                      customElevatedButton(
                                                                    onTap:
                                                                        () async {
                                                                      if (controller
                                                                              .myCompletedAuctions_model!
                                                                              .data!
                                                                              .data[index]
                                                                              .topBid!
                                                                              .user!
                                                                              .whatsapp
                                                                              .toString() !=
                                                                          'null') {
                                                                        String
                                                                            shortUrl =
                                                                            await DynamicLinksService.createDynamicLink(
                                                                          type:
                                                                              'Aucation',
                                                                          parameter: controller
                                                                              .myCompletedAuctions_model!
                                                                              .data!
                                                                              .data[index]
                                                                              .id
                                                                              .toString(),
                                                                        );

                                                                        Share.share(
                                                                            shortUrl);
                                                                        Helper().send_Whatsapp(
                                                                            phoneNum:
                                                                                controller.myCompletedAuctions_model!.data!.data[index].topBid!.user!.whatsapp.toString(),
                                                                            massege: shortUrl);
                                                                      }
                                                                    },
                                                                    color: AppColors
                                                                        .whatsabColor,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        SvgPicture.asset(
                                                                            AppImages.whatsab),
                                                                        SizedBox(
                                                                          width:
                                                                              5.w,
                                                                        ),
                                                                        Text(
                                                                          'whatsapp'
                                                                              .tr,
                                                                          style: TextStyle(
                                                                              fontFamily: 'Cairo',
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: AppColors.white),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 120.w,
                                                                  height: 35.h,
                                                                  child:
                                                                      customElevatedButton(
                                                                    onTap:
                                                                        () async {
                                                                      final Uri
                                                                          launchUri =
                                                                          Uri(
                                                                        scheme:
                                                                            'tel',
                                                                        path: controller
                                                                            .myCompletedAuctions_model!
                                                                            .data!
                                                                            .data[index]
                                                                            .topBid!
                                                                            .user!
                                                                            .mobile
                                                                            .toString(),
                                                                      );
                                                                      await launchUrl(
                                                                          launchUri);
                                                                    },
                                                                    color: AppColors
                                                                        .phoneCallColor,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        SvgPicture.asset(
                                                                            AppImages.call),
                                                                        SizedBox(
                                                                          width:
                                                                              5.w,
                                                                        ),
                                                                        Text(
                                                                          'phone Call'
                                                                              .tr,
                                                                          style: TextStyle(
                                                                              fontFamily: 'Cairo',
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: AppColors.white),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 35.h,
                                                                  width: SharedPreferencesController()
                                                                              .languageCode ==
                                                                          'ar'
                                                                      ? 120.w
                                                                      : 100.w,
                                                                  child:
                                                                      customElevatedButton(
                                                                    onTap:
                                                                        () async {
                                                                      final Uri
                                                                          launchUri =
                                                                          Uri(
                                                                        scheme:
                                                                            'sms',
                                                                        path: controller
                                                                            .myCompletedAuctions_model!
                                                                            .data!
                                                                            .data[index]
                                                                            .topBid!
                                                                            .user!
                                                                            .mobile
                                                                            .toString(),
                                                                      );
                                                                      await launchUrl(
                                                                          launchUri);
                                                                    },
                                                                    color: AppColors
                                                                        .smsColor,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        SvgPicture.asset(
                                                                            AppImages.sms2),
                                                                        SizedBox(
                                                                          width:
                                                                              5.w,
                                                                        ),
                                                                        Text(
                                                                          'sms'
                                                                              .tr,
                                                                          style: TextStyle(
                                                                              fontFamily: 'Cairo',
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: AppColors.white),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                      );
                                    })
                                  : SizedBox(
                                      height: 630.h,
                                      width: width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 200.h,
                                          ),
                                          Image.asset(AppImages.matte),
                                          SizedBox(
                                            height: 35.h,
                                          ),
                                          Text(
                                            'No completed Aucation yet'.tr,
                                            style: TextStyle(
                                                fontFamily: 'Cairo',
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.black_color),
                                          ),
                                          Spacer(),
                                          customElevatedButton(
                                            onTap: () {
                                              Get.to(chooseAdvType_Screen());
                                            },
                                            color: AppColors.main_color,
                                            child: Text(
                                              'Add your aucation'.tr,
                                              style: TextStyle(
                                                  fontFamily: 'Cairo',
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.white),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35.h,
                                          ),
                                        ],
                                      ),
                                    );
                        }),
                      ),


                      Visibility(
                        visible: isEndedAucations,
                        child: GetX<Aucations_GetxController>(
                            builder: (Aucations_GetxController controller) {
                          return (controller.isLoadingMyEndedAuctions.isTrue)
                              ?shimmer_Auction_ListView(width: width,)
                              : controller.myEndedAuctions_model!.data!.data
                                      .isNotEmpty
                                  ? GetBuilder<Aucations_GetxController>(
                                      builder: (Aucations_GetxController
                                          controller) {
                                      return SizedBox(
                                        child: ListView.separated(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            itemCount: controller
                                                .myEndedAuctions_model!
                                                .data!
                                                .data
                                                .length,
                                            separatorBuilder: (context, index) {
                                              return SizedBox(
                                                height: 14.h,
                                              );
                                            },
                                            itemBuilder: (context, index) {
                                              //   DateTime now = DateTime.now();
                                              // DateTime dt1 = DateTime.parse(controller.myEndedAuctions_model!.data!.data[index].auctionTo.toString());
                                              // Duration diff = dt1.difference(now);

                                              bool hadTargetDone = false;

                                              if (controller
                                                      .myEndedAuctions_model!
                                                      .data!
                                                      .data[index]
                                                      .topBid ==
                                                  null) {
                                                hadTargetDone = false;
                                                print('No Target');
                                              } else {
                                                int.parse(controller
                                                            .myEndedAuctions_model!
                                                            .data!
                                                            .data[index]
                                                            .topBid!
                                                            .amount
                                                            .toString()) >=
                                                        int.parse(controller
                                                            .myEndedAuctions_model!
                                                            .data!
                                                            .data[index]
                                                            .price
                                                            .toString())
                                                    ? hadTargetDone = true
                                                    : hadTargetDone = false;
                                                print('Had Target');
                                              }

                                              return GestureDetector(
                                                onTap: () async {
                                                  if (await Helper()
                                                      .checkInternet()) {
                                                    singleAucations_Model?
                                                        singleAucation =
                                                        await _home_getxController
                                                            .getAucationByID(
                                                                context:
                                                                    context,
                                                                ID: controller
                                                                    .myEndedAuctions_model!
                                                                    .data!
                                                                    .data![
                                                                        index]
                                                                    .id
                                                                    .toString());
                                                    if (singleAucation !=
                                                        null) {
                                                      if (singleAucation.data
                                                              .user!.userId ==
                                                          _profile_getxController
                                                              .profile_model!
                                                              .data
                                                              .userId) {
                                                        Get.to(mySingleAucation_Screen(
                                                            aucations_model:
                                                                singleAucation));
                                                      } else {
                                                        await Get.to(
                                                            singleAucation_Screen(
                                                                aucations_model:
                                                                    singleAucation));
                                                      }
                                                    } else {}
                                                  } else {
                                                    Helper().show_Dialog(
                                                        context: context,
                                                        title: 'No Internet'.tr,
                                                        img: AppImages
                                                            .no_internet,
                                                        subTitle:
                                                            'Try Again'.tr);
                                                  }
                                                },
                                                child: Container(
                                                  width: width,
                                                  decoration: BoxDecoration(
                                                      color: AppColors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  padding: EdgeInsets.only(
                                                      top: 12.h,
                                                      right: 8.w,
                                                      left: 8.w,
                                                      bottom: 12.h),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            clipBehavior:
                                                                Clip.antiAlias,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                            child:
                                                                CachedNetworkImage(
                                                              fit: BoxFit.cover,
                                                              width: 135.w,
                                                              height: 135.h,
                                                              imageUrl: controller
                                                                  .myEndedAuctions_model!
                                                                  .data!
                                                                  .data[index]
                                                                  .photo
                                                                  .toString(),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 10.w,
                                                                    left: 10.w),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width: 150.w,
                                                                  // height: 50.h,
                                                                  child: Text(
                                                                    SharedPreferencesController().languageCode ==
                                                                            'en'
                                                                        ? controller
                                                                            .myEndedAuctions_model!
                                                                            .data!
                                                                            .data[
                                                                                index]
                                                                            .title
                                                                            .toString()
                                                                        : controller
                                                                            .myEndedAuctions_model!
                                                                            .data!
                                                                            .data[index]
                                                                            .titleAr
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Cairo',
                                                                        fontSize: 12
                                                                            .sp,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: AppColors
                                                                            .black_color),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 150.w,
                                                                  child: Text(
                                                                    SharedPreferencesController().languageCode ==
                                                                            'en'
                                                                        ? controller
                                                                            .myEndedAuctions_model!
                                                                            .data!
                                                                            .data[
                                                                                index]
                                                                            .description
                                                                            .toString()
                                                                        : controller
                                                                            .myEndedAuctions_model!
                                                                            .data!
                                                                            .data[index]
                                                                            .descriptionAr
                                                                            .toString(),
                                                                    maxLines: 2,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Cairo',
                                                                        fontSize: 9
                                                                            .sp,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: AppColors
                                                                            .black_color
                                                                            .withOpacity(0.54)),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10.h,
                                                                ),
                                                                SizedBox(
                                                                  width: 181.w,
                                                                  child: Row(
                                                                    children: [
                                                                      SvgPicture
                                                                          .asset(
                                                                        AppImages
                                                                            .red_clock,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            5.w,
                                                                      ),
                                                                      Text(
                                                                        diff.inSeconds <=
                                                                                0
                                                                            ? 'Aucation Ended'.tr
                                                                            : '${Helper.formatDuration(diff)}',
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Cairo',
                                                                            fontSize:
                                                                                12.sp,
                                                                            overflow: TextOverflow.clip,
                                                                            fontWeight: FontWeight.w500,
                                                                            color: AppColors.red),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 181.w,
                                                                  child: Row(
                                                                    children: [
                                                                      Image.asset(
                                                                          AppImages
                                                                              .price),
                                                                      SizedBox(
                                                                        width:
                                                                            5.w,
                                                                      ),
                                                                      Text(
                                                                        controller.myEndedAuctions_model!.data!.data[index].price.toString() +
                                                                            ' ' +
                                                                            'Qar'.tr,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Cairo',
                                                                            fontSize:
                                                                                14.sp,
                                                                            overflow: TextOverflow.clip,
                                                                            fontWeight: FontWeight.bold,
                                                                            color: AppColors.main_color),
                                                                      ),
                                                                      Spacer(),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () async {
                                                                          String
                                                                              shortUrl =
                                                                              await DynamicLinksService.createDynamicLink(
                                                                            type:
                                                                                'Aucation',
                                                                            parameter:
                                                                                controller.myEndedAuctions_model!.data!.data[index].id.toString(),
                                                                          );

                                                                          Share.share(
                                                                              shortUrl);
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'share'
                                                                              .tr,
                                                                          style: TextStyle(
                                                                              fontFamily: 'Cairo',
                                                                              fontSize: 12.sp,
                                                                              overflow: TextOverflow.clip,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: AppColors.gray_color),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            5.w,
                                                                      ),
                                                                      SvgPicture.asset(
                                                                          AppImages
                                                                              .share,
                                                                          width:
                                                                              20.w),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 15.h,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            'View'.tr,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Cairo',
                                                                fontSize: 10.sp,
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: AppColors
                                                                    .black_color),
                                                          ),
                                                          SvgPicture.asset(
                                                              AppImages.view,
                                                              width: 20.w),
                                                          SizedBox(
                                                            width: 13.w,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 15.h,
                                                      ),
                                                      Visibility(
                                                        visible: controller
                                                                .myEndedAuctions_model!
                                                                .data!
                                                                .data[index]
                                                                .topBid !=
                                                            null,
                                                        replacement: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SvgPicture.asset(
                                                                    AppImages
                                                                        .close_circle),
                                                                SizedBox(
                                                                  width: 5.w,
                                                                ),
                                                                Text(
                                                                  'لم يحقق الهدف ',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Cairo',
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color:
                                                                        AppColors
                                                                            .red,
                                                                  ),
                                                                ),
                                                                Spacer(),
                                                                SizedBox(
                                                                  width: 100.w,
                                                                  child:
                                                                      customElevatedButton(
                                                                    onTap:
                                                                        () async {
                                                                      Get.defaultDialog(
                                                                        title:
                                                                            'هل انت متأكد من إلغاء المزاد ؟',
                                                                        content:
                                                                            SizedBox(
                                                                          height:
                                                                              45.h,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              TextButton(
                                                                                onPressed: () async {
                                                                                  await controller.cancelAucation(
                                                                                    context,
                                                                                    AucationID: controller.myEndedAuctions_model!.data!.data[index].id.toString(),
                                                                                  );

                                                                                  Get.back();
                                                                                },
                                                                                child: Text(
                                                                                  'yes'.tr,
                                                                                  style: TextStyle(fontFamily: 'Cairo', fontSize: 12.sp, fontWeight: FontWeight.w400, color: AppColors.gray_color),
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
                                                                                  style: TextStyle(fontFamily: 'Cairo', fontSize: 12.sp, fontWeight: FontWeight.w400, color: AppColors.gray_color),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        radius:
                                                                            10,
                                                                        titlePadding:
                                                                            EdgeInsets.all(15),
                                                                      );
                                                                    },
                                                                    color:
                                                                        AppColors
                                                                            .red,
                                                                    height:
                                                                        40.h,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          'إلغاء',
                                                                          style: TextStyle(
                                                                              fontFamily: 'Cairo',
                                                                              fontSize: 10.sp,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: AppColors.white),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Divider(
                                                              indent: 15.w,
                                                              endIndent: 15.w,
                                                            ),
                                                            ListTile(
                                                              leading:
                                                                  Container(
                                                                clipBehavior: Clip.antiAlias,
                                                                height: 60.h,
                                                                width: 60.w,
                                                                decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child: CachedNetworkImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  imageUrl: controller
                                                                      .myEndedAuctions_model!
                                                                      .data!
                                                                      .data[
                                                                          index]
                                                                      .topBid!
                                                                      .user!
                                                                      .photo
                                                                      .toString(),
                                                                ),
                                                              ),
                                                              title: Row(
                                                                children: [
                                                                  Text(
                                                                    controller
                                                                        .myEndedAuctions_model!
                                                                        .data!
                                                                        .data[
                                                                            index]
                                                                        .topBid!
                                                                        .user!
                                                                        .name
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Cairo',
                                                                        fontSize: 12
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: AppColors
                                                                            .black_color),
                                                                  ),
                                                                  Spacer(),
                                                                  // Text(
                                                                  //   'منذ ساعة',
                                                                  //   style: TextStyle(
                                                                  //       fontFamily:
                                                                  //           'Cairo',
                                                                  //       fontSize: 10
                                                                  //           .sp,
                                                                  //       fontWeight:
                                                                  //           FontWeight
                                                                  //               .bold,
                                                                  //       color: AppColors
                                                                  //           .darkgray_color),
                                                                  // ),
                                                                ],
                                                              ),
                                                              subtitle: Row(
                                                                children: [
                                                                  Text(
                                                                    controller
                                                                        .myEndedAuctions_model!
                                                                        .data!
                                                                        .data[
                                                                            index]
                                                                        .topBid!
                                                                        .amount
                                                                        .toString()+' '+'Qar'.tr,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Cairo',
                                                                        fontSize: 12
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: AppColors
                                                                            .darkgray_color),
                                                                  ),
                                                                  Spacer(),
                                                                  SvgPicture.asset(hadTargetDone
                                                                      ? AppImages
                                                                          .green_verify
                                                                      : AppImages
                                                                          .close_circle),
                                                                  Text(
                                                                    hadTargetDone
                                                                        ? 'محقق الهدف'
                                                                        : 'لم يحقق الهدف ',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Cairo',
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: hadTargetDone
                                                                          ? AppColors
                                                                              .messageColor
                                                                          : AppColors
                                                                              .red,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 15.h,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                SizedBox(
                                                                  width: SharedPreferencesController()
                                                                              .languageCode ==
                                                                          'ar'
                                                                      ? 90.w
                                                                      : 105.w,
                                                                  height: 35.h,
                                                                  child:
                                                                      customElevatedButton(
                                                                    onTap:
                                                                        () async {
                                                                      if (controller
                                                                              .myEndedAuctions_model!
                                                                              .data!
                                                                              .data[index]
                                                                              .topBid!
                                                                              .user!
                                                                              .whatsapp
                                                                              .toString() !=
                                                                          'null') {
                                                                        //Todo -> add url
                                                                        String
                                                                            shortUrl =
                                                                            await DynamicLinksService.createDynamicLink(
                                                                          type:
                                                                              'Aucation',
                                                                          parameter: controller
                                                                              .myEndedAuctions_model!
                                                                              .data!
                                                                              .data[index]
                                                                              .id
                                                                              .toString(),
                                                                        );

                                                                        // Share.share(shortUrl);
                                                                        Helper().send_Whatsapp(
                                                                            phoneNum:
                                                                                controller.myEndedAuctions_model!.data!.data[index].topBid!.user!.whatsapp.toString(),
                                                                            massege: shortUrl);
                                                                      }
                                                                    },
                                                                    color: AppColors
                                                                        .whatsabColor,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        SvgPicture.asset(
                                                                            AppImages.whatsab),
                                                                        SizedBox(
                                                                          width:
                                                                              5.w,
                                                                        ),
                                                                        Text(
                                                                          'whatsapp'
                                                                              .tr,
                                                                          style: TextStyle(
                                                                              fontFamily: 'Cairo',
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: AppColors.white),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 120.w,
                                                                  height: 35.h,
                                                                  child:
                                                                      customElevatedButton(
                                                                    onTap:
                                                                        () async {
                                                                      final Uri
                                                                          launchUri =
                                                                          Uri(
                                                                        scheme:
                                                                            'tel',
                                                                        path: controller
                                                                            .myEndedAuctions_model!
                                                                            .data!
                                                                            .data[index]
                                                                            .topBid!
                                                                            .user!
                                                                            .mobile
                                                                            .toString(),
                                                                      );
                                                                      await launchUrl(
                                                                          launchUri);
                                                                    },
                                                                    color: AppColors
                                                                        .phoneCallColor,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        SvgPicture.asset(
                                                                            AppImages.call),
                                                                        SizedBox(
                                                                          width:
                                                                              5.w,
                                                                        ),
                                                                        Text(
                                                                          'phone Call'
                                                                              .tr,
                                                                          style: TextStyle(
                                                                              fontFamily: 'Cairo',
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: AppColors.white),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 35.h,
                                                                  width: SharedPreferencesController()
                                                                              .languageCode ==
                                                                          'ar'
                                                                      ? 120.w
                                                                      : 100.w,
                                                                  child:
                                                                      customElevatedButton(
                                                                    onTap:
                                                                        () async {
                                                                      final Uri
                                                                          launchUri =
                                                                          Uri(
                                                                        scheme:
                                                                            'sms',
                                                                        path: controller
                                                                            .myEndedAuctions_model!
                                                                            .data!
                                                                            .data[index]
                                                                            .topBid!
                                                                            .user!
                                                                            .mobile
                                                                            .toString(),
                                                                      );
                                                                      await launchUrl(
                                                                          launchUri);
                                                                    },
                                                                    color: AppColors
                                                                        .smsColor,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        SvgPicture.asset(
                                                                            AppImages.sms2),
                                                                        SizedBox(
                                                                          width:
                                                                              5.w,
                                                                        ),
                                                                        Text(
                                                                          'sms'
                                                                              .tr,
                                                                          style: TextStyle(
                                                                              fontFamily: 'Cairo',
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: AppColors.white),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 15.h,
                                                            ),
                                                            Divider(
                                                              indent: 15.w,
                                                              endIndent: 15.w,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                SizedBox(
                                                                  width: 100.w,
                                                                  child:
                                                                      customElevatedButton(
                                                                    onTap:
                                                                        () async {
                                                                      Get.defaultDialog(
                                                                        title: 'سيتم اعتماد المزاد ل' +
                                                                            '${controller.myEndedAuctions_model!.data!.data[index].topBid!.user!.name.toString()}' +
                                                                            ' بمبلغ ' +
                                                                            '${controller.myEndedAuctions_model!.data!.data[index].topBid!.amount.toString()}',
                                                                        content:
                                                                            SizedBox(
                                                                          height:
                                                                              45.h,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              TextButton(
                                                                                onPressed: () async {
                                                                                  await controller.complete_auction(
                                                                                    context,
                                                                                    AucationID: controller.myEndedAuctions_model!.data!.data[index].id.toString(),
                                                                                  );

                                                                                  Get.back();
                                                                                },
                                                                                child: Text(
                                                                                  'yes'.tr,
                                                                                  style: TextStyle(fontFamily: 'Cairo', fontSize: 12.sp, fontWeight: FontWeight.w400, color: AppColors.gray_color),
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
                                                                                  style: TextStyle(fontFamily: 'Cairo', fontSize: 12.sp, fontWeight: FontWeight.w400, color: AppColors.gray_color),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        radius:
                                                                            10,
                                                                        titlePadding:
                                                                            EdgeInsets.all(15),
                                                                      );
                                                                    },
                                                                    color: AppColors
                                                                        .main_color,
                                                                    height:
                                                                        40.h,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          'بيع',
                                                                          style: TextStyle(
                                                                              fontFamily: 'Cairo',
                                                                              fontSize: 10.sp,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: AppColors.white),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 5.w,
                                                                ),

                                                                /*
                                                              if (!hadTargetDone)
                                                                SizedBox(
                                                                  width:
                                                                      100.w,
                                                                  child:
                                                                      customElevatedButton(
                                                                    onTap:
                                                                        () {},
                                                                    color: AppColors
                                                                        .messageColor,
                                                                    height:
                                                                        40.h,
                                                                    child:
                                                                        Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment.center,
                                                                      children: [
                                                                        Text(
                                                                          'تمديد المزاد',
                                                                          style: TextStyle(
                                                                              fontFamily: 'Cairo',
                                                                              fontSize: 10.sp,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: AppColors.white),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              if (!hadTargetDone)
                                                                SizedBox(
                                                                  width: 5.w,
                                                                ),


                                                               */

                                                                SizedBox(
                                                                  width: 100.w,
                                                                  child:
                                                                      customElevatedButton(
                                                                    onTap:
                                                                        () async {
                                                                      Get.defaultDialog(
                                                                        title:
                                                                            'هل انت متأكد من إلغاء المزاد ؟',
                                                                        content:
                                                                            SizedBox(
                                                                          height:
                                                                              45.h,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              TextButton(
                                                                                onPressed: () async {
                                                                                  await controller.cancelAucation(
                                                                                    context,
                                                                                    AucationID: controller.myEndedAuctions_model!.data!.data[index].id.toString(),
                                                                                  );

                                                                                  Get.back();
                                                                                },
                                                                                child: Text(
                                                                                  'yes'.tr,
                                                                                  style: TextStyle(fontFamily: 'Cairo', fontSize: 12.sp, fontWeight: FontWeight.w400, color: AppColors.gray_color),
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
                                                                                  style: TextStyle(fontFamily: 'Cairo', fontSize: 12.sp, fontWeight: FontWeight.w400, color: AppColors.gray_color),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        radius:
                                                                            10,
                                                                        titlePadding:
                                                                            EdgeInsets.all(15),
                                                                      );
                                                                    },
                                                                    color:
                                                                        AppColors
                                                                            .red,
                                                                    height:
                                                                        40.h,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          'عدم بيع',
                                                                          style: TextStyle(
                                                                              fontFamily: 'Cairo',
                                                                              fontSize: 10.sp,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: AppColors.white),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                      );
                                    })
                                  : SizedBox(
                                      height: 630.h,
                                      width: width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 200.h,
                                          ),
                                          Image.asset(AppImages.matte),
                                          SizedBox(
                                            height: 35.h,
                                          ),
                                          Text(
                                            'No Ended Aucation yet'.tr,
                                            style: TextStyle(
                                                fontFamily: 'Cairo',
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.black_color),
                                          ),
                                          Spacer(),
                                          customElevatedButton(
                                            onTap: () {
                                              Get.to(chooseAdvType_Screen());
                                            },
                                            color: AppColors.main_color,
                                            child: Text(
                                              'Add your aucation'.tr,
                                              style: TextStyle(
                                                  fontFamily: 'Cairo',
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.white),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35.h,
                                          ),
                                        ],
                                      ),
                                    );
                        }),
                      ),
                      Visibility(
                        visible: isCanceldAucations,
                        child: GetX<Aucations_GetxController>(
                            builder: (Aucations_GetxController controller) {
                          return (controller.isLoadingMyCanceledAuctions.isTrue)
                              ? shimmer_Auction_ListView(width: width,)
                              : controller.myCanceledAuctions_model!.data!.data
                                      .isNotEmpty
                                  ? GetBuilder<Aucations_GetxController>(
                                      builder: (Aucations_GetxController
                                          controller) {
                                      return SizedBox(
                                        child: ListView.separated(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            itemCount: controller
                                                .myCanceledAuctions_model!
                                                .data!
                                                .data
                                                .length,
                                            separatorBuilder: (context, index) {
                                              return SizedBox(
                                                height: 14.h,
                                              );
                                            },
                                            itemBuilder: (context, index) {
                                              DateTime now = DateTime.now();
                                              DateTime dt1 = DateTime.parse(
                                                  controller
                                                      .myCanceledAuctions_model!
                                                      .data!
                                                      .data[index]
                                                      .auctionTo
                                                      .toString());
                                              Duration diff =
                                                  dt1.difference(now);
                                              return GestureDetector(
                                                onTap: () async {
                                                  if (await Helper()
                                                      .checkInternet()) {
                                                    singleAucations_Model?
                                                        singleAucation =
                                                        await _home_getxController
                                                            .getAucationByID(
                                                                context:
                                                                    context,
                                                                ID: controller
                                                                    .myCanceledAuctions_model!
                                                                    .data!
                                                                    .data![
                                                                        index]
                                                                    .id
                                                                    .toString());
                                                    if (singleAucation !=
                                                        null) {
                                                      if (singleAucation.data
                                                              .user!.userId ==
                                                          _profile_getxController
                                                              .profile_model!
                                                              .data
                                                              .userId) {
                                                        Get.to(mySingleAucation_Screen(
                                                            aucations_model:
                                                                singleAucation));
                                                        setState(() {});
                                                      } else {
                                                        await Get.to(
                                                            singleAucation_Screen(
                                                                aucations_model:
                                                                    singleAucation));
                                                        setState(() {});
                                                      }
                                                    } else {}
                                                  } else {
                                                    Helper().show_Dialog(
                                                        context: context,
                                                        title: 'No Internet'.tr,
                                                        img: AppImages
                                                            .no_internet,
                                                        subTitle:
                                                            'Try Again'.tr);
                                                  }
                                                },
                                                child: Container(
                                                  width: width,
                                                  decoration: BoxDecoration(
                                                      color: AppColors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  padding: EdgeInsets.only(
                                                      top: 12.h,
                                                      right: 8.w,
                                                      left: 8.w,
                                                      bottom: 12.h),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            clipBehavior:
                                                                Clip.antiAlias,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                            child:
                                                                CachedNetworkImage(
                                                              fit: BoxFit.cover,
                                                              width: 135.w,
                                                              height: 135.h,
                                                              imageUrl: controller
                                                                  .myCanceledAuctions_model!
                                                                  .data!
                                                                  .data[index]
                                                                  .photo
                                                                  .toString(),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 10.w,
                                                                    left: 10.w),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width: 150.w,
                                                                  // height: 50.h,
                                                                  child: Text(
                                                                    SharedPreferencesController().languageCode ==
                                                                            'en'
                                                                        ? controller
                                                                            .myCanceledAuctions_model!
                                                                            .data!
                                                                            .data[
                                                                                index]
                                                                            .title
                                                                            .toString()
                                                                        : controller
                                                                            .myCanceledAuctions_model!
                                                                            .data!
                                                                            .data[index]
                                                                            .titleAr
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Cairo',
                                                                        fontSize: 12
                                                                            .sp,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: AppColors
                                                                            .black_color),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 150.w,
                                                                  child: Text(
                                                                    SharedPreferencesController().languageCode ==
                                                                            'en'
                                                                        ? controller
                                                                            .myCanceledAuctions_model!
                                                                            .data!
                                                                            .data[
                                                                                index]
                                                                            .description
                                                                            .toString()
                                                                        : controller
                                                                            .myCanceledAuctions_model!
                                                                            .data!
                                                                            .data[index]
                                                                            .descriptionAr
                                                                            .toString(),
                                                                    maxLines: 2,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Cairo',
                                                                        fontSize: 9
                                                                            .sp,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: AppColors
                                                                            .black_color
                                                                            .withOpacity(0.54)),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10.h,
                                                                ),
                                                                SizedBox(
                                                                  width: 181.w,
                                                                  child: Row(
                                                                    children: [
                                                                      SvgPicture
                                                                          .asset(
                                                                        diff.inSeconds <=
                                                                                0
                                                                            ? AppImages.red_clock
                                                                            : AppImages.greenclock,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            5.w,
                                                                      ),
                                                                      Text(
                                                                        diff.inSeconds <=
                                                                                0
                                                                            ? 'Aucation Ended'.tr
                                                                            : '${Helper.formatDuration(diff)}',
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Cairo',
                                                                            fontSize: 12
                                                                                .sp,
                                                                            overflow: TextOverflow
                                                                                .clip,
                                                                            fontWeight: FontWeight
                                                                                .w500,
                                                                            color: diff.inSeconds <= 0
                                                                                ? AppColors.red
                                                                                : AppColors.messageColor),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),

                                                                /*
                                                        Directionality(
                                                          textDirection: direction, // notice lower case

                                                          child: SlideCountdown(
                                                            duration: timeRemain(
                                                                controller.myCanceledAuctions_model!.data!.data[index].auctionTo
                                                                    .toString()
                                                            ),
                                                            replacement:Row(
                                                              children: [

                                                                Text(

                                                                  'Aucation Ended'.tr,                                               style: TextStyle(
                                                                    fontFamily:
                                                                    'Cairo',
                                                                    fontSize: 12
                                                                        .sp,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                    color: AppColors
                                                                        .red),
                                                                ),
                                                                SizedBox(width: 5.w,),

                                                                SvgPicture.asset(
                                                                  AppImages
                                                                      .red_clock,
                                                                ),
                                                              ],
                                                            ),
                                                            suffixIcon: Row(
                                                              children: [                                                                        SizedBox(width: 5.w,),

                                                                SvgPicture.asset(
                                                                  AppImages
                                                                      .greenclock,
                                                                ),

                                                              ],
                                                            ),
                                                            slideDirection: SlideDirection.up,
                                                            separator: '-',
                                                            showZeroValue: true,
                                                            decoration: BoxDecoration(
                                                              color: AppColors.white,


                                                            ),
                                                            textStyle: TextStyle(
                                                                fontFamily: 'Cairo',
                                                                fontSize: 12.sp,
                                                                fontWeight: FontWeight.w500,
                                                                color: AppColors.black_color),
                                                          ),
                                                        ),


                                                         */
                                                                SizedBox(
                                                                  width: 181.w,
                                                                  child: Row(
                                                                    children: [
                                                                      Image.asset(
                                                                          AppImages
                                                                              .price),
                                                                      SizedBox(
                                                                        width:
                                                                            5.w,
                                                                      ),
                                                                      Text(
                                                                        controller.myCanceledAuctions_model!.data!.data[index].price.toString() +
                                                                            ' ' +
                                                                            'Qar'.tr,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Cairo',
                                                                            fontSize:
                                                                                14.sp,
                                                                            overflow: TextOverflow.clip,
                                                                            fontWeight: FontWeight.bold,
                                                                            color: AppColors.main_color),
                                                                      ),
                                                                      Spacer(),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () async {
                                                                          String
                                                                              shortUrl =
                                                                              await DynamicLinksService.createDynamicLink(
                                                                            type:
                                                                                'Aucation',
                                                                            parameter:
                                                                                controller.myCanceledAuctions_model!.data!.data[index].id.toString(),
                                                                          );

                                                                          Share.share(
                                                                              shortUrl);
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'share'
                                                                              .tr,
                                                                          style: TextStyle(
                                                                              fontFamily: 'Cairo',
                                                                              fontSize: 12.sp,
                                                                              overflow: TextOverflow.clip,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: AppColors.gray_color),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            5.w,
                                                                      ),
                                                                      SvgPicture.asset(
                                                                          AppImages
                                                                              .share,
                                                                          width:
                                                                              20.w),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 15.h,
                                                      ),
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 100.w,
                                                            child:
                                                                customElevatedButton(
                                                              onTap: () {
                                                                Helper
                                                                    .openDialoge(
                                                                  context,
                                                                  onTap:
                                                                      () async {
                                                                    bool
                                                                        isDeleted =
                                                                        await controller
                                                                            .deleteAucation(
                                                                      context,
                                                                      AucationID: controller
                                                                          .myCanceledAuctions_model!
                                                                          .data!
                                                                          .data[
                                                                              index]
                                                                          .id
                                                                          .toString(),
                                                                    );

                                                                    Get.back();

                                                                    setState(
                                                                        () {});
                                                                  },
                                                                  title:
                                                                      'aucationsDeleteSure'
                                                                          .tr,
                                                                );
                                                              },
                                                              color:
                                                                  AppColors.red,
                                                              height: 40.h,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  SvgPicture.asset(
                                                                      AppImages
                                                                          .trash),
                                                                  SizedBox(
                                                                    width: 5.w,
                                                                  ),
                                                                  Text(
                                                                    'delete'.tr,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Cairo',
                                                                        fontSize: 10
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        color: AppColors
                                                                            .white),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5.w,
                                                          ),
                                                          Spacer(),
                                                          Text(
                                                            'View'.tr,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Cairo',
                                                                fontSize: 10.sp,
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: AppColors
                                                                    .black_color),
                                                          ),
                                                          SvgPicture.asset(
                                                              AppImages.view,
                                                              width: 20.w),
                                                          SizedBox(
                                                            width: 13.w,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                      );
                                    })
                                  : SizedBox(
                                      height: 630.h,
                                      width: width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 200.h,
                                          ),
                                          Image.asset(AppImages.matte),
                                          SizedBox(
                                            height: 35.h,
                                          ),
                                          Text(
                                            'No Aucation yet'.tr,
                                            style: TextStyle(
                                                fontFamily: 'Cairo',
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.black_color),
                                          ),
                                          Spacer(),
                                          customElevatedButton(
                                            onTap: () {
                                              Get.to(chooseAdvType_Screen());
                                            },
                                            color: AppColors.main_color,
                                            child: Text(
                                              'Add your aucation'.tr,
                                              style: TextStyle(
                                                  fontFamily: 'Cairo',
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.white),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35.h,
                                          ),
                                        ],
                                      ),
                                    );
                        }),
                      ),
                    ]),
              ),
            ),
          ),
          GetX<home_GetxController>(builder: (home_GetxController controller) {
            return (controller.isLoadingData.isTrue)
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
                : Container();
          }),
        ],
      ),
    );
  }

  Future show_ErrorDialog({
    required BuildContext context,
    required String title,
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
                height: 314.h,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
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
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 70.h,
                              ),
                              Image.asset(
                                AppImages.error,
                                width: 71.w,
                                height: 71.h,
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              Text(
                                title,
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black_color),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                subTitle,
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.black_color),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }
}
