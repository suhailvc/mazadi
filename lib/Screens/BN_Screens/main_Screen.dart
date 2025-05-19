import 'dart:convert';
import 'dart:io' show Platform;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mazzad/Bindings/HomeBindings.dart';
import 'package:mazzad/Screens/BN_Screens/profile/profile_Screen.dart';
import 'package:mazzad/Screens/LaunchScreen/launchScreen.dart';
import 'package:mazzad/Screens/Login/Login_Screen.dart';
import 'package:mazzad/Utils/Helper.dart';

import '../../Bindings/onBoardingBindings.dart';
import '../../Controllers/GetxController/AuthController.dart';
import '../../Controllers/GetxController/checkNetWorkGetx_Controller.dart';
import '../../Controllers/GetxController/profileController.dart';
import '../../Controllers/GetxController/drawerController.dart';
import '../../Database/SharedPreferences/shared_preferences.dart';
import '../../Utils/AppColors.dart';
import '../../Utils/asset_images.dart';
import '../../Utils/customElevatedButton.dart';
import '../onBoarding/onBoarding_Screen.dart';
import 'Aucations/Aucations_Screen.dart';
import 'Aucations/myAucations_Screen.dart';
import 'Aucations/myBids_Screen.dart';
import 'advertise/advertise_Screen.dart';
import 'drawer/contact_Screen.dart';
import 'drawer/myNotifications_Screen.dart';
import 'drawer/myWallet_Screen.dart';
import 'drawer/sellCash_Screen.dart';
import 'drawer/terms_Screen.dart';
import 'drawer/wishList_Screen.dart';
import 'home/home_Screen.dart';
import 'newAdvertise/chooseAdvType_Screen.dart';

class main_Screen extends StatefulWidget {
  @override
  _main_ScreenState createState() => _main_ScreenState();
}

class _main_ScreenState extends State<main_Screen>
    with TickerProviderStateMixin {
  PageController _myPage = PageController(initialPage: 0);
  MyDrawerController _drawerController = Get.put(MyDrawerController());

  var _profile_GetxController = Get.find<profile_GetxController>();
  var _auth_getxController = Get.find<Auth_GetxController>();
  var _netWork_getxController = Get.find<checkNetWorkGetx_Controller>();

  @override
  void initState() {
    super.initState();
    SharedPreferencesController().setFirstLoggin(true);
  }

  double _pageindex = 0;
  bool checked = false;
  int currentIndex = 0;

  bool mazzad = false;
  bool home = true;
  bool adv = false;
  bool profile = false;
  bool addNew = false;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GetBuilder<MyDrawerController>(
        builder: (_) => ZoomDrawer(
            controller: _.zoomDrawerController,
            menuScreenWidth: width,
            isRtl: SharedPreferencesController().languageCode == 'ar'
                ? true
                : false,
            menuBackgroundColor: AppColors.main_color,
            mainScreen: Scaffold(
              key: scaffoldKey,
              backgroundColor: AppColors.background_color,
              body: Stack(
                children: [
                  Scaffold(
                    resizeToAvoidBottomInset: false,
                    extendBodyBehindAppBar: true,
                    bottomNavigationBar: BottomAppBar(
                      elevation: 2,
                      child: Container(
                        padding: EdgeInsets.only(top: 13.h),
                        decoration: BoxDecoration(
                          color: AppColors.background_color,
                        ),
                        height: 95.h,
                        width: width,
                        child: Container(
                          // padding: EdgeInsets.symmetric(horizontal: 0.066*width, vertical: 0.014*height),
                          padding: EdgeInsets.only(
                              right: 24.w, left: 24.w, bottom: 10.h),
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  topLeft: Radius.circular(30))),
                          height: 78.h,
                          width: width,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: BN_icon(
                                  title: 'home'.tr,
                                  itsBool: home,
                                  svgName: AppImages.home,
                                  ontap: () {
                                    setState(() {
                                      _myPage.jumpToPage(0);
                                      mazzad = false;
                                      home = true;
                                      adv = false;
                                      profile = false;
                                      addNew = false;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 15.3.w,
                              ),
                              Expanded(
                                flex: 2,
                                child: BN_icon(
                                  title: 'Aucations'.tr,
                                  itsBool: mazzad,
                                  svgName: AppImages.mazzadat,
                                  ontap: () {
                                    setState(() {
                                      _myPage.jumpToPage(1);
                                      mazzad = true;
                                      home = false;
                                      adv = false;
                                      profile = false;
                                      addNew = false;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  onTap: () {
                                    if(SharedPreferencesController().getToken.isNotEmpty){
                                      if (_profile_GetxController
                                          .profile_model!.data.status ==
                                          1) {
                                        setState(() {
                                          _myPage.jumpToPage(4);
                                          mazzad = false;
                                          home = false;
                                          adv = false;
                                          profile = false;
                                          addNew = true;
                                        });
                                      } else {
                                        Helper.showSnackBar(context,
                                            text:
                                            'your account is not Active now !'
                                                .tr);
                                      }
                                    }else{
                                      Get.to(()=>LoginScreen());
                                    }




                                  },
                                  child: Container(
                                    height: 64.h,
                                    width: 64.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: addNew
                                          ? AppColors.main_color
                                          : AppColors.black_color,
                                    ),
                                    child: Icon(Icons.add,
                                        color: AppColors.white, size: 30),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: BN_icon(
                                  title: 'My Advertisment'.tr,
                                  itsBool: adv,
                                  svgName: AppImages.adv,
                                  ontap: () {
                                    if(SharedPreferencesController().getToken.isNotEmpty){
                                      setState(() {
                                        _myPage.jumpToPage(2);
                                        mazzad = false;
                                        home = false;
                                        adv = true;
                                        profile = false;
                                        addNew = false;
                                      });
                                    }else{
                                      Get.to(()=>LoginScreen());
                                    }

                                  },
                                ),
                              ),
                              SizedBox(
                                width: 15.3.w,
                              ),
                              Expanded(
                                child: BN_icon(
                                  title: 'profile'.tr,
                                  itsBool: profile,
                                  svgName: AppImages.profile,
                                  ontap: () {
                                    if(SharedPreferencesController().getToken.isNotEmpty){


                                      setState(() {
                                        _myPage.jumpToPage(3);
                                        mazzad = false;
                                        home = false;
                                        adv = false;
                                        profile = true;
                                        addNew = false;
                                      });

                                    }else{
                                      Get.to(()=>LoginScreen());
                                    }


                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    body: PageView(
                      controller: _myPage,
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        home_Screen(),
                        const Aucations_Screen(),
                        const advertise_Screen(),
                        const profile_Screen(),
                        const chooseAdvType_Screen(),
                      ],
                    ),
                  ),

                  /*
                  Obx((){
                    print(_netWork_getxController.connectionType.value);

                    return
                      _netWork_getxController.connectionType.value==0?
                      Center(
                        child: Container(
                          width: 314.w,
                          height: 314.h,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(15)

                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 15.h,
                              ),
                              Stack(
                                children: [
                                  Image.asset(AppImages.win, color: Colors.white.withOpacity(0.3), colorBlendMode: BlendMode.modulate,),
                                  Positioned(
                                      bottom: 45.h,
                                      right: 70.w,
                                      left: 70.w,
                                      child: Image.asset(AppImages.no_internet,height: 128.h,width: 128.w,)),
                                ],
                              ),


                              Text(
                                'لا يتوفر اتصال بالانترنت',
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black_color),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Get.offAll(LaunchScreen(),binding: HomeBindings());
                                },
                                child: Text(
                                  'حاول مرة اخرى',
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.black_color),
                                ),
                              ),

                              SizedBox(
                                height: 15.h,
                              ),

                            ],
                          ),

                        ),
                      ):Container();
                  }),
                  */
                ],
              ),
            ),
            menuScreen: Container(
              decoration: BoxDecoration(color: AppColors.main_color),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 54.h,
                    ),
                    GetX<profile_GetxController>(
                        builder: (profile_GetxController controller) {
                      return controller.isLoadingProfile.isTrue
                          ? Center(
                              child: LoadingAnimationWidget.waveDots(
                                color: AppColors.background_color,
                                size: 40,
                              ),
                            )
                          :
                      controller.profile_model!=null?
                      Row(
                              children: [
                                Container(
                                  width: 60.w,
                                  height: 60.h,
                                  constraints: BoxConstraints(),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: AppColors.main_color,
                                    shape: BoxShape.circle,
                                  ),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: controller
                                        .profile_model!.data.photo
                                        .toString(),
                                  ),
                                ),
                                SizedBox(
                                  width: 12.w,
                                ),
                                Text(
                                  controller.profile_model!.data.name
                                      .toString(),
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.white),
                                ),
                                Spacer(),
                                IconButton(
                                    onPressed: () {
                                      _drawerController.toggleDrawer();
                                    },
                                    icon: Icon(
                                      Icons.clear,
                                      color: AppColors.white,
                                    ))
                              ],
                            ):SizedBox(
                        height: 60.h,
                      );
                    }),
                    SizedBox(
                      height: 40.h,
                    ),
                    drawerListTile(
                      onTap: () {
                        setState(() {
                          _myPage.jumpToPage(0);
                          mazzad = false;
                          home = true;
                          adv = false;
                          profile = false;
                          addNew = false;
                        });
                        _drawerController.toggleDrawer();
                      },
                      title: 'home'.tr,
                      pic: AppImages.home2,
                    ),
                    drawerListTile(
                      onTap: () {
                        if(SharedPreferencesController().getToken.isNotEmpty){

                          setState(() {
                            _myPage.jumpToPage(2);
                            mazzad = false;
                            home = false;
                            adv = true;
                            profile = false;
                            addNew = false;
                          });
                          _drawerController.toggleDrawer();

                        }else{
                          Get.to(()=>LoginScreen());
                        }





                      },
                      title: 'My Advertisment'.tr,
                      pic: AppImages.clipboard,
                    ),
                    drawerListTile(
                      onTap: () {
                        if(SharedPreferencesController().getToken.isNotEmpty){
                          Get.to(myAucations_Screen());

                          _drawerController.toggleDrawer();

                        }else{
                          Get.to(()=>LoginScreen());
                        }

                      },
                      title: 'My Aucations'.tr,
                      pic: AppImages.judge,
                    ),
                    drawerListTile(
                      onTap: () {
                        if(SharedPreferencesController().getToken.isNotEmpty){
                          Get.to(()=>myBids_Screen());

                          _drawerController.toggleDrawer();

                        }else{
                          Get.to(()=>LoginScreen());
                        }
                      },
                      title: 'My Bids'.tr,
                      pic: AppImages.verify,
                    ),
                    SizedBox(
                      width: 200.w,
                      child: Material(
                        type: MaterialType.transparency,
                        child: ListTile(
                            onTap: () {
                              if(SharedPreferencesController().getToken.isNotEmpty){

                                if (_profile_GetxController.myNotifications == null) {
                                  _profile_GetxController.get_myNotifications();
                                }

                                Get.to(myNotifications_Screen());

                              }else{
                                Get.to(()=>LoginScreen());
                              }


                            },
                            title: Text(
                              'Notifications'.tr,
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white),
                            ),
                            leading: Icon(
                              Icons.notifications,
                              color: AppColors.white,
                            )),
                      ),
                    ),
                    // drawerListTile(
                    //   onTap: () {
                    //     Get.to(myNotifications_Screen());
                    //
                    //   },
                    //   title: 'Notifications'.tr,
                    //   pic: AppImages.verify,
                    // ),
                    drawerListTile(
                      onTap: () {

                        if(SharedPreferencesController().getToken.isNotEmpty){

                          if (_profile_GetxController
                              .advertisement_wishlists_model ==
                              null ||
                              _profile_GetxController.auctions_wishlists_model ==
                                  null) {
                            _profile_GetxController
                                .get_my_advertisement_wishlists();
                            _profile_GetxController.get_my_auction_wishlists();
                          }
                          Get.to(wishList_Screen());

                        }else{
                          Get.to(()=>LoginScreen());
                        }




                      },
                      title: 'Favourite'.tr,
                      pic: AppImages.heart,
                    ),
                    drawerListTile(
                      onTap: () {

                        if(SharedPreferencesController().getToken.isNotEmpty){


                          if (_profile_GetxController.wallet_model == null ||
                              _profile_GetxController.myBlockAuction_Model ==
                                  null) {
                            _profile_GetxController.get_blockAuction();
                            _profile_GetxController.get_MyBalance();
                          }

                          Get.to(myWallet_Screen());

                        }else{
                          Get.to(()=>LoginScreen());
                        }


                      },
                      title: 'Wallet'.tr,
                      pic: AppImages.wallet,
                    ),

                    GetBuilder(
                      builder: (profile_GetxController profile_getx) {
                        if (profile_getx.profile_model != null) {
                          if (profile_getx.profile_model!.data.isReseller == 1) {
                            return drawerListTile(
                              onTap: () {
                                Get.to(() => sellCash_Screen());
                              },
                              title: 'sellCash'.tr,
                              pic: AppImages.wallet,
                            );
                          } else {
                            return SizedBox();
                          }
                        } else {
                          return SizedBox();
                        }
                      },
                    ),

                    drawerListTile(
                      onTap: () {
                        Get.to(terms_Screen());
                      },
                      title: 'Terms and Conditions'.tr,
                      pic: AppImages.flag,
                    ),
                    drawerListTile(
                      onTap: () {
                        Get.to(contact_Screen());
                      },
                      title: 'Technical support'.tr,
                      pic: AppImages.question,
                    ),
               if(_profile_GetxController.profile_model!=null)     drawerListTile(
                      onTap: () async {

                        Helper.openDialoge(context, onTap: (){
                          SharedPreferencesController()
                              .setToken('');
                          SharedPreferencesController()
                              .setFirstLoggin(false);
                          Get.offAll(OnBoardingScreen(),
                              binding: onBoardingBindings());
                        },title:'logoutSure'.tr, );
                      },
                      title: 'Logout'.tr,
                      pic: AppImages.logout,
                    ),
                  ],
                ),
              ),
            ),
            borderRadius: 16.0,
            showShadow: true,
            angle: 0,
            drawerShadowsBackgroundColor: Colors.grey,
            slideWidth: MediaQuery.of(context).size.width * 0.65));
  }
}

class drawerListTile extends StatelessWidget {
  late String title;
  late String pic;
  late Function() onTap;

  drawerListTile({required this.title, required this.pic, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.w,
      child: Material(
        type: MaterialType.transparency,
        child: ListTile(
          onTap: onTap,
          title: Text(
            title,
            style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.white),
          ),
          leading: SvgPicture.asset(pic),
        ),
      ),
    );
  }
}

class BN_icon extends StatelessWidget {
  late String svgName;
  late String title;
  late bool itsBool;
  late Function() ontap;

  BN_icon({
    required this.svgName,
    required this.title,
    required this.itsBool,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: ontap,
      child: Container(
        // height: 0.061*height,
        // width: 0.186*width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /*
              Container(
                width: 8.w,
                height: 8.h,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: itsBool ? AppColors.main_color : Colors.transparent),
              ),


               */
              SizedBox(
                height: 3.h,
              ),
              SvgPicture.asset(svgName,
                  height: 30.h,
                  width: 30.w,
                  color:
                      itsBool ? AppColors.main_color : AppColors.black_color),
              Text(
                title,
                style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                    color:
                        itsBool ? AppColors.main_color : AppColors.black_color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
