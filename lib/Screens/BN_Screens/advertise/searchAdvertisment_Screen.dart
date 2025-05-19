import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mazzad/Screens/BN_Screens/Aucations/singleAucation_Screen.dart';
import 'package:mazzad/Screens/BN_Screens/advertise/singleAdvertisement_Screen.dart';
import 'package:mazzad/Utils/Helper.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Controllers/GetxController/AdvertisementsController.dart';
import '../../../Controllers/GetxController/AucationsController.dart';
import '../../../Controllers/GetxController/homeController.dart';
import '../../../Controllers/GetxController/profileController.dart';
import '../../../Models/singleAdvertisement_Model.dart';
import '../../../Models/singleAucations_Model.dart';
import '../../../Utils/AppColors.dart';
import '../../../Utils/asset_images.dart';
import '../../../Utils/customElevatedButton.dart';
import '../home/home_Screen.dart';
import '../home/widget/lastAucations.dart';
import 'MyAdvertisement_Screen.dart';

class searchAdvertisment_Screen extends StatefulWidget {
  const searchAdvertisment_Screen({Key? key}) : super(key: key);

  @override
  State<searchAdvertisment_Screen> createState() =>
      _searchAdvertisment_ScreenState();
}

class _searchAdvertisment_ScreenState extends State<searchAdvertisment_Screen> {
  // var  _home_getxController = Get.find<home_GetxController>();
  var _home_getxController = Get.find<home_GetxController>();
  var _profile_getxController = Get.find<profile_GetxController>();

  var _advertisements_getxController =
      Get.find<Advertisements_GetxController>();

 late ScrollController scrollController ;
TextEditingController searchController =TextEditingController();
  Future scrollListen() async {

      scrollController.addListener(() async {
        if (scrollController.position.pixels >= scrollController.position.maxScrollExtent) {
          _advertisements_getxController.getSearchAdvertisment(title: '',is_Pagination: true);

        }
      });

  }
 @override
  void initState() {
    super.initState();
    searchController =TextEditingController();
    scrollController= ScrollController();
    scrollListen();
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      onRefresh: () async {
        if (await Helper().checkInternet()) {
          await _home_getxController.getLatest_advertisements();
        } else {
          Helper().show_Dialog(
              context: context,
              title: 'لا يتوفر اتصال بالانترنت',
              img: AppImages.no_internet,
              subTitle: 'حاول مرة اخرى');
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background_color,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0.2,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: AppColors.darkgray_color),
              onPressed: () {
                Get.back();
              }),
          title: TextFormField(

            controller: searchController,
            textAlignVertical: TextAlignVertical.bottom,
            maxLines: 1,
            minLines: 1,
textInputAction: TextInputAction.search,
            onFieldSubmitted: (value){
              if(value.isNotEmpty){
                _advertisements_getxController.getSearchAdvertisment(title: value);
              }
            },
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black_color,
              fontFamily: 'Cairo',
            ),

            decoration: InputDecoration(

              hintText: 'search'.tr,
              hintStyle: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
                fontFamily: 'Cairo',
              ),
              suffixIcon: IconButton(icon:Icon(Icons.search),onPressed: (){
                FocusScope.of(context).unfocus();
                if(searchController.text.isNotEmpty){

                  _advertisements_getxController.getSearchAdvertisment(title: searchController.text);
                }
              },),

              contentPadding: EdgeInsets.all(10.h),
              fillColor: AppColors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.r),
                borderSide:
                BorderSide(color:AppColors.main_color, width: 0.4),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.r),
                borderSide:
                BorderSide(color:AppColors.main_color, width: 0.4),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.r),
                borderSide:
                BorderSide(color:AppColors.main_color, width: 0.4),
              ),
              focusedErrorBorder:OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.r),
                borderSide:
                BorderSide(color:AppColors.main_color, width: 0.4),
              ),

            ),
          ),


        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 35.h, right: 10.w, left: 10.w),
              child: GetX<Advertisements_GetxController>(
                  builder: (Advertisements_GetxController controller) {
                return (controller.isGettingSearchAD.isTrue)
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
                    :
                controller.searchADV_model!=null?
                controller.searchADV_model!.data.data2!.isNotEmpty?
                Column(
                      children: [
                        Expanded(
                          child: GridView.builder(
                              shrinkWrap: true,
                              // scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              controller: scrollController,
                              padding: EdgeInsets.zero,
                              itemCount:
                                  controller.searchADV_model!.data.data2!.length,
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
                                              await _advertisements_getxController.getAdvertisementByID(
                                                  context: context,

                                                  ID: controller.searchADV_model!.data.data2[index].id.toString());
                                          print(
                                              'AD id ::${controller.searchADV_model!.data.data2[index].id.toString()}');

                                          if (adv != null) {
                                            _advertisements_getxController
                                                .getCommentByID(
                                                ID: controller
                                                    .searchADV_model!
                                                    .data
                                                    .data2[
                                                index]
                                                    .id
                                                    .toString());

                                            if (adv.data.user!.userId ==
                                                _profile_getxController
                                                    .profile_model!.data.userId) {
                                              Get.to(
                                                  MyAdvertisement_Screen(adv_model: adv));
                                            } else {
                                              Get.to(singleAdvertisement_Screen(
                                                  adv_model: adv));
                                            }
                                          } else {

                                          }
                                        }
                                        else {
                                          Helper().show_Dialog(
                                              context: context,
                                              title: 'لا يتوفر اتصال بالانترنت',
                                              img: AppImages.no_internet,
                                              subTitle: 'حاول مرة اخرى');
                                        }
                                      },
                                      child: Container(
                                        width: 170.w,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius: BorderRadius.circular(10)),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              height: 154.h,
                                              width: width,
                                              imageUrl: controller.searchADV_model!
                                                  .data.data2[index].photo
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
                                                      controller.searchADV_model!
                                                          .data.data2![index].title
                                                          .toString(),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontFamily: 'Cairo',
                                                          fontSize: 12.sp,
                                                          fontWeight: FontWeight.bold,
                                                          color: AppColors.black_color),
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
                                                              .searchADV_model!
                                                              .data
                                                              .data2[index]
                                                              .commentsCount
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontFamily: 'Cairo',
                                                              fontSize: 14.sp,
                                                              overflow: TextOverflow.clip,
                                                              fontWeight: FontWeight.w600,
                                                              color: AppColors
                                                                  .darkgray_color),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Image.asset(AppImages.price),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      Text(
                                                        controller.searchADV_model!
                                                                .data.data2[index].price
                                                                .toString() +
                                                            ' ' +
                                                            'Qar'.tr,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            fontFamily: 'Cairo',
                                                            fontSize: 14.sp,
                                                            overflow: TextOverflow.clip,
                                                            fontWeight: FontWeight.bold,
                                                            color:
                                                                AppColors.main_color),
                                                      ),

                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if( controller
                                        .searchADV_model!
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
                                );
                              }),
                        ),
                    if(controller.isGettingSearchAD_Pagination.isTrue)    Center(
                          child: LoadingAnimationWidget.waveDots(
                            color: AppColors.main_color,
                            size: 40,
                          ),
                        )
                      ],
                    ):Center(
                      child: Text(
                  'No Adv'.tr,
                  style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black_color),
                ),
                    ):SizedBox();
              }),
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
      ),
    );
  }
}
