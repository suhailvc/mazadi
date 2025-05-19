import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mazzad/Database/SharedPreferences/shared_preferences.dart';

import '../../../Controllers/GetxController/AucationsController.dart';
import '../../../Controllers/GetxController/drawerController.dart';
import '../../../Controllers/GetxController/profileController.dart';
import '../../../Utils/AppColors.dart';
import '../../../Utils/asset_images.dart';
import '../../../Utils/customElevatedButton.dart';
import '../../../Utils/email_checker.dart';
import '../../Login/Register_Screen.dart';

class personalData_Screen extends StatefulWidget {
  const personalData_Screen({Key? key}) : super(key: key);

  @override
  State<personalData_Screen> createState() => _personalData_ScreenState();
}

class _personalData_ScreenState extends State<personalData_Screen> {
  MyDrawerController _drawerController = Get.put(MyDrawerController());

  // Auth_GetxController _auth_getxController = Get.put(Auth_GetxController());
  var _profile_getxController = Get.find<profile_GetxController>();

  // var _profile_getxController = Get.find<profile_GetxController>();

  late TextEditingController NameConttoller;
  late TextEditingController phoneConttoller;
  late TextEditingController emailConttoller;
  late TextEditingController whattsabConttoller;

  @override
  void initState() {
    super.initState();
    NameConttoller = TextEditingController(
        text: _profile_getxController.profile_model!.data.name.toString());
    phoneConttoller = TextEditingController(
        text: _profile_getxController.profile_model!.data.mobile.toString());
    emailConttoller = TextEditingController(
        text: _profile_getxController.profile_model!.data.email.toString());
    whattsabConttoller = TextEditingController(
        text: _profile_getxController.profile_model!.data.whatsapp.toString());
  }

  @override
  void dispose() {
    NameConttoller.dispose();
    phoneConttoller.dispose();
    emailConttoller.dispose();
    whattsabConttoller.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(sourcePath: imageFile.path) ;
    if (croppedImage == null) return null;
    return File(croppedImage.path) ;
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
            icon: Icon(Icons.arrow_back_ios, color: AppColors.darkgray_color),
            onPressed: () {
              Get.back();
            }),
        title: Text(
          'Personal data'.tr,
          style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black_color),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Divider(color: Colors.transparent),
                  Row(
                    children: [
                      SizedBox(
                        width: 15.w,
                      ),
                      SvgPicture.asset(AppImages.profile2),
                      Text(
                        'Personal data'.tr,
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
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 5.w),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 120.w,
                              height: 120.h,
                              constraints: BoxConstraints(),
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: AppColors.main_color,
                                shape: BoxShape.circle,
                              ),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: _profile_getxController
                                    .profile_model!.data.photo
                                    .toString(),
                              ),
                            ),
                            Positioned(
                              bottom: 0.h,
                              child: IconButton(
                                  onPressed: () async {
                                    var file = await ImagePicker().pickImage(
                                      source: ImageSource.gallery,
                                    );

                                    if (file != null) {
                                      File? image =File(file.path);
                                      image  = await  _cropImage(imageFile: image);
                                      await _profile_getxController.update_photo(file: image!,
                                      );
                                    }
                                    setState(() {});
                                  },
                                  icon: Container(
                                    width: 38.w,
                                    height: 38.h,
                                    constraints: BoxConstraints(),
                                    decoration: BoxDecoration(
                                        color: AppColors.main_color,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.gray_color,
                                            blurRadius: 2,
                                            offset: Offset(1, 2),
                                            spreadRadius: 1,
                                          )
                                        ]),
                                    child: Center(
                                        child: SvgPicture.asset(
                                      AppImages.edit2,
                                    )),
                                  )),
                            ),
                          ],
                        ),
                        profileTextField(
                            label: 'Name'.tr,
                            hint: 'write user Name'.tr,
                            controller: NameConttoller,
                            Validation: (String value) {
                              if (value == null || value.isEmpty) {
                                return 'Please fill in this field'.tr;
                              } else if (value.length < 5) {
                                return 'It must be greater than 5 characters'
                                    .tr;
                              }
                              return null;
                            }),
                        profileTextField(
                          label: 'phone Number'.tr,
                          hint: 'write user phone'.tr,
                          controller: phoneConttoller,
                          Validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill in this field'.tr;
                            } else if (!GetUtils.isPhoneNumber(value)) {
                              return 'Make sure the Phone is correct'.tr;
                            }
                            return null;
                          },
                          readOnly: true,
                        ),
                        profileTextField(
                          label: 'email'.tr,
                          hint: 'Write your email'.tr,
                          controller: emailConttoller,
                          Validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill in this field'.tr;
                            }else if (EmailChecker.isNotValid(value)) {
                              return 'Please Enter Valid Email'.tr;
                            }
                            return null;
                          },
                        ),
                        profileTextField(
                          label: 'whatsapp'.tr,
                          hint: 'whatsapp'.tr,
                          controller: whattsabConttoller,
                          Validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill in this field'.tr;
                            } else if (!GetUtils.isPhoneNumber(value)) {
                              return 'Make sure the Phone is correct'.tr;
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 13.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GetX(builder: (profile_GetxController profile_getx){
                              return  SizedBox(
                                height: 50.h,
                                width: 112.w,
                                child: customElevatedButton(
                                  isLoading: profile_getx.IsUpdatingProfile.value,
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await profile_getx.update_profile(
                                        name: NameConttoller.text,
                                        mobile: phoneConttoller.text,
                                        email: emailConttoller.text,
                                        city_id: profile_getx
                                            .profile_model!.data.cityId
                                            .toString(),
                                        address: profile_getx
                                            .profile_model!.data.address
                                            .toString(),
                                        whatsapp: whattsabConttoller.text,
                                      );
                                      Get.back();
                                    }
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
                              );

                            }),

                            SizedBox(
                              width: 10.w,
                            ),
                            SizedBox(
                              height: 50.h,
                              width: 112.w,
                              child: customElevatedButton(
                                onTap: () {
                                  Get.back();
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
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
