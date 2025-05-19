import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mazzad/Controllers/GetxController/AdvertisementsController.dart';
import 'package:mazzad/Controllers/GetxController/homeController.dart';
import 'package:mazzad/Screens/BN_Screens/updateAdvertise/adv/UpdateAdvCategory_Screen.dart';
import 'package:mazzad/Utils/AppColors.dart';
import 'package:mazzad/Utils/customElevatedButton.dart';

import '../../../../Database/SharedPreferences/shared_preferences.dart';
import '../../../../Models/singleAdvertisement_Model.dart';
import '../../../../Models/singleAucations_Model.dart';


class UpdateAdvertismentLanguage_Screen extends StatefulWidget {
  late singleAdvertisement_Model? Adv_model;

  UpdateAdvertismentLanguage_Screen({required this.Adv_model});

  @override
  State<UpdateAdvertismentLanguage_Screen> createState() => _UpdateAdvertismentLanguage_ScreenState();
}

class _UpdateAdvertismentLanguage_ScreenState extends State<UpdateAdvertismentLanguage_Screen> {
  var _home_getxController = Get.find<home_GetxController>();
  var _Advertisements_getxController = Get.find<Advertisements_GetxController>();
  bool isAdv = true;
  bool isBothLanguage = true;
  bool isArabicLanguage = false;
  bool isEnglishLanguage = false;
@override
  void initState() {
    super.initState();
    SharedPreferencesController().oldDeletedPhotos = [];
    SharedPreferencesController().cover_image_id ='';
if(widget.Adv_model!.data.language=='both'){
  isBothLanguage = true;
  isArabicLanguage = false;
  isEnglishLanguage = false;
  SharedPreferencesController().newADVLanguage = 'both';

  setState(() {

  });
}
else if(widget.Adv_model!.data.language=='ar'){
  isArabicLanguage = true;       isBothLanguage = false;
  isEnglishLanguage = false;
  SharedPreferencesController().newADVLanguage = 'ar';

  setState(() {

  });
}
else{
  SharedPreferencesController().newADVLanguage = 'en';
isArabicLanguage = false;       isBothLanguage = false;

isEnglishLanguage = true;
  setState(() {

  });
}

  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.2,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          tooltip: 'back'.tr,
          icon: Icon(Icons.arrow_back, color: AppColors.lightgray_color),
        ),
        title: Text(
          'newAdv'.tr,
          style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black_color),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                color: Colors.transparent,
              ),
              /*
              Text(
                'selectAdvType'.tr,
                style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black_color),
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        isAdv = true;
                        setState(() {});
                      },
                      child: Stack(
                        children: [
                          Container(
                            height: 170.h,
                            width: 155.w,
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(AppImages.perspective_matte,
                                    height: 86.h),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Text(
                                  'shareYourAdv'.tr,
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.lightgray_color),
                                ),
                              ],
                            ),
                          ),
                          Checkbox(
                            value: isAdv,
                            onChanged: (x) {},
                            activeColor: AppColors.main_color,
                            side: BorderSide(color: AppColors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        isAdv = false;
                        setState(() {});
                      },
                      child: Stack(
                        children: [
                          Container(
                            height: 170.h,
                            width: 155.w,
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(AppImages.matte, height: 86.h),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Text(
                                  'shareYourAucation'.tr,
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.lightgray_color),
                                ),
                              ],
                            ),
                          ),
                          Checkbox(
                            value: !isAdv,
                            onChanged: (x) {},
                            activeColor: AppColors.main_color,
                            side: BorderSide(color: AppColors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),


               */
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Select Adv Language'.tr,
                style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black_color),
              ),
              SizedBox(
                height: 15.h,
              ),
              GestureDetector(
                onTap: () {
                  SharedPreferencesController().newADVLanguage = 'both';

                  setState(() {
                    isBothLanguage = true;
                    isArabicLanguage = false;
                    isEnglishLanguage = false;
                  });
                },
                child: Container(
                  width: width,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                  EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'both'.tr,
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: isBothLanguage
                                    ? AppColors.main_color
                                    : AppColors.black_color),
                          ),
                          Text(
                            'both Language'.tr,
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: isBothLanguage
                                    ? AppColors.main_color
                                    : AppColors.black_color),
                          ),
                        ],
                      ),
                      Spacer(),
                      Checkbox(
                        value: isBothLanguage,
                        onChanged: (x) {},
                        activeColor: AppColors.main_color,
                        side: BorderSide(color: AppColors.white),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              GestureDetector(
                onTap: () {
                  SharedPreferencesController().newADVLanguage = 'ar';

                  setState(() {
                    isBothLanguage = false;
                    isArabicLanguage = true;
                    isEnglishLanguage = false;
                  });
                },
                child: Container(
                  width: width,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                  EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Arabic'.tr,
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: isArabicLanguage
                                    ? AppColors.main_color
                                    : AppColors.black_color),
                          ),
                          SizedBox(
                            width: 280.w,
                            child: Text(
                              'Ad Arabic Language'.tr,
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: isArabicLanguage
                                      ? AppColors.main_color
                                      : AppColors.black_color),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Checkbox(
                        value: isArabicLanguage,
                        onChanged: (x) {},
                        activeColor: AppColors.main_color,
                        side: BorderSide(color: AppColors.white),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              GestureDetector(
                onTap: () {
                  SharedPreferencesController().newADVLanguage = 'en';

                  setState(() {
                    isBothLanguage = false;
                    isArabicLanguage = false;
                    isEnglishLanguage = true;
                  });
                },
                child: Container(
                  width: width,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                  EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'English'.tr,
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: isEnglishLanguage
                                    ? AppColors.main_color
                                    : AppColors.black_color),
                          ),
                          SizedBox(
                            width: 280.w,
                            child: Text(
                              'Ad English Language'.tr,
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: isEnglishLanguage
                                      ? AppColors.main_color
                                      : AppColors.black_color),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Checkbox(
                        value: isEnglishLanguage,
                        onChanged: (x) {},
                        activeColor: AppColors.main_color,
                        side: BorderSide(color: AppColors.white),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              customElevatedButton(
                onTap: () {
                  // if (isAdv) {
                  //   Get.to(chooseNewAdvCategory_Screen());
                  // }else{
                  if(widget.Adv_model!.data.category!.parent!.parentId !=null ||widget.Adv_model!.data.category!.parentId != null) {

                    // _home_getxController.AdvertisementChangeStatusByID(
                    //   ParentId: widget.Adv_model!.data.category!.parent!
                    //       .parentId!.toInt(),
                    //   Id: widget.Adv_model!.data.category!.parentId!.toInt(),
                    //
                    // );


                    SharedPreferencesController().subCategoryID =widget.Adv_model!.data.categoryId.toString();

                  }else{
                    _home_getxController.AdvertiseClearStatus();
                  }
                    Get.to(UpdateAdvCategory_Screen(Adv_model: widget.Adv_model,));
                },
                color: AppColors.main_color,
                child: Text(
                  'Continue'.tr,
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
