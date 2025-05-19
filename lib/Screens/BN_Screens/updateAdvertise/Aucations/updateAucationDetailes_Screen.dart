import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mazzad/Database/SharedPreferences/shared_preferences.dart';
import 'package:mazzad/Screens/BN_Screens/newAdvertise/Aucations/saveAucationDetailes_Screen.dart';
import 'package:mazzad/Screens/BN_Screens/newAdvertise/adv/saveAdvDetailes_Screen.dart';
import 'package:mazzad/Screens/BN_Screens/updateAdvertise/Aucations/saveUpdatedAucationDetailes_Screen.dart';

import '../../../../Controllers/GetxController/AucationsController.dart';
import '../../../../Controllers/GetxController/homeController.dart';
import '../../../../Models/singleAucations_Model.dart';
import '../../../../Utils/AppColors.dart';
import '../../../../Utils/asset_images.dart';
import '../../../../Utils/customElevatedButton.dart';
import '../../profile/addNewPaymentWay_Screen.dart';

class updateAucationDetailes_Screen extends StatefulWidget {
  late singleAucations_Model? aucations_model;
  late bool? hasChangeCategory;


  updateAucationDetailes_Screen({required this.aucations_model,required this.hasChangeCategory,});

  @override
  State<updateAucationDetailes_Screen> createState() => _updateAucationDetailes_ScreenState();
}

class _updateAucationDetailes_ScreenState extends State<updateAucationDetailes_Screen> {
  var _home_getxController = Get.find<home_GetxController>();

  var _aucation_getxController = Get.find<Aucations_GetxController>();

  TextEditingController NameConttoller = TextEditingController();

  int currentIndex = 0;

  refresh() {
    setState(() {});
  }



  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
if( _aucation_getxController.isLoadingQuestions.isFalse){
  if(widget.hasChangeCategory==false){
    _aucation_getxController
        .singleAucationCategory_model!
        .data!
        .TypeEditingController.text= widget.aucations_model!.data.type!.name.toString();
    SharedPreferencesController().type_id=widget.aucations_model!.data.type!.id.toString();
    if(widget.aucations_model!.data.features!.length ==_aucation_getxController.category_featuresQ_Model!.data.length){

    for(int i =0;i<widget.aucations_model!.data.features!.length;i++){
      _aucation_getxController.category_featuresQ_Model!.data[i].textEditingController.text=widget.aucations_model!.data.features![i].value.toString();

      SharedPreferencesController().features[i]['value']=_aucation_getxController.category_featuresQ_Model!.data[i].textEditingController.text;

      print(SharedPreferencesController().features);
    }
    }


    setState(() {

    });
  }

}

  }

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
          'Aucation Details'.tr,
          style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.lightgray_color),
        ),
      ),
      backgroundColor: AppColors.background_color,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
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
                          value: 2 / 3,
                        ),
                      )),
                ),
                SizedBox(
                  height: 15.h,
                ),
                SizedBox(
                  child: GetX<Aucations_GetxController>(
                      builder: (Aucations_GetxController controller) {
                        return controller.isLoadingQuestions.isTrue ||controller.isLoadingSingleAucation.isTrue
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
                            : Column(
                          children: [
                            /*
                            Row(
                              children: [
                                SvgPicture.asset(AppImages.circle),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  ' الفئات الفرعية',
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
                            Container(
                              height: 45.h,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(5),
                                  color: AppColors.white),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w),
                              child: TextField(
                                controller: controller
                                    .singleAucationCategory_model!
                                    .data
                                    .subCategoryEditingController,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black_color,
                                  fontFamily: 'Cairo',
                                ),
                                minLines: 1,
                                onTap: () {
                                  Get.bottomSheet(
                                      enableDrag: true,
                                      enterBottomSheetDuration: Duration(milliseconds: 700),
                                      exitBottomSheetDuration: Duration(milliseconds: 700),
                                      isScrollControlled: true,
                                      StatefulBuilder(builder:
                                          (BuildContext context,
                                          StateSetter
                                          setState /*You can rename this!*/) {
                                        return Container(
                                          height: 750.h,
                                          decoration: BoxDecoration(
                                            color: AppColors
                                                .background_color,
                                            borderRadius:
                                            BorderRadius.only(
                                                topRight:
                                                Radius.circular(
                                                    15),
                                                topLeft:
                                                Radius.circular(
                                                    15)),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          child: SingleChildScrollView(
                                            physics:
                                            BouncingScrollPhysics(),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 15.h,
                                                ),
                                                Text(
                                                  'الفئات الفرعية',
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
                                                        .singleAucationCategory_model!
                                                        .data.subCategories!
                                                        .length,
                                                    separatorBuilder:
                                                        (context,
                                                        index2) {
                                                      return SizedBox(
                                                        height: 10.h,
                                                      );
                                                    },
                                                    itemBuilder: (context,
                                                        index2) {
                                                      return RadioListTile(
                                                          title: Text(
                                                            controller
                                                                .singleAucationCategory_model!
                                                                .data.subCategories![index2].name.toString(),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                'Cairo',
                                                                fontSize:
                                                                16.sp,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                                color: AppColors
                                                                    .black_color),
                                                          ),
                                                          value: controller
                                                              .singleAucationCategory_model!
                                                              .data.subCategories![index2].name.toString(),
                                                          groupValue:
                                                          controller
                                                              .singleAucationCategory_model!
                                                              .data
                                                              .subCategoryGroupValue,
                                                          activeColor:
                                                          AppColors
                                                              .main_color,
                                                          onChanged:
                                                              (value) {

                                                            controller.singleAucationCategory_model!.data.subCategoryEditingController!.text=value!;


                                                            controller.singleAucationCategory_model!.data. subCategoryGroupValue = value;
                                                            SharedPreferencesController().subCategoryID=controller
                                                                .singleAucationCategory_model!
                                                                .data.subCategories![index2].id.toString();
                                                            print(SharedPreferencesController().subCategoryID);
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
                                maxLines: 1,
                                readOnly: true,
                                cursorColor: Colors.grey,
                                decoration: InputDecoration(
                                  hintText: controller
                                      .singleAucationCategory_model!
                                      .data
                                      .subCategoryGroupValue == ''
                                      ? ''
                                      :controller
                                      .singleAucationCategory_model!
                                      .data
                                      . subCategoryGroupValue,
                                  hintStyle: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                    fontFamily: 'Cairo',
                                  ),
                                  contentPadding:
                                  EdgeInsets.only(bottom: 5.h),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder:
                                  InputBorder.none,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),



                             */


                     Row(
                              children: [
                                SvgPicture.asset(AppImages.circle),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  ' النوع',
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

                              controller:  controller
                                  .singleAucationCategory_model!
                                  .data!
                                  .TypeEditingController,
                              textAlignVertical: TextAlignVertical.bottom,
                              minLines: 1, readOnly: true,
                              onTap: (){
                                Get.bottomSheet(
                                    enableDrag: true,
                                    enterBottomSheetDuration: Duration(milliseconds: 700),
                                    exitBottomSheetDuration: Duration(milliseconds: 700),
                                    isScrollControlled: true,
                                    StatefulBuilder(builder:
                                        (BuildContext context,
                                        StateSetter
                                        setState /*You can rename this!*/) {
                                      return Container(
                                        height: 750.h,
                                        decoration: BoxDecoration(
                                          color: AppColors
                                              .background_color,
                                          borderRadius:
                                          BorderRadius.only(
                                              topRight:
                                              Radius.circular(
                                                  15),
                                              topLeft:
                                              Radius.circular(
                                                  15)),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        child: SingleChildScrollView(
                                          physics:
                                          BouncingScrollPhysics(),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 15.h,
                                              ),
                                              Text(
                                                'النوع',
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
                                                      .singleAucationCategory_model!
                                                      .data!.typeCategories!
                                                      .length,
                                                  separatorBuilder:
                                                      (context,
                                                      index2) {
                                                    return SizedBox(
                                                      height: 10.h,
                                                    );
                                                  },
                                                  itemBuilder: (context,
                                                      index2) {
                                                    return RadioListTile(
                                                        title: Text(
                                                          SharedPreferencesController()
                                                              .languageCode ==
                                                              'ar'
                                                              ? controller
                                                              .singleAucationCategory_model!
                                                              .data!
                                                              .typeCategories![
                                                          index2]
                                                              .name
                                                              .toString()
                                                              : controller
                                                              .singleAucationCategory_model!
                                                              .data!
                                                              .typeCategories![
                                                          index2]
                                                              .name_en
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontFamily:
                                                              'Cairo',
                                                              fontSize:
                                                              16.sp,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600,
                                                              color: AppColors
                                                                  .black_color),
                                                        ),
                                                        value:  SharedPreferencesController()
                                                            .languageCode ==
                                                            'ar'
                                                            ? controller
                                                            .singleAucationCategory_model!
                                                            .data!
                                                            .typeCategories![
                                                        index2]
                                                            .name
                                                            .toString()
                                                            : controller
                                                            .singleAucationCategory_model!
                                                            .data!
                                                            .typeCategories![
                                                        index2]
                                                            .name_en
                                                            .toString(),
                                                        groupValue:
                                                        controller
                                                            .singleAucationCategory_model!
                                                            .data!
                                                            .typeGroupValue,
                                                        activeColor:
                                                        AppColors
                                                            .main_color,
                                                        onChanged:
                                                            (value) {

                                                          controller.singleAucationCategory_model!.data!.TypeEditingController!.text=value!;


                                                          controller.singleAucationCategory_model!.data!. typeGroupValue = value;
                                                          SharedPreferencesController().type_id=controller
                                                              .singleAucationCategory_model!
                                                              .data!.typeCategories![index2].id.toString();

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
                                fillColor: AppColors.white,
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
                              height: 20.h,
                            ),
                            SizedBox(
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount: controller
                                      .category_featuresQ_Model!.data.length,
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: 20.w,
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(AppImages.circle),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Text(
                                              controller.category_featuresQ_Model!
                                                  .data[index].title
                                                  .toString(),
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

                                          controller: controller.category_featuresQ_Model!.data[index].textEditingController,
                                          textAlignVertical: TextAlignVertical.bottom,
                                          minLines: 1,
                                          onChanged: (value){


                                            SharedPreferencesController().features[index]['value']=_aucation_getxController.category_featuresQ_Model!.data[index].textEditingController.text;

                                            print(SharedPreferencesController().features);
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
                                            fillColor: AppColors.white,
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
                                  }),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            customElevatedButton(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {

    Get.to(saveUpdatedAucationDetailes_Screen(aucations_model: widget.aucations_model,));


    }
    ;
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
                            ), SizedBox(
                              height: 25.h,
                            ),
                          ],
                        );
                      }),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

openBottomSheet() {}

class profileTextField extends StatelessWidget {
  late String label;
  late String hint;
  late TextEditingController controller;

  profileTextField({
    required this.label,
    required this.hint,
    required this.controller,
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
        Container(
          height: 45.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: AppColors.white),
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: TextField(
            controller: controller,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black_color,
              fontFamily: 'Cairo',
            ),
            minLines: 1,
            maxLines: 1,
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
                fontFamily: 'Cairo',
              ),
              contentPadding: EdgeInsets.only(bottom: 5.h),
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
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}
