import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mazzad/Screens/BN_Screens/Aucations/mySingleAucation_Screen.dart';
import 'package:mazzad/Screens/BN_Screens/Aucations/singleAucation_Screen.dart';
import 'package:mazzad/Utils/Helper.dart';

import '../../../Controllers/GetxController/AucationsController.dart';
import '../../../Controllers/GetxController/drawerController.dart';
import '../../../Controllers/GetxController/homeController.dart';
import '../../../Controllers/GetxController/profileController.dart';
import '../../../Models/singleAucationCategory_Model.dart';
import '../../../Models/singleAucations_Model.dart';
import '../../../Utils/AppColors.dart';
import '../../../Utils/asset_images.dart';
import '../../../firebase/fb_firestore_controller.dart';
import '../home/home_Screen.dart';
import '../home/widget/lastAucations.dart';

class AucationsByCategory_Screen extends StatefulWidget {
  late String categoryName;

  AucationsByCategory_Screen({required this.categoryName});

  @override
  State<AucationsByCategory_Screen> createState() =>
      _AucationsByCategory_ScreenState();
}

class _AucationsByCategory_ScreenState
    extends State<AucationsByCategory_Screen> {
  var aucations_getxController = Get.find<Aucations_GetxController>();
  var _home_getxController = Get.find<home_GetxController>();
  var _profile_getxController = Get.find<profile_GetxController>();

  bool isAllType=true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      onRefresh: () async {},
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.white,
            elevation: 0.2,
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              tooltip: 'back'.tr,
              icon: Icon(Icons.arrow_back, color: AppColors.lightgray_color),
            ),
            title: Text(
              widget.categoryName,
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black_color),
            ),
          ),
          body: Stack(
            children: [


              GetX<Aucations_GetxController>(
                  builder: (Aucations_GetxController controller) {
                return (controller.isLoadingSingleAucation.isTrue)
                    ? Center(
                        child: LoadingAnimationWidget.dotsTriangle(
                          color: AppColors.main_color,
                          size: 40,
                        ),
                      )
                    : Padding(
                        padding:
                            EdgeInsets.only(top: 35.h, right: 10.w, left: 10.w),
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [







                              Text(
                                'Active Auctions'.tr,
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black_color),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),

                              GridView.builder(
                                  shrinkWrap: true,
                                  // scrollDirection: Axis.horizontal,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount:controller.auctionOfCategory_ListCopy.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: Helper.childAspectRatio(1.15),
                                      crossAxisSpacing: 15.w,
                                      mainAxisSpacing: 15.h,
                                      crossAxisCount: 2),
                                  itemBuilder: (context, index) {
                                    DateTime now = DateTime.now();
                                    DateTime dt1 = DateTime.parse(controller.auctionOfCategory_ListCopy[index]
                                        .auctionTo
                                        .toString());
                                    Duration diff = dt1.difference(now);
                                    return
                                    StreamBuilder<DocumentSnapshot>(
                                        stream: FbFireStoreController().getAucationLastBid(aucationID: controller.auctionOfCategory_ListCopy![index].id),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                                          if (snapshot!.hasData) {
                                            var data = snapshot.data!;
                                            return    GestureDetector(
                                              onTap: () async {

                                                if(await Helper().checkInternet()){

                                                  singleAucations_Model? singleAucation =
                                                  await _home_getxController
                                                      .getAucationByID(
                                                      context:  context,

                                                      ID: controller.auctionOfCategory_ListCopy[index]
                                                          .id
                                                          .toString());

                                                  if(singleAucation!=null){
                                                    if(singleAucation.data.user!.userId==_profile_getxController.profile_model!.data.userId){
                                                      Get.to(mySingleAucation_Screen(
                                                          aucations_model: singleAucation));
                                                    }else{
                                                      await Get.to(singleAucation_Screen(aucations_model: singleAucation));

                                                    }




                                                  }else{
                                                  }
                                                }else{
                                                  Helper().show_Dialog(
                                                      context: context,
                                                      title: 'No Internet'.tr,
                                                      img: AppImages.no_internet,
                                                      subTitle: 'Try Again'.tr);
                                                }

                                              },
                                              child: lastAucations_widget(
                                                title: controller.auctionOfCategory_ListCopy[index].title
                                                    .toString(),
                                                width: 290.w,
                                                img: controller.auctionOfCategory_ListCopy[index].photo
                                                    .toString(),
                                                paragraph: controller.auctionOfCategory_ListCopy[index].description
                                                    .toString(),
                                                name: '',
                                                bidCount: controller.auctionOfCategory_ListCopy[index].lastBid
                                                    .toString(),
                                                time: diff.inSeconds <= 0
                                                    ? 'Aucation Ended'.tr
                                                    : '${Helper.formatDuration(diff)}',
                                                price:
 data.exists?
                                              data['lastPrice'].toString():


                                                controller.auctionOfCategory_ListCopy[index].price
                                                    .toString(),
                                              ),
                                            );
                                          } else {
                                            return SizedBox();
                                          }
                                        });


                                  }),









                              SizedBox(
                                height: 50.h,
                              ),
                            ],
                          ),
                        ),
                      );
              }),
              GetX<home_GetxController>(
                  builder: (home_GetxController controller) {
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
          )),
    );
  }
}
