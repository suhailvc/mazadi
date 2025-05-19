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

import '../../../../Controllers/GetxController/AdvertisementsController.dart';
import '../../../../Controllers/GetxController/homeController.dart';
import '../../../../Models/singleAdvertisement_Model.dart';
import '../../../../Utils/AppColors.dart';
import '../../../../Utils/asset_images.dart';
import '../../../../Utils/customElevatedButton.dart';
import '../../../../Utils/email_checker.dart';
import '../../Aucations/singleAttachment_Screen.dart';
import '../../main_Screen.dart';
import '../../profile/addNewPaymentWay_Screen.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class SaveUpdatedAdvDetailes_Screen extends StatefulWidget {
  late singleAdvertisement_Model? Adv_model;

  SaveUpdatedAdvDetailes_Screen({required this.Adv_model});

  @override
  State<SaveUpdatedAdvDetailes_Screen> createState() =>
      _SaveUpdatedAdvDetailes_ScreenState();
}

class _SaveUpdatedAdvDetailes_ScreenState
    extends State<SaveUpdatedAdvDetailes_Screen> with Helper {
  var _home_getxController = Get.find<home_GetxController>();
  var _Advertisements_getxController =
      Get.find<Advertisements_GetxController>();
  TextEditingController PriceController = TextEditingController();
  TextEditingController arTitleController = TextEditingController();
  TextEditingController arDescriptionController = TextEditingController();
  TextEditingController enTitleController = TextEditingController();
  TextEditingController enDescriptionController = TextEditingController();

  List<String?> Photos = [];
  FilePickerResult? file;
  final _formKey = GlobalKey<FormState>();
  String CoverPhoto = '';

  Future<File> CompressFile({required String Path}) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(Path)}');
    final result = await FlutterImageCompress.compressAndGetFile(Path, newPath,
        quality: 35);
    return result!;
  }

  bool isDeleteing = false;

  @override
  void initState() {
    super.initState();
    PriceController =
        TextEditingController(text: widget.Adv_model!.data.price.toString());
    arTitleController =
        TextEditingController(text: widget.Adv_model!.data.titleAr.toString());
    arDescriptionController = TextEditingController(
        text: widget.Adv_model!.data.descriptionAr.toString());
    enTitleController =
        TextEditingController(text: widget.Adv_model!.data.title.toString());
    enDescriptionController = TextEditingController(
        text: widget.Adv_model!.data.description.toString());
  }
  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(sourcePath: imageFile.path) ;
    if (croppedImage == null) return null;
    return File(croppedImage.path) ;
  }

  @override
  void dispose() {
    PriceController.dispose();
    arTitleController.dispose();
    arDescriptionController.dispose();
    enTitleController.dispose();
    enDescriptionController.dispose();
    super.dispose();
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
                  keyboardType: TextInputType.number,
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
                          if (SharedPreferencesController().newADVLanguage ==
                              'en') {
                            return null;
                          } else {
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
                          controller: arDescriptionController,
                          textAlignVertical: TextAlignVertical.top,
                          minLines: null,
                          maxLines: null,
                          expands: true,
                          validator: (value) {
                            if (SharedPreferencesController().newADVLanguage ==
                                'en') {
                              return null;
                            } else {
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
                          if (SharedPreferencesController().newADVLanguage ==
                              'ar') {
                            return null;
                          } else {
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
                        height: 100.h,
                        child: TextFormField(
                          controller: enDescriptionController,
                          textAlignVertical: TextAlignVertical.top,
                          minLines: null,
                          maxLines: null,
                          expands: true,
                          validator: (value) {
                            if (SharedPreferencesController().newADVLanguage ==
                                'ar') {
                              return null;
                            } else {
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
                    if (Photos.length + widget.Adv_model!.data.images!.length <=
                        3) {
                      var file = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                      );

                      if (Photos.length <= 3) {
                        File? image =File(file!.path);

                        image  = await  _cropImage(imageFile: image);
                        File x = await CompressFile(Path: file!.path);
                        Photos.add(x.path);
                        setState(() {});
                      } else {}
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
                        if (Photos.length +
                                widget.Adv_model!.data.images!.length <=
                            3)
                          Text(
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
                // if (Photos.length != 0)
                Row(
                  children: [
                    SizedBox(
                      height: 60.h,
                      child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: widget.Adv_model!.data.images!.length,
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              width: 5.w,
                            );
                          },
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(()=>singleAttachment_Screen(
                                  attachment: widget.Adv_model!.data.images![index]!.photo!,
                                  attachmentVideo: widget.Adv_model!.data.images![index]!.photo!,
                                  attachmentType: 'image',
                                  isFromNetWork: true,
                                ));
                                CoverPhoto = widget
                                    .Adv_model!.data.images![index].photo
                                    .toString();
                                SharedPreferencesController().cover_image_id =
                                    widget.Adv_model!.data.images![index].id
                                        .toString();
                                setState(() {});
                              },
                              // onLongPress: (){
                              //   Photos.removeAt(index);
                              //   photoIndex=0;
                              //   setState(() {
                              //
                              //   });
                              // },
                              child: Draggable(
                                // axis:moveAxis =='horizontal'? Axis.horizontal: Axis.vertical,
                                childWhenDragging: Container(
                                    height: 60.h,
                                    width: 60.h,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: CoverPhoto ==
                                                widget.Adv_model!.data
                                                    .images![index].photo
                                                    .toString()
                                            ? Border.all(
                                                color: AppColors.main_color,
                                                width: 2)
                                            : Border.all(width: 0)),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: widget
                                          .Adv_model!.data.images![index].photo
                                          .toString(),
                                    )),
                                onDragStarted: () {
                                  isDeleteing = true;
                                  setState(() {});
                                },
                                onDragEnd: (x) {
                                  isDeleteing = false;
                                  setState(() {});
                                },
                                onDragCompleted: () {
                                  SharedPreferencesController()
                                      .oldDeletedPhotos
                                      .add(widget
                                          .Adv_model!.data.images![index].id
                                          .toString());
                                  if (CoverPhoto ==
                                      widget.Adv_model!.data.images![index]
                                          .photo) {
                                    CoverPhoto = '';
                                  }
                                  widget.Adv_model!.data.images!
                                      .removeAt(index);

                                  print(SharedPreferencesController()
                                      .oldDeletedPhotos);
                                  setState(() {});
                                },
                                child: Container(
                                    height: 60.h,
                                    width: 60.h,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: CoverPhoto ==
                                                widget.Adv_model!.data
                                                    .images![index].photo
                                                    .toString()
                                            ? Border.all(
                                                color: AppColors.main_color,
                                                width: 2)
                                            : Border.all(width: 0)),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: widget
                                          .Adv_model!.data.images![index].photo
                                          .toString(),
                                    )),
                                feedback: Container(
                                    height: 60.h,
                                    width: 60.h,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: CoverPhoto ==
                                                widget.Adv_model!.data
                                                    .images![index].photo
                                                    .toString()
                                            ? Border.all(
                                                color: AppColors.main_color,
                                                width: 2)
                                            : Border.all(width: 0)),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: widget
                                          .Adv_model!.data.images![index].photo
                                          .toString(),
                                    )),
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
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
                              onTap: () {
                                Get.to(()=>singleAttachment_Screen(
                                  attachment: Photos[index]!,
                                  attachmentVideo: Photos[index]!,
                                  attachmentType: 'image',
                                  isFromNetWork: false,
                                ));
                                CoverPhoto = Photos[index].toString();
                                SharedPreferencesController().cover_image_id =
                                    '';

                                setState(() {});
                              },
                              child: Draggable(
                                  // axis:moveAxis =='horizontal'? Axis.horizontal: Axis.vertical,
                                  childWhenDragging: Container(
                                    height: 60.h,
                                    width: 60.h,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: CoverPhoto ==
                                                Photos[index].toString()
                                            ? Border.all(
                                                color: AppColors.main_color,
                                                width: 2)
                                            : Border.all(width: 0)),
                                    child: Image.file(File(Photos[index]!),
                                        fit: BoxFit.cover),
                                  ),
                                  onDragStarted: () {
                                    isDeleteing = true;
                                    setState(() {});
                                  },
                                  onDragEnd: (x) {
                                    isDeleteing = false;
                                    setState(() {});
                                  },
                                  onDragCompleted: () {
                                    if (CoverPhoto == Photos[index]) {
                                      CoverPhoto = '';
                                    }
                                    Photos.removeAt(index);

                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 60.h,
                                    width: 60.h,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: CoverPhoto ==
                                                Photos[index].toString()
                                            ? Border.all(
                                                color: AppColors.main_color,
                                                width: 2)
                                            : Border.all(width: 0)),
                                    child: Image.file(File(Photos[index]!),
                                        fit: BoxFit.cover),
                                  ),
                                  feedback: Container(
                                    height: 60.h,
                                    width: 60.h,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: CoverPhoto ==
                                                Photos[index].toString()
                                            ? Border.all(
                                                color: AppColors.main_color,
                                                width: 2)
                                            : Border.all(width: 0)),
                                    child: Image.file(File(Photos[index]!),
                                        fit: BoxFit.cover),
                                  )),
                            );
                          }),
                    ),
                    Spacer(),
                    Visibility(
                      visible: isDeleteing,
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
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child:
                              Center(child: SvgPicture.asset(AppImages.trash)),
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
                          onTap: () async {},
                          color: AppColors.main_color,
                          child: LoadingAnimationWidget.waveDots(
                            color: AppColors.white,
                            size: 40,
                          ),
                        )
                      : customElevatedButton(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              if (Photos.length +
                                      widget.Adv_model!.data.images!.length !=
                                  0) {
                                if (CoverPhoto != '') {
                                  if (await Helper().checkInternet()) {
                                    if (SharedPreferencesController()
                                            .newADVLanguage ==
                                        'ar') {
                                      bool isSaved = await controller.EditAdvertisements(
                                          advID: widget.Adv_model!.data.id
                                              .toString(),
                                          description: enDescriptionController.text
                                                  .isEmpty
                                              ? arDescriptionController.text
                                              : enDescriptionController.text,
                                          title: enTitleController.text.isEmpty
                                              ? arTitleController.text
                                              : enTitleController.text,
                                          category_id:
                                              SharedPreferencesController()
                                                  .subCategoryID,
                                          city_id: SharedPreferencesController()
                                              .city_id,
                                          description_ar:
                                              arDescriptionController.text,
                                          photo: CoverPhoto,
                                          cover_image_id:
                                              SharedPreferencesController()
                                                  .cover_image_id,
                                          photos: Photos,
                                          deleted_list:
                                              SharedPreferencesController()
                                                  .oldDeletedPhotos,
                                          features: SharedPreferencesController()
                                              .features,
                                          price: PriceController.text,
                                          title_ar: arTitleController.text,
                                          type_id: SharedPreferencesController()
                                              .type_id,
                                          language:
                                              SharedPreferencesController()
                                                  .newADVLanguage);

                                      if (isSaved) {
                                        Get.offAll(main_Screen(),
                                            binding: HomeBindings());

                                        show_SuccessDialog(context: context);
                                      } else {
                                        Helper().show_Dialog(
                                            context: context,
                                            title: 'There is Error'.tr,
                                            img: AppImages.error,
                                            subTitle: 'Try Again'.tr);
                                      }
                                    }

                                    if (SharedPreferencesController()
                                            .newADVLanguage ==
                                        'en') {
                                      bool isSaved = await controller.EditAdvertisements(
                                          advID: widget.Adv_model!.data.id
                                              .toString(),
                                          deleted_list:
                                              SharedPreferencesController()
                                                  .oldDeletedPhotos,
                                          description: enDescriptionController
                                                  .text.isEmpty
                                              ? arDescriptionController.text
                                              : enDescriptionController.text,
                                          title: enTitleController.text.isEmpty
                                              ? arTitleController.text
                                              : enTitleController.text,
                                          category_id:
                                              SharedPreferencesController()
                                                  .subCategoryID,
                                          city_id: SharedPreferencesController()
                                              .city_id,
                                          description_ar: arDescriptionController
                                                  .text.isEmpty
                                              ? enDescriptionController.text
                                              : arDescriptionController.text,
                                          photo: CoverPhoto,
                                          photos: Photos,
                                          cover_image_id:
                                              SharedPreferencesController()
                                                  .cover_image_id,
                                          features: SharedPreferencesController()
                                              .features,
                                          price: PriceController.text,
                                          title_ar: arTitleController.text.isEmpty
                                              ? enTitleController.text
                                              : arTitleController.text,
                                          type_id: SharedPreferencesController().type_id,
                                          language: SharedPreferencesController().newADVLanguage);

                                      if (isSaved) {
                                        Get.offAll(main_Screen(),
                                            binding: HomeBindings());
                                        show_SuccessDialog(context: context);
                                      } else {
                                        Helper().show_Dialog(
                                            context: context,
                                            title: 'There is Error'.tr,
                                            img: AppImages.error,
                                            subTitle: 'Try Again'.tr);
                                      }
                                    }

                                    if (SharedPreferencesController()
                                            .newADVLanguage ==
                                        'both') {
                                      bool isSaved = await controller
                                          .EditAdvertisements(
                                              advID: widget
                                                  .Adv_model!.data.id
                                                  .toString(),
                                              deleted_list:
                                                  SharedPreferencesController()
                                                      .oldDeletedPhotos,
                                              description:
                                                  enDescriptionController.text,
                                              title: enTitleController.text,
                                              category_id:
                                                  SharedPreferencesController()
                                                      .subCategoryID,
                                              city_id:
                                                  SharedPreferencesController()
                                                      .city_id,
                                              description_ar:
                                                  arDescriptionController.text,
                                              photo: CoverPhoto,
                                              cover_image_id:
                                                  SharedPreferencesController()
                                                      .cover_image_id,
                                              photos: Photos,
                                              features:
                                                  SharedPreferencesController()
                                                      .features,
                                              price: PriceController.text,
                                              title_ar: arTitleController.text,
                                              type_id:
                                                  SharedPreferencesController()
                                                      .type_id,
                                              language:
                                                  SharedPreferencesController()
                                                      .newADVLanguage);

                                      if (isSaved) {
                                        Get.offAll(main_Screen(),
                                            binding: HomeBindings());

                                        show_SuccessDialog(context: context,);
                                      } else {
                                        Helper().show_Dialog(
                                            context: context,
                                            title: 'There is Error'.tr,
                                            img: AppImages.error,
                                            subTitle: 'Try Again'.tr);
                                      }
                                    }
                                  } else {
                                    Helper().show_Dialog(
                                        context: context,
                                        title: 'No Internet'.tr,
                                        img: AppImages.no_internet,
                                        subTitle: 'Try Again'.tr);
                                  }
                                } else {
                                  Helper.showSnackBar(context,
                                      text: 'Please select cover Photo'.tr);
                                }
                              } else {
                                Helper.showSnackBar(context,
                                    text: 'Please Add 1 Photo of at least'.tr);
                              }
                            }
                            ;

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
