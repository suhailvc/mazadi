import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mazzad/Screens/Login/selectCity_Screen.dart';
import 'package:mazzad/Utils/asset_images.dart';

import '../../Bindings/HomeBindings.dart';
import '../../Controllers/GetxController/AuthController.dart';
import '../../Database/SharedPreferences/shared_preferences.dart';
import '../../Utils/AppColors.dart';
import '../../Utils/Helper.dart';
import '../../Utils/customElevatedButton.dart';
import '../BN_Screens/main_Screen.dart';

class OTP_Screen extends StatefulWidget {
  late String mobileNumber;
  OTP_Screen({required this.mobileNumber});

  @override
  State<OTP_Screen> createState() => _OTP_ScreenState();
}

class _OTP_ScreenState extends State<OTP_Screen> {
  TextEditingController OTPController = TextEditingController();

  // var _auth_getxController = Get.find<Auth_GetxController>();

  Auth_GetxController _auth_getxController = Get.put(Auth_GetxController());

  @override
  void initState() {
    super.initState();
    _auth_getxController.StartOTPTimer();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            tooltip: 'رجوع',
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: Colors.transparent),
            SizedBox(
              height: 125.h,
            ),
            Text(
              ' الرجاء ادخال رمز التحقق OTP  ',
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black_color.withOpacity(0.8)),
            ),
            Text(
              'إدخال رمز التحقق',
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black_color),
            ),
            SizedBox(
              height: 50.h,
            ),
            Container(
              height: 45.h,
              padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.h),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 3.h),
                    child: Text(
                      '----',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black_color,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  VerticalDivider(
                    thickness: 2,
                  ),
                  SizedBox(
                    width: 150.w,
                    child: TextField(
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black_color,
                        fontFamily: 'Cairo',
                      ),
                      keyboardType: TextInputType.phone,
                      autofocus: true,
                      minLines: 1,
                      maxLines: 1,
                      controller: OTPController,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        hintText: '',
                        hintStyle: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
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
                  GetX(builder: (Auth_GetxController auth_getx){
                    return
                      auth_getx.timeRemaining.value==59?

                      TextButton(
                        onPressed: () async {

                          await _auth_getxController.getMobile_otpCode(
                              mobile: widget.mobileNumber);
                          auth_getx.StartOTPTimer();
                          Helper.showSnackBar(context,
                              text: _auth_getxController
                                  .mobile_otpCode_Model!.verifyMobileCode
                                  .toString());
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
            ),
            SizedBox(
              height: 50.h,
            ),
            SizedBox(
              child: GetX<Auth_GetxController>(
                  builder: (Auth_GetxController controller) {
                return controller.isLoading.isTrue
                    ? customElevatedButton(
                        onTap: () async {},
                        color: AppColors.main_color,
                        child: Center(
                          child: LoadingAnimationWidget.waveDots(
                            color: AppColors.background_color,
                            size: 40,
                          ),
                        ),
                      )
                    : customElevatedButton(
                        onTap: () async {

                          await controller.Login(
                              mobile: widget.mobileNumber,
                              verify_mobile_code: OTPController.text);

                          if (controller.login_model!.code < 400){
                          SharedPreferencesController().setToken('Bearer ' + controller.login_model!.accessToken.toString());
                          Get.offAll(main_Screen(), binding: HomeBindings());


                          }else{
                           show_ErrorDialog(context: context,description:
                               SharedPreferencesController().languageCode=='en'?
                           controller.login_model!.messageEn:  controller.login_model!.messageAr );
                         }

                        },
                        color: AppColors.main_color,
                        child: Text(
                          'استمرار',
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      );
              }),
            ),

          ],
        ),
      ),
    );
  }


  Future show_ErrorDialog({
    required BuildContext context,
    required String description,
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
                    borderRadius: BorderRadius.circular(15)

                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Stack(
                      children: [
                        Image.asset(AppImages.win, color: Colors.white
                            .withOpacity(0.3), colorBlendMode: BlendMode
                            .modulate,),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [ SizedBox(
                              height: 70.h,
                            ),
                              Image.asset(
                                AppImages.error, width: 71.w, height: 71.h,),
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
                                description,
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
