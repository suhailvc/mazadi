import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mazzad/Database/SharedPreferences/shared_preferences.dart';
import 'package:mazzad/Screens/BN_Screens/advertise/singleAdvertisement_Screen.dart';
import 'package:mazzad/Utils/asset_images.dart';
import 'package:mazzad/firebase/firebase_dynamic_links.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

import '../../../Controllers/GetxController/AdvertisementsController.dart';
import '../../../Controllers/GetxController/homeController.dart';
import '../../../Controllers/GetxController/profileController.dart';
import '../../../Models/singleAdvertisement_Model.dart';
import '../../../Utils/AppColors.dart';
import '../../../Utils/Helper.dart';
import '../../../Utils/customElevatedButton.dart';
import 'MyAdvertisement_Screen.dart';

class singleUser_Screen extends StatefulWidget {
  late User? user;

  singleUser_Screen({required this.user});

  @override
  State<singleUser_Screen> createState() => _singleUser_ScreenState();
}

class _singleUser_ScreenState extends State<singleUser_Screen> {

  var _advertisements_getxController = Get.find<Advertisements_GetxController>();
  var _home_getxController = Get.find<home_GetxController>();
  var _profile_getxController = Get.find<profile_GetxController>();

  late ScrollController ADVController ;

  Future scrollListen() async {

    ADVController.addListener(() async {
      if (ADVController.position.pixels >= ADVController.position.maxScrollExtent) {
        print('asf');
        _advertisements_getxController.getUserAdvertisment(widget.user!.id,is_Pagination: true);
      }
    });



  }
  @override
  void initState() {
    super.initState();
    ADVController= ScrollController();
    scrollListen();

  }

  @override
  void dispose() {
    ADVController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.background_color,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          tooltip: 'back'.tr,
          icon: Icon(Icons.arrow_back, color: AppColors.lightgray_color),
        ),
        centerTitle: true,
        title: Text(
          widget.user!.name.toString(),
          style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.lightgray_color),
        ),
        // actions: [
        //   Row(
        //     children: [
        //       GestureDetector(
        //         onTap: () async {
        //           String shortUrl = await DynamicLinksService.createDynamicLink(
        //             type: 'user',
        //             parameter: widget.user!.id.toString(),
        //           );
        //
        //           Share.share(shortUrl);
        //         },
        //         child: Text(
        //           'share'.tr,
        //           style: TextStyle(
        //               fontFamily: 'Cairo',
        //               fontSize: 12.sp,
        //               overflow: TextOverflow.clip,
        //               fontWeight: FontWeight.w500,
        //               color: AppColors.gray_color),
        //         ),
        //       ),
        //       SizedBox(
        //         width: 5.w,
        //       ),
        //       SvgPicture.asset(AppImages.share, width: 20.w),
        //       SizedBox(
        //         width: 10.w,
        //       ),
        //     ],
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        controller: ADVController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                width: width,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      clipBehavior: Clip.antiAlias,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        width: 70.w,
                        height: 70.h,
                        imageUrl: widget.user!.photo.toString(),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.user!.name.toString(),
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black_color),
                        ),
                        Row(
                          children: [
                            Text(
                              'phone Number'.tr,
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black_color),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              widget.user!.mobile.toString(),
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black_color),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                )),
            SizedBox(
              height: 15.h,
            ),
            Container(
                width: width,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(5)),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: SharedPreferencesController().languageCode == 'ar'
                          ? 90.w
                          : 105.w,
                      height: 35.h,
                      child: customElevatedButton(
                        onTap: () async {
                        Helper().send_Whatsapp(
                              phoneNum: widget.user!.whatsapp.toString(),
                              massege: '');
                        },
                        color: AppColors.whatsabColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppImages.whatsab),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              'whatsapp'.tr,
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
                      child: customElevatedButton(
                        onTap: () async {
                          final Uri launchUri = Uri(
                            scheme: 'tel',
                            path: widget.user!.mobile.toString(),
                          );
                          await launchUrl(launchUri);
                        },
                        color: AppColors.phoneCallColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppImages.call),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              'phone Call'.tr,
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
                      width: SharedPreferencesController().languageCode == 'ar'
                          ? 120.w
                          : 100.w,
                      child: customElevatedButton(
                        onTap: () async {
                          final Uri launchUri = Uri(
                            scheme: 'sms',
                            path: widget.user!.mobile.toString(),
                          );
                          await launchUrl(launchUri);
                        },
                        color: AppColors.smsColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppImages.sms2),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              'sms'.tr,
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
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 10.h),
              child: Text(
                'الاعلانات',
                style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black_color),
              ),
            ),
            Divider(
              height: 0,
              thickness: 2,
            ),

            Padding(
              padding: EdgeInsets.only(
                  top: 10.h, right: 10.w, left: 10.w, bottom: 50.h),
              child: GetBuilder<Advertisements_GetxController>(
                  builder: (Advertisements_GetxController controller) {
                return (controller.isGettingUserAD.isTrue)
                    ? GridView.builder(
                        shrinkWrap: true,
                        // scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: 6,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: Helper.childAspectRatio(1.2),
                            crossAxisSpacing: 15.w,
                            mainAxisSpacing: 15.h,
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return Container(
                            width: 170.w,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade200,
                                    child: Container(
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Container(
                                        width: width,
                                        height: 154.h,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                    )),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5.w, vertical: 5.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Divider(
                                        color: Colors.transparent,
                                      ),
                                      Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade200,
                                        child: Container(
                                          width: 100.w,
                                          height: 12.h,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade200,
                                        child: Container(
                                          width: 50.w,
                                          height: 10.h,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade200,
                                        child: Container(
                                          width: 70.w,
                                          height: 10.h,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 9.h,
                                      ),
                                      Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade200,
                                        child: Container(
                                          width: 110.w,
                                          height: 11.h,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        })
                    : GridView.builder(
                        shrinkWrap: true,
                        // scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount:
                            controller.userAdvertisment_Model!.data.data2!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: Helper.childAspectRatio(1.2),
                            crossAxisSpacing: 15.w,
                            mainAxisSpacing: 15.h,
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return Stack(
                            alignment: AlignmentDirectional.topStart,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  if (await Helper().checkInternet()) {
                                    singleAdvertisement_Model? adv =
                                        await controller.getAdvertisementByID(
                                            context: context,
                                                ID: controller
                                                    .userAdvertisment_Model!
                                                    .data
                                                    .data2[index]
                                                    .id
                                                    .toString());


                                    if (adv != null) {
                                      if (adv.data.user!.userId ==
                                          _profile_getxController
                                              .profile_model!.data.userId) {
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
                                },
                                child: Container(
                                  width: 170.w,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        height: 154.h,
                                        width: width,
                                        imageUrl: controller
                                            .userAdvertisment_Model!
                                            .data
                                            .data2[index]
                                            .photo
                                            .toString(),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.w, vertical: 5.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 160.w,
                                              child: Text(
                                                controller.userAdvertisment_Model!
                                                    .data.data2![index].title
                                                    .toString(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppColors.black_color),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            SizedBox(
                                              width: 150.w,
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      AppImages.messages),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Text(
                                                    controller
                                                        .userAdvertisment_Model!
                                                        .data
                                                        .data2[index]
                                                        .commentsCount
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontFamily: 'Cairo',
                                                        fontSize: 14.sp,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppColors
                                                            .darkgray_color),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            SizedBox(
                                              width: 150.w,
                                              child: Row(
                                                children: [
                                                  Image.asset(AppImages.price),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Text(
                                                    controller
                                                            .userAdvertisment_Model!
                                                            .data
                                                            .data2[index]
                                                            .price
                                                            .toString() +
                                                        ' ' +
                                                        'Qar'.tr,
                                                    style: TextStyle(
                                                        fontFamily: 'Cairo',
                                                        fontSize: 14.sp,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: AppColors
                                                            .main_color),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    'View'.tr,
                                                    style: TextStyle(
                                                        fontFamily: 'Cairo',
                                                        fontSize: 10.sp,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: AppColors
                                                            .black_color),
                                                  ),
                                                  SvgPicture.asset(
                                                      AppImages.view,
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
                              ),
                              if (controller.userAdvertisment_Model!.data
                                      .data2[index].paid !=
                                  0)
                                Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    decoration:
                                        BoxDecoration(color: Colors.amber),
                                    child: Text('paid'.tr,
                                        style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontSize: 18.sp,
                                            color: Colors.white)))
                            ],
                          );
                        });
              }),
            ),
          ],
        ),
      ),
    );
  }
}
