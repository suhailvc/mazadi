import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mazzad/Controllers/GetxController/AdvertisementsController.dart';
import 'package:mazzad/Models/singleAucations_Model.dart';
import 'package:mazzad/Screens/BN_Screens/advertise/singleComment_Screen.dart';
import 'package:mazzad/Utils/Helper.dart';
import 'package:mazzad/Utils/asset_images.dart';

import '../../../Controllers/GetxController/homeController.dart';
import '../../../Database/SharedPreferences/shared_preferences.dart';
import '../../../Models/singleAdvertisement_Model.dart';
import '../../../Utils/AppColors.dart';
import '../../../Utils/customElevatedButton.dart';
import '../Aucations/singleAttachment_Screen.dart';
import '../updateAdvertise/adv/UpdateAdvertismentLanguage_Screen.dart';

class MyAdvertisement_Screen extends StatefulWidget {
  late singleAdvertisement_Model? adv_model;

  MyAdvertisement_Screen({required this.adv_model});

  @override
  State<MyAdvertisement_Screen> createState() => _MyAdvertisement_ScreenState();
}

class _MyAdvertisement_ScreenState extends State<MyAdvertisement_Screen> {
  var _home_getxController = Get.find<home_GetxController>();
  TextEditingController commentController = TextEditingController();

  var _advertisements_getxController = Get.find<Advertisements_GetxController>();

  int myBid = 0;

  bool checkBoxValue = false;
  bool hasBalance = true;
  String groupValue = 'لا اريد نشر الاعلان';
  List images = [];

  bool isPhotoBig=false;
  @override
  void initState() {
    super.initState();
    // images.add(widget.adv_model!.data.photo.toString());
    // print(widget.adv_model!.data.id);
    commentController = TextEditingController();
    for (int i = 0; i < widget.adv_model!.data.images!.length; i++) {
      images.add(widget.adv_model!.data.images![i].photo);
    }
  }
@override
  void dispose() {
  commentController.dispose();    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.background_color,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageSlideshow(
              width: width,
              height: isPhotoBig?812.h:335.h,
              isLoop: true,
              children: images
                  .map((e) => GestureDetector(
                onTap: (){
                  Get.to(()=>singleAttachment_Screen(
                    attachment: e,
                    attachmentVideo: '',

                    attachmentType: 'image',
                  ));
                },
                child: CachedNetworkImage(

                  imageUrl: e,
                  progressIndicatorBuilder:
                      (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress)),
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error),
                ),
                  ))
                  .toList(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 250.w,
                        child: Text(
                          SharedPreferencesController().languageCode=='en'?

                          widget.adv_model!.data.title.toString():
                          widget.adv_model!.data.titleAr.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black_color),
                        ),
                      ),
                      Spacer(),
                      SvgPicture.asset(AppImages.edit),
                      SizedBox(
                        width: 5.w,
                      ),
                      GestureDetector(
                        onTap: (){

                          Get.to(UpdateAdvertismentLanguage_Screen(Adv_model: widget.adv_model,));
                          _home_getxController.AdvertisementChangeStatusByID(
                            ParentId: widget.adv_model!.data.category!.parent!
                                .parentId!.toInt(),
                            Id: widget.adv_model!.data.category!.parentId!.toInt(),

                          );

                        },
                        child: Text(
                          'Advertisement edit'.tr,
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black_color),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 250.w,
                        child: Text(
                          SharedPreferencesController().languageCode == 'en'
                              ? widget.adv_model!.data.category!.parent!.name
                              .toString() +
                              ' - ' +
                              widget.adv_model!.data.category!.name.toString()
                              : widget.adv_model!.data.category!.parent!.name_ar
                              .toString() +
                              ' - ' +
                              widget.adv_model!.data.category!.name_ar
                                  .toString(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black_color),
                        ),
                      ),
                      Text(
                        _advertisements_getxController.getCityName(widget.adv_model!.data.cityId),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black_color),
                      ),
                    ],
                  ),

                               SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    width: width,
                    color: AppColors.white,
                    padding: EdgeInsets.symmetric(
                        horizontal: 6.w, vertical: 10.h),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 11.h,
                        ),
                        detailsWidget(
                          img: AppImages.clock,
                          title: 'publish date'.tr,
                          data: DateFormat.yMMMd()
                              .format(DateTime.parse(widget.adv_model!.data.createdAt.toString(),)),
                        ),
                        detailsWidget(
                          img: AppImages.greenView,
                          title: 'Views count'.tr,
                          data: '${widget.adv_model!.data!.views.toString()}' +
                              'Views'.tr,
                        ),
                        detailsWidget(
                          img: AppImages.pin,
                          title: 'price'.tr,
                          data: '${widget.adv_model!.data!.price.toString()}'+' '+'Qar'.tr,
                          isDivider: false,
                          isPng: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    width: width,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.symmetric(
                        horizontal: 12.w, vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          SharedPreferencesController().languageCode=='en'?

                          widget.adv_model!.data.title.toString():
                          widget.adv_model!.data.titleAr.toString(),
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black_color),
                        ),
                        SizedBox(height: 10.h,),
                        Text(
                          SharedPreferencesController().languageCode=='en'?
                          widget.adv_model!.data.description.toString()
:
                          widget.adv_model!.data.descriptionAr.toString(),
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black_color),
                        ),
                      ],
                    ),
                  ),

                  if(widget.adv_model!.data.features!.isNotEmpty)          SizedBox(
                    height: 15.h,
                  ),
           if(widget.adv_model!.data.features!.isNotEmpty)       GridView.builder(
                      shrinkWrap: true,
                      // scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: widget.adv_model!.data.features!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 100,
                          childAspectRatio: 100 / 100,
                          crossAxisSpacing: 15.w,
                          mainAxisSpacing: 15.h,
                          crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        return Container(
                          width: 112.w,
                          height: 70.h,
                          padding: EdgeInsets.symmetric(vertical: 3.h),
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            children: [
                              Text(
                                widget.adv_model!.data.features![index].key.toString(),
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black_color),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                widget.adv_model!.data.features![index].value.toString(),
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black_color),
                              ),
                            ],
                          ),
                        );
                      }),
                  SizedBox(
                    height: 20.h,
                  ),
                  if( _advertisements_getxController.comments_model!=null)             Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'comments'.tr,
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black_color),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        '(${widget.adv_model!.data.commentsCount.toString()})',
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkgray_color),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),


                  if( _advertisements_getxController.comments_model!=null)    GetBuilder(
                builder: (Advertisements_GetxController controller) {
                  return
                    controller.isLoadingComments.isFalse?
                    SizedBox(
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: controller.comments_model!.data.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 14.h,
                          );
                        },
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: ()async{
                           await   Get.to(singleComment_Screen(commentData: controller.comments_model!.data[index],));
                           setState(() {

                           });
                            },
                            leading: Container(
                              clipBehavior: Clip.antiAlias,
                              height: 60.h,
                              width: 60.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:  controller.comments_model!.data[index].user!.photo
                                    .toString(),
                              ),
                            ),
                            title: Row(
                              children: [
                                Text(
                                  controller.comments_model!.data[index].user!.name
                                      .toString(),
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black_color),
                                ),
                                Spacer(),
                                Text(
                                  controller.comments_model!.data[index].time,
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.darkgray_color),
                                ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller
                                      .comments_model!.data[index].comment
                                      .toString(),
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.darkgray_color),
                                ),
                                if( controller
                                    .comments_model!.data[index].replies.isNotEmpty)Text(
                                  'view All Replies'.tr + '(${controller
                                      .comments_model!.data[index].replies.length})',

                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.black_color),
                                ),
                              ],
                            ),
                          );
                        }),
                  ):Center(child: CircularProgressIndicator());
                }),

                  SizedBox(
                    height: 35.h,
                  ),
                  Container(
                      width: width,
                      height: 140.h,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(

                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black_color,
                              fontFamily: 'Cairo',
                            ),
                            minLines: 1,
                            controller: commentController,
                            maxLines: 3,onChanged: (x){
                            setState(() {

                            });
                          },
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              hintText: 'write your comment here'.tr,
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
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GetX(builder: (Advertisements_GetxController adv_getx){
                                return                               SizedBox(
                                  height: 35.h,
                                  width: 70.w,
                                  child: customElevatedButton(
                                    onTap: () async {
                                      if (commentController.text.isNotEmpty) {

                                        bool commentSaved =    await _advertisements_getxController.addAdvertisementComment(
                                            context,
                                            Advertisement_ID: widget.adv_model!.data.id.toString(),
                                            comment: commentController.text);
                                        if (commentSaved) {
                                          commentController.clear();
                                        }
                                        //   //ToDo -> add Comment Local
                                        //   commentController.clear();
                                        //   _advertisements_getxController
                                        //       .getCommentByID(
                                        //           ID: widget.adv_model!.data.id
                                        //               .toString());
                                        //
                                        //   widget.adv_model = await _advertisements_getxController
                                        //           .getAdvertisementByID(
                                        //           context: context,
                                        //           ID: widget.adv_model!.data.id.toString());
                                        //
                                        //   setState(() {});
                                        //
                                        //   // _home_getxController.getLatest_advertisements();
                                        //
                                        // } else {
                                        //   Helper().show_Dialog(
                                        //       context: context,
                                        //       title: 'لا يتوفر اتصال بالانترنت',
                                        //       img: AppImages.no_internet,
                                        //       subTitle: 'حاول مرة اخرى');
                                        // }
                                      }
                                    },
                                    isLoading:  adv_getx. isAddingComment.value,
                                    color: commentController.text.isNotEmpty
                                        ? AppColors.main_color
                                        : AppColors.gray_color,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'send'.tr,
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ],
                          )
                        ],
                      )),


                  SizedBox(
                    height: 35.h,
                  ),
                  customElevatedButton(
                    onTap: () {
                      deleteBottomSheet();
                    },
                    color: AppColors.red,
                    child: Text(
                      'Advertisement delete'.tr,
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white),
                    ),
                  ),

                  SizedBox(
                    height: 50.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  deleteBottomSheet() {
    Get.bottomSheet(StatefulBuilder(builder:
        (BuildContext context, StateSetter setState /*You can rename this!*/) {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.background_color,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 15.h,
              ),
              Text(
                'delete reason'.tr,
                style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black_color),
              ),
              SizedBox(
                height: 15.h,
              ),
              RadioListTile(
                value: 'لا اريد نشر الاعلان',
                groupValue: groupValue,
                activeColor: AppColors.main_color,

                onChanged: (x) {
                  groupValue = x!;
                  setState(() {});
                },
                title: Text(
                  'I dont want to post an ad '.tr,
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkgray_color),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Divider(),
              RadioListTile(
                value: 'تم بيع السلعة',
                groupValue: groupValue,
                activeColor: AppColors.main_color,
                onChanged: (x) {
                  groupValue = x!;
                  setState(() {});
                },
                title: Text(
                  'Item has been sold out'.tr,
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkgray_color),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Divider(),
              RadioListTile(
                value: 'اخرى',
                activeColor: AppColors.main_color,

                groupValue: groupValue,
                onChanged: (x) {
                  groupValue = x!;
                  setState(() {});
                },
                title: Text(
                  'others'.tr,
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkgray_color),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Divider(),
              SizedBox(
                height: 15.h,
              ),
              customElevatedButton(
                onTap: ()async {
                  bool isSaved =   await _advertisements_getxController.delete_Advertisement(ID: widget.adv_model!.data.id.toString());
                 if(isSaved){
                   Get.back();
                   Get.back();


          }else{

          Helper() .show_Dialog(context: context,title: 'لا يتوفر اتصال بالانترنت',img: AppImages.no_internet,subTitle: 'حاول مرة اخرى');

          }


                },
                color: AppColors.main_color,
                child: Text(
                  'send'.tr,
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white),
                ),
              ),  SizedBox(
                height: 15.h,
              ),
            ],
          ),
        ),
      );
    }));
  }
}

class detailsWidget extends StatelessWidget {
  late String img;
  late String title;
  late String data;
  late Color textColor;
  late bool isDivider;
  late bool isPng;

  detailsWidget({
    required this.img,
    required this.title,
    required this.data,
    this.textColor = AppColors.black_color,
    this.isDivider = true,
    this.isPng = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            isPng
                ? Image.asset(img)
                : SvgPicture.asset(
                    img,
                  ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              title,
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: textColor),
            ),
            Spacer(),
            Text(
              data,
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: textColor),
            ),
            SizedBox(
              width: 15.w,
            ),
          ],
        ),
        SizedBox(
          height: 11.h,
        ),
        if (isDivider) Divider(),
      ],
    );
  }
}
