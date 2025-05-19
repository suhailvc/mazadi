import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mazzad/Database/SharedPreferences/shared_preferences.dart';
import 'package:mazzad/Utils/AppColors.dart';
import 'package:mazzad/Utils/Helper.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Controllers/GetxController/AdvertisementsController.dart';
import '../../../Controllers/GetxController/homeController.dart';
import '../../../Models/advertisementCategories_Model.dart';
import '../../../Models/advertisementCategoryDetails_Model.dart';
import '../../../Utils/asset_images.dart';
import 'advertiseForSubCategory_Screen.dart';

class advertiseSubCategory_Screen extends StatefulWidget {
  late String CategoryName;
  late String CategoryID;

  advertiseSubCategory_Screen({
    required this.CategoryName,
    required this.CategoryID,
  });

  @override
  State<advertiseSubCategory_Screen> createState() =>
      _advertiseSubCategory_ScreenState();
}

class _advertiseSubCategory_ScreenState
    extends State<advertiseSubCategory_Screen> {
  var _advertisements_getxController =
      Get.find<Advertisements_GetxController>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: AppColors.background_color,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0.2,
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: AppColors.darkgray_color),
              onPressed: () {
                Get.back();
              }),
          title: Text(
            widget.CategoryName,
            style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black_color),
          ),
          // actions: [
          //   IconButton(
          //       icon: SvgPicture.asset(AppImages.search), onPressed: () {}),
          // ],
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            GetX<home_GetxController>(
                builder: (home_GetxController controller) {
              return (controller.isLoadingCategoryData.isTrue)
                  ? Center(
                      child: LoadingAnimationWidget.dotsTriangle(
                        color: AppColors.main_color,
                        size: 40,
                      ),
                    )
                  : SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          // SizedBox(height: 15.h,),
                          //
                          // CachedNetworkImage(
                          //   width: width,
                          //   fit: BoxFit.cover,
                          //   imageUrl:controller.categories_ID_model!.lastPaidAdvertisement!.photo.toString(),
                          // ),

                          Padding(
                            padding: EdgeInsets.only(
                              top: 15.h,
                              left: 10.w,
                              right: 10.w,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Divider(color: Colors.transparent),

                                /*
                      Text(
                        'Ads by type'.tr,
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black_color),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      GridView.builder(
                          shrinkWrap: true,
                          // scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: _advertisements_getxController.category_types!.data!.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: 50.h,
                              childAspectRatio: 50 / 112,
                              crossAxisSpacing: 15.w,
                              mainAxisSpacing: 15.h,
                              crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                if(await Helper().checkInternet()) {
                                _advertisements_getxController
                                    .get_advertisement_byCategory(
                                    ID: widget.CategoryID,
                                    TypeID: _advertisements_getxController.category_types!.data![index].id);
                                Get.to(advertiseForSubCategory_Screen(
                                  CategoryName: widget.CategoryName,
                                  TypeID: _advertisements_getxController.category_types!.data![index].id,));

                              }
                                else{
                                Helper() .show_Dialog(context: context,title: 'لا يتوفر اتصال بالانترنت',img: AppImages.no_internet,subTitle: 'حاول مرة اخرى');
                              }
                              },
                              child:Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 13.h),
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Center(
                                  child: Text(

                                    _advertisements_getxController.category_types!.data![index].name.toString(),
                                    style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.gray_color),
                                  ),
                                ),
                              )
                            );
                          }),


                       */
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text(
                                  'Subcategories'.tr,
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black_color),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                /*
                      GridView.builder(
                          shrinkWrap: true,
                          // scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: controller.categories_ID_model!.data!.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: 185.h,
                              childAspectRatio: 185 / 108,
                              crossAxisSpacing: 15.w,
                              mainAxisSpacing: 15.h,
                              crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                // await  controller.get_category_by_id(ID: controller.AllAdvertisement!.data[index].subCategories![index2].id.toString(),);
                                //
                                if(await Helper().checkInternet()){

                                _advertisements_getxController.get_advertisement_byCategory(ID: controller.categories_ID_model!.data![index].id
                                       .toString() ,);
                                   print(controller.categories_ID_model!.data![index].id.toString() ,);
                                // Get.to(advertiseSubCategory_Screen(Data:controller.categories_ID_model,));
                                Get.to(advertiseForSubCategory_Screen(CategoryName:controller.categories_ID_model!.data![index].name
                                    .toString() ,));

                              }else{
                                  Helper() .show_Dialog(context: context,title: 'لا يتوفر اتصال بالانترنت',img: AppImages.no_internet,subTitle: 'حاول مرة اخرى');
                                }
                              },
                              child: Container(
                                height: 185.h,
                                width: 108.w,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CachedNetworkImage(

                                      fit: BoxFit.cover,
                                      height: 84.h,
                                      width:  84.w,
                                      imageUrl: controller.categories_ID_model!.data![index].icon
                                          .toString(),

                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
SharedPreferencesController().languageCode=='en'?
                                      controller.categories_ID_model!.data![index].name
                                          .toString():
controller.categories_ID_model!.data![index].name_ar
    .toString(),
                                      style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 14.sp,
                                          shadows: [
                                            BoxShadow(
                                              color: Colors.grey,

                                              spreadRadius: 20,

                                              blurRadius: 20,

                                              offset: Offset(
                                                  2, 2), // changes position of shadow
                                            ),
                                          ],
                                          fontWeight: FontWeight.bold,
                                          color:
                                              AppColors.black_color.withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),


                       */
                                SizedBox(
                                  child: ListView.separated(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemCount: controller
                                          .categories_ID_model!.data!.length,
                                      separatorBuilder: (context, index) {
                                        return Divider(
                                          thickness: 1.2,
                                          endIndent: 25.w,
                                          indent: 25.w,
                                        );
                                      },
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          onTap: () async {
                                            // await  controller.get_category_by_id(ID: controller.AllAdvertisement!.data[index].subCategories![index2].id.toString(),);
                                            //
                                            if (await Helper().checkInternet()) {
                                              _advertisements_getxController.get_advertisement_byCategory(
                                                ID: controller.categories_ID_model!
                                                    .data![index].id
                                                    .toString(),
                                              );

                                              // Get.to(advertiseSubCategory_Screen(Data:controller.categories_ID_model,));
                                              Get.to(advertiseForSubCategory_Screen(
                                                CategoryName:
                                                SharedPreferencesController().languageCode=='ar'?
                                                controller
                                                    .categories_ID_model!
                                                    .data![index]
                                                    .name_ar
                                                    .toString():controller
                                                    .categories_ID_model!
                                                    .data![index]
                                                    .name
                                                    .toString(),
                                              ));
                                            } else {
                                              Helper().show_Dialog(
                                                  context: context,
                                                  title: 'لا يتوفر اتصال بالانترنت',
                                                  img: AppImages.no_internet,
                                                  subTitle: 'حاول مرة اخرى');
                                            }
                                          },
                                          title: Text(
                                            SharedPreferencesController()
                                                        .languageCode ==
                                                    'en'
                                                ? controller.categories_ID_model!
                                                    .data![index].name
                                                    .toString()
                                                : controller.categories_ID_model!
                                                    .data![index].name_ar
                                                    .toString(),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontFamily: 'Cairo',
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.black_color
                                                    .withOpacity(0.8)),
                                          ),
                                          trailing: Icon(Icons.arrow_forward_ios),
                                        );
                                      }),
                                ),
                                SizedBox(
                                  height: 50.h,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
            }),




          ],
        ));
  }
}
