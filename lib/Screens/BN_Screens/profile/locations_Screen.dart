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

class locations_Screen extends StatefulWidget {
  const locations_Screen({Key? key}) : super(key: key);

  @override
  State<locations_Screen> createState() => _locations_ScreenState();
}

class _locations_ScreenState extends State<locations_Screen> {
  // Auth_GetxController _auth_getxController = Get.put(Auth_GetxController());
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
          'Addresses'.tr,
          style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black_color),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20.h,
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
                SvgPicture.asset(AppImages.location),
                Text(
                  'Addresses'.tr,
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
              height: 650.h,
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Previously added titles'.tr,
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
                  SizedBox(
                    child: GetX<profile_GetxController>(
                        builder: (profile_GetxController controller) {
                      return controller.isLoadingAddress.isTrue
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
                          : ListView.separated(
                              shrinkWrap: true,
                              // scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              // itemCount: 3,
                              itemCount: controller.address_model!.data.length,
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 10.h,
                                );
                              },
                              itemBuilder: (context, index) {
                                print(controller.address_model!.data.length);
                                return Container(
                                  height: 45.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.background_color),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppImages.gray_location,
                                        width: 26.w,
                                        height: 26.h,
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      SizedBox(
                                        width: 250.w,
                                        child: TextField(
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.black_color
                                                .withOpacity(0.7),
                                            fontFamily: 'Cairo',
                                          ),
                                          minLines: 1,
                                          readOnly: true,
                                          maxLines: 1,
                                          cursorColor: Colors.grey,
                                          decoration: InputDecoration(
                                            hintText: controller.address_model!
                                                    .data[index].address +
                                                ' _ ' +
                                                controller.address_model!
                                                    .data[index].district,
                                            hintStyle: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                              fontFamily: 'Cairo',
                                            ),
                                            contentPadding:
                                                EdgeInsets.only(bottom: 5.h),
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            focusedErrorBorder:
                                                InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                        onTap: ()async {
                                          print(controller
                                              .address_model!
                                              .data[index]
                                              .id.toString());
                                        await  _profile_getxController.delete_address(
                                              addressID: controller
                                                  .address_model!
                                                  .data[index]
                                                  .id.toString());
                                        setState(() {

                                        });
                                        },
                                        child: SvgPicture.asset(
                                          AppImages.failed,
                                          width: 26.w,
                                          height: 26.h,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                    }),
                  ),
                  SizedBox(
                    height: 13.h,
                  ),
                  Visibility(
                    visible: isAddNew,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 13.h,
                        ),
                        profileTextField(
                            label: 'Choose City'.tr, controller: NameConttoller),
                        profileTextField(
                            label: 'Street name'.tr, controller: emailConttoller),
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50.h,
                              width: 112.w,
                              child: customElevatedButton(
                                onTap: () async {
                                  await _profile_getxController.add_address(
                                      name: 'home',
                                      mobile: _profile_getxController
                                          .profile_model!.data.mobile
                                          .toString(),
                                      district: emailConttoller.text,
                                      city_id: _profile_getxController
                                          .profile_model!.data.cityId
                                          .toString(),
                                      address: NameConttoller.text);
                                  isAddNew = false;
                                  NameConttoller.clear();
                                  emailConttoller.clear();
                                  setState(() {});
                                },
                                color: AppColors.main_color,
                                child: Text(
                                  'save'.tr,
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            SizedBox(
                              height: 50.h,
                              width: 112.w,
                              child: customElevatedButton(
                                onTap: () {
                                  isAddNew = false;
                                  setState(() {});
                                },
                                color: AppColors.gray_color,
                                child: Text(
                                  'cancel'.tr,
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    replacement: GestureDetector(
                      onTap: () {
                        isAddNew = true;
                        setState(() {});
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 20.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.greenColor),
                            child:
                                Icon(Icons.add, color: Colors.white, size: 20),
                          ),
                          Text(
                            'add new address'.tr,
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black_color),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
