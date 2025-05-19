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
import 'package:video_compress/video_compress.dart';

// import '../../../../Controllers/GetxController/AdvertisementsController.dart';
import '../../../../Controllers/GetxController/AucationsController.dart';
import '../../../../Controllers/GetxController/homeController.dart';
import '../../../../Controllers/GetxController/profileController.dart';
import '../../../../Utils/AppColors.dart';
import '../../../../Utils/asset_images.dart';
import '../../../../Utils/customElevatedButton.dart';
import '../../../../Utils/email_checker.dart';
import '../../Aucations/singleAttachment_Screen.dart';
import '../../drawer/addWalletAmount_Screen.dart';
import '../../drawer/myWallet_Screen.dart';
import '../../main_Screen.dart';
import '../../profile/addNewPaymentWay_Screen.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class saveAucationDetailes_Screen extends StatefulWidget {
  @override
  State<saveAucationDetailes_Screen> createState() =>
      _saveAucationDetailes_ScreenState();
}

class _saveAucationDetailes_ScreenState
    extends State<saveAucationDetailes_Screen> with Helper {
  var _home_getxController = Get.find<home_GetxController>();

  // var _Advertisements_getxController = Get.find<Advertisements_GetxController>();
  var _aucation_getxController = Get.find<Aucations_GetxController>();
  var _profile_getxController = Get.find<profile_GetxController>();

  TextEditingController PriceController = TextEditingController();
  TextEditingController arTitleController = TextEditingController();
  TextEditingController arDescriptionController = TextEditingController();
  TextEditingController enTitleController = TextEditingController();
  TextEditingController enDescriptionController = TextEditingController();
  TextEditingController minBIDController = TextEditingController();
  int photoIndex = 0;
  bool isDeleteing = false;

  List<String?> Photos = [];
  List<String?>  videos=[];
File? videoThumbnail ;
  FilePickerResult? file;
  @override
  DateTime _selectedStartDate = DateTime.now();
  DateTime _selectedEndDate = DateTime.now().add(Duration(days: 1));
  final _formKey = GlobalKey<FormState>();
bool isLoadingVideo =false;
  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(sourcePath: imageFile.path) ;
    if (croppedImage == null) return null;
    return File(croppedImage.path) ;
  }
  Future<String> CompressFile({required String Path,required String type,}) async {

    if(type=='video'){
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

    }else{
      final newPath = p.join((await getTemporaryDirectory()).path,
          '${DateTime.now()}.${p.extension(Path)}');
      final result = await FlutterImageCompress.compressAndGetFile(Path, newPath,
          quality: 35);
      return result!.path;
    }





  }


  double appTax = 0;

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

      print(_selectedStartDate.toString());
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
                  onChanged: (value) {
                    appTax = double.parse(_home_getxController.setting_model!.data.fixed_fees) +
                        (double.parse(PriceController.text) * (double.parse(_home_getxController.setting_model!.data.auctionRatio)));
                    if (appTax >= double.parse(_home_getxController.setting_model!.data.fixed_fees)+double.parse(_home_getxController.setting_model!.data.auctionRatioMax)) {
                      appTax = double.parse(_home_getxController.setting_model!.data.fixed_fees)+double.parse(_home_getxController.setting_model!.data.auctionRatioMax);
                    }


                  },
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
                    // var file = await ImagePicker().pickImage(
                    //   source: ImageSource.gallery,
                    // );
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
                      ]
                    );

                    if(file !=null){



                  String attachmentType =await checkAttachmentType(imagePath:file!.paths.first! );
                  if(attachmentType =='image'){
                    if(Photos.length<=3){
                      File? image =File(file!.paths.first!);

                      image  = await  _cropImage(imageFile: image);
                      String x = await  CompressFile(Path:file!.paths.first!,type:attachmentType );
                      Photos.add(x);
                      setState(() {});
                    }
                  }else{
                    if(videos.length==0){

                      videoThumbnail = await VideoCompress.getFileThumbnail(
                        file!.paths.first!,
                        quality: 100,
                      );
                      String x = await  CompressFile(Path:file!.paths.first!,type:attachmentType );



                      videos.add(x);
                      setState(() {});
                    }else{
                      Helper.showSnackBar(context, text: 'No more than one video'.tr);
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
                        if (Photos.length < 4)
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
                if (Photos.length != 0 || videos.length!=0|| isLoadingVideo)
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
                                onTap: () {
                                  Get.to(()=>singleAttachment_Screen(
                                    attachment: Photos[index]!,
                                    attachmentVideo: Photos[index]!,
                                    attachmentType: 'image',
                                    isFromNetWork: false,
                                  ));
                                  photoIndex = index;
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
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: photoIndex == index
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
                                      Photos.removeAt(index);
                                      photoIndex = 0;
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 60.h,
                                      width: 60.h,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: photoIndex == index
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
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: photoIndex == index
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
                      SizedBox(width: 5,),

                      !isLoadingVideo?    SizedBox(
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
                                onTap: (){
                                  Get.to(()=>singleAttachment_Screen(
                                    attachment: videos.first!,
                                    attachmentVideo: videos.first!,
                                    attachmentType: 'video',
                                    isFromNetWork: false,
                                  ));
                                },
                                child: Draggable(
                                  // axis:moveAxis =='horizontal'? Axis.horizontal: Axis.vertical,
                                    childWhenDragging: Container(
                                      height: 60.h,
                                      width: 60.h,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(5),
                                          border: Border.all(width: 0)),
                                      child: Image.file(File(videoThumbnail!.path),
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
                                      videos.removeAt(index);
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

                                          child: Image.file(File(videoThumbnail!.path),
                                              fit: BoxFit.cover),
                                        ),
                                        Icon(Icons.videocam_outlined,color: AppColors.white,)
                                      ],
                                    ),
                                    feedback: Container(
                                      height: 60.h,
                                      width: 60.h,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(5),
                                          border:  Border.all(width: 0)),
                                      child: Image.file(File(videoThumbnail!.path),
                                          fit: BoxFit.cover),
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
                            child: Center(
                                child: SvgPicture.asset(AppImages.trash)),
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
                          onTap: () async {

                          },
                          color: AppColors.main_color,
                          child: LoadingAnimationWidget.waveDots(
                            color: AppColors.white,
                            size: 40,
                          ),
                        )
                      : customElevatedButton(
                          onTap: () async {
                            FocusScope.of(context).unfocus();

                            if (_formKey.currentState!.validate()) {
                              if (Photos.length != 0) {
                                Get.bottomSheet(
                                    GetBuilder(builder: (profile_GetxController profile_getx){
                                      return
                                    Container(
                                  constraints: BoxConstraints(
                                    minHeight: 250.h,
                                    maxHeight: 500.h
                                  ),
                                  decoration: const BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        topLeft: Radius.circular(15),
                                      )),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 20.h),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Center(
                                        child: Text(
                                          'Auction Add Fee'.tr,
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.black_color),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25.h,
                                      ),
                                      Text(
                                        'appTax'.tr,
                                        style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.black_color),
                                      ),
                                      if (num.parse(profile_getx
                                              .wallet_model!.data.free
                                              .toString()) <
                                          appTax)
                                        Row(
                                          children: [
                                            Text(
                                              'You do not have enough balance!'.tr,
                                              style: TextStyle(
                                                  fontFamily: 'Cairo',
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.black_color),
                                            ),
                                            Spacer(),
                                            SizedBox(
                                              width: 90.w,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Get.to(
                                                      myWallet_Screen());
                                                },
                                                child: Text(
                                                  'charge Balance'.tr,
                                                  style: TextStyle(
                                                      fontFamily: 'Cairo',
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors.white),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  backgroundColor:
                                                      AppColors.red,
                                                  elevation: 0,
                                                  minimumSize: Size(107, 31),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),


                                      SizedBox(
                                        height: 25.h,
                                      ),
                                      if (num.parse(profile_getx
                                          .wallet_model!.data.free
                                          .toString()) >=
                                          appTax)        customElevatedButton(
                                        onTap: () async {

                                          FocusScope.of(context).unfocus();

                                          if (await Helper().checkInternet()) {
                                            if (SharedPreferencesController().newADVLanguage == 'ar') {
                                              bool isSaved = await controller.AddNewAucation(
                                                  context,
                                                  videos:videos,
                                                  vedio_thumb: videoThumbnail!=null? videoThumbnail!.path :'',
                                                  description: enDescriptionController
                                                          .text.isEmpty
                                                      ? arDescriptionController
                                                          .text
                                                      : enDescriptionController
                                                          .text,
                                                  title: enTitleController.text.isEmpty
                                                      ? arTitleController.text
                                                      : enTitleController.text,
                                                  category_id:
                                                      SharedPreferencesController()
                                                          .category_id,
                                                  city_id: '1',
                                                  auction_to: _selectedEndDate
                                                      .toString(),
                                                  auction_from: _selectedStartDate
                                                      .toString(),
                                                  min_bid:
                                                      minBIDController.text,
                                                  description_ar:
                                                      arDescriptionController
                                                          .text,
                                                  photo: Photos[photoIndex]
                                                      .toString(),
                                                  photos: Photos,
                                                  features:
                                                      SharedPreferencesController()
                                                          .features,
                                                  price: PriceController.text,
                                                  title_ar:
                                                      arTitleController.text,
                                                  type_id: SharedPreferencesController()
                                                      .type_id,
                                                  language:
                                                      SharedPreferencesController()
                                                          .newADVLanguage);

                                              if (isSaved) {
                                                Get.offAll(main_Screen(), binding: HomeBindings());

                                                show_SuccessDialog(context: context,isAuction: true);

                                              }
                                            }

                                            if (SharedPreferencesController().newADVLanguage == 'en') {
                                              bool isSaved = await controller.AddNewAucation(
                                                  context,
                                                  videos:videos,
                                                  vedio_thumb: videoThumbnail!=null? videoThumbnail!.path :'',

                                                  description: enDescriptionController
                                                          .text.isEmpty
                                                      ? arDescriptionController
                                                          .text
                                                      : enDescriptionController
                                                          .text,
                                                  title: enTitleController.text.isEmpty
                                                      ? arTitleController.text
                                                      : enTitleController.text,
                                                  category_id:
                                                      SharedPreferencesController()
                                                          .category_id,
                                                  city_id: '1',
                                                  description_ar: arDescriptionController
                                                          .text.isEmpty
                                                      ? enDescriptionController
                                                          .text
                                                      : arDescriptionController
                                                          .text,
                                                  photo: Photos[photoIndex]
                                                      .toString(),
                                                  photos: Photos,
                                                  auction_to: _selectedEndDate
                                                      .toString(),
                                                  auction_from: _selectedStartDate
                                                      .toString(),
                                                  min_bid:
                                                      minBIDController.text,
                                                  features:
                                                      SharedPreferencesController()
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
                                                show_SuccessDialog(context: context,isAuction: true);

                                              }
                                            }

                                            if (SharedPreferencesController().newADVLanguage == 'both') {
                                              bool isSaved = await controller.AddNewAucation(
                                                  context,
                                                  videos:videos,
                                                  vedio_thumb: videoThumbnail!=null? videoThumbnail!.path :'',

                                                  description:
                                                      enDescriptionController
                                                          .text,
                                                  title: enTitleController.text,
                                                  category_id:
                                                      SharedPreferencesController()
                                                          .category_id,
                                                  city_id: '1',
                                                  auction_to: _selectedEndDate
                                                      .toString(),
                                                  auction_from:
                                                      _selectedStartDate
                                                          .toString(),
                                                  min_bid:
                                                      minBIDController.text,
                                                  description_ar:
                                                      arDescriptionController
                                                          .text,
                                                  photo: Photos[photoIndex]
                                                      .toString(),
                                                  photos: Photos,
                                                  features:
                                                      SharedPreferencesController()
                                                          .features,
                                                  price: PriceController.text,
                                                  title_ar:
                                                      arTitleController.text,
                                                  type_id:
                                                      SharedPreferencesController()
                                                          .type_id,
                                                  language:
                                                      SharedPreferencesController()
                                                          .newADVLanguage);

                                              if (isSaved) {
                                                Get.offAll(main_Screen(), binding: HomeBindings());

                                                show_SuccessDialog(context: context,isAuction: true);

                                              }
                                            }
                                          }
                                          else {
                                            Helper().show_Dialog(
                                                context: context,
                                                title: 'No Internet'.tr,
                                                img: AppImages.no_internet,
                                                subTitle: 'Try Again'.tr);

                                          }
                                        },
                                        color: AppColors.main_color,
                                        child: Text(
                                          'Ok'.tr,
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                                    }));



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
