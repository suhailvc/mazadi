import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mazzad/Database/SharedPreferences/shared_preferences.dart';
import 'package:mazzad/Screens/BN_Screens/advertise/singleAdvertisement_Screen.dart';
import 'package:mazzad/Utils/Helper.dart';
import 'package:mazzad/firebase/firebase_dynamic_links.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Controllers/GetxController/AdvertisementsController.dart';
import '../../../Controllers/GetxController/AucationsController.dart';
import '../../../Controllers/GetxController/drawerController.dart';
import '../../../Utils/AppColors.dart';
import '../../../Utils/asset_images.dart';
import '../../../Utils/customElevatedButton.dart';
import 'MyAdvertisement_Screen.dart';

class advertise_Screen extends StatefulWidget {
  const advertise_Screen({Key? key}) : super(key: key);

  @override
  State<advertise_Screen> createState() => _advertise_ScreenState();
}

class _advertise_ScreenState extends State<advertise_Screen> {
  // Advertisements_GetxController _advertisements_getxController =
  //     Get.put(Advertisements_GetxController());
  MyDrawerController _drawerController = Get.put(MyDrawerController());
  var _advertisements_getxController =
      Get.find<Advertisements_GetxController>();

  bool runningAdv = true;

  late ScrollController myActiveADVController ;
  late ScrollController myWaitingADVController ;

  Future scrollListen() async {

    myActiveADVController.addListener(() async {
      if (myActiveADVController.position.pixels >= myActiveADVController.position.maxScrollExtent) {
        _advertisements_getxController.getMyAdvertisements(is_Refresh: true);
      }
    });
    myWaitingADVController.addListener(() async {
      if (myWaitingADVController.position.pixels >= myWaitingADVController.position.maxScrollExtent) {
        _advertisements_getxController.getMyWaiting_advertisements(is_Refresh: true);
      }
    });

  }
  @override
  void initState() {
    super.initState();
    myWaitingADVController= ScrollController();
    myActiveADVController= ScrollController();
    scrollListen();

  }

  @override
  void dispose() {
    myActiveADVController.dispose();
    myWaitingADVController.dispose();
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
            icon: SvgPicture.asset(AppImages.drawer),
            onPressed: () {
              _drawerController.toggleDrawer();
            }),
        title: Text(
          'My Advertisment'.tr,
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
            padding: EdgeInsets.only(top: 35.h, left: 10.w, right: 10.w),
            child: RefreshIndicator(
              onRefresh: () async {
                _advertisements_getxController.getMyWaiting_advertisements();
                _advertisements_getxController.getMyAdvertisements();
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            runningAdv = true;
                            setState(() {});
                          },
                          child: Container(
                            height: 60.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: runningAdv
                                    ? AppColors.main_color
                                    : AppColors.white),
                            child: Center(
                              child: Text(
                                'Running'.tr,
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: runningAdv
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
                            runningAdv = false;
                            setState(() {});
                          },
                          child: Container(
                            height: 60.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: !runningAdv
                                    ? AppColors.main_color
                                    : AppColors.white),
                            child: Center(
                              child: Text(
                                'waiting'.tr,
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: !runningAdv
                                        ? AppColors.white
                                        : AppColors.gray_color),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Visibility(
                      visible: runningAdv,
                      child: SizedBox(
                          width: width,
                          child: GetX<Advertisements_GetxController>(builder:
                              (Advertisements_GetxController controller) {
                            return controller.isLoadingMyAdvertisements.isTrue
                                ? SizedBox(
                                    child: ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemCount: 5,
                                        separatorBuilder: (context, index) {
                                          return SizedBox(
                                            height: 14.h,
                                          );
                                        },
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () async {},
                                            child: Container(
                                              width: width,
                                              decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              padding: EdgeInsets.only(
                                                  top: 12.h,
                                                  right: 8.w,
                                                  left: 8.w,
                                                  bottom: 12.h),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                          clipBehavior: Clip
                                                              .antiAlias,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          child: Shimmer
                                                              .fromColors(
                                                                  baseColor:
                                                                      Colors.grey
                                                                          .shade300,
                                                                  highlightColor:
                                                                      Colors
                                                                          .grey
                                                                          .shade200,
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        135.w,
                                                                    height:
                                                                        135.h,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade300,
                                                                    ),
                                                                  ))),
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
                                                            Shimmer.fromColors(
                                                                baseColor: Colors
                                                                    .grey
                                                                    .shade300,
                                                                highlightColor:
                                                                    Colors.grey
                                                                        .shade200,
                                                                child:
                                                                    Container(
                                                                  width: 150.w,
                                                                  height: 12.h,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade300,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                                )),
                                                            SizedBox(
                                                              height: 10.h,
                                                            ),
                                                            Shimmer.fromColors(
                                                                baseColor: Colors
                                                                    .grey
                                                                    .shade300,
                                                                highlightColor:
                                                                    Colors.grey
                                                                        .shade200,
                                                                child:
                                                                    Container(
                                                                  width: 135.w,
                                                                  height: 11.h,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade300,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                                )),
                                                            SizedBox(
                                                              height: 15.h,
                                                            ),
                                                            Shimmer.fromColors(
                                                                baseColor: Colors
                                                                    .grey
                                                                    .shade300,
                                                                highlightColor:
                                                                    Colors.grey
                                                                        .shade200,
                                                                child:
                                                                    Container(
                                                                  width: 160.w,
                                                                  height: 12.h,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade300,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                                )),
                                                            SizedBox(
                                                              height: 15.h,
                                                            ),
                                                            Shimmer.fromColors(
                                                                baseColor: Colors
                                                                    .grey
                                                                    .shade300,
                                                                highlightColor:
                                                                    Colors.grey
                                                                        .shade200,
                                                                child:
                                                                    Container(
                                                                  width: 150.w,
                                                                  height: 12.h,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade300,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                                )),
                                                            SizedBox(
                                                              height: 8.h,
                                                            ),
                                                            Shimmer.fromColors(
                                                                baseColor: Colors
                                                                    .grey
                                                                    .shade300,
                                                                highlightColor:
                                                                    Colors.grey
                                                                        .shade200,
                                                                child:
                                                                    Container(
                                                                  width: 130.w,
                                                                  height: 11.h,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade300,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  )
                                : controller
                                        .advertisements_model!.data.data.isEmpty
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Divider(color: Colors.transparent),
                                          SizedBox(
                                            height: 110.h,
                                          ),
                                          Image.asset(AppImages.noData),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          Text(
                                            'noAdsYet'.tr,
                                            style: TextStyle(
                                                fontFamily: 'Cairo',
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.black_color),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  width: 20.w,
                                                  height: 20.h,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color:
                                                          AppColors.main_color),
                                                  child: Icon(Icons.add,
                                                      color: Colors.white,
                                                      size: 20),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Text(
                                                'addnewAdd'.tr,
                                                style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        AppColors.black_color),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    : SizedBox(
                                        child: ListView.separated(
                                            shrinkWrap: true,
                                            controller: myActiveADVController,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            itemCount: controller
                                                .advertisements_model!
                                                .data
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
                                                    var adv = await controller
                                                        .getAdvertisementByID(
                                                            context: context,
                                                            ID: controller
                                                                .advertisements_model!
                                                                .data
                                                                .data[index]
                                                                .id
                                                                .toString());
                                                    //
                                                    if (adv != null) {
                                                      controller.getCommentByID(
                                                          ID: controller
                                                              .advertisements_model!
                                                              .data
                                                              .data[index]
                                                              .id
                                                              .toString());
                                                      Get.to(
                                                          MyAdvertisement_Screen(
                                                              adv_model: adv));
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
                                                                  .advertisements_model!
                                                                  .data
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
                                                                            .advertisements_model!
                                                                            .data
                                                                            .data[
                                                                                index]
                                                                            .title
                                                                        : controller
                                                                            .advertisements_model!
                                                                            .data
                                                                            .data[index]
                                                                            .titleAr,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Cairo',
                                                                        fontSize: 12
                                                                            .sp,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .clip,
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
                                                                            .advertisements_model!
                                                                            .data
                                                                            .data[
                                                                                index]
                                                                            .description
                                                                        : controller
                                                                            .advertisements_model!
                                                                            .data
                                                                            .data[index]
                                                                            .descriptionAr,
                                                                    maxLines: 2,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Cairo',
                                                                        fontSize: 9
                                                                            .sp,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .clip,
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
                                                                      SvgPicture.asset(
                                                                          AppImages
                                                                              .messages,
                                                                          width:
                                                                              20.w),
                                                                      SizedBox(
                                                                        width:
                                                                            5.w,
                                                                      ),
                                                                      Text(
                                                                        controller
                                                                            .advertisements_model!
                                                                            .data
                                                                            .data[index]
                                                                            .commentsCount
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Cairo',
                                                                            fontSize:
                                                                                12.sp,
                                                                            overflow: TextOverflow.clip,
                                                                            fontWeight: FontWeight.w500,
                                                                            color: AppColors.gray_color),
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
                                                                        controller.advertisements_model!.data.data[index].price +
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
                                                                                'Advertisment',
                                                                            parameter:
                                                                                controller.advertisements_model!.data.data[index].id.toString(),
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
                                                                Get.defaultDialog(
                                                                  title:
                                                                      'areyousuredeletingAds'
                                                                          .tr,
                                                                  content:
                                                                      SizedBox(
                                                                    height:
                                                                        40.h,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        TextButton(
                                                                          onPressed:
                                                                              () async {
                                                                            bool
                                                                                isDeleted =
                                                                                await _advertisements_getxController.delete_Advertisement(ID: controller.advertisements_model!.data.data[index].id.toString());

                                                                            if (isDeleted) {
                                                                              Get.back();
                                                                            } else {
                                                                              Get.back();

                                                                              Helper().show_Dialog(context: context, title: 'No Internet'.tr, img: AppImages.no_internet, subTitle: 'Try Again'.tr);
                                                                            }
                                                                            setState(() {});
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            'yes'.tr,
                                                                            style: TextStyle(
                                                                                fontFamily: 'Cairo',
                                                                                fontSize: 12.sp,
                                                                                fontWeight: FontWeight.w400,
                                                                                color: AppColors.gray_color),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              15.w,
                                                                        ),
                                                                        VerticalDivider(),
                                                                        SizedBox(
                                                                          width:
                                                                              15.w,
                                                                        ),
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Get.back();
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            'no'.tr,
                                                                            style: TextStyle(
                                                                                fontFamily: 'Cairo',
                                                                                fontSize: 12.sp,
                                                                                fontWeight: FontWeight.w400,
                                                                                color: AppColors.gray_color),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  radius: 10,
                                                                  titlePadding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              15),
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
                                                          /*
                                                          SizedBox(
                                                            width: 100.w,
                                                            child:
                                                                customElevatedButton(
                                                              onTap: () {},
                                                              color: AppColors
                                                                  .gray2_color,
                                                              height: 40.h,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  SvgPicture.asset(
                                                                      AppImages
                                                                          .refresh),
                                                                  SizedBox(
                                                                    width: 5.w,
                                                                  ),
                                                                  Text(
                                                                    'إعادة النشر',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Cairo',
                                                                        fontSize:
                                                                            10.sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        color: AppColors
                                                                            .darkgray_color),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),


                                                           */
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
                          })),
                      replacement: SizedBox(
                          width: width,
                          child: GetX<Advertisements_GetxController>(builder:
                              (Advertisements_GetxController controller) {
                            return controller
                                    .isLoadingMyWaitingAdvertisements.isTrue
                                ? SizedBox(
                                    child: ListView.separated(
                                        shrinkWrap: true,

                                        physics: NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemCount: 5,
                                        separatorBuilder: (context, index) {
                                          return SizedBox(
                                            height: 14.h,
                                          );
                                        },
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () async {},
                                            child: Container(
                                              width: width,
                                              decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              padding: EdgeInsets.only(
                                                  top: 12.h,
                                                  right: 8.w,
                                                  left: 8.w,
                                                  bottom: 12.h),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                          clipBehavior: Clip
                                                              .antiAlias,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          child: Shimmer
                                                              .fromColors(
                                                                  baseColor:
                                                                      Colors.grey
                                                                          .shade300,
                                                                  highlightColor:
                                                                      Colors
                                                                          .grey
                                                                          .shade200,
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        135.w,
                                                                    height:
                                                                        135.h,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade300,
                                                                    ),
                                                                  ))),
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
                                                            Shimmer.fromColors(
                                                                baseColor: Colors
                                                                    .grey
                                                                    .shade300,
                                                                highlightColor:
                                                                    Colors.grey
                                                                        .shade200,
                                                                child:
                                                                    Container(
                                                                  width: 150.w,
                                                                  height: 12.h,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade300,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                                )),
                                                            SizedBox(
                                                              height: 10.h,
                                                            ),
                                                            Shimmer.fromColors(
                                                                baseColor: Colors
                                                                    .grey
                                                                    .shade300,
                                                                highlightColor:
                                                                    Colors.grey
                                                                        .shade200,
                                                                child:
                                                                    Container(
                                                                  width: 135.w,
                                                                  height: 11.h,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade300,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                                )),
                                                            SizedBox(
                                                              height: 15.h,
                                                            ),
                                                            Shimmer.fromColors(
                                                                baseColor: Colors
                                                                    .grey
                                                                    .shade300,
                                                                highlightColor:
                                                                    Colors.grey
                                                                        .shade200,
                                                                child:
                                                                    Container(
                                                                  width: 160.w,
                                                                  height: 12.h,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade300,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                                )),
                                                            SizedBox(
                                                              height: 15.h,
                                                            ),
                                                            Shimmer.fromColors(
                                                                baseColor: Colors
                                                                    .grey
                                                                    .shade300,
                                                                highlightColor:
                                                                    Colors.grey
                                                                        .shade200,
                                                                child:
                                                                    Container(
                                                                  width: 150.w,
                                                                  height: 12.h,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade300,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                                )),
                                                            SizedBox(
                                                              height: 8.h,
                                                            ),
                                                            Shimmer.fromColors(
                                                                baseColor: Colors
                                                                    .grey
                                                                    .shade300,
                                                                highlightColor:
                                                                    Colors.grey
                                                                        .shade200,
                                                                child:
                                                                    Container(
                                                                  width: 130.w,
                                                                  height: 11.h,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade300,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  )
                                : controller.Waiting_advertisements!.data.data
                                        .isEmpty
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Divider(color: Colors.transparent),
                                          SizedBox(
                                            height: 110.h,
                                          ),
                                          Image.asset(AppImages.noData),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          Text(
                                            'noAdvWaiting'.tr,
                                            style: TextStyle(
                                                fontFamily: 'Cairo',
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.black_color),
                                          ),
                                        ],
                                      )
                                    : SizedBox(
                                        child: ListView.separated(
                                            shrinkWrap: true,
                                            controller: myWaitingADVController,

                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            itemCount: controller
                                                .Waiting_advertisements!
                                                .data
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
                                                    var adv = await controller
                                                        .getAdvertisementByID(
                                                            context: context,
                                                            ID: controller
                                                                .Waiting_advertisements!
                                                                .data
                                                                .data[index]
                                                                .id
                                                                .toString());

                                                    if (adv != null) {
                                                      controller.getCommentByID(
                                                          ID: controller
                                                              .Waiting_advertisements!
                                                              .data
                                                              .data[index]
                                                              .id
                                                              .toString());

                                                      Get.to(
                                                          MyAdvertisement_Screen(
                                                              adv_model: adv));
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
                                                                  .Waiting_advertisements!
                                                                  .data
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
                                                                            .Waiting_advertisements!
                                                                            .data
                                                                            .data[
                                                                                index]
                                                                            .title
                                                                        : controller
                                                                            .Waiting_advertisements!
                                                                            .data
                                                                            .data[index]
                                                                            .titleAr,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Cairo',
                                                                        fontSize: 12
                                                                            .sp,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .clip,
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
                                                                            .Waiting_advertisements!
                                                                            .data
                                                                            .data[
                                                                                index]
                                                                            .description
                                                                        : controller
                                                                            .Waiting_advertisements!
                                                                            .data
                                                                            .data[index]
                                                                            .descriptionAr,
                                                                    maxLines: 2,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Cairo',
                                                                        fontSize: 9
                                                                            .sp,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .clip,
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
                                                                  child:
                                                                      Visibility(
                                                                    visible: controller
                                                                            .Waiting_advertisements!
                                                                            .data
                                                                            .data[index]
                                                                            .status ==
                                                                        0,
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
                                                                              fontFamily: 'Cairo',
                                                                              fontSize: 12.sp,
                                                                              overflow: TextOverflow.clip,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: AppColors.black_color),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    replacement:
                                                                        Row(
                                                                      children: [
                                                                        SvgPicture
                                                                            .asset(
                                                                          AppImages
                                                                              .failed,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              5.w,
                                                                        ),
                                                                        Text(
                                                                          'تم رفض الاعلان',
                                                                          style: TextStyle(
                                                                              fontFamily: 'Cairo',
                                                                              fontSize: 12.sp,
                                                                              overflow: TextOverflow.clip,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: AppColors.black_color),
                                                                        ),
                                                                      ],
                                                                    ),
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
                                                                        controller.Waiting_advertisements!.data.data[index].price +
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
                                                                              context: context);
                                                                        },
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Text(
                                                                              'share'.tr,
                                                                              style: TextStyle(fontFamily: 'Cairo', fontSize: 12.sp, overflow: TextOverflow.clip, fontWeight: FontWeight.w500, color: AppColors.gray_color),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 5.w,
                                                                            ),
                                                                            SvgPicture.asset(AppImages.share,
                                                                                width: 20.w),
                                                                          ],
                                                                        ),
                                                                      ),
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
                                                                Get.defaultDialog(
                                                                  title:
                                                                      'areyousuredeletingAds'
                                                                          .tr,
                                                                  content:
                                                                      SizedBox(
                                                                    height:
                                                                        40.h,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        TextButton(
                                                                          onPressed:
                                                                              () async {
                                                                            bool
                                                                                isDeleted =
                                                                                await _advertisements_getxController.delete_Advertisement(ID: controller.Waiting_advertisements!.data.data[index].id.toString());

                                                                            if (isDeleted) {
                                                                              Get.back();
                                                                            } else {
                                                                              Get.back();

                                                                              Helper().show_Dialog(context: context, title: 'No Internet'.tr, img: AppImages.no_internet, subTitle: 'Try Again'.tr);
                                                                            }
                                                                            setState(() {});
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            'yes'.tr,
                                                                            style: TextStyle(
                                                                                fontFamily: 'Cairo',
                                                                                fontSize: 12.sp,
                                                                                fontWeight: FontWeight.w400,
                                                                                color: AppColors.gray_color),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              15.w,
                                                                        ),
                                                                        VerticalDivider(),
                                                                        SizedBox(
                                                                          width:
                                                                              15.w,
                                                                        ),
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Get.back();
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            'no'.tr,
                                                                            style: TextStyle(
                                                                                fontFamily: 'Cairo',
                                                                                fontSize: 12.sp,
                                                                                fontWeight: FontWeight.w400,
                                                                                color: AppColors.gray_color),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  radius: 10,
                                                                  titlePadding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              15),
                                                                );

                                                                // Get.snackbar('', 'لا يمكن الحذف لانه لم يتم نشر الاعلان !');
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
                          })),
                    ),
                    SizedBox(
                      height: 225.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
          GetX<Advertisements_GetxController>(
              builder: (Advertisements_GetxController controller) {
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
                                'The ad has not been published'.tr,
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
                                'Still waiting for approval'.tr,
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
