import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mazzad/Screens/BN_Screens/profile/payment_Screen.dart';
import 'package:mazzad/Screens/BN_Screens/profile/personalData_Screen.dart';
import 'package:mazzad/Screens/BN_Screens/profile/setting_Screen.dart';
import 'package:mazzad/Utils/Helper.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Bindings/onBoardingBindings.dart';
import '../../../Controllers/GetxController/AucationsController.dart';
import '../../../Controllers/GetxController/AuthController.dart';
import '../../../Controllers/GetxController/drawerController.dart';
import '../../../Controllers/GetxController/profileController.dart';
import '../../../Database/SharedPreferences/shared_preferences.dart';
import '../../../Utils/AppColors.dart';
import '../../../Utils/asset_images.dart';
import '../../../Utils/customElevatedButton.dart';
import '../../onBoarding/onBoarding_Screen.dart';
import 'locations_Screen.dart';

class profile_Screen extends StatefulWidget {
  const profile_Screen({Key? key}) : super(key: key);

  @override
  State<profile_Screen> createState() => _profile_ScreenState();
}

class _profile_ScreenState extends State<profile_Screen> {
  MyDrawerController _drawerController = Get.put(MyDrawerController());
  // Auth_GetxController _auth_getxController = Get.put(Auth_GetxController());
  var  _profile_getxController = Get.find<profile_GetxController>();
  var _auth_getxController = Get.find<Auth_GetxController>();


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      onRefresh: ()async{

       await _profile_getxController.get_profile();
      },
      child: Scaffold(
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
              'profile'.tr,
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black_color),
            ),
          ),
          body: SizedBox(
              width: width,
              child: GetX<profile_GetxController>(
                  builder: (profile_GetxController controller) {
                return  Padding(
                        padding: EdgeInsets.symmetric(
                           horizontal: 10.w,vertical: 20.h),
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                Divider(color: Colors.transparent),

                                controller.isLoadingProfile.isTrue? Shimmer.fromColors(
                                    baseColor:  Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade200,
                                    child: Container(
                                      width: 120.w,
                                      height: 120.h,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        shape: BoxShape.circle,

                                      ),
                                    )

                                ) :
                                Container(
                                  width: 120.w,
                                  height: 120.h,
                                  constraints: BoxConstraints(),
                                   clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      color: AppColors.main_color,
                                      shape: BoxShape.circle,
                                      ),
                                  child:  CachedNetworkImage(
                                    fit: BoxFit.cover,

                                    imageUrl: controller.profile_model!.data.photo.toString(),
                                 ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                controller.isLoadingProfile.isTrue? Shimmer.fromColors(
                                    baseColor:  Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade200,
                                    child: Container(
                                      width: 140.w,
                                      height: 16.h,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
 borderRadius: BorderRadius.circular(5)

                                      ),
                                    )

                                ) :         Text(
                                  controller.profile_model!.data.name.toString(),
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.black_color),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                controller.isLoadingProfile.isTrue? Shimmer.fromColors(
                                    baseColor:  Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade200,
                                    child: Container(
                                      width: 120.w,
                                      height: 14.h,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius: BorderRadius.circular(5)

                                      ),
                                    )

                                ) :     Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(AppImages.call,
                                        height: 20.h, width: 20.w),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(
                                      controller.profile_model!.data.mobile.toString(),
                                      style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black_color),
                                    ),
                                  ],
                                ),


                                SizedBox(
                                  height: 36.h,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                       horizontal: 5.w),
                                  decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 15.h,
                                      ),

                                      /*
                                      Row(
                                        children: [
                                          Text(
                                            'Personal data'.tr,
                                            style: TextStyle(
                                                fontFamily: 'Cairo',
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.black_color),
                                          ),
                                        ],
                                      ),


                                       */

                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      SizedBox(
                                        height: 50.h,
                                        child: customElevatedButton(
                                          onTap: () {
                                            if(controller.isLoadingProfile.isFalse) {
                                              Get.to(personalData_Screen());
                                            }

                                            },
                                          color: AppColors.gray2_color,
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(AppImages.profile2),
                                              Text(
                                                'Personal data'.tr,
                                                style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.black_color),
                                              ),
                                              Spacer(),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: AppColors.black_color
                                                    .withOpacity(0.6),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      SizedBox(
                                        height: 50.h,
                                        child: customElevatedButton(
                                          onTap: () {
                                            Get.to(locations_Screen());

                                          },
                                          color: AppColors.gray2_color,
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(AppImages.location),SizedBox(
                                                width: 5.w,
                                              ),
                                              Text(
                                                'Addresses'.tr,
                                                style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.black_color),
                                              ),
                                              Spacer(),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: AppColors.black_color
                                                    .withOpacity(0.6),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),


                                      SizedBox(
                                        height: 10.h,
                                      ),

                                      /*
                                      SizedBox(
                                        height: 50.h,
                                        child: customElevatedButton(
                                          onTap: () {
                                            Get.to(payment_Screen());

                                          },
                                          color: AppColors.gray2_color,
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(AppImages.wallet2),SizedBox(
                                                width: 5.w,
                                              ),
                                              Text(
                                                'payment methods'.tr,
                                                style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.black_color),
                                              ),
                                              Spacer(),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: AppColors.black_color
                                                    .withOpacity(0.6),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                       */

                                      SizedBox(
                                        height: 50.h,
                                        child: customElevatedButton(
                                          onTap: () {
                                            Get.to(setting_Screen());

                                          },
                                          color: AppColors.gray2_color,
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(AppImages.setting,color: AppColors.gold),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Text(
                                                'settings'.tr,
                                                style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.black_color),
                                              ),
                                              Spacer(),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: AppColors.black_color
                                                    .withOpacity(0.6),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      SizedBox(
                                        height: 50.h,
                                        child: customElevatedButton(
                                          onTap: () async{

                                            Helper.openDialoge(context,
                                              onTap: (){
                                              // bool isLogout = await _auth_getxController.logout();
                                              // if(isLogout==true){
                                              SharedPreferencesController().setToken('');
                                              SharedPreferencesController().setFirstLoggin(false);
                                              Get.offAll(OnBoardingScreen(),binding: onBoardingBindings());

                                              setState(() {
                                              });

                                              // }else{
                                              //   print('LOGOUT ERROR');
                                              //
                                              //
                                              // }
                                            },title:  'logoutSure'.tr,);




                                          },
                                          color: AppColors.red,
                                          child: Text(
                                            'Logout'.tr,
                                            style: TextStyle(
                                                fontFamily: 'Cairo',
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.white),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 40.h,)

                              ]),
                        ),
                      );
              }))),
    );
  }
}
