import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mazzad/Controllers/GetxController/profileController.dart';
import 'package:mazzad/Screens/BN_Screens/Aucations/singleAucation_Screen.dart';
import 'package:mazzad/Utils/Helper.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Controllers/GetxController/AucationsController.dart';
import '../../../Controllers/GetxController/homeController.dart';
import '../../../Models/myBids_model.dart';
import '../../../Models/singleAucations_Model.dart';
import '../../../Utils/AppColors.dart';
import '../../../Utils/asset_images.dart';
import '../../../Utils/customElevatedButton.dart';
import '../../../firebase/fb_firestore_controller.dart';
import '../home/widget/lastAucations.dart';
import 'LastAucations_Screen.dart';
import 'mySingleAucation_Screen.dart';

class myBids_Screen extends StatefulWidget {
  const myBids_Screen({Key? key}) : super(key: key);

  @override
  State<myBids_Screen> createState() => _myBids_ScreenState();
}

class _myBids_ScreenState extends State<myBids_Screen> with Helper{
  bool isWaitingsBids = true;
  bool isWinningBids = false;
  bool islosedBids = false;
  var _aucations_getxController = Get.find<Aucations_GetxController>();
  var _home_getxController = Get.find<home_GetxController>();
  var _profile_getxController = Get.find<profile_GetxController>();

  late ScrollController scrollController ;


  Future scrollListen() async {

    scrollController.addListener(() async {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent) {
        if(isWaitingsBids == true){
          _aucations_getxController.getMy_wait_bids(is_Pagination: true);

        }else if(isWinningBids == true){
          _aucations_getxController.getMy_win_bids(is_Pagination: true);

        }else if(islosedBids == true){
          _aucations_getxController.getMy_lose_bids(is_Pagination: true);


        }

      }
    });




  }
  @override
  void initState() {
    super.initState();
    scrollController= ScrollController();

    scrollListen();

  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }


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
            icon: Icon(Icons.arrow_back_ios, color: AppColors.darkgray_color),
            onPressed: () {
              Get.back();
            }),
        title: Text(
          'My Bids'.tr,
          style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black_color),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            width: width,
            child: Padding(
              padding: EdgeInsets.only(top: 25.h, right: 10.w, left: 10.w),
              child: RefreshIndicator(
                onRefresh: () async {

                  if(isWaitingsBids == true){
                    _aucations_getxController.getMy_wait_bids();

                  }else if(isWinningBids == true){
                    _aucations_getxController.getMy_win_bids();

                  }else if(islosedBids == true){
                    _aucations_getxController.getMy_lose_bids();


                  }



                  // if (await Helper().checkInternet()) {
                  //   _aucations_getxController.getMy_wait_bids();
                  //   _aucations_getxController.getMy_win_bids();
                  //   _aucations_getxController.getMy_lose_bids();
                  // } else {
                  //   Helper().show_Dialog(
                  //       context: context,
                  //       title: 'No Internet'.tr,
                  //       img: AppImages.no_internet,
                  //       subTitle: 'Try Again'.tr);
                  // }
                },
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 60.h,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    isWaitingsBids = true;
                                    isWinningBids = false;
                                    islosedBids = false;

                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 60.h,
                                    width: 150.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: isWaitingsBids
                                            ? AppColors.main_color
                                            : AppColors.white),
                                    child: Center(
                                      child: Text(
                                        'waiting'.tr,
                                        style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.bold,
                                            color: isWaitingsBids
                                                ? AppColors.white
                                                : AppColors.gray_color),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    isWaitingsBids = false;
                                    isWinningBids = true;
                                    islosedBids = false;

                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 60.h,
                                    width: 150.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: isWinningBids
                                            ? AppColors.main_color
                                            : AppColors.white),
                                    child: Center(
                                      child: Text(
                                        'winning Bids'.tr,
                                        style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.bold,
                                            color: isWinningBids
                                                ? AppColors.white
                                                : AppColors.gray_color),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    isWaitingsBids = false;
                                    isWinningBids = false;
                                    islosedBids = true;

                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 60.h,
                                    width: 150.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: islosedBids
                                            ? AppColors.main_color
                                            : AppColors.white),
                                    child: Center(
                                      child: Text(
                                        'Losed Bids'.tr,
                                        style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.bold,
                                            color: islosedBids
                                                ? AppColors.white
                                                : AppColors.gray_color),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),

                        Visibility(
                          visible: isWaitingsBids,
                          child: GetX<Aucations_GetxController>(
                              builder: (Aucations_GetxController controller) {
                                List<bid_AuctionData> AuctionsData =[];
                                  AuctionsData  =controller.myWaitingBids_model!.data!.data!.where((element) => element.auction!=null).toList();
                                  print(controller.myWaitingBids_model!.data!.data!.length);

                            return (controller.isLoadingMyWaitingBids.isTrue)
                                ? auctionShimmerGridView(width: width)
                                : AuctionsData.isNotEmpty
                                    ? GridView.builder(
                                        shrinkWrap: true,
                                        // scrollDirection: Axis.horizontal,
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemCount: AuctionsData
                                            .length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                childAspectRatio:
                                                    Helper.childAspectRatio(
                                                        1.2),
                                                crossAxisSpacing: 15.w,
                                                mainAxisSpacing: 15.h,
                                                crossAxisCount: 2),
                                        itemBuilder: (context, index) {
                                          DateTime now = DateTime.now();
                                          DateTime dt1 = DateTime.parse(
                                              AuctionsData[index]
                                                  .auction!
                                                  .auctionTo
                                                  .toString());
                                          Duration diff = dt1.difference(now);
                                          return StreamBuilder<
                                                  DocumentSnapshot>(
                                              stream: FbFireStoreController()
                                                  .getAucationLastBid(
                                                      aucationID: AuctionsData[index]
                                                          .auction!
                                                          .id!),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<
                                                          DocumentSnapshot>
                                                      snapshot) {
                                                if (snapshot!.hasData) {
                                                  var data = snapshot.data!;
                                                  return GestureDetector(
                                                    onTap: () async {
                                                      if (await Helper()
                                                          .checkInternet()) {
                                                        singleAucations_Model?
                                                            singleAucation =
                                                            await _home_getxController
                                                                .getAucationByID(
                                                                    context:
                                                                        context,
                                                                    ID: AuctionsData[
                                                                            index]
                                                                        .auction!
                                                                        .id
                                                                        .toString());
                                                        if (singleAucation !=
                                                            null) {
                                                          if (singleAucation
                                                                  .data
                                                                  .user!
                                                                  .userId ==
                                                              _profile_getxController
                                                                  .profile_model!
                                                                  .data
                                                                  .userId) {
                                                            Get.to(mySingleAucation_Screen(
                                                                aucations_model:
                                                                    singleAucation));
                                                            print('my');
                                                          } else {
                                                            await Get.to(
                                                                singleAucation_Screen(
                                                                    aucations_model:
                                                                        singleAucation,));
                                                            print('no');
                                                          }
                                                        } else {}
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
                                                    },
                                                    child: lastAucations_widget(
                                                      title:AuctionsData[index]
                                                          .auction!
                                                          .title!
                                                          .toString(),
                                                      width: 290.w,
                                                      img:AuctionsData[index]
                                                          .auction!
                                                          .photo!
                                                          .toString(),
                                                      paragraph:AuctionsData[index]
                                                          .auction!
                                                          .description!
                                                          .toString(),
                                                      name: '',
                                                      bidCount: AuctionsData[index]
                                                          .auction!
                                                          .price
                                                          .toString(),
                                                      time: diff.inSeconds <= 0
                                                          ? 'انتهى المزاد'
                                                          : '${Helper.formatDuration(diff)}',
                                                      price: data.exists
                                                          ? data['lastPrice']
                                                              .toString()
                                                          : AuctionsData[index]
                                                              .auction!
                                                              .price
                                                              .toString(),
                                                    ),
                                                  );
                                                } else {
                                                  return SizedBox();
                                                }
                                              });
                                        })
                                    : SizedBox(
                                        height: 630.h,
                                        width: width,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 200.h,
                                            ),
                                            Image.asset(AppImages.matte),
                                            SizedBox(
                                              height: 35.h,
                                            ),
                                            Text(
                                              'No Bids yet'.tr,
                                              style: TextStyle(
                                                  fontFamily: 'Cairo',
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.black_color),
                                            ),
                                            SizedBox(
                                              height: 35.h,
                                            ),
                                          ],
                                        ),
                                      );
                          }),
                        ),
                        Visibility(
                          visible: isWinningBids,
                          child: GetX<Aucations_GetxController>(
                              builder: (Aucations_GetxController controller) {
                                List<bid_AuctionData> AuctionsData =[];
                                if(controller.myWinBids_model!=null){
                                  AuctionsData  =controller.myWinBids_model!.data!.data!.where((element) => element.auction!=null).toList();
                                }
                            return (controller.isLoadingMyWinBids.isTrue)
                                ? auctionShimmerGridView(width: width)
                                :
                            AuctionsData.isNotEmpty
                                    ? GridView.builder(
                                        shrinkWrap: true,
                                        // scrollDirection: Axis.horizontal,
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemCount: AuctionsData.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                childAspectRatio:
                                                    Helper.childAspectRatio(
                                                        1.2),
                                                crossAxisSpacing: 15.w,
                                                mainAxisSpacing: 15.h,
                                                crossAxisCount: 2),
                                        itemBuilder: (context, index) {
                                          DateTime now = DateTime.now();
                                          DateTime dt1 = DateTime.parse(
                                              AuctionsData[index].auction!.auctionTo
                                                  .toString());
                                          Duration diff = dt1.difference(now);

                                          return StreamBuilder<
                                                  DocumentSnapshot>(
                                              stream: FbFireStoreController()
                                                  .getAucationLastBid(
                                                      aucationID: AuctionsData[index]
                                                          .auction!
                                                          .id!),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<
                                                          DocumentSnapshot>
                                                      snapshot) {
                                                if (snapshot!.hasData) {
                                                  var data = snapshot.data!;
                                                  return GestureDetector(
                                                    onTap: () async {
                                                      if (await Helper()
                                                          .checkInternet()) {
                                                        singleAucations_Model?
                                                            singleAucation =
                                                            await _home_getxController
                                                                .getAucationByID(
                                                                    context:
                                                                        context,
                                                                    ID:AuctionsData[
                                                                            index]
                                                                        .auction!
                                                                        .id
                                                                        .toString());
                                                        if (singleAucation != null) {

                                                          await Get.to(singleAucation_Screen(aucations_model: singleAucation,isFrom_Winnings_Page: true,));
                                                        } else {}
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
                                                    },
                                                    child: lastAucations_widget(
                                                      title:AuctionsData[index]
                                                          .auction!
                                                          .title
                                                          .toString(),
                                                      width: 290.w,
                                                      img: AuctionsData[index]
                                                          .auction!
                                                          .photo
                                                          .toString(),
                                                      paragraph: controller
                                                          .myWinBids_model!
                                                          .data!
                                                          .data![index]
                                                          .auction!
                                                          .description
                                                          .toString(),
                                                      name: '',
                                                      bidCount: AuctionsData[index]
                                                          .auction!
                                                          .price
                                                          .toString(),
                                                      time: diff.inSeconds <= 0
                                                          ? 'Aucation Ended'.tr
                                                          : '${Helper.formatDuration(diff)}',
                                                      price: data.exists
                                                          ? data['lastPrice']
                                                              .toString()
                                                          : AuctionsData[index]
                                                              .auction!
                                                              .price
                                                              .toString(),
                                                    ),
                                                  );
                                                } else {
                                                  return SizedBox();
                                                }
                                              });
                                        })
                                    : SizedBox(
                                        height: 630.h,
                                        width: width,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 200.h,
                                            ),
                                            Image.asset(AppImages.matte),
                                            SizedBox(
                                              height: 35.h,
                                            ),
                                            Text(
                                              'No Bids yet'.tr,
                                              style: TextStyle(
                                                  fontFamily: 'Cairo',
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.black_color),
                                            ),
                                            SizedBox(
                                              height: 35.h,
                                            ),
                                          ],
                                        ),
                                      );
                          }),
                        ),
                        Visibility(
                          visible: islosedBids,
                          child: GetX<Aucations_GetxController>(
                              builder: (Aucations_GetxController controller) {
                                List<bid_AuctionData> AuctionsData =[];
                                if(controller.myLoseBids_model!=null){
                                  AuctionsData  =controller.myLoseBids_model!.data!.data!.where((element) => element.auction!=null).toList();
                                }
                            return (controller.isLoadingMyLoseBids.isTrue)
                                ? auctionShimmerGridView(width: width)
                                : controller
                                        .myLoseBids_model!.data.data!.isNotEmpty
                                    ? GridView.builder(
                                        shrinkWrap: true,
                                        // scrollDirection: Axis.horizontal,
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemCount: AuctionsData.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                childAspectRatio:
                                                    Helper.childAspectRatio(
                                                        1.2),
                                                crossAxisSpacing: 15.w,
                                                mainAxisSpacing: 15.h,
                                                crossAxisCount: 2),
                                        itemBuilder: (context, index) {
                                          DateTime now = DateTime.now();
                                          DateTime dt1 = DateTime.parse(
                                              AuctionsData[index].auction!.auctionTo
                                                  .toString());
                                          Duration diff = dt1.difference(now);
                                          return StreamBuilder<
                                                  DocumentSnapshot>(
                                              stream: FbFireStoreController()
                                                  .getAucationLastBid(
                                                      aucationID: AuctionsData[index]
                                                          .auction!
                                                          .id!),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<
                                                          DocumentSnapshot>
                                                      snapshot) {
                                                if (snapshot!.hasData) {
                                                  var data = snapshot.data!;
                                                  return GestureDetector(
                                                    onTap: () async {
                                                      if (await Helper()
                                                          .checkInternet()) {
                                                        singleAucations_Model?
                                                            singleAucation =
                                                            await _home_getxController
                                                                .getAucationByID(
                                                                    context:
                                                                        context,
                                                                    ID: AuctionsData[
                                                                            index]
                                                                        .auction!
                                                                        .id
                                                                        .toString());
                                                        if (singleAucation !=
                                                            null) {
                                                          if (singleAucation
                                                                  .data
                                                                  .user!
                                                                  .id ==
                                                              _profile_getxController
                                                                  .profile_model!
                                                                  .data
                                                                  .userId) {
                                                            Get.to(mySingleAucation_Screen(
                                                                aucations_model:
                                                                    singleAucation));
                                                            print('my');
                                                          } else {
                                                            await Get.to(
                                                                singleAucation_Screen(
                                                                    aucations_model:
                                                                        singleAucation));
                                                            print('no');
                                                          }
                                                        } else {}
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
                                                    },
                                                    child: lastAucations_widget(
                                                      title: AuctionsData[index]
                                                          .auction!
                                                          .title
                                                          .toString(),
                                                      width: 290.w,
                                                      img:AuctionsData[index]
                                                          .auction!
                                                          .photo
                                                          .toString(),
                                                      paragraph:AuctionsData[index]
                                                          .auction!
                                                          .description
                                                          .toString(),
                                                      name: '',
                                                      bidCount: AuctionsData[index]
                                                          .auction!
                                                          .price
                                                          .toString(),
                                                      time: diff.inSeconds <= 0
                                                          ? 'Aucation Ended'.tr
                                                          : '${Helper.formatDuration(diff)}',
                                                      price: data.exists
                                                          ? data['lastPrice']
                                                              .toString()
                                                          : AuctionsData[index]
                                                              .auction!
                                                              .price
                                                              .toString(),
                                                    ),
                                                  );
                                                } else {
                                                  return SizedBox();
                                                }
                                              });
                                        })
                                    : SizedBox(
                                        height: 630.h,
                                        width: width,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 200.h,
                                            ),
                                            Image.asset(AppImages.matte),
                                            SizedBox(
                                              height: 35.h,
                                            ),
                                            Text(
                                              'No Bids yet'.tr,
                                              style: TextStyle(
                                                  fontFamily: 'Cairo',
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.black_color),
                                            ),
                                            SizedBox(
                                              height: 35.h,
                                            ),
                                          ],
                                        ),
                                      );
                          }),
                        ),
                      ]),
                ),
              ),
            ),
          ),
          GetX<home_GetxController>(builder: (home_GetxController controller) {
            return (controller.isLoadingData.isTrue)
                ? Center(
                    child: Container(
                      height: 60.h,
                      width: 60.w,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.main_color),
                      child: LoadingAnimationWidget.fourRotatingDots(
                        color: AppColors.white,
                        size: 40,
                      ),
                    ),
                  )
                : Container();
          }),
        ],
      ),
    );
  }
}

class shimmer_Auction_ListView extends StatelessWidget {
  const shimmer_Auction_ListView({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: 5,
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 14.h,
            );
          },
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {},
              child: Container(
                width: width,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius:
                    BorderRadius.circular(8)),
                padding: EdgeInsets.only(
                    top: 12.h,
                    right: 8.w,
                    left: 8.w,
                    bottom: 12.h),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                            clipBehavior:
                            Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    8)),
                            child: Shimmer
                                .fromColors(
                                baseColor:
                                Colors.grey
                                    .shade300,
                                highlightColor:
                                Colors.grey
                                    .shade200,
                                child:
                                Container(
                                  width: 135.w,
                                  height: 135.h,
                                  decoration:
                                  BoxDecoration(
                                    color: Colors
                                        .grey
                                        .shade300,
                                  ),
                                ))),
                        Padding(
                          padding: EdgeInsets.only(
                              right: 10.w,
                              left: 10.w),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              Shimmer.fromColors(
                                  baseColor: Colors
                                      .grey
                                      .shade300,
                                  highlightColor:
                                  Colors.grey
                                      .shade200,
                                  child: Container(
                                    width: 150.w,
                                    height: 12.h,
                                    decoration: BoxDecoration(
                                        color: Colors
                                            .grey
                                            .shade300,
                                        borderRadius:
                                        BorderRadius.circular(
                                            5)),
                                  )),
                              SizedBox(
                                height: 10.h,
                              ),
                              Shimmer.fromColors(
                                  baseColor: Colors
                                      .grey
                                      .shade300,
                                  highlightColor:
                                  Colors.grey
                                      .shade200,
                                  child: Container(
                                    width: 135.w,
                                    height: 11.h,
                                    decoration: BoxDecoration(
                                        color: Colors
                                            .grey
                                            .shade300,
                                        borderRadius:
                                        BorderRadius.circular(
                                            5)),
                                  )),
                              SizedBox(
                                height: 15.h,
                              ),
                              Shimmer.fromColors(
                                  baseColor: Colors
                                      .grey
                                      .shade300,
                                  highlightColor:
                                  Colors.grey
                                      .shade200,
                                  child: Container(
                                    width: 160.w,
                                    height: 12.h,
                                    decoration: BoxDecoration(
                                        color: Colors
                                            .grey
                                            .shade300,
                                        borderRadius:
                                        BorderRadius.circular(
                                            5)),
                                  )),
                              SizedBox(
                                height: 15.h,
                              ),
                              Shimmer.fromColors(
                                  baseColor: Colors
                                      .grey
                                      .shade300,
                                  highlightColor:
                                  Colors.grey
                                      .shade200,
                                  child: Container(
                                    width: 150.w,
                                    height: 12.h,
                                    decoration: BoxDecoration(
                                        color: Colors
                                            .grey
                                            .shade300,
                                        borderRadius:
                                        BorderRadius.circular(
                                            5)),
                                  )),
                              SizedBox(
                                height: 8.h,
                              ),
                              Shimmer.fromColors(
                                  baseColor: Colors
                                      .grey
                                      .shade300,
                                  highlightColor:
                                  Colors.grey
                                      .shade200,
                                  child: Container(
                                    width: 130.w,
                                    height: 11.h,
                                    decoration: BoxDecoration(
                                        color: Colors
                                            .grey
                                            .shade300,
                                        borderRadius:
                                        BorderRadius.circular(
                                            5)),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
