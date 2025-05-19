import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mazzad/Bindings/HomeBindings.dart';
import 'package:mazzad/Database/SharedPreferences/shared_preferences.dart';
import 'package:mazzad/Utils/Helper.dart';
import 'package:mazzad/Utils/formTextField_widget.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../../../../Controllers/GetxController/AdvertisementsController.dart';
import '../../../../Controllers/GetxController/homeController.dart';
import '../../../../Utils/AppColors.dart';
import '../../../../Utils/asset_images.dart';
import '../../../../Utils/customElevatedButton.dart';
import '../../../../Utils/email_checker.dart';
import '../../Aucations/singleAttachment_Screen.dart';
import '../../main_Screen.dart';
import '../../profile/addNewPaymentWay_Screen.dart';

class saveAdvDetailes_Screen extends StatefulWidget {
  @override
  State<saveAdvDetailes_Screen> createState() => _saveAdvDetailes_ScreenState();
}

class _saveAdvDetailes_ScreenState extends State<saveAdvDetailes_Screen> with Helper{
  var _home_getxController = Get.find<home_GetxController>();
  var _Advertisements_getxController =
      Get.find<Advertisements_GetxController>();
  TextEditingController PriceController = TextEditingController();
  TextEditingController arTitleController = TextEditingController();
  TextEditingController arDescriptionController = TextEditingController();
  TextEditingController enTitleController = TextEditingController();
  TextEditingController enDescriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  Future<File> CompressFile({required String Path}) async {
    final newPath = p.join((await getTemporaryDirectory()).path,'${DateTime.now()}.${p.extension(Path)}');
final result = await FlutterImageCompress.compressAndGetFile(Path, newPath,quality: 35);
  return result!;

  }
  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(sourcePath: imageFile.path) ;
    if (croppedImage == null) return null;
    return File(croppedImage.path) ;
  }
bool isDeleteing =false;
  List<String?> Photos = [];
  FilePickerResult? file;
  int photoIndex=0;
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
                          value: 3 / 3,
                        ),
                      )),
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
                      'the Price'.tr,
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

                  controller: PriceController,
                  textAlignVertical: TextAlignVertical.bottom,
                  maxLines: 1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill in this field'.tr ;
                    }
                    return null;
                  },
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black_color,
                    fontFamily: 'Cairo',
                  ),keyboardType:TextInputType.number,

                  decoration: InputDecoration(
                    hintText: 'Write Price here'.tr,
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
                  height: 15.h,
                ),
                Visibility(
                  visible:
                      SharedPreferencesController().newADVLanguage == 'both' ||
                          SharedPreferencesController().newADVLanguage == 'ar',
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AppImages.circle),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            'arabic Details'.tr,
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

                        controller: arTitleController,
                        textAlignVertical: TextAlignVertical.bottom,
                        maxLines: 1,
                        minLines: 1,
                        maxLength: 20,

                        validator: (value) {
                          if(SharedPreferencesController().newADVLanguage == 'en' ){
                            return null;
                          }
                          else{
                            if (value == null || value.isEmpty) {
                              return 'Please fill in this field'.tr;
                            }else if (value.length<=5) {
                              return 'It must be greater than 5 characters'.tr;
                            } else if (value.length>20) {
                              return 'It must be less than 20 characters'.tr;
                            } else if (NameChecker.isNotValid(value)) {
                              return 'Please Enter Valid Name'.tr;
                            }
                            return null;
                          }
                        },
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black_color,
                          fontFamily: 'Cairo',
                        ),

                        decoration: InputDecoration(
                          hintText: 'ad title'.tr,
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

/*
                      Container(
                        height: 92.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.white),
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: TextField(
                          controller: arDescriptionController,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black_color,
                            fontFamily: 'Cairo',
                          ),
                          minLines: 1,
                          maxLines: 4,
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                            hintText: 'ad desc'.tr,
                            hintStyle: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
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


 */

                      SizedBox(
                        height: 100.h,

                        child: TextFormField(
                          textAlign: TextAlign.start,
                          controller: arDescriptionController,
                          textAlignVertical: TextAlignVertical.top,
                          minLines: null,
                          maxLines: null,
                          expands: true,
                          validator: (value) {
                            if(SharedPreferencesController().newADVLanguage == 'en' ){
                              return null;
                            }
                            else{
                              if (value == null || value.isEmpty) {
                                return 'Please fill in this field'.tr;
                              }
                              return null;
                            }
                          },
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black_color,
                            fontFamily: 'Cairo',
                          ),

                          decoration: InputDecoration(
                            hintText: 'ad desc'.tr,
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
                      SizedBox(
                        height: 15.h,
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible:
                      SharedPreferencesController().newADVLanguage == 'both' ||
                          SharedPreferencesController().newADVLanguage == 'en',
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AppImages.circle),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            'english Details'.tr,
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

                        controller: enTitleController,
                        textAlignVertical: TextAlignVertical.bottom,
                        maxLines: 1,
                        maxLength: 20,
                        validator: (value) {
if(SharedPreferencesController().newADVLanguage == 'ar' ){
  return null;

}
else{
  if (value == null || value.isEmpty) {
    return 'Please fill in this field'.tr;
  }else if (value.length<=5) {
    return 'It must be greater than 5 characters'.tr;
  }else if (value.length>20) {
    return 'It must be less than 20 characters'.tr;
  }  else if (NameChecker.isNotValid(value)) {
    return 'Please Enter Valid Name'.tr;
  }
  return null;
}



                        },
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black_color,
                          fontFamily: 'Cairo',
                        ),

                        decoration: InputDecoration(
                          hintText: 'ad title'.tr,
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
                      SizedBox(
                        height: 100,
                        child: TextFormField(

                          controller: enDescriptionController,
                          textAlignVertical: TextAlignVertical.top,
                          minLines: null,
                          maxLines: null,
                          expands: true,
                          validator: (value) {
                            if(SharedPreferencesController().newADVLanguage == 'ar' ){
                              return null;

                            }
                            else{
                              if (value == null || value.isEmpty) {
                                return 'Please fill in this field'.tr;
                              }
                              return null;
                            }

                          },
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black_color,
                            fontFamily: 'Cairo',
                          ),

                          decoration: InputDecoration(
                            hintText: 'ad desc'.tr,
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
                      SizedBox(
                        height: 15.h,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(AppImages.circle),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      'Add Photos'.tr,
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black_color),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                GestureDetector(
                  onTap: () async {
                    var file = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                    );
if(file !=null){

  if(Photos.length<=3){

    File? image =File(file!.path);
    image  = await  _cropImage(imageFile: image);
    File x = await  CompressFile(Path:image!.path);
    Photos.add(x.path);
    setState(() {});
  }
}

                  },
                  child: Container(
                    height: 45.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.white),
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(AppImages.gallery),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          'attach files'.tr,
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black_color),
                        ),
                        Spacer(),
                   if(Photos.length<4)     Text(
                          'Add'.tr,
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.lightgray_color),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                if (Photos.length != 0)
                  Row(
                    children: [
                      SizedBox(
                        height: 60.h,
                        child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: Photos.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                width: 5.w,
                              );
                            },
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  Get.to(()=>singleAttachment_Screen(
                                    attachment: Photos[index]!,
                                    attachmentVideo: Photos[index]!,
                                    attachmentType: 'image',
                                    isFromNetWork: false,
                                  ));
                                  photoIndex=index;
                                  setState(() {

                                  });
                                },
                                // onLongPress: (){
                                //   Photos.removeAt(index);
                                //   photoIndex=0;
                                //   setState(() {
                                //
                                //   });
                                // },
                                child:

                                Draggable(
                                  // axis:moveAxis =='horizontal'? Axis.horizontal: Axis.vertical,
                                  childWhenDragging: Container(

                                    height: 60.h,
                                    width: 60.h,
                                    clipBehavior: Clip.antiAlias,

                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5) ,
                                        border:
                                        photoIndex==index?
                                        Border.all(color: AppColors.main_color,width: 2):Border.all(width: 0)

                                    ),
                                    child: Image.file(
                                        File(Photos[index]!),
                                        fit: BoxFit.cover),
                                  ),
onDragStarted: (){
  isDeleteing=true;
  setState(() {

  });
},
                                    onDragEnd: (x){
                                      isDeleteing=false;
                                      setState(() {

                                      });
                                    },
                                  onDragCompleted: () {
                                    Photos.removeAt(index);
                                      photoIndex=0;
                                      setState(() {

                                      });
                                  },
                                  child: Container(

                                    height: 60.h,
                                    width: 60.h,
                                    clipBehavior: Clip.antiAlias,

                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5) ,
                                        border:
                                        photoIndex==index?
                                        Border.all(color: AppColors.main_color,width: 2):Border.all(width: 0)

                                    ),
                                    child: Image.file(
                                        File(Photos[index]!),
                                        fit: BoxFit.cover),
                                  ),
                                  feedback: Container(

                                    height: 60.h,
                                    width: 60.h,
                                    clipBehavior: Clip.antiAlias,

                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5) ,
                                        border:
                                        photoIndex==index?
                                        Border.all(color: AppColors.main_color,width: 2):Border.all(width: 0)

                                    ),
                                    child: Image.file(
                                        File(Photos[index]!),
                                        fit: BoxFit.cover),
                                  )
                                ),



                              );
                            }),
                      ),
                      Spacer(),

                      Visibility(
                        visible:isDeleteing ,
                        child: DragTarget(builder: (
                            BuildContext context,
                            List<dynamic> accepted,
                            List<dynamic> rejected,
                            ) {
                          return Container(

                            height: 60.h,
                            width: 60.h,
                            clipBehavior: Clip.antiAlias,

                            decoration: BoxDecoration(
                                color: AppColors.red,
                              borderRadius: BorderRadius.circular(5) ,

                            ),
                            child: Center(child: SvgPicture.asset(AppImages.trash)),
                          );
                        }),
                      )



                    ],
                  ),
                SizedBox(
                  height: 15.h,
                ),
                GetX<Advertisements_GetxController>(
                    builder: (Advertisements_GetxController controller) {
                  return (controller.isSavingAdv.isTrue)
                      ? customElevatedButton(
                          onTap: () async {


                          },
                          color: AppColors.main_color,
                          child: LoadingAnimationWidget.waveDots(
                            color: AppColors.white,
                            size: 40,
                          ),
                        )
                      : customElevatedButton(
                          onTap: ()async {


                            if (_formKey.currentState!.validate()) {
                              if(Photos.length!=0){
                                if(await Helper().checkInternet()){

                                  if(SharedPreferencesController().newADVLanguage=='ar'){

                                    bool isSaved= await   controller.AddNewAdvertisements(
                                        description: enDescriptionController.text.isEmpty?arDescriptionController.text:enDescriptionController.text,
                                        title: enTitleController.text.isEmpty?arTitleController.text:enTitleController.text,
                                        category_id:SharedPreferencesController().subCategoryID,
                                        // category_id:SharedPreferencesController().category_id,
                                        city_id: SharedPreferencesController().city_id,
                                        description_ar: arDescriptionController.text,
                                        photo: Photos[photoIndex].toString(),
                                        photos:Photos ,
                                        features: SharedPreferencesController().features,
                                        price: PriceController.text,
                                        title_ar: arTitleController.text,
                                        type_id: SharedPreferencesController().type_id,
                                        language: SharedPreferencesController().newADVLanguage
                                    );


                                    if(isSaved){
                                      Get.offAll(main_Screen(),binding: HomeBindings());

                                      show_SuccessDialog(context: context);




                                    }else{
                                      Helper().show_Dialog(
                                          context: context,
                                          title: 'There is Error'.tr,
                                          img: AppImages.error,
                                          subTitle: 'Try Again'.tr);
                                    }}
                                  if(SharedPreferencesController().newADVLanguage=='en'){

                                    bool isSaved= await   controller.AddNewAdvertisements(
                                        description: enDescriptionController.text.isEmpty?arDescriptionController.text:enDescriptionController.text,
                                        title: enTitleController.text.isEmpty?arTitleController.text:enTitleController.text,
                                        category_id:SharedPreferencesController().subCategoryID,
                                        city_id: SharedPreferencesController().city_id,
                                        description_ar: arDescriptionController.text.isEmpty?enDescriptionController.text:arDescriptionController.text,
                                        photo: Photos[photoIndex].toString(),
                                        photos:Photos ,
                                        features: SharedPreferencesController().features,
                                        price: PriceController.text,
                                        title_ar: arTitleController.text.isEmpty?enTitleController.text:arTitleController.text,
                                        type_id: SharedPreferencesController().type_id,
                                        language: SharedPreferencesController().newADVLanguage
                                    );


                                    if(isSaved){
                                      Get.offAll(main_Screen(),binding: HomeBindings());
                                      show_SuccessDialog(context: context);




                                    }else{
                                      Helper().show_Dialog(
                                          context: context,
                                          title: 'There is Error'.tr,
                                          img: AppImages.error,
                                          subTitle: 'Try Again'.tr);
                                    }}
                                  if(SharedPreferencesController().newADVLanguage=='both'){

                                    bool isSaved= await   controller.AddNewAdvertisements(
                                        description: enDescriptionController.text,
                                        title: enTitleController.text,
                                        category_id:SharedPreferencesController().subCategoryID,
                                        city_id: SharedPreferencesController().city_id,
                                        description_ar: arDescriptionController.text,
                                        photo: Photos[photoIndex].toString(),
                                        photos:Photos ,
                                        features: SharedPreferencesController().features,
                                        price: PriceController.text,
                                        title_ar: arTitleController.text,
                                        type_id: SharedPreferencesController().type_id,
                                        language: SharedPreferencesController().newADVLanguage
                                    );


                                    if(isSaved){

                                      Get.offAll(main_Screen(),binding: HomeBindings());

                                      show_SuccessDialog(context: context);




                                    }else{
                                      Helper().show_Dialog(
                                          context: context,
                                          title: 'There is Error'.tr,
                                          img: AppImages.error,
                                          subTitle: 'Try Again'.tr);
                                    }}



                                }else{
                                  Helper().show_Dialog(
                                      context: context,
                                      title: 'No Internet'.tr,
                                      img: AppImages.no_internet,
                                      subTitle: 'Try Again'.tr);                                }
                              }
                              else{
                                Helper.showSnackBar(context,text: 'Please Add 1 Photo of at least'.tr);
                              }


                            };







                            // Get.offAll(main_Screen(),binding: HomeBindings());
                            //
                          // show_SuccessDialog(context: context);



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
                        );
                }),
                SizedBox(
                  height: 25.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

