import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mazzad/Database/SharedPreferences/shared_preferences.dart';

import '../../../Bindings/onBoardingBindings.dart';
import '../../../Controllers/GetxController/AucationsController.dart';
import '../../../Controllers/GetxController/drawerController.dart';
import '../../../Controllers/GetxController/homeController.dart';
import '../../../Controllers/GetxController/profileController.dart';
import '../../../Language/app_locale.dart';
import '../../../Utils/AppColors.dart';
import '../../../Utils/Helper.dart';
import '../../../Utils/asset_images.dart';
import '../../../Utils/customElevatedButton.dart';
import '../../onBoarding/onBoarding_Screen.dart';
import 'addNewPaymentWay_Screen.dart';

class setting_Screen extends StatefulWidget {
  const setting_Screen({Key? key}) : super(key: key);

  @override
  State<setting_Screen> createState() => _setting_ScreenState();
}

class _setting_ScreenState extends State<setting_Screen> {


String LanguageCode='en';
String AdsLanguageCode='both';
var _home_getxController = Get.find<home_GetxController>();
var _profile_getxController = Get.find<profile_GetxController>();

@override
  void initState() {
    super.initState();
      LanguageCode= SharedPreferencesController().languageCode;
    AdsLanguageCode= SharedPreferencesController().ADVLanguage;
    setState(() {

    });
  }
refresh(){
  setState((){});

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
            icon: Icon(Icons.arrow_back_ios,color: AppColors.darkgray_color),
            onPressed: () {
Get.back();
            }),
        title: Text(
          'settings'.tr,
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
                SvgPicture.asset(AppImages.setting,color: AppColors.gold),                SizedBox(width: 5.w,),

                Text(
                  'settings'.tr,
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
                  GestureDetector(
                     onTap: (){
                       Get.bottomSheet(
                           isScrollControlled: true,
                           enableDrag: true,

                           StatefulBuilder(builder: (BuildContext context,
                               StateSetter setState /*You can rename this!*/) {
                             return Container(
                               width: width,
 height: 550.h,
                               decoration: BoxDecoration(
                                 color: AppColors.background_color,
                                 borderRadius: BorderRadius.only(
                                     topRight: Radius.circular(15),
                                     topLeft: Radius.circular(15)),
                               ),
                               padding: EdgeInsets.symmetric(horizontal: 10.w),
                               child: SingleChildScrollView(
                                 physics: BouncingScrollPhysics(),
                                 child: Column(
                                   children: [
                                     SizedBox(
                                       height: 15.h,
                                     ),
                                     Text(
                                       'App Language'.tr,
                                       style: TextStyle(
                                           fontFamily: 'Cairo',
                                           fontSize: 16.sp,
                                           fontWeight: FontWeight.w500,
                                           color: AppColors.black_color),
                                     ),
                                     Divider(
                                       endIndent: 30.w,
                                       indent: 30.w,
                                     ),
                                     SizedBox(
                                       height: 15.h,
                                     ),
                                     RadioListTile(
                                         title:
                                         Text(
                                           'Arabic'.tr,
                                           style: TextStyle(
                                               fontFamily: 'Cairo',
                                               fontSize: 16.sp,
                                               fontWeight: FontWeight.w500,
                                               color: AppColors.black_color),
                                         ),
                                         value: 'ar', groupValue: LanguageCode, onChanged: (x){
LanguageCode=x!;
AppLocale.changeLang(LanguageCode);

setState((){});
refresh();
                                     }),
                                     RadioListTile(
                                         title:
                                         Text(
                                           'English'.tr,
                                           style: TextStyle(
                                               fontFamily: 'Cairo',
                                               fontSize: 16.sp,
                                               fontWeight: FontWeight.w500,
                                               color: AppColors.black_color),
                                         ),
                                         value: 'en', groupValue: LanguageCode, onChanged: (x){
                                       LanguageCode=x!;
                                       AppLocale.changeLang(LanguageCode);


                                       setState((){});
                                       refresh();

                                     }),
                                   ],
                                 ),
                               ),
                             );
                           }));

                     },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 15.w,),

                        Text(
                          'App Language'.tr,
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black_color),
                        ),
                        Spacer(),
                        Text(
                          SharedPreferencesController().languageCode=='ar'?'Arabic'.tr:'English'.tr,
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color:  AppColors.black_color
                                  .withOpacity(0.6),),
                        ),
                        SizedBox(width: 5.w,),

                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.black_color
                              .withOpacity(0.6),size: 20,
                        )
                      ],
                    ),
                  ),



                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(

              padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 15.w),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  GestureDetector(
                    onTap: (){
                      Get.bottomSheet(
                          isScrollControlled: true,
                          enableDrag: true,

                          StatefulBuilder(
                              builder: (BuildContext context,
                              StateSetter setState /*You can rename this!*/) {
                            return Container(
                              width: width,
                              height: 550.h,
                              decoration: BoxDecoration(
                                color: AppColors.background_color,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15)),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    Text(
                                      'ads Language'.tr,
                                      style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black_color),
                                    ),
                                    Divider(
                                      endIndent: 30.w,
                                      indent: 30.w,
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    RadioListTile(
                                        title:
                                        Text(
                                          'Arabic'.tr,
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.black_color),
                                        ),
                                        value: 'ar', groupValue: AdsLanguageCode, onChanged: (x){
                                      AdsLanguageCode=x!;
                                      SharedPreferencesController().setADVLanguage(x.toString());
                                      _home_getxController.getLatest_advertisements();
                                      _home_getxController.getLastAucations();

                                      setState((){});
                                      refresh();
                                    }),
                                    RadioListTile(
                                        title:
                                        Text(
                                          'English'.tr,
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.black_color),
                                        ),
                                        value: 'en', groupValue: AdsLanguageCode, onChanged: (x){                                      AdsLanguageCode=x!;

                                    SharedPreferencesController().setADVLanguage(x.toString());
                                    _home_getxController.getLatest_advertisements();
                                    _home_getxController.getLastAucations();

                                      setState((){});
                                      refresh();

                                    }),
                                    RadioListTile(
                                        title:
                                        Text(
                                          'both'.tr,
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.black_color),
                                        ),
                                        value: 'both', groupValue: AdsLanguageCode, onChanged: (x){
                                          AdsLanguageCode=x!;

                                    SharedPreferencesController().setADVLanguage(x.toString());
                                          _home_getxController.getLatest_advertisements();
                                          _home_getxController.getLastAucations();


                                      setState((){});
                                      refresh();

                                    }),
                                  ],
                                ),
                              ),
                            );
                          }));

                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 15.w,),

                        Text(
                          'ads Language'.tr,
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black_color),
                        ),
                        Spacer(),
                        Text(
                          SharedPreferencesController().ADVLanguage=='ar'?'Arabic'.tr:SharedPreferencesController().ADVLanguage=='en'?'English'.tr:'both'.tr,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color:  AppColors.black_color
                                .withOpacity(0.6),),
                        ),
                        SizedBox(width: 5.w,),

                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.black_color
                              .withOpacity(0.6),size: 20,
                        )
                      ],
                    ),
                  ),


                ],
              ),
            ),
            SizedBox(
              height: 100.h,
            ),

            SizedBox(
              height: 50.h,width: 350.w,
              child: customElevatedButton(
                onTap: () async{

                  Helper.openDialoge(context,
                    onTap: (){
                      _profile_getxController.remove_myAccount();
                    },title:  'DeletAccountSure'.tr,);




                },
                color: AppColors.red,
                child: Text(
                  'deleteAccoount'.tr,
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white),
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),

          ]),
        ),
      ),
    );
  }
}

