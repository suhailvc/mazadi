import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mazzad/Bindings/HomeBindings.dart';
import 'package:mazzad/Screens/BN_Screens/main_Screen.dart';
import 'package:mazzad/Utils/CustomText.dart';

import '../../Controllers/GetxController/BoardingController.dart';
import '../../Utils/AppColors.dart';
import '../Login/Login_Screen.dart';
import 'onBoarding_Content.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  boarding_GetxController _boarding_getxController =
      Get.put(boarding_GetxController());

  // var  _boarding_getxController = Get.find<boarding_GetxController>();

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    _pageController = PageController();
    _boarding_getxController.isLoading.listen((p0) {
      if(p0==false){
        setState(() {

        });
      }
    });

  }

  @override
  void dispose() {
// TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(right: 0.w, left: 0.w),
        child: GetX<boarding_GetxController>(
            builder: (boarding_GetxController controller) {
          return controller.isLoading.isTrue
              ? Center(
                  child: Container(
                    height: 60.h,
                    width: 60.w,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: LoadingAnimationWidget.fourRotatingDots(
                      color: AppColors.main_color,
                      size: 40,
                    ),
                  ),
                )
              : Stack(
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.boardings_model!.data.length,
                      onPageChanged: (page) {
                        _currentPage = page;
                        setState(() {});
                      },
                      itemBuilder: (context, index) {
                        return OnBoardingContent(
                          image: controller.boardings_model!.data[index].photo
                              .toString(),
                          title: controller.boardings_model!.data[index].title
                              .toString(),
                          description: controller
                              .boardings_model!.data[index].description
                              .toString(),
                        );
                      },
                    ),
                    Visibility(
                      visible: _currentPage !=
                          controller.boardings_model!.data.length - 1,
                      child: Positioned(
                        top: 72.h,
                        left: 20.w,
                        child: TextButton(
                          onPressed: () {
                            Get.offAll(main_Screen(),binding: HomeBindings());
                            // Get.offAll(LoginScreen());
                          },
                          child: Text(
                            'تخطي',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: 'Cairo',
                                color: AppColors.black_color),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _currentPage != 0,
                      child: Positioned(
                        top: 72.h,
                        right: 20.w,
                        child: IconButton(
                            onPressed: () {
                              _pageController.previousPage(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.ease);
                            },
                            icon: Icon(Icons.arrow_back_ios)),
                      ),
                    ),
                    Visibility(
                      visible: _currentPage !=
                          controller.boardings_model!.data.length - 1,
                      child: Positioned(
                        bottom: 30.h,
                        left: 20.w,
                        child: GestureDetector(
                          onTap: () {
                            _pageController.nextPage(
                                duration: Duration(seconds: 1),
                                curve: Curves.ease);
                          },
                          child: Container(
                            width: 40.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.main_color),
                            child:
                                Icon(Icons.arrow_forward, color: Colors.white),
                          ),
                        ),
                      ),
                      replacement: Positioned(
                        bottom: 30.h,
                        left: 20.w,
                        child: Row(
                          children: [
                            AppText(
                              text: 'البدء',
                              textStyle: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      AppColors.black_color.withOpacity(0.58)),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.offAll(main_Screen(),binding: HomeBindings());
                                // Get.offAll(LoginScreen());
                              },
                              child: Container(
                                width: 40.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.main_color),
                                child: Icon(Icons.arrow_forward,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
        }),
      ),
    );
  }
}
