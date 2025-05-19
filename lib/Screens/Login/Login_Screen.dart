// import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mazzad/Screens/BN_Screens/main_Screen.dart';
import 'package:mazzad/Screens/Login/Register_Screen.dart';
import 'package:mazzad/Utils/Helper.dart';
import 'package:mazzad/Utils/asset_images.dart';

import '../../Bindings/HomeBindings.dart';
import '../../Controllers/GetxController/AuthController.dart';
import '../../Utils/AppColors.dart';
import '../../Utils/customElevatedButton.dart';
import 'OTP_Screen.dart';

class LoginScreen extends StatefulWidget {
  late bool show_visitorButton ;

  LoginScreen({this.show_visitorButton=false});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _auth_getxController = Get.find<Auth_GetxController>();

  TextEditingController mobileController = TextEditingController();

  String emojy = '🇵🇸';
  String phoneCodeUI = '972+';
  String phoneCode = '00972';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'تسجيل الدخول',
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black_color.withOpacity(0.8)),
            ),
            Text(
              'ادخال رقم الهاتف',
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
              height: 40.h,
              padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 2.h),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      height: 40.h,
                      width: 150.w,
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: TextField(
                          onChanged: (x) {
                            setState(() {});
                          },
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black_color,
                            fontFamily: 'Cairo',
                          ),
                          keyboardType: TextInputType.phone,
                          autofocus: true,
                          controller: mobileController,
                          maxLines: 1,
                          maxLength: 9,
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                            hintText: '599-000-000',
                            counter: SizedBox(),
                            hintStyle: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                              fontFamily: 'Cairo',
                            ),
                            contentPadding: EdgeInsets.only(bottom: 0.h),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    thickness: 2,
                  ),

                  PopupMenuButton(
                    onSelected: (i) {
                      print(i);
    if (i == 1) {
       phoneCodeUI = '972+';
       phoneCode = '00972';
    }else{
      phoneCodeUI = '970+';
      phoneCode = '00970';
    }
    setState(() {

    });
                    },
                    padding: EdgeInsets.zero,
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: 1,
                          onTap: () {},
                          child: Text('972+'),
                        ),
                        PopupMenuItem(
                          value: 2,
                          onTap: () {},
                          child: Text('970+'),
                        ),
                      ];
                    },
                    child: Row(
                      children: [
                        Icon(Icons.keyboard_arrow_down),
                        Text(
                          phoneCodeUI,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black_color,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          emojy,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black_color,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            SizedBox(
              child: GetX<Auth_GetxController>(
                  builder: (Auth_GetxController controller) {
                return controller.isLoadingOTP.isTrue
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
                          if (mobileController.text.length == 9) {
                            await controller.getMobile_otpCode(
                                mobile: phoneCode + mobileController.text);
                            await controller.StartOTPTimer();
                            if (controller.mobile_otpCode_Model!.code.toString() != '200') {
                              Get.to(Register_Screen(
                                mobileNumber: phoneCode + mobileController.text,
                              ));
                            } else {
                              Get.to(OTP_Screen(
                                mobileNumber: phoneCode + mobileController.text,
                              ));
                            }
                          }
                        },
                        color: mobileController.text.length == 9
                            ? AppColors.main_color
                            : AppColors.gray_color,
                        child: Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      );
              }),
            ),
            SizedBox(
              height: 25.h,
            ),
          // Center(
          //     child: TextButton(
          //       onPressed: () {
          //         // Get.to(()=>main_Screen(),binding: HomeBindings());
          //       Get.back();
          //
          //       },
          //       child: Text(
          //         'الدخول كزائر',
          //         style: TextStyle(
          //             fontFamily: 'Cairo',
          //             fontSize: 16.sp,
          //             fontWeight: FontWeight.w500,
          //             color: AppColors.black_color.withOpacity(0.8)),
          //       ),
          //     ),
          //   )


          ],
        ),
      ),
    );
  }
}
