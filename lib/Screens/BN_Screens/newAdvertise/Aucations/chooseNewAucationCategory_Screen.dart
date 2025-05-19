import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mazzad/Screens/BN_Screens/newAdvertise/adv/AdvDetailes_Screen.dart';

import '../../../../Controllers/GetxController/AdvertisementsController.dart';
import '../../../../Controllers/GetxController/AucationsController.dart';
import '../../../../Controllers/GetxController/homeController.dart';
import '../../../../Database/SharedPreferences/shared_preferences.dart';
import '../../../../Utils/AppColors.dart';
import '../../../../Utils/customElevatedButton.dart';
import 'aucationDetailes_Screen.dart';

class chooseNewAucationCategory_Screen extends StatefulWidget {
  @override
  State<chooseNewAucationCategory_Screen> createState() =>
      _chooseNewAucationCategory_ScreenState();
}

class _chooseNewAucationCategory_ScreenState
    extends State<chooseNewAucationCategory_Screen> {
  var _home_getxController = Get.find<home_GetxController>();
  var _aucation_getxController = Get.find<Aucations_GetxController>();


  bool hasSelect=false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          tooltip: 'back'.tr,
          icon: Icon(Icons.arrow_back, color: AppColors.lightgray_color),
        ),
        centerTitle: true,
        title: Text(
          'shareYourAucation'.tr,
          style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.lightgray_color),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                color: Colors.transparent,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.h, bottom: 30.h),
                child: Container(
                    clipBehavior: Clip.antiAlias,
                    height: 10.h,
                    decoration: BoxDecoration(),
                    child: ClipRRect(
                      clipBehavior: Clip.antiAlias,
                      borderRadius: BorderRadius.circular(15),
                      child: LinearProgressIndicator(
                        backgroundColor: Color(0xFFACB7CA),
                        color: Color(0xff5C66E3),
                        value: (1) / 3,
                      ),
                    )),
              ),
              Text(
                'select Category'.tr,
                style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black_color),
              ),
              SizedBox(
                height: 15.h,
              ),
              SizedBox(
                height: 530.h,
                child: GetX<Aucations_GetxController>(
                    builder: (Aucations_GetxController controller) {
                  return controller.isLoading.isTrue
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
                      : SizedBox(
                          child: GridView.builder(
                              shrinkWrap: true,
                              // scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: controller.category_model!
                                  .data.length,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 185.h,
                                  childAspectRatio: 203 / 170,
                                  crossAxisSpacing: 15.w,
                                  mainAxisSpacing: 15.h,
                                  crossAxisCount: 2),
                              itemBuilder: (context, index2) {
                                return GestureDetector(
                                  onTap: () async {
                                    // await  _home_getxController.get_category_by_id(ID: controller.category_model!.data[index2].id.toString(),);

                                    // Get.to(advertiseSubCategory_Screen(Data:controller.categories_ID_model,));
                                    hasSelect=true;
                                    controller.AucationChangeStatus(index: index2);


                                    SharedPreferencesController().category_id= controller.category_model!.data[index2].id.toString();



                                    setState(() {});
                                     controller.getCategoryBYID(ID:controller.category_model!.data[index2].id.toString() );

                                     controller.getCategory_featuresQ(ID: controller.category_model!.data[index2].id.toString());
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 185.h,
                                        width: 170.w,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius:
                                            BorderRadius.circular(
                                                10)),
                                        child: Stack(
                                          children: [
                                            CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              height: 185.h,
                                              width: width,
                                              imageUrl: controller
                                                  .category_model!
                                                  .data[index2]

                                                  .icon
                                                  .toString(),
                                          ),
                                            Center(
                                              child: SizedBox(
                                                width: 150.w,
                                                child: Text(
                                                  SharedPreferencesController().languageCode=='en'?
                                                  controller
                                                      .category_model!
                                                      .data[index2]
                                                      .name
                                                      .toString():controller
                                                  .category_model!
                                                  .data[index2]
                                                  .name_ar
                                                  .toString(),
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontFamily: 'Cairo',
                                                      shadows: [
                                                        BoxShadow(
                                                          color:
                                                          Colors.grey,

                                                          spreadRadius:
                                                          20,

                                                          blurRadius: 20,

                                                          offset: Offset(
                                                              2,
                                                              2), // changes position of shadow
                                                        ),
                                                        BoxShadow(
                                                          color:
                                                          Colors.grey,

                                                          spreadRadius:
                                                          20,

                                                          blurRadius: 20,

                                                          offset: Offset(
                                                              2,
                                                              2), // changes position of shadow
                                                        ),
                                                        BoxShadow(
                                                          color:
                                                          Colors.grey,

                                                          spreadRadius:
                                                          20,

                                                          blurRadius: 20,

                                                          offset: Offset(
                                                              2,
                                                              2), // changes position of shadow
                                                        ),
                                                      ],
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      color: AppColors
                                                          .white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Checkbox(
                                        value: controller
                                            .category_model!
                                            .data[index2]

                                            .isSelected,
                                        onChanged: (x) {},
                                        activeColor: AppColors.main_color,
                                        side: BorderSide(
                                            color: AppColors.white),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        );
                }),
              ),
              SizedBox(
                height: 25.h,
              ),
              customElevatedButton(
                onTap: () {
                  if(hasSelect){
                  Get.to(aucationDetailes_Screen());
                }
                },
                color: AppColors.main_color,
                child: Text(
                  'Continue'.tr,
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
