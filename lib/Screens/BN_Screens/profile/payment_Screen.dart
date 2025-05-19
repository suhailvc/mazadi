import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../Controllers/GetxController/AucationsController.dart';
import '../../../Controllers/GetxController/drawerController.dart';
import '../../../Controllers/GetxController/profileController.dart';
import '../../../Utils/AppColors.dart';
import '../../../Utils/asset_images.dart';
import '../../../Utils/customElevatedButton.dart';
import 'addNewPaymentWay_Screen.dart';

class payment_Screen extends StatefulWidget {
  const payment_Screen({Key? key}) : super(key: key);

  @override
  State<payment_Screen> createState() => _payment_ScreenState();
}

class _payment_ScreenState extends State<payment_Screen> {
  MyDrawerController _drawerController = Get.put(MyDrawerController());
  // Auth_GetxController _auth_getxController = Get.put(Auth_GetxController());


  var _profile_getxController = Get.find<profile_GetxController>();


  late TextEditingController NameConttoller;
 late TextEditingController phoneConttoller;
 late TextEditingController emailConttoller;
 late TextEditingController whattsabConttoller;

 @override
  void initState() {
    super.initState();
    NameConttoller=TextEditingController();
    phoneConttoller=TextEditingController();
    emailConttoller=TextEditingController();
    whattsabConttoller=TextEditingController();
  }
  @override
  void dispose() {
    NameConttoller.dispose();
    phoneConttoller.dispose();
    emailConttoller.dispose();
    whattsabConttoller.dispose();
    super.dispose();
  }
  bool isAddNew=false;
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
            icon: Icon(Icons.arrow_back_ios,color: AppColors.darkgray_color),
            onPressed: () {
Get.back();
            }),
        title: Text(
          'payment methods'.tr,
          style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black_color),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h,),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Divider(color: Colors.transparent),
             
            Row(
              children: [
                SizedBox(width: 15.w,),
                SvgPicture.asset(AppImages.wallet2),
                Text(
                  'payment methods'.tr,
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black_color),
                ),

              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(

              padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 15.w),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [

                  Row(
                    children: [
                      Text(
                        'My Payment Methods'.tr,
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black_color),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 13.h,
                  ),

                  Container(
                    height: 45.h,

                    decoration: BoxDecoration (
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.gray_color.withOpacity(0.25)),
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImages.payoneer,width: 26.w,height: 26.h,),
SizedBox(width: 5.w,),
                        SizedBox(
                          width: 250.w,
                          child: TextField(
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black_color.withOpacity(0.7),
                              fontFamily: 'Cairo',
                            ),
                            minLines: 1,readOnly: true,
                            maxLines: 1,
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              hintText: 'Credit Card'.tr,

                              hintStyle: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                                fontFamily: 'Cairo',
                              ),
                              contentPadding: EdgeInsets.only(bottom: 5.h),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        Spacer(),
                        SvgPicture.asset(AppImages.failed,width: 26.w,height: 26.h,),
                      ],
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(
              height: 40.h,
            ),

            SizedBox(
              height: 50.h, width: 335.w,
              child: customElevatedButton(
                onTap: () {
                  Get.to(addNewPaymentWay_Screen());
                },
                color: AppColors.main_color,
                child: Text(
                  'Add Payment Methods'.tr,
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white),
                ),
              ),
            ),

          ]),
        ),
      ),
    );
  }
}

class profileTextField extends StatelessWidget {
  late String label;
  late TextEditingController controller;

  profileTextField({
 required   this.label,
 required   this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(AppImages.circle),
            SizedBox(
              width: 5.w,
            ),
            Text(
              label,
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black_color),
            ),
          ],
        ),
        SizedBox(
          height: 13.h,
        ),
        Container(
          height: 45.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.gray_color.withOpacity(0.25)),
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: TextField(
            controller: controller,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black_color,
              fontFamily: 'Cairo',
            ),
            minLines: 1,
            maxLines: 1,
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              hintText: '',
              hintStyle: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
                fontFamily: 'Cairo',
              ),
              contentPadding: EdgeInsets.only(bottom: 5.h),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}
