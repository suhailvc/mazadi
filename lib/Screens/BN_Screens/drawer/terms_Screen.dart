import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../Controllers/GetxController/homeController.dart';
import '../../../Controllers/GetxController/profileController.dart';
import '../../../Utils/AppColors.dart';
import '../../../Utils/asset_images.dart';
import '../../../Utils/customElevatedButton.dart';

class terms_Screen extends StatefulWidget {
  const terms_Screen({Key? key}) : super(key: key);

  @override
  State<terms_Screen> createState() => _terms_ScreenState();
}

class _terms_ScreenState extends State<terms_Screen> {
  var _profile_GetxController = Get.find<profile_GetxController>();

refresh(){
  setState(() {

  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Terms and Conditions'.tr,
          style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black_color),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 25.w,vertical: 25.h),
          child: Column(
            children: [
              GetBuilder(builder: (home_GetxController home_getx){
                return
              Text(
                home_getx.setting_model!.data.terms,
             textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black_color),
              );
              })

            ],
          ),
        ),
      ),
    );
  }
  }

