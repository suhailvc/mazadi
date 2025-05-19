import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mazzad/Database/SharedPreferences/shared_preferences.dart';
import 'package:mazzad/Screens/BN_Screens/advertise/MyAdvertisement_Screen.dart';
import 'package:mazzad/Screens/BN_Screens/advertise/singleAdvertisement_Screen.dart';
import 'package:mazzad/Utils/AppColors.dart';
import 'package:mazzad/Utils/Helper.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Controllers/GetxController/AdvertisementsController.dart';
import '../../../Controllers/GetxController/homeController.dart';
import '../../../Controllers/GetxController/profileController.dart';
import '../../../Models/advertisementCategories_Model.dart';
import '../../../Models/advertisementCategoryDetails_Model.dart';
import '../../../Models/singleAdvertisement_Model.dart';
import '../../../Utils/Constant.dart';
import '../../../Utils/asset_images.dart';

class advertiseForSubCategory_Screen extends StatefulWidget {
  late String CategoryName;
  late int? TypeID;

  advertiseForSubCategory_Screen({required this.CategoryName,this.TypeID});

  @override
  State<advertiseForSubCategory_Screen> createState() =>
      _advertiseForSubCategory_ScreenState();
}

class _advertiseForSubCategory_ScreenState
    extends State<advertiseForSubCategory_Screen> {

  bool isAllType=true;

  var _advertisements_getxController = Get.find<Advertisements_GetxController>();
  var _profile_getxController = Get.find<profile_GetxController>();


  // late BannerAd _bannerAd;
  bool isAdmobLoaded = false;

  late ScrollController scrollController ;

  Future scrollListen() async {

    scrollController.addListener(() async {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent) {
        _advertisements_getxController.get_advertisement_byCategory_Pagination();
      }
    });

  }



  @override
  void initState() {

    super.initState();
    scrollController= ScrollController();
    scrollListen();
    if(widget.TypeID!=null){
      isAllType=false;
    }
    setState(() {});
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
            icon: Icon(Icons.arrow_back, color: AppColors.darkgray_color),
            onPressed: () {
              Get.back();
            }),
        title: Text(
          widget.CategoryName,
          style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black_color),
        ),
        // actions: [
        //   IconButton(
        //       icon: SvgPicture.asset(AppImages.search), onPressed: () {}),
        // ],
      ),
      body:
      GetX<Advertisements_GetxController>(
        builder: (Advertisements_GetxController controller) {
      return (controller.isLoadingCategoryAdvertisements.isTrue)
          ? Center(
        child: LoadingAnimationWidget.dotsTriangle(
          color: AppColors.main_color,
          size: 40,
        ),
      )
          :

      Padding(
        padding: EdgeInsets.only(
          top: 15.h,
          left: 10.w,
          right: 10.w,
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: scrollController,

              physics: BouncingScrollPhysics(),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: Colors.transparent),
                  // Text(
                  //   'الاعلانات حسب النوع',
                  //   style: TextStyle(
                  //       fontFamily: 'Cairo',
                  //       fontSize: 16.sp,
                  //       fontWeight: FontWeight.bold,
                  //       color: AppColors.black_color),
                  // ),



              SizedBox(
      height: 50.h,
      child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () async {
                        isAllType=true;

                        _advertisements_getxController.changeTypeStatus();
                        setState(() {
                        });

                      },
                      child:Container(
                        height: 44.h,
                        width: 112.w,
                        decoration: BoxDecoration(
                            color:isAllType?AppColors.main_color: AppColors.white,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Center(
                          child: Text(

                            'All'.tr,
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color:isAllType? AppColors.white: AppColors.gray_color),
                          ),
                        ),
                      )
                  ),
                  SizedBox(
                    width: 14.w,
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: _advertisements_getxController.category_types!.data!.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: 14.w,
                        );
                      },
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () async {
                              // await  controller.get_category_by_id(ID: controller.AllAdvertisement!.data[index].subCategories![index2].id.toString(),);
                              //
                              // Get.to(advertiseSubCategory_Screen(Data:controller.categories_ID_model,));
                              _advertisements_getxController.changeTypeStatus(TypeID: int.parse(_advertisements_getxController.category_types!.data![index].id.toString()));
                              isAllType=false;
                              setState(() {

                              });
                            },
                            child:Container(
                              height: 44.h,
                              width: 112.w,
                              decoration: BoxDecoration(
                                  color:_advertisements_getxController.category_types!.data![index].isSelected?AppColors.main_color: AppColors.white,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Center(
                                child: Text(

                                  _advertisements_getxController.category_types!.data![index].name.toString(),
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color:_advertisements_getxController.category_types!.data![index].isSelected? AppColors.white: AppColors.gray_color),
                                ),
                              ),
                            )
                        );



                      }),
                ],
              ),
      ),
              ),

                  SizedBox(
                    height: 20.h,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Container(
                  //       child: isAdmobLoaded
                  //           ? Column(
                  //         children: [
                  //           Container(
                  //             height: _bannerAd.size.height.toDouble(),
                  //             width: _bannerAd.size.width.toDouble(),
                  //             child: AdWidget(ad: _bannerAd),
                  //           ), SizedBox(
                  //             height: 15.h,
                  //           ),
                  //         ],
                  //       )
                  //           : Container(),
                  //     ),
                  //   ],
                  // ),


                  Text(
                    'Available Advertisements'.tr,
                    style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black_color),
                  ),

                  SizedBox(
                    height: 20.h,
                  ),
                  GridView.builder(
                      shrinkWrap: true,
                      // scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: controller.advOfCategory_ListCopy.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: Helper.childAspectRatio(1.2),
                          crossAxisSpacing: 15.w,
                          mainAxisSpacing: 15.h,
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            GestureDetector(
                              onTap: () async {      if(await Helper().checkInternet()){
print(controller.advOfCategory_ListCopy[index]
    .id);
    var adv=await _advertisements_getxController
                                    .getAdvertisementByID(
      context: context,
                                    ID: controller.advOfCategory_ListCopy[index]
                                        .id
                                        .toString(),);
                               if(adv!=null){
                                 controller.getCommentByID(ID:controller.advOfCategory_ListCopy[index]
                                     .id
                                     .toString() );
                                 if (adv.data.user!.userId == _profile_getxController.profile_model!.data.userId) {

                                   Get.to(MyAdvertisement_Screen(adv_model:adv));
                                 } else {
                                   Get.to(singleAdvertisement_Screen(adv_model: adv));
                                 }



                                }else{

                                                         }
                                }else{
                                Helper().show_Dialog(
                                    context: context,
                                    title: 'No Internet'.tr,
                                    img: AppImages.no_internet,
                                    subTitle: 'Try Again'.tr);                                }

                              },
                              child: Container(
                                width: 170.w,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius:
                                    BorderRadius.circular(
                                        10)),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      height: 154.h,
                                      width: width,
                                      imageUrl: controller.advOfCategory_ListCopy[index]!
                                          .photo
                                          .toString(),
                                    ),
                                    Padding(
                                      padding:
                                      EdgeInsets.symmetric(
                                          horizontal: 5.w,
                                          vertical: 5.h),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          SizedBox(
                                            width: 160.w,
                                            child: Text(
                                              SharedPreferencesController().languageCode=='en'?
                                              controller.advOfCategory_ListCopy[index]!
                                                  .title
                                                  .toString(): controller.advOfCategory_ListCopy[index]!
                                                  .titleAr
                                                  .toString()


                                              ,
                                              maxLines: 1,
                                              overflow:
                                              TextOverflow
                                                  .ellipsis,
                                              style: TextStyle(
                                                  fontFamily:
                                                  'Cairo',
                                                  fontSize: 12.sp,
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
                                                  width: 5.w,
                                                ),
                                                Text(
                                                  controller.advOfCategory_ListCopy[
                                                  index]!
                                                      .comments_count
                                                      .toString(),
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
                                                          .w600,
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
                                                Image.asset
                                                  (
                                                    AppImages
                                                        .price),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Text(
                                                  controller.advOfCategory_ListCopy[
                                                  index]!
                                                      .price
                                                      .toString()+' '+'Qar'.tr,
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
                                                  'عرض',
                                                  style: TextStyle(
                                                      fontFamily:
                                                      'Cairo',
                                                      fontSize:
                                                      10.sp,
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
                                                    AppImages
                                                        .view,
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
                            if( controller.advOfCategory_ListCopy[index].paid!=0)      Container(
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
                        );
                      }),

                  SizedBox(
                    height: 30.h,
                  ),


                ],
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
      );})
    );
  }


/*
  void _createBannerAd() {

    _bannerAd = BannerAd(
      size: AdSize.banner,
      // adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      adUnitId: (Platform.isAndroid)
          ? Android_admobBanner1
          : IOS_admobBanner1,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          isAdmobLoaded = true;
          print('Ad Loaded');
          print('------------------------- Ad Loaded -------------------------');

          setState(() {

          });
        },
        onAdFailedToLoad: (ad, error) {
          print('------------------------- onAdFailedToLoad -------------------------');
          _bannerAd.dispose();
        },
      ),
      request: AdRequest(),
    );
    _bannerAd.load();
  }


 */
}
