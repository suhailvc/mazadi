import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mazzad/Database/SharedPreferences/shared_preferences.dart';
import 'package:mazzad/Screens/BN_Screens/newAdvertise/adv/saveAdvDetailes_Screen.dart';
import 'package:mazzad/Screens/BN_Screens/updateAdvertise/adv/SaveUpdatedAdvDetailes_Screen.dart';

import '../../../../Controllers/GetxController/AdvertisementsController.dart';
import '../../../../Controllers/GetxController/homeController.dart';
import '../../../../Models/singleAdvertisement_Model.dart';
import '../../../../Utils/AppColors.dart';
import '../../../../Utils/asset_images.dart';
import '../../../../Utils/customElevatedButton.dart';
import '../../profile/addNewPaymentWay_Screen.dart';

class UpdateAdvDetailes_Screen extends StatefulWidget {
  late singleAdvertisement_Model? Adv_model;
  late bool? hasChangeCategory;

  UpdateAdvDetailes_Screen({required this.Adv_model,required this.hasChangeCategory,});

  @override
  State<UpdateAdvDetailes_Screen> createState() => _UpdateAdvDetailes_ScreenState();
}

class _UpdateAdvDetailes_ScreenState extends State<UpdateAdvDetailes_Screen> {
  var _home_getxController = Get.find<home_GetxController>();
  var _Advertisements_getxController =
      Get.find<Advertisements_GetxController>();
  TextEditingController NameConttoller = TextEditingController();

  int currentIndex = 0;

  refresh() {
    setState(() {});
  }

  Future  getQuestions ()async{
    SharedPreferencesController().features.clear();

    for(int i=0;i<await _Advertisements_getxController.category_featuresQ_Model!.data.length;i++){
      SharedPreferencesController().features.add({
        'key':_Advertisements_getxController.category_featuresQ_Model!.data[i].title,
        'value':_Advertisements_getxController.category_featuresQ_Model!.data[i].textEditingController.text
      });

    }
    print(SharedPreferencesController().features);

  }


  @override
  void initState() {
    super.initState();
    // if(_Advertisements_getxController.category_featuresQ_Model!=null) {
    //   getQuestions();
    //   setState(() {
    //
    //   });
    if( _Advertisements_getxController.isLoadingQuestions.isFalse){

    if(widget.hasChangeCategory==false){

      SharedPreferencesController().subCategoryID=widget.Adv_model!.data.category!.id.toString();
      SharedPreferencesController().city_id=widget.Adv_model!.data.cityId.toString();
    int cityIndex =  _Advertisements_getxController.cities_model!.data!.indexWhere((element) => element.id.toString()==widget.Adv_model!.data.cityId.toString());
      _Advertisements_getxController.cities_model!.CityEditingController.text =
      SharedPreferencesController().languageCode=='en'?

          _Advertisements_getxController
          .cities_model!
          .data![cityIndex].name.toString():
      _Advertisements_getxController
          .cities_model!
          .data![cityIndex].nameAr.toString();

      _Advertisements_getxController
          .singleAdvertisementCategory_model!
          .data!
          .subCategoryEditingController.text =
      SharedPreferencesController().languageCode=='en'?

          widget.Adv_model!.data.category!.name.toString():widget.Adv_model!.data.category!.name.toString();

      print(SharedPreferencesController().subCategoryID);

      _Advertisements_getxController.cities_model!.CityGroupValue =
      SharedPreferencesController().languageCode=='en'?

          _Advertisements_getxController
          .cities_model!
          .data![cityIndex].name.toString():
      _Advertisements_getxController
          .cities_model!
          .data![cityIndex].nameAr.toString();
      // _Advertisements_getxController.singleAdvertisementCategory_model!.data!.subCategoryEditingController.text= (SharedPreferencesController().languageCode=='en'?widget.Adv_model!.data.category!.name:widget.Adv_model!.data.category!.name_ar)!;
      _Advertisements_getxController.singleAdvertisementCategory_model!.data!.TypeEditingController.text= (widget.Adv_model!.data.type!.name)!;
      SharedPreferencesController().type_id=widget.Adv_model!.data.typeId.toString();

      if(widget.Adv_model!.data.features!.length ==_Advertisements_getxController.category_featuresQ_Model!.data.length){
      for(int i =0;i<widget.Adv_model!.data.features!.length;i++){
        _Advertisements_getxController.category_featuresQ_Model!.data[i].textEditingController.text=widget.Adv_model!.data.features![i].value.toString();

        SharedPreferencesController().features[i]['value']=_Advertisements_getxController.category_featuresQ_Model!.data[i].textEditingController.text;

        print(SharedPreferencesController().subCategoryID);
      }
    }


      setState(() {

      });
    }
    }


  }
  final _formKey = GlobalKey<FormState>();

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
          'Advertisement detail'.tr,
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
                  child: GetX<Advertisements_GetxController>(
                      builder: (Advertisements_GetxController controller) {
                        return controller.isLoadingQuestions.isTrue ||controller.isLoadingIDData.isTrue
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
                            Row(
                              children: [
                                SvgPicture.asset(AppImages.circle),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  'Subcategories'.tr,
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

                            if(controller.isLoadingIDData.isFalse)

                                     TextFormField(

                              controller: controller
                                  .singleAdvertisementCategory_model!
                                  .data!
                                  .subCategoryEditingController,
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
                                                'Subcategories'.tr,
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
                                                      .singleAdvertisementCategory_model!
                                                      .data!.subCategories!
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
                                                              .singleAdvertisementCategory_model!
                                                              .data!
                                                              .subCategories![
                                                          index2]
                                                              .nameAr
                                                              .toString()
                                                              :
                                                          controller
                                                              .singleAdvertisementCategory_model!
                                                              .data!.subCategories![index2].name.toString(),
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
                                                        value:
                                                        SharedPreferencesController()
                                                            .languageCode ==
                                                            'ar'
                                                            ? controller
                                                            .singleAdvertisementCategory_model!
                                                            .data!
                                                            .subCategories![
                                                        index2]
                                                            .nameAr
                                                            .toString()
                                                            :
                                                        controller
                                                            .singleAdvertisementCategory_model!
                                                            .data!.subCategories![index2].name.toString(),
                                                        groupValue:
                                                        controller
                                                            .singleAdvertisementCategory_model!
                                                            .data!
                                                            .subCategoryGroupValue,
                                                        activeColor:
                                                        AppColors
                                                            .main_color,
                                                        onChanged:
                                                            (value) {

                                                          controller.singleAdvertisementCategory_model!.data!.subCategoryEditingController!.text=value!;


                                                          controller.singleAdvertisementCategory_model!.data!. subCategoryGroupValue = value;
                                                          SharedPreferencesController().subCategoryID=controller
                                                              .singleAdvertisementCategory_model!
                                                              .data!.subCategories![index2].id.toString();
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

                            Row(
                              children: [
                                SvgPicture.asset(AppImages.circle),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  'type'.tr,
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

                              controller: controller
                                  .singleAdvertisementCategory_model!
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
                                                'type'.tr,
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
                                                      .singleAdvertisementCategory_model!
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
                                                          SharedPreferencesController().languageCode=='ar'?
                                                          controller
                                                              .singleAdvertisementCategory_model!
                                                              .data!
                                                              .typeCategories![
                                                          index2]
                                                              .name
                                                              .toString()
                                                              :
                                                          controller
                                                              .singleAdvertisementCategory_model!
                                                              .data!.typeCategories![index2].name_en.toString(),
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
                                                        value:
                                                        SharedPreferencesController().languageCode=='ar'?
                                                        controller
                                                            .singleAdvertisementCategory_model!
                                                            .data!
                                                            .typeCategories![
                                                        index2]
                                                            .name
                                                            .toString()
                                                            :

                                                        controller
                                                            .singleAdvertisementCategory_model!
                                                            .data!.typeCategories![index2].name_en.toString(),
                                                        groupValue:
                                                        controller
                                                            .singleAdvertisementCategory_model!
                                                            .data!
                                                            .typeGroupValue,
                                                        activeColor:
                                                        AppColors
                                                            .main_color,
                                                        onChanged:
                                                            (value) {

                                                          controller.singleAdvertisementCategory_model!.data!.TypeEditingController!.text=value!;


                                                          controller.singleAdvertisementCategory_model!.data!. typeGroupValue = value;
                                                          SharedPreferencesController().type_id=controller
                                                              .singleAdvertisementCategory_model!
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

                                        Visibility(
                                          visible: controller
                                              .category_featuresQ_Model!
                                              .data[index]
                                              .type ==
                                              'input',
                                          child:
                                          TextFormField(

                                            controller:controller.category_featuresQ_Model!.data[index].textEditingController,
                                            textAlignVertical: TextAlignVertical.bottom,
                                            minLines: 1,
                                            onChanged: (value){

                                              SharedPreferencesController().features[index]['value']=_Advertisements_getxController.category_featuresQ_Model!.data[index].textEditingController.text;

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


                                          replacement:
                                          TextFormField(

                                            controller: controller
                                                .category_featuresQ_Model!
                                                .data[index]
                                                .textEditingController,
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
                                                              controller
                                                                  .category_featuresQ_Model!
                                                                  .data[index]
                                                                  .title
                                                                  .toString(),
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
                                                                    .category_featuresQ_Model!
                                                                    .data
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
                                                                            .category_featuresQ_Model!
                                                                            .data[
                                                                        index]
                                                                            .choices![index2],
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
                                                                          .category_featuresQ_Model!
                                                                          .data[index]
                                                                          .choices![
                                                                      index2],
                                                                      groupValue:
                                                                      controller
                                                                          .category_featuresQ_Model!
                                                                          .data[index]
                                                                          .  groupValue,
                                                                      activeColor:
                                                                      AppColors
                                                                          .main_color,
                                                                      onChanged:
                                                                          (value) {

                                                                        controller.category_featuresQ_Model!.data[index].textEditingController!.text=value!;


                                                                        controller.category_featuresQ_Model!.data[index]. groupValue = value!;
                                                                        SharedPreferencesController().features[index]['value']=_Advertisements_getxController.category_featuresQ_Model!.data[index].textEditingController.text;

                                                                        print(SharedPreferencesController().features);
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

                                            } ,
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
                            Row(
                              children: [
                                SvgPicture.asset(AppImages.circle),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  'city'.tr,
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

                              controller: controller
                                  .cities_model!
                                  .CityEditingController,
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
                                                          SharedPreferencesController().languageCode=='en'?

                                                          controller
                                                              .cities_model!
                                                              .data![index2].name.toString():controller
                                                              .cities_model!
                                                              .data![index2].nameAr.toString(),
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
                                                        value:  controller
                                                            .cities_model!
                                                            .data![index2].name.toString(),

                                                        groupValue:
                                                        controller
                                                            .cities_model!.CityGroupValue.toString(),
                                                        activeColor:
                                                        AppColors
                                                            .main_color,
                                                        onChanged:
                                                            (value) {

                                                          controller.cities_model!.CityEditingController.text=value!;

                                                          controller.cities_model!.CityGroupValue = value;

                                                          SharedPreferencesController().city_id=controller
                                                              .cities_model!
                                                              .data![index2].id.toString();
                                                          print(SharedPreferencesController().city_id);
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
                              height: 13.h,
                            ),
                            customElevatedButton(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {

                                                   Get.to(SaveUpdatedAdvDetailes_Screen(Adv_model: widget.Adv_model,));



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
