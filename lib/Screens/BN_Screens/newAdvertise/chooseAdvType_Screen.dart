import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../Controllers/GetxController/drawerController.dart';
import '../../../Database/SharedPreferences/shared_preferences.dart';
import '../../../Utils/AppColors.dart';
import '../../../Utils/asset_images.dart';
import '../../../Utils/customElevatedButton.dart';
import 'Aucations/chooseNewAucationCategory_Screen.dart';
import 'adv/chooseNewAdvCategory_Screen.dart';

class chooseAdvType_Screen extends StatefulWidget {
  const chooseAdvType_Screen({Key? key}) : super(key: key);

  @override
  State<chooseAdvType_Screen> createState() => _chooseAdvType_ScreenState();
}

class _chooseAdvType_ScreenState extends State<chooseAdvType_Screen> {
  MyDrawerController _drawerController = Get.put(MyDrawerController());

  bool isAdv = true;
  bool isBothLanguage = false;
  bool isArabicLanguage = true;
  bool isEnglishLanguage = false;
@override
  void initState() {
  super.initState();
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
            icon: SvgPicture.asset(AppImages.drawer),
            onPressed: () {
              _drawerController.toggleDrawer();
            }),
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
              Text(
                'selectAdvType'.tr,
                style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black_color),
              ),
              SizedBox(
                height: 10.h,
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
              SizedBox(
                height: 12.h,
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
                height: 12.h,
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
                height: 12.h,
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
                height: 12.h,
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
                height: 25.h,
              ),






              customElevatedButton(
                onTap: () {
                  if (isAdv) {
                    Get.to(chooseNewAdvCategory_Screen());
                  }else{
                    Get.to(chooseNewAucationCategory_Screen());
                  }
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
