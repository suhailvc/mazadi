

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mazzad/Controllers/GetxController/homeController.dart';
import 'package:mazzad/Controllers/GetxController/profileController.dart';
import 'package:mazzad/Models/singleAucations_Model.dart';
import 'package:mazzad/Screens/BN_Screens/Aucations/mySingleAucation_Screen.dart';
import 'package:mazzad/Screens/BN_Screens/Aucations/singleAucation_Screen2.dart';
import 'package:mazzad/Utils/AppColors.dart';
import 'package:mazzad/Utils/Helper.dart';
import 'package:mazzad/Utils/asset_images.dart';

class viewAllRelatedAucation_Screen extends StatefulWidget {
  late singleAucations_Model? aucations_model;

  viewAllRelatedAucation_Screen({required this.aucations_model});
  @override
  State<viewAllRelatedAucation_Screen> createState() => _viewAllRelatedAucation_ScreenState();
}

class _viewAllRelatedAucation_ScreenState extends State<viewAllRelatedAucation_Screen> {
  var _home_getxController = Get.find<home_GetxController>();
  var _profile_getxController = Get.find<profile_GetxController>();

  String BidTime(String time) {
  DateTime now = DateTime.now();
  DateTime dt1 = DateTime.parse(time);
  Duration diff = now.difference(dt1);

  if(diff.inDays>0){
    return 'since'.tr+diff.inDays.toString()+'day'.tr;

  }else if(diff.inHours>0){
    return 'since'.tr+diff.inHours.toString()+'hour'.tr;


  }else{
    return 'since'.tr+diff.inMinutes.toString()+'minute'.tr;


  }
}

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background_color,
      appBar: AppBar(
        elevation: 0,centerTitle: true,
        title: Text(
          'Related Auctions'.tr,
          style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black_color),
        ),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          tooltip: 'back'.tr,

          icon: Icon(Icons.arrow_back, color: AppColors.lightgray_color),
        ),

      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
        child:GridView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount:
            widget.aucations_model!.data!.similarAuctions.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: Helper.childAspectRatio(1.35),
                crossAxisSpacing: 15.w,
                mainAxisSpacing: 15.h,
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
  if(await Helper().checkInternet()){

  singleAucations_Model singleAucation =
                  await _home_getxController.getAucationByID(
                      context:  context,

                      ID: widget.aucations_model!.data!
                          .similarAuctions[index].id
                          .toString());
                  if(singleAucation!=null){
                    if(singleAucation.data.user!.id==_profile_getxController.profile_model!.data.userId){
                      Get.to(mySingleAucation_Screen(
                          aucations_model: singleAucation));
                      print('my');
                    }else{
                      await Get.to(singleAucation_Screen2(aucations_model: singleAucation));
                      print('no');

                    }




                  }else{
                  }
                  }else{
    Helper() .show_Dialog(context: context,title: 'لا يتوفر اتصال بالانترنت',img: AppImages.no_internet,subTitle: 'حاول مرة اخرى');
  }
                },
                child: Container(
                  height: 250.h,
                  width: 162.w,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        fit: BoxFit.cover,
                        width: 300.w,
                        height: 157.h,
                        imageUrl: widget.aucations_model!.data!
                            .similarAuctions[index].photo
                            .toString(),
                      ),
                      Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 5.w),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 150.w,
                              // height: 50.h,
                              child: Text(
                                widget.aucations_model!.data!
                                    .similarAuctions[index].title
                                    .toString(),
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 12.sp,
                                    overflow: TextOverflow.clip,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black_color),
                              ),
                            ),
                            SizedBox(
                              width: 150.w,
                              // height: 50.h,
                              child: Text(
                                widget
                                    .aucations_model!
                                    .data
                                    .similarAuctions[index]
                                    .descriptionAr
                                    .toString(),
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 11.sp,
                                    overflow: TextOverflow.clip,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.gray_color),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
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
                                    widget.aucations_model!.data!
                                        .similarAuctions[index].price
                                        .toString()+' '+'Qar'.tr,
                                    style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 14.sp,
                                        overflow: TextOverflow.clip,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.main_color),
                                  ),
                                  Spacer(),
                                  Text(
                                    widget.aucations_model!.data!
                                        .similarAuctions[index].views
                                        .toString(),
                                    style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 10.sp,
                                        overflow: TextOverflow.clip,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.gray_color),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  SvgPicture.asset(AppImages.view,
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
              );
            }),
      ),

    );
  }
}
