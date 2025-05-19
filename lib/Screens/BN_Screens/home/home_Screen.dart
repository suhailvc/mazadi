import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mazzad/Controllers/GetxController/profileController.dart';
import 'package:mazzad/Database/SharedPreferences/shared_preferences.dart';
import 'package:mazzad/Models/advertisementCategoryDetails_Model.dart';
import 'package:mazzad/Screens/BN_Screens/Aucations/LastAucations_Screen.dart';
import 'package:mazzad/Screens/BN_Screens/Aucations/mySingleAucation_Screen.dart';
import 'package:mazzad/Screens/BN_Screens/Aucations/singleAucation_Screen.dart';
import 'package:mazzad/Screens/BN_Screens/advertise/LastAdvertisment_Screen.dart';
import 'package:mazzad/Screens/BN_Screens/home/widget/lastAucations.dart';
import 'package:mazzad/Utils/AppColors.dart';
import 'package:mazzad/Utils/Helper.dart';
import 'package:mazzad/Utils/asset_images.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Controllers/GetxController/AdvertisementsController.dart';
import '../../../Controllers/GetxController/checkNetWorkGetx_Controller.dart';
import '../../../Controllers/GetxController/drawerController.dart';
import '../../../Controllers/GetxController/homeController.dart';
import '../../../Models/singleAdvertisement_Model.dart';
import '../../../Models/singleAucations_Model.dart';
import '../../../firebase/fb_firestore_controller.dart';
import '../advertise/MyAdvertisement_Screen.dart';
import '../advertise/advertiseSubCategory_Screen.dart';
import '../advertise/searchAdvertisment_Screen.dart';
import '../advertise/singleAdvertisement_Screen.dart';
import '../newAdvertise/adv/saveAdvDetailes_Screen.dart';

class home_Screen extends StatefulWidget {
  const home_Screen({Key? key}) : super(key: key);

  @override
  State<home_Screen> createState() => _home_ScreenState();
}

class _home_ScreenState extends State<home_Screen> {
  // home_GetxController _home_getxController =Get.put<home_GetxController>(home_GetxController());

  MyDrawerController _drawerController = Get.put(MyDrawerController());

  // Advertisements_GetxController _advertisements_getxController =
  // Get.put(Advertisements_GetxController());

  var _advertisements_getxController =
      Get.find<Advertisements_GetxController>();
  var _home_getxController = Get.find<home_GetxController>();
  var _profile_getxController = Get.find<profile_GetxController>();
  var _netWork_getxController = Get.find<checkNetWorkGetx_Controller>();

  @override
  void initState() {
    super.initState();
    setState(() {});
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      onRefresh: () async {
        if (await Helper().checkInternet()) {
          await _home_getxController.start();
        } else {
          Helper().show_Dialog(
              context: context,
              title: 'No Internet'.tr,
              img: AppImages.no_internet,
              subTitle: 'Try Again'.tr);
        }
      },
      child: Scaffold(
          backgroundColor: AppColors.background_color,
          extendBodyBehindAppBar: false,
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
              'home'.tr,
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black_color),
            ),
            actions: [
              IconButton(
                  icon: SvgPicture.asset(AppImages.search), onPressed: () {

                    Get.to(()=>searchAdvertisment_Screen());

              }),
            ],
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // SizedBox(
                    //   height: 15.h,
                    // ),
                    GetX<home_GetxController>(
                        builder: (home_GetxController controller) {
                      return controller.isLoadingSlider.isTrue
                          ? Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade200,
                              child: Container(
                                width: width,
                                height: 170.h,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                ),
                              ))
                          :
                 controller.slider_model!.data!.isNotEmpty?
                        ImageSlideshow(
                        width: width,
                        isLoop: true,
                        children: controller.slider_model!.data!
                            .map((e) => CachedNetworkImage(

                          imageUrl: e.image!,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress)),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        ))
                            .toList(),
                      ):SizedBox();
                    }),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            color: Colors.transparent,
                          ),
                          GetX<home_GetxController>(
                              builder: (home_GetxController controller) {
                            return (controller.isLoadingLastAucation.isTrue)
                                ? shimmerWidget(width: width)


                                :
                            controller.lastAucations_model!=null?

                            controller.lastAucations_model!.data!.data!.isNotEmpty
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Last Aucations'.tr,
                                                style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppColors.black_color),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.to(
                                                      LastAucations_Screen());
                                                },
                                                child: Text(
                                                  'View All'.tr,
                                                  style: TextStyle(
                                                      fontFamily: 'Cairo',
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          AppColors.gray_color),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          AspectRatio(
                                            aspectRatio: Helper.childAspectRatio(2.45),
                                            child: ListView.separated(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                physics:
                                                    BouncingScrollPhysics(),
                                                padding: EdgeInsets.zero,
                                                itemCount: controller
                                                    .lastAucations_model!
                                                    .data!
                                                    .data!
                                                    .length,
                                                separatorBuilder:
                                                    (context, index) {
                                                  return SizedBox(
                                                    width: 14.w,
                                                  );
                                                },
                                                itemBuilder: (context, index) {
                                                  DateTime now = DateTime.now();
                                                  DateTime dt1 = DateTime.parse(
                                                      controller
                                                          .lastAucations_model!
                                                          .data!
                                                          .data![index]
                                                          .auctionTo
                                                          .toString());
                                                  Duration diff =
                                                      dt1.difference(now);
                                                  // var Time=   DateFormat("hh:mm:ss").format(now);
                                                  return
                                                    StreamBuilder<DocumentSnapshot>(
                                                        stream: FbFireStoreController().getAucationLastBid(aucationID: controller.lastAucations_model!
                                                            .data!.data![index].id),
                                                        builder: (BuildContext context,
                                                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                                                          if (snapshot!.hasData) {
                                                            var data = snapshot.data!;
                                                            return GestureDetector(
                                                              onTap: () async {
                                                                if (await Helper()
                                                                    .checkInternet()) {
                                                                  singleAucations_Model?
                                                                  singleAucation = await controller.getAucationByID(
                                                                      context:  context,

                                                                      ID: controller
                                                                          .lastAucations_model!
                                                                          .data
                                                                          .data[index]
                                                                          .id
                                                                          .toString());
                                                                  if (singleAucation != null) {
                                                                    if (singleAucation.data.user!.userId ==
                                                                        _profile_getxController.profile_model!.data.userId) {
                                                                      Get.to(mySingleAucation_Screen(
                                                                          aucations_model:
                                                                          singleAucation));
                                                                    } else {
                                                                      await Get.to(
                                                                          singleAucation_Screen(
                                                                              aucations_model:
                                                                              singleAucation));
                                                                    }
                                                                  } else {

                                                                  }
                                                                } else {
                                                                  Helper().show_Dialog(
                                                                      context: context,
                                                                      title: 'No Internet'.tr,
                                                                      img: AppImages.no_internet,
                                                                      subTitle: 'Try Again'.tr);
                                                                }
                                                              },
                                                              child: lastAucations_widget(
                                                                title: SharedPreferencesController()
                                                                    .languageCode ==
                                                                    'en'
                                                                    ? controller
                                                                    .lastAucations_model!
                                                                    .data
                                                                    .data[index]
                                                                    .title
                                                                    .toString()
                                                                    : controller
                                                                    .lastAucations_model!
                                                                    .data
                                                                    .data[index]
                                                                    .titleAr
                                                                    .toString(),
                                                                width: 290.w,
                                                                img: controller
                                                                    .lastAucations_model!
                                                                    .data
                                                                    .data[index]
                                                                    .photo
                                                                    .toString(),
                                                                paragraph: SharedPreferencesController()
                                                                    .languageCode ==
                                                                    'en'
                                                                    ? controller
                                                                    .lastAucations_model!
                                                                    .data
                                                                    .data[index]
                                                                    .description
                                                                    .toString()
                                                                    : controller
                                                                    .lastAucations_model!
                                                                    .data
                                                                    .data[index]
                                                                    .descriptionAr
                                                                    .toString(),
                                                                name: '',
                                                                bidCount: controller
                                                                    .lastAucations_model!
                                                                    .data
                                                                    .data[index]
                                                                    .bidsCount
                                                                    .toString(),
                                                                time: diff.inSeconds <= 0
                                                                    ? 'Aucation Ended'.tr
                                                                    : '${formatDuration(diff)}',
                                                                price: data.exists?
                                                                data['lastPrice'].toString():
                                                                     controller
                                                                    .lastAucations_model!
                                                                    .data
                                                                    .data[index]
                                                                    .minBid
                                                                    .toString(),
                                                              ),
                                                            );
                                                          } else {
                                                            return SizedBox();
                                                          }
                                                        });
                                                }),
                                          ),
                                        ],
                                      )
                                    : SizedBox():SizedBox();
                          }),
                          SizedBox(
                            height: 15.h,
                          ),
                          GetX<home_GetxController>(
                              builder: (home_GetxController controller) {
                            return (controller
                                    .isLoadingLastAdvertisements.isTrue)
                                ? shimmerWidget(width: width)
                                :

                            controller.advertisements_model!=null?

                            controller.advertisements_model!.data.data2!
                                        .isNotEmpty
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Last Advertisment'.tr,
                                                style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppColors.black_color),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.to(
                                                      LastAdvertisment_Screen());
                                                },
                                                child: Text(
                                                  'View All'.tr,
                                                  style: TextStyle(
                                                      fontFamily: 'Cairo',
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          AppColors.gray_color),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          AspectRatio(
                                            aspectRatio: Helper.childAspectRatio(2.45),
                                            child: ListView.separated(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                physics:
                                                    BouncingScrollPhysics(),
                                                padding: EdgeInsets.zero,
                                                clipBehavior: Clip.none,
                                                itemCount: controller
                                                    .advertisements_model!
                                                    .data
                                                    .data2!
                                                    .length,
                                                separatorBuilder:
                                                    (context, index) {
                                                  return SizedBox(
                                                    width: 14.w,
                                                  );
                                                },
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () async {
                                                      if (await Helper().checkInternet()) {
                                                        singleAdvertisement_Model?
                                                            adv = await _advertisements_getxController
                                                                .getAdvertisementByID(
                                                            context: context,

                                                            ID: controller
                                                                        .advertisements_model!
                                                                        .data
                                                                        .data2[
                                                                            index]
                                                                        .id
                                                                        .toString());
                                                        if (adv != null) {
                                                          _advertisements_getxController
                                                              .getCommentByID(
                                                                  ID: controller
                                                                      .advertisements_model!
                                                                      .data
                                                                      .data2[
                                                                          index]
                                                                      .id
                                                                      .toString());
                                                          if (adv.data.user!
                                                                  .userId ==
                                                              _profile_getxController
                                                                  .profile_model!
                                                                  .data
                                                                  .userId) {
                                                            Get.to(MyAdvertisement_Screen(adv_model: adv));
                                                          } else {
                                                            Get.to(singleAdvertisement_Screen(adv_model: adv));
                                                          }
                                                        } else {

                                                        }
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
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              AppColors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              CachedNetworkImage(
                                                                fit: BoxFit.cover,
                                                                height: 154.h,
                                                                width: width,
                                                                imageUrl: controller
                                                                    .advertisements_model!
                                                                    .data
                                                                    .data2[index]
                                                                    .photo
                                                                    .toString(),
                                                              ),
                                                        if( controller
                                                            .advertisements_model!
                                                            .data
                                                            .data2[index].paid!=0)      Container(
                                                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                                                decoration: BoxDecoration(
                                                                  color: Colors.amber
                                                                ),
                                                                child: Text(
                                                                  'paid'.tr,
                                                                  style: TextStyle(
                                                                      fontFamily: 'Cairo',
                                                                      fontSize: 18.sp,
                                                                    color: Colors.white

                                                                  ))
                                                              )

                                                            ],
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        5.w,
                                                                    vertical:
                                                                        15.h),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                SizedBox(
                                                                  width: 160.w,
                                                                  child: Text(
                                                                    SharedPreferencesController().languageCode ==
                                                                            'en'
                                                                        ? controller
                                                                            .advertisements_model!
                                                                            .data
                                                                            .data2![
                                                                                index]
                                                                            .title
                                                                            .toString()
                                                                        : controller
                                                                            .advertisements_model!
                                                                            .data
                                                                            .data2![index]
                                                                            .titleAr
                                                                            .toString(),
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
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
                                                                ),
                                                                SizedBox(
                                                                  height: 5.h,
                                                                ),
                                                                SizedBox(
                                                                  width: 150.w,
                                                                  child: Row(
                                                                    children: [
                                                                      SvgPicture.asset(
                                                                          AppImages
                                                                              .messages),
                                                                      SizedBox(
                                                                        width:
                                                                            5.w,
                                                                      ),
                                                                      Text(
                                                                        controller
                                                                            .advertisements_model!
                                                                            .data
                                                                            .data2[index]
                                                                            .commentsCount
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Cairo',
                                                                            fontSize:
                                                                                14.sp,
                                                                            overflow: TextOverflow.clip,
                                                                            fontWeight: FontWeight.w600,
                                                                            color: AppColors.darkgray_color),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 5.h,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Image.asset(
                                                                        AppImages
                                                                            .price),
                                                                    SizedBox(
                                                                      width:
                                                                          5.w,
                                                                    ),
                                                                    Text(
                                                                      controller.advertisements_model!.data.data2[index].price.toString() +
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
                                          ),
                                        ],
                                      )
                                    : SizedBox():SizedBox();
                          }),
                          SizedBox(
                            height: 50.h,
                          ),
                          GetX<home_GetxController>(
                              builder: (home_GetxController controller) {
                            return (controller.isLoadingAdvertisements.isTrue)
                                ? Center(
                                    child: LoadingAnimationWidget.waveDots(
                                      color: AppColors.main_color,
                                      size: 40,
                                    ),
                                  )
                                :
                            controller.AllAdvertisement_Categories!=null?

                            SizedBox(
                                    child: ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemCount: controller
                                            .AllAdvertisement_Categories!.data.length,
                                        separatorBuilder: (context, index) {
                                          return SizedBox(
                                            height: 20.h,
                                          );
                                        },
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              /*
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Spacer(),
                                                  // Text(
                                                  //   controller.AllAdvertisement!
                                                  //       .data[index].advertisementsCount
                                                  //       .toString(),
                                                  //   style: TextStyle(
                                                  //       fontFamily:
                                                  //       'Cairo',
                                                  //       fontSize:
                                                  //       13.sp,
                                                  //       overflow:
                                                  //       TextOverflow
                                                  //           .clip,
                                                  //       fontWeight:
                                                  //       FontWeight
                                                  //           .bold,
                                                  //       color: AppColors
                                                  //           .black_color),
                                                  // ),
                                                ],
                                              ),


                                               */
                                              Text(
                                                SharedPreferencesController()
                                                            .languageCode ==
                                                        'en'
                                                    ? controller
                                                        .AllAdvertisement_Categories!
                                                        .data[index]
                                                        .name
                                                        .toString()
                                                    : controller
                                                        .AllAdvertisement_Categories!
                                                        .data[index]
                                                        .name_ar
                                                        .toString(),
                                                style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppColors.black_color),
                                              ),
                                              SizedBox(
                                                height: 20.w,
                                              ),
                                              GridView.builder(
                                                  shrinkWrap: true,
                                                  // scrollDirection: Axis.horizontal,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  padding: EdgeInsets.zero,
                                                  itemCount: controller
                                                      .AllAdvertisement_Categories!
                                                      .data[index]
                                                      .subCategories!
                                                      .length,
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                          mainAxisExtent: 185.h,
                                                          childAspectRatio:
                                                              203 / 170,
                                                          crossAxisSpacing:
                                                              15.w,
                                                          mainAxisSpacing: 15.h,
                                                          crossAxisCount: 2),
                                                  itemBuilder:
                                                      (context, index2) {
                                                    return GestureDetector(
                                                      onTap: () async {


                                                        if (await Helper().checkInternet()) {
                                                          advertisementCategoryDetails_Model?category = await controller
                                                                  .get_category_by_id(
                                                            ID: controller
                                                                .AllAdvertisement_Categories!
                                                                .data[index]
                                                                .subCategories![
                                                                    index2]
                                                                .id
                                                                .toString(),
                                                          );

                                                          if (category != null) {
                                                            await _advertisements_getxController
                                                                .get_category_types(
                                                              ID: controller
                                                                  .AllAdvertisement_Categories!
                                                                  .data[index]
                                                                  .subCategories![
                                                                      index2]
                                                                  .id
                                                                  .toString(),
                                                            );
                                                            Get.to(advertiseSubCategory_Screen(
                                                                CategoryName: SharedPreferencesController()
                                                                            .languageCode ==
                                                                        'en'
                                                                    ? controller
                                                                        .AllAdvertisement_Categories!
                                                                        .data[
                                                                            index]
                                                                        .subCategories![
                                                                            index2]
                                                                        .name
                                                                        .toString()
                                                                    : controller
                                                                        .AllAdvertisement_Categories!
                                                                        .data[
                                                                            index]
                                                                        .subCategories![
                                                                            index2]
                                                                        .name_ar
                                                                        .toString(),
                                                                CategoryID: controller
                                                                    .AllAdvertisement_Categories!
                                                                    .data[index]
                                                                    .subCategories![
                                                                        index2]
                                                                    .id
                                                                    .toString()));
                                                          }
                                                        } else {
                                                          Helper().show_Dialog(
                                                              context: context,
                                                              title: 'No Internet'.tr,
                                                              img: AppImages.no_internet,
                                                              subTitle: 'Try Again'.tr);
                                                        }
                                                      },
                                                      child: Container(
                                                        height: 185.h,
                                                        width: 170.w,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                AppColors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        // padding: EdgeInsets.only(bottom: 10.h),
                                                        child: Stack(
                                                          children: [
                                                            CachedNetworkImage(
                                                              fit: BoxFit.cover,
                                                              height: 185.h,
                                                              width: width,
                                                              imageUrl: controller
                                                                  .AllAdvertisement_Categories!
                                                                  .data[index]
                                                                  .subCategories![
                                                                      index2]
                                                                  .icon
                                                                  .toString(),
                                                            ),
                                                            Center(
                                                              child: Text(
                                                                SharedPreferencesController()
                                                                            .languageCode ==
                                                                        'en'
                                                                    ? controller
                                                                        .AllAdvertisement_Categories!
                                                                        .data[
                                                                            index]
                                                                        .subCategories![
                                                                            index2]
                                                                        .name
                                                                        .toString()
                                                                    : controller
                                                                        .AllAdvertisement_Categories!
                                                                        .data[
                                                                            index]
                                                                        .subCategories![
                                                                            index2]
                                                                        .name_ar
                                                                        .toString(),
                                                                style:
                                                                    TextStyle(
                                                                        fontFamily:
                                                                            'Cairo',
                                                                        fontSize: 16
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        shadows: [
                                                                          BoxShadow(
                                                                            color:
                                                                                Colors.grey,

                                                                            spreadRadius:
                                                                                20,

                                                                            blurRadius:
                                                                                20,

                                                                            offset:
                                                                                Offset(2, 2), // changes position of shadow
                                                                          ),
                                                                          BoxShadow(
                                                                            color:
                                                                                Colors.grey,

                                                                            spreadRadius:
                                                                                20,

                                                                            blurRadius:
                                                                                20,

                                                                            offset:
                                                                                Offset(2, 2), // changes position of shadow
                                                                          ),
                                                                          BoxShadow(
                                                                            color:
                                                                                Colors.grey,

                                                                            spreadRadius:
                                                                                20,

                                                                            blurRadius:
                                                                                20,

                                                                            offset:
                                                                                Offset(2, 2), // changes position of shadow
                                                                          ),
                                                                        ],
                                                                        color: AppColors
                                                                            .white),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  })
                                            ],
                                          );
                                        }),
                                  ):SizedBox();
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              GetX<home_GetxController>(
                  builder: (home_GetxController controller) {
                return (controller.isLoadingData.isTrue ||
                        controller.isLoadingCategoryData.isTrue)
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
          )),
    );
  }
}

class shimmerWidget extends StatelessWidget {
  const shimmerWidget({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 275.h,
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: 3,
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 14.w,
            );
          },
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {},
              child: Container(
                height: 203.h,
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
                              borderRadius: BorderRadius.circular(8)),
                          child: Container(
                            width: width,
                            height: 154.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                            ),
                          ),
                        )),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                  borderRadius: BorderRadius.circular(8)),
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
                                  borderRadius: BorderRadius.circular(8)),
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
                                  borderRadius: BorderRadius.circular(8)),
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
                                  borderRadius: BorderRadius.circular(8)),
                            ),
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
  }
}
