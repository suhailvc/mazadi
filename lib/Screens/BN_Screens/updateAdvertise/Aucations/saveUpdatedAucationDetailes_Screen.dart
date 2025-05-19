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
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mazzad/Bindings/HomeBindings.dart';
import 'package:mazzad/Database/SharedPreferences/shared_preferences.dart';
import 'package:mazzad/Utils/Helper.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:video_compress/video_compress.dart';

// import '../../../../Controllers/GetxController/AdvertisementsController.dart';
import '../../../../Controllers/GetxController/AucationsController.dart';
import '../../../../Controllers/GetxController/homeController.dart';
import '../../../../Models/singleAucations_Model.dart';
import '../../../../Utils/AppColors.dart';
import '../../../../Utils/asset_images.dart';
import '../../../../Utils/customElevatedButton.dart';
import '../../../../Utils/email_checker.dart';
import '../../Aucations/singleAttachment_Screen.dart';
import '../../main_Screen.dart';
import '../../profile/addNewPaymentWay_Screen.dart';

class saveUpdatedAucationDetailes_Screen extends StatefulWidget {
  late singleAucations_Model? aucations_model;

  saveUpdatedAucationDetailes_Screen({required this.aucations_model});

  @override
  State<saveUpdatedAucationDetailes_Screen> createState() =>
      _saveUpdatedAucationDetailes_ScreenState();
}

class _saveUpdatedAucationDetailes_ScreenState
    extends State<saveUpdatedAucationDetailes_Screen> with Helper {
  var _home_getxController = Get.find<home_GetxController>();

  // var _Advertisements_getxController = Get.find<Advertisements_GetxController>();
  var _aucation_getxController = Get.find<Aucations_GetxController>();

  TextEditingController PriceController = TextEditingController();
  TextEditingController arTitleController = TextEditingController();
  TextEditingController arDescriptionController = TextEditingController();
  TextEditingController enTitleController = TextEditingController();
  TextEditingController enDescriptionController = TextEditingController();
  TextEditingController minBIDController = TextEditingController();
  File? videoThumbnailFile ;
  bool isLoadingVideo =false;

  Future<String> CompressFile({
    required String Path,
    required String type,
  }) async {
    if (type == 'video') {
      isLoadingVideo =true;
      setState(() {

      });
      final result = await VideoCompress.compressVideo(
        Path,
        quality: VideoQuality.MediumQuality,
      );
      isLoadingVideo =false;
      setState(() {

      });
      return result!.path!;
      return '';
    } else {
      final newPath = p.join((await getTemporaryDirectory()).path,
          '${DateTime.now()}.${p.extension(Path)}');
      final result = await FlutterImageCompress.compressAndGetFile(
          Path, newPath,
          quality: 35);
      return result!.path;
    }
  }

  String checkAttachmentType({required String imagePath}) {
    if (imagePath.split('.').last == 'jpg' ||
        imagePath.split('.').last == 'png' ||
        imagePath.split('.').last == 'jpeg' ||
        imagePath.split('.').last == 'gif' ||
        imagePath.split('.').last == 'svg') {
      return 'image';
    } else {
      return 'video';
    }
  }

  List<String?> Photos = [];
  List<String?> videos = [];
  String VideoThumbnail = '';
  FilePickerResult? file;
  DateTime _selectedStartDate = DateTime.now();
  DateTime _selectedEndDate = DateTime.now().add(Duration(days: 1));

  @override
  void initState() {
    super.initState();
    if (widget.aucations_model!.data.vedio != null &&
        widget.aucations_model!.data.vedio_thumb != null) {
      videos.add(widget.aucations_model!.data.vedio!);
      VideoThumbnail = widget.aucations_model!.data.vedio_thumb!;
    }else{
      isVideoChanged=true;
    }

    PriceController =
        TextEditingController(text: widget.aucations_model!.data.price);
    arTitleController =
        TextEditingController(text: widget.aucations_model!.data.titleAr);
    arDescriptionController =
        TextEditingController(text: widget.aucations_model!.data.descriptionAr);
    enTitleController =
        TextEditingController(text: widget.aucations_model!.data.title);
    enDescriptionController =
        TextEditingController(text: widget.aucations_model!.data.description);
    minBIDController =
        TextEditingController(text: widget.aucations_model!.data.minBid);
    _selectedStartDate =
        DateTime.parse(widget.aucations_model!.data.auctionFrom.toString());
    _selectedEndDate =
        DateTime.parse(widget.aucations_model!.data.auctionTo.toString());
    setState(() {});
  }

  @override
  void dispose() {
    PriceController.dispose();
    arTitleController.dispose();
    arDescriptionController.dispose();
    enTitleController.dispose();
    enDescriptionController.dispose();
    minBIDController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  int photoIndex = 0;
  bool isDeleteing = false;
  String CoverPhoto = '';
  bool isVideoChanged = false;
  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(sourcePath: imageFile.path) ;
    if (croppedImage == null) return null;
    return File(croppedImage.path) ;
  }
  @override
  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedStartDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != _selectedStartDate)
      _selectedStartDate = pickedDate;
    setState(() {
      // currentDate = pickedDate;
      _selectedStartDate.isAfter(_selectedEndDate)
          ? _selectedEndDate = _selectedStartDate
          : _selectedEndDate = _selectedEndDate;

    });
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedEndDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != _selectedEndDate)
      setState(() {
        // _selectedEndDate = pickedDate;
        pickedDate.isBefore(_selectedStartDate)
            ? _selectedEndDate = _selectedStartDate
            : _selectedEndDate = pickedDate;
      });
  }

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
                      'your Target'.tr,
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
                    // hintText: 'Write Price here'.tr,
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

                Row(
                  children: [
                    SvgPicture.asset(AppImages.circle),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      'Minimum Bid'.tr,
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
                  controller: minBIDController,
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
                    // hintText: 'Write Price here'.tr,
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
                Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(AppImages.circle),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          'Auction timeline'.tr,
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
                    GestureDetector(
                      onTap: () {
                        _selectStartDate(context);
                      },
                      child: Container(
                        height: 45.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.white),
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          children: [
                            Text(
                              'Auction start date'.tr,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                                fontFamily: 'Cairo',
                              ),
                            ),
                            Spacer(),
                            SvgPicture.asset(AppImages.calendar),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              DateFormat.yMMMd().format(_selectedStartDate),
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                                fontFamily: 'Cairo',
                              ),
                            ),
                            SizedBox(
                              width: 13.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        _selectEndDate(context);
                      },
                      child: Container(
                        height: 45.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.white),
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          children: [
                            Text(
                              'Auction end date'.tr,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                                fontFamily: 'Cairo',
                              ),
                            ),
                            Spacer(),
                            SvgPicture.asset(AppImages.calendar),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              DateFormat.yMMMd().format(_selectedEndDate),
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                                fontFamily: 'Cairo',
                              ),
                            ),
                            SizedBox(
                              width: 13.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
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
                        height: 25.h,
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
                        height: 25.h,
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
                    file = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowMultiple: false,
                        withData: true,
                        allowedExtensions: [
                          'jpg',
                          'mp4',
                          'mkv',
                          'png',
                          'jpeg',
                          'svg',
                          'gif',
                        ]);
                    if (file != null) {
                      String attachmentType = await checkAttachmentType(imagePath: file!.paths.first!);
                      if (attachmentType == 'image') {
                        if (Photos.length + widget.aucations_model!.data.images!.length <= 3) {
                          if (Photos.length <= 3) {
                            File? image =File(file!.paths!.first!);

                            image  = await  _cropImage(imageFile: image);

                            String x = await CompressFile(Path: file!.paths.first!, type: attachmentType);
                            Photos.add(x);
                            setState(() {});
                          }
                        }
                      } else {
                        if (videos.length == 0) {
                          videoThumbnailFile = await VideoCompress.getFileThumbnail(
                            file!.paths.first!,
                            quality: 100,
                          );
                          String x = await CompressFile(
                              Path: file!.paths.first!, type: attachmentType);

                          videos.add(x);
                          print(videos);
                          setState(() {});
                        } else {
                          Helper.showSnackBar(context,
                              text: 'لا يمكن اضافة اكثر من فيديو');
                        }
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
                        if (Photos.length +
                                widget.aucations_model!.data.images!.length <=
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
                          itemCount:
                              widget.aucations_model!.data.images!.length,
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              width: 5.w,
                            );
                          },
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(()=>singleAttachment_Screen(
                                  attachment: widget
                                      .aucations_model!.data.images![index].photo
                                      .toString(),
                                  attachmentVideo: widget
                                      .aucations_model!.data.images![index].photo
                                      .toString(),
                                  attachmentType: 'image',
                                  isFromNetWork: true,
                                ));
                                CoverPhoto = widget
                                    .aucations_model!.data.images![index].photo
                                    .toString();
                                SharedPreferencesController().cover_image_id =
                                    widget
                                        .aucations_model!.data.images![index].id
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
                                                widget.aucations_model!.data
                                                    .images![index].photo
                                                    .toString()
                                            ? Border.all(
                                                color: AppColors.main_color,
                                                width: 2)
                                            : Border.all(width: 0)),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: widget.aucations_model!.data
                                          .images![index].photo
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
                                      .add(widget.aucations_model!.data
                                          .images![index].id
                                          .toString());
                                  if (CoverPhoto ==
                                      widget.aucations_model!.data
                                          .images![index].photo) {
                                    CoverPhoto = '';
                                  }
                                  widget.aucations_model!.data.images!
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
                                                widget.aucations_model!.data
                                                    .images![index].photo
                                                    .toString()
                                            ? Border.all(
                                                color: AppColors.main_color,
                                                width: 2)
                                            : Border.all(width: 0)),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: widget.aucations_model!.data
                                          .images![index].photo
                                          .toString(),
                                    )),
                                feedback: Container(
                                    height: 60.h,
                                    width: 60.h,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: CoverPhoto ==
                                                widget.aucations_model!.data
                                                    .images![index].photo
                                                    .toString()
                                            ? Border.all(
                                                color: AppColors.main_color,
                                                width: 2)
                                            : Border.all(width: 0)),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: widget.aucations_model!.data
                                          .images![index].photo
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
                                  attachment: Photos[index].toString(),
                                  attachmentVideo: Photos[index].toString(),
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
                    SizedBox(
                      width: 5,
                    ),

                    !isLoadingVideo?   SizedBox(
                      height: 60.h,
                      child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: videos.length,
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              width: 5.w,
                            );
                          },
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => singleAttachment_Screen(
                                      attachment: videos.first!,
                                      attachmentVideo: videos.first!,
                                      attachmentType: 'video',
                                      isFromNetWork:
                                      isVideoChanged?
                                      false:true,
                                    ));
                              },
                              child: Draggable(
                                  // axis:moveAxis =='horizontal'? Axis.horizontal: Axis.vertical,
                                  childWhenDragging: Container(
                                    height: 60.h,
                                    width: 60.h,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(width: 0)),
                                    child:
    isVideoChanged?
                                    Image.file(File(videoThumbnailFile!.path),
                                        fit: BoxFit.cover):
    CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: VideoThumbnail,
    )
                                    ,
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
                                    videos.removeAt(index);
                                    isVideoChanged=true;
                                    setState(() {});
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        height: 60.h,
                                        width: 60.h,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(width: 0)),
                                        child:   isVideoChanged?
                                        Image.file(File(videoThumbnailFile!.path),
                                            fit: BoxFit.cover):
                                        CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: VideoThumbnail,
                                        ),
                                      ),
                                      Icon(
                                        Icons.videocam_outlined,
                                        color: AppColors.white,
                                      )
                                    ],
                                  ),
                                  feedback: Container(
                                    height: 60.h,
                                    width: 60.h,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(width: 0)),
                                    child:    isVideoChanged?
                                    Image.file(File(videoThumbnailFile!.path),
                                        fit: BoxFit.cover):
                                    CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: VideoThumbnail,
                                    ),
                                  )),
                            );
                          }),
                    ):SizedBox(
                      height: 30.h,
                      width: 30.w,
                      child: CircularProgressIndicator(
                        color: AppColors.main_color,
                      ),
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
                GetX<Aucations_GetxController>(
                    builder: (Aucations_GetxController controller) {
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
                                      widget.aucations_model!.data.images!
                                          .length !=
                                  0) {
                                if (CoverPhoto != '') {
                                  if (await Helper().checkInternet()) {
                                    if (SharedPreferencesController()
                                            .newADVLanguage ==
                                        'ar') {
                                      bool isSaved = await controller.UpdateAucation(
                                          context,

                                          video: videos,
                                          vedio_thumb: videoThumbnailFile!=null ? videoThumbnailFile!.path :VideoThumbnail,
                                          deleteVedio: isVideoChanged.toString(),
                                          deleted_list: SharedPreferencesController().oldDeletedPhotos,
                                          cover_image_id:
                                              SharedPreferencesController()
                                                  .cover_image_id,
                                          AucationID: widget
                                              .aucations_model!.data.id
                                              .toString(),
                                          description: enDescriptionController
                                                  .text.isEmpty
                                              ? arDescriptionController.text
                                              : enDescriptionController.text,
                                          title: enTitleController.text.isEmpty
                                              ? arTitleController.text
                                              : enTitleController.text,
                                          category_id: SharedPreferencesController()
                                              .category_id,
                                          city_id: SharedPreferencesController()
                                              .city_id,
                                          auction_to:
                                              _selectedEndDate.toString(),
                                          auction_from:
                                              _selectedStartDate.toString(),
                                          min_bid: minBIDController.text,
                                          description_ar:
                                              arDescriptionController.text,
                                          photo: CoverPhoto,
                                          photos: Photos,
                                          features: SharedPreferencesController()
                                              .features,
                                          price: PriceController.text,
                                          title_ar: arTitleController.text,
                                          type_id: SharedPreferencesController().type_id,
                                          language: SharedPreferencesController().newADVLanguage);

                                      if (isSaved) {
                                        Get.offAll(main_Screen(),
                                            binding: HomeBindings());

                                        show_SuccessDialog(context: context,isAuction: true);
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
                                      bool isSaved = await controller.UpdateAucation(
                                          context,

                                          video: videos,
                                          vedio_thumb: videoThumbnailFile!=null ? videoThumbnailFile!.path :VideoThumbnail,
                                          deleteVedio: isVideoChanged.toString(),
                                          AucationID: widget.aucations_model!.data.id
                                              .toString(),
                                          description: enDescriptionController.text.isEmpty
                                              ? arDescriptionController.text
                                              : enDescriptionController.text,
                                          title: enTitleController.text.isEmpty
                                              ? arTitleController.text
                                              : enTitleController.text,
                                          category_id: SharedPreferencesController()
                                              .category_id,
                                          city_id: SharedPreferencesController()
                                              .city_id,
                                          deleted_list: SharedPreferencesController()
                                              .oldDeletedPhotos,
                                          description_ar: arDescriptionController.text.isEmpty
                                              ? enDescriptionController.text
                                              : arDescriptionController.text,
                                          photo: CoverPhoto,
                                          photos: Photos,
                                          auction_to:
                                              _selectedEndDate.toString(),
                                          auction_from:
                                              _selectedStartDate.toString(),
                                          min_bid: minBIDController.text,
                                          features: SharedPreferencesController()
                                              .features,
                                          price: PriceController.text,
                                          cover_image_id:
                                              SharedPreferencesController()
                                                  .cover_image_id,
                                          title_ar: arTitleController.text.isEmpty
                                              ? enTitleController.text
                                              : arTitleController.text,
                                          type_id: SharedPreferencesController().type_id,
                                          language: SharedPreferencesController().newADVLanguage);

                                      if (isSaved) {
                                        Get.offAll(main_Screen(),
                                            binding: HomeBindings());
                                        show_SuccessDialog(context: context,isAuction: true);
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
                                      bool isSaved = await controller.UpdateAucation(
                                          context,
                                          video: videos,
                                          vedio_thumb: videoThumbnailFile!=null ? videoThumbnailFile!.path :VideoThumbnail,
                                          deleteVedio: isVideoChanged.toString(),
                                          AucationID: widget
                                              .aucations_model!.data.id
                                              .toString(),
                                          description:
                                              enDescriptionController.text,
                                          title: enTitleController.text,
                                          category_id:
                                              SharedPreferencesController()
                                                  .category_id,
                                          city_id: SharedPreferencesController()
                                              .city_id,
                                          deleted_list:
                                              SharedPreferencesController()
                                                  .oldDeletedPhotos,
                                          cover_image_id:
                                              SharedPreferencesController()
                                                  .cover_image_id,
                                          auction_to:
                                              _selectedEndDate.toString(),
                                          auction_from:
                                              _selectedStartDate.toString(),
                                          min_bid: minBIDController.text,
                                          description_ar:
                                              arDescriptionController.text,
                                          photo: CoverPhoto,
                                          photos: Photos,
                                          features:
                                              SharedPreferencesController()
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

                                        show_SuccessDialog(context: context,isAuction: true);
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
