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

class addNewPaymentWay_Screen extends StatefulWidget {
  const addNewPaymentWay_Screen({Key? key}) : super(key: key);

  @override
  State<addNewPaymentWay_Screen> createState() =>
      _addNewPaymentWay_ScreenState();
}

class _addNewPaymentWay_ScreenState extends State<addNewPaymentWay_Screen> {
  MyDrawerController _drawerController = Get.put(MyDrawerController());
  var _profile_getxController = Get.find<profile_GetxController>();



  late TextEditingController NameConttoller;
  late TextEditingController phoneConttoller;
  late TextEditingController emailConttoller;
  late TextEditingController whattsabConttoller;

  @override
  void initState() {
    super.initState();
    NameConttoller = TextEditingController();
    phoneConttoller = TextEditingController();
    emailConttoller = TextEditingController();
    whattsabConttoller = TextEditingController();
  }

  @override
  void dispose() {
    NameConttoller.dispose();
    phoneConttoller.dispose();
    emailConttoller.dispose();
    whattsabConttoller.dispose();
    super.dispose();
  }

  bool isAddNew = false;
  String RadioValue = 'payoneer';

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
            icon: Icon(Icons.arrow_back_ios, color: AppColors.darkgray_color),
            onPressed: () {
              Get.back();
            }),
        title: Text(
          'طرق الدفع',
          style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black_color),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 20.h,
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Divider(color: Colors.transparent),
            Row(
              children: [
                SizedBox(
                  width: 15.w,
                ),
                SvgPicture.asset(AppImages.wallet2),
                Text(
                  'طرق الدفع',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'اختيار طريقة الاضافة',
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black_color),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 21.h,
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 25.h, horizontal: 15.w),
                      decoration: BoxDecoration(
                          color: AppColors.background_color,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                AppImages.payoneer,
                                width: 26.w,
                                height: 26.h,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                'بطاقة ائتمان',
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black_color),
                              ),
                              Spacer(),
                              Radio(
                                value: 'payoneer',
                                groupValue: RadioValue,
                                onChanged: (value) {
                                  setState(() {
                                    RadioValue = value!;
                                  });
                                },
                                activeColor: AppColors.main_color,
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                AppImages.paypal,
                                width: 26.w,
                                height: 26.h,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                'باي بال',
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black_color),
                              ),
                              Spacer(),
                              Radio(
                                value: 'paypal',
                                groupValue: RadioValue,
                                onChanged: (value) {
                                  RadioValue = value!;
                                  setState(() {});
                                },
                                activeColor: AppColors.main_color,
                              )
                            ],
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 16.h,
                  ),
                  Container(
                    height: 45.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.background_color),
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: TextField(
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black_color.withOpacity(0.7),
                        fontFamily: 'Cairo',
                      ),
                      minLines: 1,
                      readOnly: true,
                      maxLines: 1,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        hintText: 'رقم البطاقة',
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
                    height: 16.h,
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 160.w,
                          child: profileTextField(
                            label: 'تاريخ الانتهاء',
                            controller: NameConttoller,
                          ),
                        ),
                        SizedBox(width: 15.w,),
                        SizedBox(
                          width: 160.w,
                          child: profileTextField(
                            label: 'الرقم السري',
                            controller: NameConttoller,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            SizedBox(
              height: 50.h,
              width: 335.w,
              child: customElevatedButton(
                onTap: () {},
                color: AppColors.main_color,
                child: Text(
                  'اضف الآن',
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
    required this.label,
    required this.controller,
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
              color: AppColors.background_color),
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
