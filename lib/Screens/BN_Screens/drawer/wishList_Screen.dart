
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mazzad/Screens/BN_Screens/Aucations/mySingleAucation_Screen.dart';
import 'package:mazzad/Utils/Helper.dart';
import 'package:mazzad/firebase/firebase_dynamic_links.dart';
import 'package:share_plus/share_plus.dart';

import '../../../Controllers/GetxController/AdvertisementsController.dart';
import '../../../Controllers/GetxController/homeController.dart';
import '../../../Controllers/GetxController/profileController.dart';
import '../../../Database/SharedPreferences/shared_preferences.dart';
import '../../../Models/singleAdvertisement_Model.dart';
import '../../../Models/singleAucations_Model.dart';
import '../../../Utils/AppColors.dart';
import '../../../Utils/asset_images.dart';
import '../../../Utils/customElevatedButton.dart';
import '../Aucations/singleAucation_Screen.dart';
import '../advertise/MyAdvertisement_Screen.dart';
import '../advertise/singleAdvertisement_Screen.dart';

class wishList_Screen extends StatefulWidget {
  const wishList_Screen({Key? key}) : super(key: key);

  @override
  State<wishList_Screen> createState() => _wishList_ScreenState();
}

class _wishList_ScreenState extends State<wishList_Screen> {
  // var _auth_getxController = Get.find<Auth_GetxController>();
  var _profile_getxController = Get.find<profile_GetxController>();
  var _home_getxController = Get.find<home_GetxController>();
  var _adv_getxController = Get.find<Advertisements_GetxController>();

  bool isAdvertise =true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
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
          'Favourite'.tr,
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
            padding: EdgeInsets.only(top: 35.h, left: 10.w, right: 10.w, bottom: 10.h),
            child: RefreshIndicator(
              onRefresh: ()async{
                _profile_getxController.get_my_advertisement_wishlists();
                _profile_getxController.get_my_auction_wishlists();
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
                            isAdvertise = true;
                            setState(() {});
                          },
                          child: Container(
                            height: 60.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: isAdvertise
                                    ? AppColors.main_color
                                    : AppColors.white),
                            child: Center(
                              child: Text(
                                'Advertisements'.tr,
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: isAdvertise
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
                            isAdvertise = false;
                            setState(() {});
                          },
                          child: Container(
                            height: 60.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: !isAdvertise
                                    ? AppColors.main_color
                                    : AppColors.white),
                            child: Center(
                              child: Text(
                                'Aucations'.tr,
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: !isAdvertise
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
                      visible: isAdvertise,
                      child: SizedBox(
                          width: width,
                          child: GetX<profile_GetxController>(
                              builder: (profile_GetxController controller) {
                                return controller.isLoadingAdvertisement_wishlists.isTrue
                                    ? Center(
                                  child: Container(
                                    height: 60.h,
                                    width: 60.w,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: AppColors.background_color),
                                    child: LoadingAnimationWidget.fourRotatingDots(
                                      color: AppColors.main_color,
                                      size: 40,
                                    ),
                                  ),
                                )
                                    : controller.advertisement_wishlists_model!.data.isEmpty
                                    ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                      'no Favourite Advertisements'.tr,
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
                                      physics: NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemCount:controller.advertisement_wishlists_model!.data.length,
                                      separatorBuilder: (context, index) {
                                        return SizedBox(
                                          height: 14.h,
                                        );
                                      },
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () async {
                                            singleAdvertisement_Model? adv= await _adv_getxController.getAdvertisementByID(
                                                context: context,

                                                ID: controller.advertisement_wishlists_model!.data[index].advertisementId.toString());
                                            if(adv!=null){
                                              _adv_getxController.getCommentByID(ID:controller.advertisement_wishlists_model!.data[index].advertisementId.toString());
                                              if (adv.data.user!.id == _profile_getxController.profile_model!.data.userId) {
                                                Get.to(MyAdvertisement_Screen(adv_model:adv));
                                              } else {
                                                Get.to(singleAdvertisement_Screen(adv_model: adv));
                                              }



                                            }else{
                                            }
                                          },
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
                                                      clipBehavior:
                                                      Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(8)),
                                                      child: CachedNetworkImage(
                                                        fit: BoxFit.cover,
                                                        width: 135.w,
                                                        height: 135.h,
                                                        imageUrl: controller.advertisement_wishlists_model!.data[index].advertisement.photo.toString(),
                                                   ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        right: 10.w, left: 10.w
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          SizedBox(
                                                            width: 150.w,
                                                            // height: 50.h,
                                                            child: Text(
                                                              SharedPreferencesController().languageCode=='en'?

                                                              controller.advertisement_wishlists_model!.data[index].advertisement.title.toString():controller.advertisement_wishlists_model!.data[index].advertisement.titleAr.toString(),
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                  'Cairo',
                                                                  fontSize: 12.sp,
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
                                                              SharedPreferencesController().languageCode=='en'?

                                                              controller.advertisement_wishlists_model!.data[index].advertisement.description.toString():controller.advertisement_wishlists_model!.data[index].advertisement.descriptionAr.toString(),
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                  'Cairo',
                                                                  fontSize: 9.sp,
                                                                  overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                                  color: AppColors
                                                                      .black_color
                                                                      .withOpacity(
                                                                      0.54)),
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
                                                                        .love,
                                                                    ),
                                                                SizedBox(
                                                                  width: 5.w,
                                                                ),
                                                                Text(
                                                                  controller.advertisement_wishlists_model!.data[index].advertisement.wishlist.toString(),
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                      'Cairo',
                                                                      fontSize:
                                                                      12.sp,
                                                                      overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                      color: AppColors
                                                                          .gray_color),
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
                                                                  width: 5.w,
                                                                ),
                                                                Text(
                                                                  controller.advertisement_wishlists_model!.data[index].advertisement.price.toString(),
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                      'Cairo',
                                                                      fontSize:
                                                                      14.sp,
                                                                      overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                      color: AppColors
                                                                          .main_color),
                                                                ),
                                                                Spacer(),

                                                                Text(
                                                                  'View'.tr,
                                                                  style: TextStyle(
                                                                      fontFamily: 'Cairo',
                                                                      fontSize: 12.sp,
                                                                      overflow:
                                                                      TextOverflow.clip,
                                                                      fontWeight:
                                                                      FontWeight.w500,
                                                                      color: AppColors
                                                                          .gray_color),
                                                                ), SizedBox(
                                                                  width: 5.w,
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

                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                );
                              })),

                      replacement: SizedBox(
                          width: width,
                          child: GetX<profile_GetxController>(
                              builder: (profile_GetxController controller) {
                                return controller.isLoadingAuctions_wishlists.isTrue
                                    ? Center(
                                  child: Container(
                                    height: 60.h,
                                    width: 60.w,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: AppColors.background_color),
                                    child: LoadingAnimationWidget.fourRotatingDots(
                                      color: AppColors.main_color,
                                      size: 40,
                                    ),
                                  ),
                                )
                                    : controller.auctions_wishlists_model!.data.isEmpty
                                    ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                      'no Favourite Aucations'.tr,
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
                                      physics: BouncingScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemCount: controller.auctions_wishlists_model!.data
                                          .length,
                                      separatorBuilder: (context, index) {
                                        return SizedBox(
                                          height: 14.h,
                                        );
                                      },
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () async {
                                            // await controller.getAdvertisementByID(
                                            //     ID: controller
                                            //         .Waiting_advertisements!
                                            //         .data
                                            //         .data[index]
                                            //         .id
                                            //         .toString());

                                            // Get.to(MyAdvertisement_Screen(adv_model: controller.singleAdvertisement));



                                            singleAucations_Model?  singleAucation = await _home_getxController.getAucationByID(
                                                context:  context,
                                                ID: controller.auctions_wishlists_model!.data[index].auctionId.toString());

                                            if(singleAucation!=null){
                                              if(singleAucation.data.user!.id==_profile_getxController.profile_model!.data.userId){
                                                Get.to(mySingleAucation_Screen(
                                                    aucations_model: singleAucation));
                                              }else{
                                                await Get.to(singleAucation_Screen(aucations_model: singleAucation));

                                              }




                                            }

                                          },
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
                                                      clipBehavior:
                                                      Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(8)),
                                                      child: CachedNetworkImage(
                                                        fit: BoxFit.cover,
                                                        width: 135.w,
                                                        height: 135.h,
                                                        imageUrl:controller.auctions_wishlists_model!.data[index].auction!.photo.toString(),
                                                   ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        right: 10.w,    left: 10.w

                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          SizedBox(
                                                            width: 150.w,
                                                            // height: 50.h,
                                                            child: Text(
                                                              SharedPreferencesController().languageCode=='en'?

                                                              controller.auctions_wishlists_model!.data[index].auction!.title.toString():controller.auctions_wishlists_model!.data[index].auction!.titleAr.toString(),
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                  'Cairo',
                                                                  fontSize: 12.sp,
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
                                                              SharedPreferencesController().languageCode=='en'?

                                                              controller.auctions_wishlists_model!.data[index].auction!.description.toString(): controller.auctions_wishlists_model!.data[index].auction!.descriptionAr.toString(),
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                  'Cairo',
                                                                  fontSize: 9.sp,
                                                                  overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                                  color: AppColors
                                                                      .black_color
                                                                      .withOpacity(
                                                                      0.54)),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10.h,
                                                          ),
                                                          SizedBox(
                                                            width: 181.w,
                                                            child: Row(
                                                              children: [
                                                                Image.asset(
                                                                    AppImages
                                                                        .price),
                                                                SizedBox(
                                                                  width: 5.w,
                                                                ),
                                                                Text(
                                                                  controller.auctions_wishlists_model!.data[index].auction!.price.toString(),
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                      'Cairo',
                                                                      fontSize:
                                                                      14.sp,
                                                                      overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                      color: AppColors
                                                                          .main_color),
                                                                ),
                                                                Spacer(),
                                                                GestureDetector(
                                                                  onTap: ()async{
                                                                    String shortUrl = await DynamicLinksService.createDynamicLink(
                                                                      type: 'Aucation',
                                                                      parameter: controller.auctions_wishlists_model!.data[index].auction!.id.toString(),
                                                                    );

                                                                    Share.share(shortUrl);
                                                                  },
                                                                  child: Text(
                                                                    'share'.tr,
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
                                                                            .w500,
                                                                        color: AppColors
                                                                            .gray_color),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 5.w,
                                                                ),
                                                                SvgPicture.asset(
                                                                    AppImages
                                                                        .share,
                                                                    width: 20.w),
                                                              ],
                                                            ),
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
                                      }),
                                );
                              })),
                    ),

                  ],
                ),
              ),
            ),
          ),
          Center(
            child: GetX<home_GetxController>(
                builder: ( home_GetxController controller){
                  return (controller.isLoadingData.isTrue) ?
                  Center(
                    child: Container(
                      height: 60.h,
                      width: 60.w,
                      padding: EdgeInsets.all(10),
                      decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(8)
                          ,color: AppColors.main_color
                      ) ,
                      child: LoadingAnimationWidget.fourRotatingDots(
                        color: AppColors.white,
                        size: 40,
                      ),),
                  ):Container();




                }),
          ),
          Center(
            child: GetX<Advertisements_GetxController>(
                builder: ( Advertisements_GetxController controller){
                  return (controller.isLoadingData.isTrue) ?
                  Center(
                    child: Container(
                      height: 60.h,
                      width: 60.w,
                      padding: EdgeInsets.all(10),
                      decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(8)
                          ,color: AppColors.main_color
                      ) ,
                      child: LoadingAnimationWidget.fourRotatingDots(
                        color: AppColors.white,
                        size: 40,
                      ),),
                  ):Container();




                }),
          ),
        ],
      ),
    );
  }
}
