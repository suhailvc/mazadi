import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mazzad/Database/SharedPreferences/shared_preferences.dart';
import 'package:mazzad/Models/singleAucations_Model.dart';
import 'package:mazzad/Screens/BN_Screens/advertise/singleComment_Screen.dart';
import 'package:mazzad/Screens/BN_Screens/advertise/singleUser_Screen.dart';
import 'package:mazzad/Utils/Helper.dart';
import 'package:mazzad/Utils/asset_images.dart';
import 'package:mazzad/firebase/firebase_dynamic_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

import '../../../Controllers/GetxController/AdvertisementsController.dart';
import '../../../Controllers/GetxController/homeController.dart';
import '../../../Controllers/GetxController/profileController.dart';
import '../../../Models/singleAdvertisement_Model.dart';
import '../../../Utils/AppColors.dart';
import '../../../Utils/customElevatedButton.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import '../Aucations/singleAttachment_Screen.dart';

class singleAdvertisement_Screen extends StatefulWidget {
  late singleAdvertisement_Model? adv_model;

  singleAdvertisement_Screen({required this.adv_model});

  @override
  State<singleAdvertisement_Screen> createState() =>
      _singleAdvertisement_ScreenState();
}

class _singleAdvertisement_ScreenState
    extends State<singleAdvertisement_Screen> {
  var _advertisements_getxController =
      Get.find<Advertisements_GetxController>();
  var _auth_getxController = Get.find<profile_GetxController>();
  var _home_getxController = Get.find<home_GetxController>();

  TextEditingController commentController = TextEditingController();



  int myBid = 0;

  bool checkBoxValue = false;
  bool hasBalance = true;
  List images = [];
  List advertisement_wishlists = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.adv_model!.data.images!.length; i++) {
      images.add(widget.adv_model!.data.images![i].photo);
    }
    setState(() {});
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
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: () async {
                  String shortUrl = await DynamicLinksService.createDynamicLink(
                    type: 'Advertisment',
                    parameter: widget.adv_model!.data.id.toString(),
                  );

                  Share.share(shortUrl);
                },
                child: Text(
                  'share'.tr,
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 12.sp,
                      overflow: TextOverflow.clip,
                      fontWeight: FontWeight.w500,
                      color: AppColors.gray_color),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              SvgPicture.asset(AppImages.share, width: 20.w),
              SizedBox(
                width: 10.w,
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageSlideshow(
              width: width,
              height: 335.h,
              isLoop: true,
              children: images
                  .map((e) => GestureDetector(
                        onTap: () {
                          Get.to(() => singleAttachment_Screen(
                                attachment: e,
                                attachmentVideo: '',
                                attachmentType: 'image',
                              ));
                        },
                        child: CachedNetworkImage(
                          imageUrl: e,
                          // fit: BoxFit.fill,

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
                        width: 220.w,
                        child: Text(
                          SharedPreferencesController().languageCode == 'en'
                              ? widget.adv_model!.data!.title.toString()
                              : widget.adv_model!.data!.titleAr.toString(),
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black_color),
                        ),
                      ),
                      Spacer(),
                      widget.adv_model!.data.wishlist == 1
                          ? SizedBox(
                              width: 120.w,
                              child: ElevatedButton(
                                onPressed: () async {
                                  widget.adv_model!.data.wishlist == 1
                                      ? widget.adv_model!.data.wishlist = 0
                                      : widget.adv_model!.data.wishlist = 1;

                                  setState(() {});
                                  bool status = await _auth_getxController
                                      .ChangeAdvertisement_wishlistsStatus(
                                          ID: widget.adv_model!.data.id
                                              .toString());
                                  widget.adv_model =
                                      await _advertisements_getxController
                                          .getAdvertisementByID(
                                              context: context,
                                              ID: widget.adv_model!.data.id
                                                  .toString());
                                  if (!status) {
                                    widget.adv_model!.data.wishlist == 1
                                        ? widget.adv_model!.data.wishlist = 0
                                        : widget.adv_model!.data.wishlist = 1;
                                  }

                                  // await  _auth_getxController.ChangeAdvertisement_wishlistsStatus(ID: widget.adv_model!.data.id.toString());
                                  setState(() {});
                                },
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(AppImages.love,
                                          color: AppColors.white),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        '',
                                        style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.blue_color),
                                      ),
                                    ]),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(color: AppColors.red)),
                                  backgroundColor: AppColors.red,
                                  elevation: 0,
                                  minimumSize: Size(107, 31),
                                ),
                              ),
                            )
                          : SizedBox(
                              width: 120.w,
                              child: ElevatedButton(
                                onPressed: () async {
                                  widget.adv_model!.data.wishlist == 1
                                      ? widget.adv_model!.data.wishlist = 0
                                      : widget.adv_model!.data.wishlist = 1;

                                  setState(() {});
                                  bool status = await _auth_getxController
                                      .ChangeAdvertisement_wishlistsStatus(
                                          ID: widget.adv_model!.data.id
                                              .toString());
                                  widget.adv_model =
                                      await _advertisements_getxController
                                          .getAdvertisementByID(
                                              context: context,
                                              ID: widget.adv_model!.data.id
                                                  .toString());
                                  if (!status) {
                                    widget.adv_model!.data.wishlist == 1
                                        ? widget.adv_model!.data.wishlist = 0
                                        : widget.adv_model!.data.wishlist = 1;
                                  }
                                  setState(() {});
                                },
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(AppImages.love),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        'addFavourite'.tr,
                                        style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.blue_color),
                                      ),
                                    ]),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                          color: AppColors.blue_color)),
                                  backgroundColor: AppColors.background_color,
                                  elevation: 0,
                                  minimumSize: Size(107, 31),
                                ),
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.w, vertical: 10.h),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 11.h,
                        ),
                        detailsWidget(
                          img: AppImages.clock,
                          title: 'publish date'.tr,
                          data: DateFormat.yMMMd().format(DateTime.parse(
                            widget.adv_model!.data.createdAt.toString(),
                          )),
                          // data: timeRemain(),
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
                          data: '${widget.adv_model!.data!.price.toString()}' +
                              ' ' +
                              'Qar'.tr,
                          isDivider: false,
                          isPng: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      _advertisements_getxController.getUserAdvertisment(
                          widget.adv_model!.data!.user!.userId);
                      Get.to(() => singleUser_Screen(
                            user: widget.adv_model!.data!.user!,
                          ));
                    },
                    child: Container(
                        width: width,
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              clipBehavior: Clip.antiAlias,
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                width: 70.w,
                                height: 70.h,
                                imageUrl: widget.adv_model!.data!.user!.photo
                                    .toString(),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(

                                  widget.adv_model!.data.user!.name.toString(),
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.black_color),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'phone Number'.tr,
                                      style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black_color),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(
                                      widget.adv_model!.data.user!.mobile
                                          .toString(),
                                      style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black_color),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                      width: width,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(5)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: SharedPreferencesController().languageCode ==
                                    'ar'
                                ? 90.w
                                : 105.w,
                            height: 35.h,
                            child: customElevatedButton(
                              onTap: () async {
                                String shortUrl = await DynamicLinksService.createDynamicLink(
                                  type: 'Advertisment',
                                  parameter: widget.adv_model!.data.id.toString(),
                                );

                                // Share.share(shortUrl);
                               Helper(). send_Whatsapp(
                                    phoneNum: widget
                                        .adv_model!.data.user!.whatsapp
                                        .toString(),
                                    massege: shortUrl);
                              },
                              color: AppColors.whatsabColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppImages.whatsab),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    'whatsapp'.tr,
                                    style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 120.w,
                            height: 35.h,
                            child: customElevatedButton(
                              onTap: () async {
                                final Uri launchUri = Uri(
                                  scheme: 'tel',
                                  path: widget.adv_model!.data.user!.mobile
                                      .toString(),
                                );
                                await launchUrl(launchUri);
                              },
                              color: AppColors.phoneCallColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppImages.call),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    'phone Call'.tr,
                                    style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 35.h,
                            width: SharedPreferencesController().languageCode ==
                                    'ar'
                                ? 120.w
                                : 100.w,
                            child: customElevatedButton(
                              onTap: () async {
                                final Uri launchUri = Uri(
                                  scheme: 'sms',
                                  path: widget.adv_model!.data.user!.mobile
                                      .toString(),
                                );
                                await launchUrl(launchUri);
                              },
                              color: AppColors.smsColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppImages.sms2),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    'sms'.tr,
                                    style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
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
                            SharedPreferencesController().languageCode == 'en'
                                ? widget.adv_model!.data!.title.toString()
                                : widget.adv_model!.data!.titleAr.toString(),
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black_color),
                          ),
                          Text(
                            SharedPreferencesController().languageCode == 'en'
                                ? widget.adv_model!.data!.description.toString()
                                : widget.adv_model!.data!.descriptionAr
                                    .toString(),
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.darkgray_color),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 15.h,
                  ),
                  if (widget.adv_model!.data.features!.length > 0)
                    GridView.builder(
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
                                  widget.adv_model!.data.features![index].key
                                      .toString(),
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
                                  widget.adv_model!.data.features![index].value
                                      .toString(),
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
                  if (widget.adv_model!.data.features!.length > 0)
                    SizedBox(
                      height: 20.h,
                    ),
                  if( _advertisements_getxController.comments_model!=null)          Row(
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
                if( _advertisements_getxController.comments_model!=null)  GetBuilder(
                      builder: (Advertisements_GetxController controller) {
                    return controller.isLoadingComments.isFalse
                        ? SizedBox(
                            child: ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemCount:
                                    controller.comments_model!.data.length,
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 14.h,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    onTap: () async {
                                      await Get.to(singleComment_Screen(
                                        commentData: controller
                                            .comments_model!.data[index],
                                      ));
                                      setState(() {});
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
                                        imageUrl: controller.comments_model!
                                            .data[index].user!.photo
                                            .toString(),
                                      ),
                                    ),
                                    title: Row(
                                      children: [
                                        Text(
                                          controller.comments_model!.data[index]
                                              .user!.name
                                              .toString(),
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.black_color),
                                        ),
                                        Spacer(),
                                        Text(
                                          controller
                                              .comments_model!.data[index].time,
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
                          )
                        : Center(child: CircularProgressIndicator());
                  }),

                  /*
                  SizedBox(
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: widget.adv_model!.data.comments!.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 14.h,
                          );
                        },
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Container(
                              clipBehavior: Clip.antiAlias,
                              height: 60.h,
                              width: 60.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: widget
                                    .adv_model!.data.comments[index].user!.photo
                                    .toString(),
                           ),
                            ),
                            title: Row(
                              children: [
                                Text(
                                  widget
                                      .adv_model!.data!.comments![index].user!.name
                                      .toString(),
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black_color),
                                ),
                                Spacer(),
                                Text(
                                  commentTime(widget
                                      .adv_model!.data!.comments![index].createdAt
                                      .toString()),
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.darkgray_color),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              widget.adv_model!.data.comments[index].comment
                                  .toString(),
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.darkgray_color),
                            ),
                          );
                        }),
                  ),


                   */

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
                            maxLines: 3,
                            onChanged: (x) {
                              setState(() {});
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
                              GetX(builder:
                                  (Advertisements_GetxController adv_getx) {
                                return SizedBox(
                                  height: 35.h,
                                  width: 70.w,
                                  child: customElevatedButton(
                                    onTap: () async {
                                      if (commentController.text.isNotEmpty) {
                                        bool commentSaved =
                                            await _advertisements_getxController
                                                .addAdvertisementComment(
                                                    context,
                                                    Advertisement_ID: widget
                                                        .adv_model!.data.id
                                                        .toString(),
                                                    comment:
                                                        commentController.text);
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
                                    isLoading: adv_getx.isAddingComment.value,
                                    color: commentController.text.isNotEmpty
                                        ? AppColors.main_color
                                        : AppColors.gray_color,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
        height: 315.h,
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
                'سبب الحذف',
                style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black_color),
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Text(
                    'لا اريد نشر الاعلان',
                    style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkgray_color),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Divider(),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Text(
                    'تم بيع السلعة',
                    style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkgray_color),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Divider(),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Text(
                    'اخرى',
                    style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkgray_color),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Divider(),
              SizedBox(
                height: 15.h,
              ),
              customElevatedButton(
                onTap: () {},
                color: AppColors.main_color,
                child: Text(
                  'ارسال',
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white),
                ),
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
            SizedBox(
              width: 10.w,
            ),
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
