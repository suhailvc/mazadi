import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mazzad/Models/registerError_Model.dart';

import '../../../Controllers/GetxController/profileController.dart';
import '../../../Utils/AppColors.dart';
import '../../../Utils/asset_images.dart';
import '../../../Utils/customElevatedButton.dart';
import '../../Bindings/HomeBindings.dart';
import '../../Controllers/GetxController/AdvertisementsController.dart';
import '../../Controllers/GetxController/AuthController.dart';
import '../../Database/SharedPreferences/shared_preferences.dart';
import '../../Utils/Helper.dart';
import '../../Utils/email_checker.dart';
import '../BN_Screens/main_Screen.dart';

class Register_Screen extends StatefulWidget {
  late String mobileNumber;

  Register_Screen({required this.mobileNumber});

  @override
  State<Register_Screen> createState() => _Register_ScreenState();
}

class _Register_ScreenState extends State<Register_Screen> {
  TextEditingController NameController = TextEditingController();
  TextEditingController PhoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController OTPController = TextEditingController();

  refresh() {
    setState(() {});
  }

  final _formKey = GlobalKey<FormState>();

  Auth_GetxController _auth_getxController = Get.put(Auth_GetxController());
  Advertisements_GetxController _advertisements_getxController =
      Get.put(Advertisements_GetxController());

  @override
  void initState() {
    super.initState();
    PhoneController = TextEditingController(text: widget.mobileNumber);
    setState(() {});
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
          'انشاء حساب جديد',
          style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black_color),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 35.h,
                ),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 25.h, horizontal: 15.w),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      profileTextField(
                          label: 'Name'.tr,
                          hint: 'write user Name'.tr,
                          controller: NameController,
                          Validation: (String value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill in this field'.tr;
                            }else if (value.length<5){
                              return 'It must be greater than 5 characters'.tr;
                            }
                            return null;
                          }),
                      profileTextField(
                        label: 'phone Number'.tr,
                        hint: 'write user phone'.tr,
                        controller: PhoneController,
                        Validation: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please fill in this field'.tr;
                          }else if (!GetUtils.isPhoneNumber(value)){
                            return 'Make sure the Phone is correct'.tr;
                          }
                          return null;
                        },
                        readOnly: true,
                      ),
                      profileTextField(
                        label: 'email'.tr,
                        hint: 'Write your email'.tr,
                        controller: emailController,
                        Validation: (value) {
                          if (value == null || value.isEmpty  ) {
                            return 'Please fill in this field'.tr;
                          }else if (EmailChecker.isNotValid(value)) {
                            return 'Please Enter Valid Email'.tr;
                          }
                          return null;
                        },
                      ),

                      GetX<Advertisements_GetxController>(
                          builder: (Advertisements_GetxController controller) {
                        return (controller.isLoadingMyCities.isTrue)
                            ? Container()
                            : Column(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(AppImages.circle),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        'المدينة',
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
                                  TextFormField(
                                    controller: _advertisements_getxController.cities_model!.CityEditingController,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    minLines: 1,
                                    readOnly: true,
                                    onTap: () {
                                      Get.bottomSheet(
                                          enableDrag: true,
                                          enterBottomSheetDuration:
                                              Duration(milliseconds: 700),
                                          exitBottomSheetDuration:
                                              Duration(milliseconds: 700),
                                          isScrollControlled: true,
                                          StatefulBuilder(builder: (BuildContext
                                                  context,
                                              StateSetter
                                                  setState /*You can rename this!*/) {
                                        return Container(
                                          height: 750.h,
                                          decoration: BoxDecoration(
                                            color: AppColors.background_color,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15),
                                                topLeft: Radius.circular(15)),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          child: SingleChildScrollView(
                                            physics: BouncingScrollPhysics(),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 15.h,
                                                ),
                                                Text(
                                                  'city'.tr,
                                                  style: TextStyle(
                                                      fontFamily: 'Cairo',
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors
                                                          .black_color),
                                                ),
                                                Divider(
                                                  thickness: 2,
                                                  indent: 15.w,
                                                  endIndent: 15.w,
                                                ),
                                                SizedBox(
                                                  height: 15.h,
                                                ),
                                                ListView.separated(
                                                    shrinkWrap: true,
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    padding: EdgeInsets.zero,
                                                    itemCount: controller
                                                        .cities_model!
                                                        .data!
                                                        .length,
                                                    separatorBuilder:
                                                        (context, index2) {
                                                      return SizedBox(
                                                        height: 10.h,
                                                      );
                                                    },
                                                    itemBuilder:
                                                        (context, index2) {
                                                      return RadioListTile(
                                                          title: Text(
                                                            SharedPreferencesController()
                                                                        .languageCode ==
                                                                    'en'
                                                                ? controller
                                                                    .cities_model!
                                                                    .data![
                                                                        index2]
                                                                    .name
                                                                    .toString()
                                                                : controller
                                                                    .cities_model!
                                                                    .data![
                                                                        index2]
                                                                    .nameAr
                                                                    .toString(),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Cairo',
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: AppColors
                                                                    .black_color),
                                                          ),
                                                          value:
                                                          SharedPreferencesController().languageCode=='ar'?
                                                          controller
                                                              .cities_model!
                                                              .data![index2]
                                                              .nameAr
                                                              .toString() :
                                                          controller
                                                              .cities_model!
                                                              .data![index2]
                                                              .name
                                                              .toString(),



                                                          groupValue: controller
                                                              .cities_model!
                                                              .CityGroupValue
                                                              .toString(),
                                                          activeColor: AppColors
                                                              .main_color,
                                                          onChanged: (value) {
                                                            controller
                                                                .cities_model!
                                                                .CityEditingController
                                                                .text = value!;

                                                            controller
                                                                    .cities_model!
                                                                    .CityGroupValue =
                                                                value;

                                                            SharedPreferencesController()
                                                                    .city_id =
                                                                controller
                                                                    .cities_model!
                                                                    .data![
                                                                        index2]
                                                                    .id
                                                                    .toString();
                                                            print(
                                                                SharedPreferencesController()
                                                                    .city_id);
                                                            setState(() {});
                                                            refresh();
                                                            Get.back();
                                                          });
                                                    }),
                                                SizedBox(
                                                  height: 25.h,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }));
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please fill in this field'.tr;
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.black_color,
                                      fontFamily: 'Cairo',
                                    ),
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                        fontFamily: 'Cairo',
                                      ),
                                      contentPadding: EdgeInsets.all(10.h),
                                      fillColor: AppColors.background_color,
                                      filled: true,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                    ),
                                  ),
                                ],
                              );
                      }),
                      profileTextField(
                        label: 'رمز التحقق',
                        hint: 'كتابة رمز التحقق هنا',
                        controller: OTPController,
                        Validation: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please fill in this field'.tr;
                          }
                          return null;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          GetX(builder: (Auth_GetxController auth_getx){
                            return
                              auth_getx.timeRemaining.value==59?

                              TextButton(
                              onPressed: () async {

                                await _auth_getxController.getMobile_otpCode(
                                    mobile: widget.mobileNumber);
                                auth_getx.StartOTPTimer();
                              },
                              child: Text(
                                'إعادة الارسال',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black_color,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ):
                              TextButton(
                                onPressed: () async {

                                },
                                child: Text(
                                  '00:${auth_getx.timeRemaining.value.toString().padLeft(2,'0')}',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black_color,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              )

                            ;
                          })

                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      GetX<Auth_GetxController>(
                          builder: (Auth_GetxController controller) {
                        return (controller.isSingingUp.isTrue)
                            ? customElevatedButton(
                                onTap: () async {},
                                color: AppColors.main_color,
                                child: LoadingAnimationWidget.waveDots(
                                  color: AppColors.white,
                                  size: 40,
                                ),
                              )
                            : customElevatedButton(
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    registerError_Model Register_Model =
                                        await controller.SignUp(
                                      name: NameController.text,
                                      mobile: PhoneController.text,
                                      email: emailController.text,
                                      verify_mobile_code: OTPController.text,
                                      address: 'gaza',
                                      city_id: SharedPreferencesController().city_id,
                                      district: 'gaza',
                                    );
                                    if (Register_Model.status.toString() == 'true') {
                                      show_RegisterSuccessDialog(context: context);
                                      clear();
                                      // await _auth_getxController.getMobile_otpCode(mobile: widget.mobileNumber);
                                      await controller.Login(mobile: widget.mobileNumber, verify_mobile_code: '1407');

                                      if (controller.login_model!.code < 400) {
                                        SharedPreferencesController().setToken('Bearer ' + controller.login_model!.accessToken.toString());

                                        Get.offAll(main_Screen(), binding: HomeBindings());
                                      } else {
                                        show_ErrorDialog(context: context);
                                      }
                                    } else {
                                      if (Register_Model.messageEn.toString() == 'Verify Mobile Code Not Correct') {
                                        Helper.showSnackBar(context,
                                            text: Register_Model.messageAr
                                                .toString());
                                      } else {
                                        Helper.showSnackBar(context,
                                            text: Register_Model
                                                .errors!.email![0]
                                                .toString());
                                      }
                                    }
                                  }
                                  ;
                                },
                                color: AppColors.main_color,
                                child: Text(
                                  'انشاء حساب',
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white),
                                ),
                              );
                      })
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 35.h,
              )
            ],
          ),
        ),
      ),
    );
  }

  clear() {
    NameController.clear();
    PhoneController.clear();
    emailController.clear();
    OTPController.clear();
    setState(() {});
  }

  Future show_ErrorDialog({
    required BuildContext context,
  }) async {
    await showDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Color(0xff242424).withOpacity(0.5),
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                width: 314.w,
                height: 314.h,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Stack(
                      children: [
                        Image.asset(
                          AppImages.win,
                          color: Colors.white.withOpacity(0.3),
                          colorBlendMode: BlendMode.modulate,
                        ),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 70.h,
                              ),
                              Image.asset(
                                AppImages.error,
                                width: 71.w,
                                height: 71.h,
                              ),
                              SizedBox(
                                height: 40.h,
                              ),
                              Text(
                                'لم يتم تسجيل الدخول ! ',
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black_color),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                'هناك مشكلة , الرجاء المحاولة مرة اخرى',
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.black_color),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  Future show_RegisterSuccessDialog({
    required BuildContext context,
  }) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Color(0xff242424).withOpacity(0.5),
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                width: 314.w,
                height: 314.h,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Stack(
                      children: [
                        Image.asset(
                          AppImages.win,
                          color: Colors.white.withOpacity(0.3),
                          colorBlendMode: BlendMode.modulate,
                        ),
                        Positioned(
                            bottom: 25.h,
                            right: 65.w,
                            child: Image.asset(
                              AppImages.success_circle,
                            )),
                      ],
                    ),
                    Text(
                      'تم انشاء الحساب ',
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black_color),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  Future show_RegisterErrorDialog({
    required BuildContext context,
  }) async {
    await showDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Color(0xff242424).withOpacity(0.5),
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                width: 314.w,
                height: 314.h,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Stack(
                      children: [
                        Image.asset(
                          AppImages.win,
                          color: Colors.white.withOpacity(0.3),
                          colorBlendMode: BlendMode.modulate,
                        ),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 70.h,
                              ),
                              Image.asset(
                                AppImages.error,
                                width: 71.w,
                                height: 71.h,
                              ),
                              SizedBox(
                                height: 40.h,
                              ),
                              Text(
                                'لم يتم انشاء الحساب ! ',
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black_color),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                'هناك مشكلة , الرجاء المحاولة مرة اخرى',
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.black_color),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }
}

class profileTextField extends StatelessWidget {
  late String label;
  late String hint;
  late bool readOnly;
  late TextEditingController controller;
  late Function? Validation;
  TextInputType textInputType = TextInputType.text;

  profileTextField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.Validation,
    this.textInputType = TextInputType.text,
    this.readOnly = false,
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
        TextFormField(
          keyboardType: textInputType,
          controller: controller,
          textAlignVertical: TextAlignVertical.bottom,
          minLines: 1,
          readOnly: readOnly,

          validator: (String? newValue) => Validation!(newValue),
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.black_color,
            fontFamily: 'Cairo',
          ),
          decoration: InputDecoration(

            hintStyle: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
              fontFamily: 'Cairo',
            ),
            contentPadding: EdgeInsets.all(10.h),
            fillColor: AppColors.background_color,
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
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}
