import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mazzad/Models/singleAucations_Model.dart';
import 'package:mazzad/Screens/BN_Screens/Aucations/mySingleAucation_Screen.dart';
import 'package:mazzad/Screens/BN_Screens/Aucations/singleAttachment_Screen.dart';
import 'package:mazzad/Screens/BN_Screens/Aucations/singleAucation_Screen2.dart';
import 'package:mazzad/Screens/BN_Screens/Aucations/viewAllBids_Screen.dart';
import 'package:mazzad/Screens/BN_Screens/Aucations/viewAllRelatedAucation_Screen.dart';
import 'package:mazzad/Utils/Helper.dart';
import 'package:mazzad/Utils/asset_images.dart';
import 'package:mazzad/firebase/firebase_dynamic_links.dart';
import 'package:share_plus/share_plus.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as UI;

import '../../../Controllers/GetxController/AucationsController.dart';
import '../../../Controllers/GetxController/profileController.dart';
import '../../../Controllers/GetxController/homeController.dart';
import '../../../Database/SharedPreferences/shared_preferences.dart';
import '../../../Utils/AppColors.dart';
import '../../../Utils/customElevatedButton.dart';
import '../../../firebase/fb_firestore_controller.dart';
import '../drawer/addWalletAmount_Screen.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../drawer/terms_Screen.dart';

class singleAucation_Screen extends StatefulWidget {
  late singleAucations_Model? aucations_model;
  late bool isFrom_Winnings_Page ;

  singleAucation_Screen({required this.aucations_model,this.isFrom_Winnings_Page=false,});

  @override
  State<singleAucation_Screen> createState() => _singleAucation_ScreenState();
}

class _singleAucation_ScreenState extends State<singleAucation_Screen> {
  timeRemain() {
    DateTime now = DateTime.now();
    DateTime dt1 =
        DateTime.parse(widget.aucations_model!.data!.auctionTo.toString());
    Duration diff = dt1.difference(now);
    return diff;
  }

  var _auth_getxController = Get.find<profile_GetxController>();
  var _home_getxController = Get.find<home_GetxController>();
  var _aucation_getxController = Get.find<Aucations_GetxController>();
  var _profile_getxController = Get.find<profile_GetxController>();

  Duration diff = Duration();
  DateTime now = DateTime.now();

  UI.TextDirection direction = UI.TextDirection.ltr;

  Duration timefromstart(String time) {
    DateTime dt1 = DateTime.parse(time);
    diff = dt1.difference(now);
    // diff = now.difference(dt1);
    return diff;
  }

  num myBid = 0;

  // List Data = [];
  bool checkBoxValue = false;
  bool hasBalance = true;
  List aucation_wishlists = [];

  double appTax = 0;

  refresh() {
    setState(() {});
  }

  late Timer mytimer;

  String timefromstart2(String time) {
    DateTime now = DateTime.now();
    DateTime dt1 = DateTime.parse(time);
    Duration diff = now.difference(dt1);

    if (diff.inDays > 0) {
      return 'since'.tr + diff.inDays.toString() + 'day'.tr;
    } else if (diff.inHours > 0) {
      return 'since'.tr + diff.inHours.toString() + 'hour'.tr;
    } else {
      return 'since'.tr + diff.inMinutes.toString() + 'minute'.tr;
    }
  }

  List images = [];

  bool isPhotoBig = false;
  bool isAucationTimeEnd = false;
  late Stream<DocumentSnapshot> _myStream;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.aucations_model!.data.images!.length; i++) {
      images.add(widget.aucations_model!.data.images![i].photo);
    }
    if (widget.aucations_model!.data.vedio != null &&
        widget.aucations_model!.data.vedio_thumb != null) {
      images.add(widget.aucations_model!.data.vedio_thumb);
    }
    myBid = num.parse(widget.aucations_model!.data.lastBid.toString());

    _myStream = FbFireStoreController()
        .getAucationLastBid(aucationID: widget.aucations_model!.data.id!);

    _myStream.listen((snapshot) {
      if (snapshot.exists) {
        widget.aucations_model!.data.lastBid = snapshot['lastPrice'];
        myBid = num.parse(widget.aucations_model!.data.lastBid!.toString());

        setState(() {});
      }
    });
    appTax = (double.parse(widget.aucations_model!.data.price!) *
        (double.parse(_home_getxController.setting_model!.data.auctionRatio)));
    if (appTax >=
        double.parse(
            _home_getxController.setting_model!.data.auctionRatioMax)) {
      appTax = double.parse(
          _home_getxController.setting_model!.data.auctionRatioMax);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      onRefresh: ()async{
        singleAucations_Model? singleAucation =
        await _home_getxController
            .getAucationByID(
            context:  context,

            ID: widget.aucations_model!.data.id.toString());
        if(singleAucation!=null){
          widget.aucations_model=singleAucation;
          setState(() {

          });
        }

      },
      child: Scaffold(
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
            'Auction Details'.tr,
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
                      type: 'Aucation',
                      parameter: widget.aucations_model!.data.id.toString(),
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
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageSlideshow(
                    width: width,
                    height: 335.h,
                    isLoop: true,
                    children: images
                        .map(
                          (e) => Stack(
                            alignment: Alignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => singleAttachment_Screen(
                                        attachment: e,
                                        attachmentVideo:
                                            widget.aucations_model!.data.vedio ??
                                                '',
                                        attachmentType: e ==
                                                widget.aucations_model!.data
                                                    .vedio_thumb
                                            ? 'video'
                                            : 'image',
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
                              ),
                              if (e == widget.aucations_model!.data.vedio_thumb)
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => singleAttachment_Screen(
                                          attachment: e,
                                          attachmentVideo: widget
                                                  .aucations_model!.data.vedio ??
                                              '',
                                          attachmentType: e ==
                                                  widget.aucations_model!.data
                                                      .vedio_thumb
                                              ? 'video'
                                              : 'image',
                                        ));
                                  },
                                  child: Icon(
                                    Icons.videocam_outlined,
                                    size: 70,
                                    color: AppColors.white,
                                  ),
                                )
                            ],
                          ),
                        )
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
                                    ? widget.aucations_model!.data!.title
                                        .toString()
                                    : widget.aucations_model!.data!.titleAr
                                        .toString(),
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black_color),
                              ),
                            ),
                            Spacer(),
                            widget.aucations_model!.data!.wishlist == 1
                                ? SizedBox(
                                    width: 115.w,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        widget.aucations_model!.data!.wishlist ==
                                                1
                                            ? widget.aucations_model!.data!
                                                .wishlist = 0
                                            : widget.aucations_model!.data!
                                                .wishlist = 1;
                                        setState(() {});
                                        bool status = await _auth_getxController
                                            .ChangeAuction_wishlistsStatus(
                                                ID: widget
                                                    .aucations_model!.data.id
                                                    .toString());
                                        if (!status) {
                                          widget.aucations_model!.data!
                                                      .wishlist ==
                                                  1
                                              ? widget.aucations_model!.data!
                                                  .wishlist = 0
                                              : widget.aucations_model!.data!
                                                  .wishlist = 1;
                                        }
                                        setState(() {});
                                      },
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side:
                                                BorderSide(color: AppColors.red)),
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
                                        widget.aucations_model!.data!.wishlist ==
                                                1
                                            ? widget.aucations_model!.data!
                                                .wishlist = 0
                                            : widget.aucations_model!.data!
                                                .wishlist = 1;
                                        setState(() {});
                                        bool status = await _auth_getxController
                                            .ChangeAuction_wishlistsStatus(
                                                ID: widget
                                                    .aucations_model!.data.id
                                                    .toString());
                                        if (!status) {
                                          widget.aucations_model!.data!
                                                      .wishlist ==
                                                  1
                                              ? widget.aucations_model!.data!
                                                  .wishlist = 0
                                              : widget.aucations_model!.data!
                                                  .wishlist = 1;
                                        }
                                        setState(() {});
                                      },
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: BorderSide(
                                                color: AppColors.blue_color)),
                                        backgroundColor:
                                            AppColors.background_color,
                                        elevation: 0,
                                        minimumSize: Size(107, 31),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(
                          width: 250.w,
                          child: Text(
                            SharedPreferencesController().languageCode == 'en'
                                ? widget.aucations_model!.data.category!.name
                                    .toString()
                                : widget.aucations_model!.data.category!.name_ar
                                    .toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black_color),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),


                    if(widget.isFrom_Winnings_Page)    GetBuilder<Aucations_GetxController>(builder: (Auction_getx){
                          return  Container(
                              width: width,
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {},
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
                                                imageUrl: '',
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  widget.aucations_model!.data.user!.name!,
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
                                                      widget.aucations_model!.data.user!.mobile!,
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
                                  Row(
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
                                              type: 'Auction',
                                              parameter:widget.aucations_model!.data.id.toString(),
                                            );

                                            Helper(). send_Whatsapp(
                                                phoneNum: widget.aucations_model!.data.user!.whatsapp!,
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
                                              path: widget.aucations_model!.data.user!.mobile!,
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
                                              path: widget.aucations_model!.data.user!.mobile!,
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
                                  ),
                                ],
                              ));

                        })
                       ,




                        SizedBox(
                          height: 15.h,
                        ),
                        Container(
                          width: width,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 11.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppImages.clock,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          'time remaining'.tr,
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.black_color),
                                        ),
                                        Spacer(),
                                        Directionality(
                                          textDirection: direction,
                                          // notice lower case

                                          child: SlideCountdown(
                                            onDone: () {
                                              isAucationTimeEnd = true;
                                              print('DONE');
                                              setState(() {});
                                            },
                                            duration: timefromstart(widget
                                                .aucations_model!.data.auctionTo
                                                .toString()),
                                            slideDirection: SlideDirection.up,
                                            separator: '-',
                                            showZeroValue: true,
                                            decoration: BoxDecoration(
                                              color: AppColors.white,
                                            ),
                                            textStyle: TextStyle(
                                                fontFamily: 'Cairo',
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.red),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 11.h,
                                    ),
                                    Divider(),
                                  ],
                                ),
                              ),
                              detailsWidget(
                                img: AppImages.redJudge,
                                title: 'bids count'.tr,
                                data:
                                    '${widget.aucations_model!.data!.bidsCount.toString()}' +
                                        'Bids'.tr,
                              ),
                              detailsWidget(
                                img: AppImages.minAucation,
                                title: 'Minimum Bid'.tr,
                                data:
                                    '${widget.aucations_model!.data!.minBid.toString()}' +
                                        ' ' +
                                        'Qar'.tr,
                              ),
                              StreamBuilder<DocumentSnapshot>(
                                  stream: _myStream,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                                    if (snapshot!.hasData) {
                                      var data = snapshot.data!;
                                      return detailsWidget(
                                        img: AppImages.realamount,
                                        title: 'Aucation open price'.tr,
                                        data:
                                            '${data.exists ? data['lastPrice'] : widget.aucations_model!.data!.lastBid}' +
                                                ' ' +
                                                'Qar'.tr,
                                        textColor: AppColors.greenColor,
                                        isDivider: false,
                                      );
                                    } else {
                                      return detailsWidget(
                                        img: AppImages.realamount,
                                        title: 'Aucation open price'.tr,
                                        data:
                                            '${widget.aucations_model!.data!.lastBid}' +
                                                ' ' +
                                                'Qar'.tr,
                                        textColor: AppColors.greenColor,
                                        isDivider: false,
                                      );
                                    }
                                  }),
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
                              horizontal: 5.w, vertical: 10.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                SharedPreferencesController().languageCode == 'en'
                                    ? widget.aucations_model!.data!.title
                                        .toString()
                                    : widget.aucations_model!.data!.titleAr
                                        .toString(),
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black_color),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                SharedPreferencesController().languageCode == 'en'
                                    ? widget.aucations_model!.data!.description
                                        .toString()
                                    : widget.aucations_model!.data!.descriptionAr
                                        .toString(),
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.black_color),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        customElevatedButton(
                          onTap: () {
                            Get.bottomSheet(
                                isScrollControlled: true, enableDrag: true,
                                StatefulBuilder(builder: (BuildContext context,
                                    StateSetter
                                        setState /*You can rename this!*/) {
                              return Container(
                                width: width,
                                decoration: BoxDecoration(
                                  color: AppColors.background_color,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      topLeft: Radius.circular(15)),
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
                                        'Bid now'.tr,
                                        style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.black_color),
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      Container(
                                        width: width,
                                        color: AppColors.white,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 11.h,
                                            ),
                                            StreamBuilder<DocumentSnapshot>(
                                                stream: _myStream,
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<
                                                            DocumentSnapshot>
                                                        snapshot) {
                                                  if (snapshot!.hasData) {
                                                    var data = snapshot.data!;
                                                    return detailsWidget(
                                                      img: AppImages.realamount,
                                                      title: 'Aucation open price'
                                                          .tr,
                                                      data:
                                                          '${data.exists ? data['lastPrice'] : widget.aucations_model!.data!.lastBid}' +
                                                              ' ' +
                                                              'Qar'.tr,
                                                      textColor:
                                                          AppColors.greenColor,
                                                      isDivider: false,
                                                    );
                                                  } else {
                                                    return detailsWidget(
                                                      img: AppImages.realamount,
                                                      title: 'Aucation open price'
                                                          .tr,
                                                      data:
                                                          '${widget.aucations_model!.data!.lastBid}' +
                                                              ' ' +
                                                              'Qar'.tr,
                                                      textColor:
                                                          AppColors.greenColor,
                                                      isDivider: false,
                                                    );
                                                  }
                                                }),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.w),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        AppImages.clock,
                                                      ),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      Text(
                                                        'time remaining'.tr,
                                                        style: TextStyle(
                                                            fontFamily: 'Cairo',
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppColors
                                                                .black_color),
                                                      ),
                                                      Spacer(),
                                                      Directionality(
                                                        textDirection: direction,
                                                        // notice lower case

                                                        child: SlideCountdown(
                                                          onDone: () {
                                                            isAucationTimeEnd =
                                                                true;
                                                            setState(() {});
                                                          },
                                                          duration: timefromstart(
                                                              widget
                                                                  .aucations_model!
                                                                  .data
                                                                  .auctionTo
                                                                  .toString()),
                                                          slideDirection:
                                                              SlideDirection.up,
                                                          separator: '-',
                                                          showZeroValue: true,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                AppColors.white,
                                                          ),
                                                          textStyle: TextStyle(
                                                              fontFamily: 'Cairo',
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                              color:
                                                                  AppColors.red),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 11.h,
                                                  ),
                                                  Divider(),
                                                ],
                                              ),
                                            ),
                                            detailsWidget(
                                              img: AppImages.minAucation,
                                              title: 'Minimum Bid'.tr,
                                              data:
                                                  '${widget.aucations_model!.data!.minBid.toString()}' +
                                                      ' ' +
                                                      'Qar'.tr,
                                              isDivider: false,
                                            ),
                                            SizedBox(
                                              height: 11.h,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12.w),
                                              child: Container(
                                                width: width,
                                                height: 45.h,
                                                decoration: BoxDecoration(
                                                    color: AppColors
                                                        .lightgray_color
                                                        .withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w),
                                                child: Visibility(
                                                  visible: myBid ==
                                                      num.parse(widget
                                                          .aucations_model!
                                                          .data
                                                          .lastBid
                                                          .toString()),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Last Bid'.tr,
                                                        style: TextStyle(
                                                            fontFamily: 'Cairo',
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppColors
                                                                .lightgray_color),
                                                      ),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      Text(
                                                        widget.aucations_model!
                                                                .data.lastBid
                                                                .toString() +
                                                            ' ' +
                                                            'Qar'.tr,
                                                        style: TextStyle(
                                                            fontFamily: 'Cairo',
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppColors
                                                                .lightgray_color),
                                                      ),
                                                      Spacer(),
                                                      GestureDetector(
                                                          onTap: () {
                                                            print('add');
                                                            myBid = myBid +
                                                                num.parse(widget
                                                                    .aucations_model!
                                                                    .data
                                                                    .minBid
                                                                    .toString());
                                                            setState(() {});
                                                          },
                                                          child: SvgPicture.asset(
                                                              AppImages.add)),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {
                                                            if (myBid !=
                                                                num.parse(widget
                                                                    .aucations_model!
                                                                    .data
                                                                    .lastBid
                                                                    .toString())) {
                                                              myBid = myBid -
                                                                  num.parse(widget
                                                                      .aucations_model!
                                                                      .data
                                                                      .minBid
                                                                      .toString());
                                                              setState(() {});
                                                            }
                                                          },
                                                          child: SvgPicture.asset(
                                                              AppImages.minus)),
                                                    ],
                                                  ),
                                                  replacement: Row(
                                                    children: [
                                                      Text(
                                                        'your Bid'.tr,
                                                        style: TextStyle(
                                                            fontFamily: 'Cairo',
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppColors
                                                                .lightgray_color),
                                                      ),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      Text(
                                                        myBid.toString() +
                                                            ' ' +
                                                            'Qar'.tr,
                                                        style: TextStyle(
                                                            fontFamily: 'Cairo',
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppColors
                                                                .black_color),
                                                      ),
                                                      Spacer(),
                                                      GestureDetector(
                                                          onTap: () {
                                                            myBid = myBid +
                                                                num.parse(widget
                                                                    .aucations_model!
                                                                    .data
                                                                    .minBid
                                                                    .toString());

                                                            setState(() {});
                                                          },
                                                          child: SvgPicture.asset(
                                                              AppImages.add)),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {
                                                            if (myBid >
                                                                num.parse(widget
                                                                    .aucations_model!
                                                                    .data
                                                                    .lastBid
                                                                    .toString())) {
                                                              myBid = myBid -
                                                                  num.parse(widget
                                                                      .aucations_model!
                                                                      .data
                                                                      .minBid
                                                                      .toString());
                                                              appTax = (double
                                                                      .parse(widget
                                                                          .aucations_model!
                                                                          .data
                                                                          .price!) *
                                                                  (double.parse(
                                                                      _home_getxController
                                                                          .setting_model!
                                                                          .data
                                                                          .auctionRatio)));
                                                              if (appTax >=
                                                                  double.parse(
                                                                      _home_getxController
                                                                          .setting_model!
                                                                          .data
                                                                          .auctionRatioMax)) {
                                                                appTax = double.parse(
                                                                    _home_getxController
                                                                        .setting_model!
                                                                        .data
                                                                        .auctionRatioMax);
                                                              }
                                                              setState(() {});
                                                            }
                                                          },
                                                          child: SvgPicture.asset(
                                                              AppImages.minus)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 11.h,
                                            ),
                                            Visibility(
                                              visible: hasBalance,
                                              replacement: noBalanceWidget(
                                                width: width,
                                                title: 'nobalance'.tr,
                                                subTitle: 'can Add balance'.tr,
                                                subTitle2:
                                                    'You need credit worth'.tr,
                                                amount: (double.parse(appTax
                                                            .toStringAsFixed(1)) -
                                                        (num.parse(
                                                            _profile_getxController
                                                                .wallet_model!
                                                                .data
                                                                .free
                                                                .toString())))
                                                    .roundToDouble()
                                                    .toString(),
                                                buttonText: 'charge Balance'.tr,
                                                onTap: () {
                                                  hasBalance = true;
                                                  checkBoxValue = true;
                                                  Get.to(
                                                      addWalletAmount_Screen());
                                                  setState(() {});
                                                },
                                                cancelTap: () {
                                                  hasBalance = true;
                                                  checkBoxValue = true;
                                                  setState(() {});
                                                },
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (myBid !=
                                                      widget.aucations_model!.data
                                                          .lastBid)
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 15),
                                                      child: Text(
                                                        'سيتم حجز مبلغ تأمين يساوي ${double.parse(appTax.toStringAsFixed(1))}' +
                                                            ' ' +
                                                            'Qar'.tr +
                                                            ' عند أول مزايدة تقوم بها  ( انظر الشروط والأحكام )',
                                                        style: TextStyle(
                                                            fontFamily: 'Cairo',
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: AppColors
                                                                .lightgray_color),
                                                      ),
                                                    ),
                                                  SizedBox(
                                                    height: 11.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Checkbox(
                                                        value: checkBoxValue,
                                                        onChanged: (value) {
                                                          checkBoxValue = value!;
                                                          setState(() {});
                                                        },
                                                        activeColor:
                                                            AppColors.main_color,
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Get.to(terms_Screen());
                                                        },
                                                        child: Text(
                                                          'confirm terms'.tr,
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                              fontFamily: 'Cairo',
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color: AppColors
                                                                  .black_color),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 11.h,
                                            ),
                                            GetX(builder:
                                                (Aucations_GetxController
                                                    Aucation_getx) {
                                              return customElevatedButton(
                                                isLoading: Aucation_getx
                                                    .isAddingBID.value,
                                                onTap: () async {
                                                  if (diff.inMinutes > 0) {
                                                    if (checkBoxValue) {
                                                      if (appTax <=
                                                          double.parse(
                                                              _profile_getxController
                                                                  .wallet_model!
                                                                  .data
                                                                  .free
                                                                  .toString())) {
                                                        if (await Helper()
                                                            .checkInternet()) {
                                                          singleAucations_Model
                                                              newAuction =
                                                              await _aucation_getxController.add_AucationBid(
                                                                  context,
                                                                  amount: myBid.toString(),
                                                                  AucationID: widget.aucations_model!.data.id.toString());
                                                          widget.aucations_model!.data = newAuction.data;

                                                          if (newAuction.status!) {

                                                            _profile_getxController.get_MyBalance();
                                                            refresh();

                                                            Get.back();

                                                            succesBottomSheet();
                                                          }
                                                        } else {
                                                          Helper().show_Dialog(
                                                              context: context,
                                                              title: 'No Internet'
                                                                  .tr,
                                                              img: AppImages
                                                                  .no_internet,
                                                              subTitle:
                                                                  'Try Again'.tr);
                                                        }
                                                      } else {
                                                        hasBalance = false;
                                                        checkBoxValue = false;
                                                        setState(() {});
                                                      }
                                                    }
                                                  } else {
                                                    Helper().show_Dialog(
                                                        context: context,
                                                        title:
                                                            'للأسف,انتهى وقت المزاد',
                                                        img: AppImages.error,
                                                        subTitle: '');
                                                  }
                                                },
                                                color: checkBoxValue
                                                    ? AppColors.main_color
                                                    : AppColors.gray_color,
                                                child: Text(
                                                  'add Bid'.tr,
                                                  style: TextStyle(
                                                      fontFamily: 'Cairo',
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.bold,
                                                      color: AppColors.white),
                                                ),
                                              );
                                            }),
                                            SizedBox(
                                              height: 15.h,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }));
                          },
                          color: AppColors.main_color,
                          child: Text(
                            'Bid now'.tr,
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        if (widget.aucations_model!.data.features!.length > 0)
                          GridView.builder(
                              shrinkWrap: true,
                              // scrollDirection: Axis.horizontal,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount:
                                  widget.aucations_model!.data.features!.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
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
                                        widget.aucations_model!.data
                                            .features![index].key
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
                                        widget.aucations_model!.data
                                            .features![index].value
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
                        if (widget.aucations_model!.data.features!.length > 0)
                          SizedBox(
                            height: 20.h,
                          ),

                        /*
                        GridView.builder(
                            shrinkWrap: true,
                            // scrollDirection: Axis.horizontal,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: titles.length,
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
                                      titles[index],
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
                                      Data[index],
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


                         */

                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            Text(
                              'Last Bids'.tr,
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
                              '(${widget.aucations_model!.data!.bidders!.length.toString()})',
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black_color),
                            ),
                            Spacer(),
                            TextButton(
                                onPressed: () {
                                  Get.to(viewAllBids_Screen(
                                    aucations_model: widget.aucations_model,
                                  ));
                                },
                                child: Text(
                                  'View All'.tr,
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.lightgray_color),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        widget.aucations_model!.data!.bidders.isNotEmpty
                            ? Container(
                                width: width,
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: ListView.separated(
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemCount: widget
                                        .aucations_model!.data!.bidders.length >=4?4:widget
                                        .aucations_model!.data!.bidders.length,
                                    separatorBuilder: (context, index) {
                                      return Divider(
                                        endIndent: 15.w,
                                        indent: 15.w,
                                      );
                                    },
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Row(
                                          children: [
                                            Text(
                                              '${widget.aucations_model!.data!.bidders![index].user!.name.toString()}',
                                              style: TextStyle(
                                                  fontFamily: 'Cairo',
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      AppColors.lightgray_color),
                                            ),
                                            Spacer(),
                                            Text(
                                              widget.aucations_model!.data!
                                                  .bidders![index].time!,
                                              style: TextStyle(
                                                  fontFamily: 'Cairo',
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      AppColors.lightgray_color),
                                            ),
                                          ],
                                        ),
                                        subtitle: Text(
                                          '${widget.aucations_model!.data!.bidders![index].amount.toString()}' +
                                              ' ' +
                                              'Qar'.tr,
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.black_color),
                                        ),
                                      );
                                    }),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'No Bids'.tr,
                                    style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.gray_color),
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            Text(
                              'Related Auctions'.tr,
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black_color),
                            ),
                            Spacer(),
                            TextButton(
                                onPressed: () {
                                  Get.to(viewAllRelatedAucation_Screen(
                                    aucations_model: widget.aucations_model,
                                  ));
                                },
                                child: Text(
                                  'View All'.tr,
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.lightgray_color),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: widget
                                .aucations_model!.data!.similarAuctions.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio:
                                        Helper.childAspectRatio(1.35),
                                    crossAxisSpacing: 15.w,
                                    mainAxisSpacing: 15.h,
                                    crossAxisCount: 2),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  if (await Helper().checkInternet()) {
                                    singleAucations_Model? singleAucation =
                                        await _home_getxController
                                            .getAucationByID(
                                                context: context,
                                                ID: widget.aucations_model!.data!
                                                    .similarAuctions[index].id
                                                    .toString());
                                    if (singleAucation != null) {
                                      if (singleAucation.data.user!.userId ==
                                          _profile_getxController
                                              .profile_model!.data.userId) {
                                        Get.to(mySingleAucation_Screen(
                                            aucations_model: singleAucation));
                                        print('my');
                                      } else {
                                        await Get.to(singleAucation_Screen2(
                                            aucations_model: singleAucation));
                                        print('no');
                                      }
                                    } else {}
                                  } else {
                                    Helper().show_Dialog(
                                        context: context,
                                        title: 'No Internet'.tr,
                                        img: AppImages.no_internet,
                                        subTitle: 'Try Again'.tr);
                                  }
                                },
                                child: Container(
                                  height: 250.h,
                                  width: 162.w,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        width: 300.w,
                                        height: 157.h,
                                        imageUrl: widget.aucations_model!.data!
                                            .similarAuctions[index].photo
                                            .toString(),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5.w),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 150.w,
                                              // height: 50.h,
                                              child: Text(
                                                widget.aucations_model!.data!
                                                    .similarAuctions[index].title
                                                    .toString(),
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: 12.sp,
                                                    overflow: TextOverflow.clip,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.black_color),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 150.w,
                                              // height: 50.h,
                                              child: Text(
                                                widget
                                                    .aucations_model!
                                                    .data
                                                    .similarAuctions[index]
                                                    .descriptionAr
                                                    .toString(),
                                                style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: 11.sp,
                                                    overflow: TextOverflow.clip,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.gray_color),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            /*
                                            SizedBox(
                                              width: 150.w,
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(AppImages.love,color: AppColors.red),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Text(
                                                    widget
                                                        .aucations_model!
                                                        .data
                                                        .similarAuctions[index]
                                                        .wishlist
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontFamily: 'Cairo',
                                                        fontSize: 10.sp,
                                                        overflow: TextOverflow.clip,
                                                        fontWeight: FontWeight.w500,
                                                        color: AppColors.black_color),
                                                  ),
                                                  Spacer(),
                                                ],
                                              ),
                                            ),


                                             */
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            SizedBox(
                                              width: 150.w,
                                              child: Row(
                                                children: [
                                                  Image.asset(AppImages.price),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Text(
                                                    widget
                                                        .aucations_model!
                                                        .data!
                                                        .similarAuctions[index]
                                                        .price
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontFamily: 'Cairo',
                                                        fontSize: 14.sp,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            AppColors.main_color),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    'View'.tr,
                                                    style: TextStyle(
                                                        fontFamily: 'Cairo',
                                                        fontSize: 10.sp,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            AppColors.gray_color),
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  SvgPicture.asset(AppImages.view,
                                                      width: 20.w),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                        SizedBox(
                          height: 50.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),


            // GetX<home_GetxController>(builder: (home_GetxController controller) {
            //   return (controller.isLoadingData.isTrue)
            //       ? Center(
            //           child: Container(
            //             height: 60.h,
            //             width: 60.w,
            //             padding: EdgeInsets.all(10),
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(8),
            //                 color: AppColors.main_color),
            //             child: LoadingAnimationWidget.fourRotatingDots(
            //               color: AppColors.white,
            //               size: 40,
            //             ),
            //           ),
            //         )
            //       : Container();
            // }),

          ],
        ),
      ),
    );
  }

  succesBottomSheet() {
    Get.bottomSheet(StatefulBuilder(builder:
        (BuildContext context, StateSetter setState /*You can rename this!*/) {
      return Container(
        height: 750.h,
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
                'Confirm Auction'.tr,
                style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black_color),
              ),
              SizedBox(
                height: 15.h,
              ),
              Stack(
                children: [
                  Image.asset(AppImages.win),
                  Positioned(
                      bottom: 25.h,
                      right: 55.w,
                      child: Image.asset(AppImages.matte)),
                ],
              ),
              Text(
                'submitted successfully'.tr,
                style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black_color),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                'submitted successfully subTitle'.tr,
                style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.lightgray_color),
              ),
              SizedBox(
                height: 25.h,
              ),
              customElevatedButton(
                onTap: () {
                  Get.back();
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
              ),
            ],
          ),
        ),
      );
    }));
  }
}

class noBalanceWidget extends StatelessWidget {
  late double width;
  late String title;

  late String subTitle;

  late String subTitle2;

  late String amount;

  late String buttonText;

  late Function() onTap;
  late Function() cancelTap;

  noBalanceWidget({
    required this.width,
    required this.title,
    required this.subTitle,
    required this.subTitle2,
    required this.amount,
    required this.buttonText,
    required this.onTap,
    required this.cancelTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: width,
          height: 115.h,
          padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
          decoration: BoxDecoration(
              color: AppColors.red.withOpacity(0.25),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(AppImages.info),
              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black_color),
                  ),
                  Text(
                    subTitle,
                    style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black_color),
                  ),
                  SizedBox(
                    width: 270.w,
                    child: Row(
                      children: [
                        Text(
                          subTitle2,
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black_color),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          amount + ' ' + 'Qar'.tr,
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black_color),
                        ),
                        Spacer(),
                        SizedBox(
                          width: 90.w,
                          child: ElevatedButton(
                            onPressed: onTap,
                            child: Text(
                              'charge Balance'.tr,
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              backgroundColor: AppColors.red,
                              elevation: 0,
                              minimumSize: Size(107, 31),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Positioned(
            right: 20.w,
            top: 10.h,
            child: GestureDetector(
                onTap: cancelTap,
                child: SvgPicture.asset(
                  AppImages.close_circle,
                  width: 20.w,
                  height: 20.h,
                ))),
      ],
    );
  }
}

class detailsWidget extends StatelessWidget {
  late String img;
  late String title;
  late String data;
  late Color textColor;
  late bool isDivider;

  detailsWidget({
    required this.img,
    required this.title,
    required this.data,
    this.textColor = AppColors.black_color,
    this.isDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
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
            ],
          ),
          SizedBox(
            height: 11.h,
          ),
          if (isDivider) Divider(),
        ],
      ),
    );
  }
}
