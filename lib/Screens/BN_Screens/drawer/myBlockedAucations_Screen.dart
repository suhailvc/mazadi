
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mazzad/Screens/BN_Screens/Aucations/mySingleAucation_Screen.dart';
import 'package:mazzad/Screens/BN_Screens/Aucations/singleAucation_Screen.dart';
import 'package:mazzad/Utils/Helper.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Controllers/GetxController/AucationsController.dart';
import '../../../Controllers/GetxController/homeController.dart';
import '../../../Controllers/GetxController/profileController.dart';
import '../../../Models/singleAucations_Model.dart';
import '../../../Utils/AppColors.dart';
import '../../../Utils/asset_images.dart';
import '../../../Utils/customElevatedButton.dart';
import '../home/home_Screen.dart';
import '../home/widget/lastAucations.dart';

class myBlockedAucations_Screen extends StatefulWidget {
  const myBlockedAucations_Screen({Key? key}) : super(key: key);

  @override
  State<myBlockedAucations_Screen> createState() => _myBlockedAucations_ScreenState();
}

class _myBlockedAucations_ScreenState extends State<myBlockedAucations_Screen> {
  bool isWaitingsAucations = true;
  bool isEndedAucations = false;
  bool isCompletedAucations = false;
  bool isCanceldAucations = false;
  // var  _home_getxController = Get.find<home_GetxController>();
  var  _aucations_getxController = Get.find<Aucations_GetxController>();
  var  _home_getxController = Get.find<home_GetxController>();
  var _profile_getxController = Get.find<profile_GetxController>();

  static String formatDuration(Duration d) {
    var seconds = d.inSeconds;
    final days = seconds~/Duration.secondsPerDay;
    seconds -= days*Duration.secondsPerDay;
    final hours = seconds~/Duration.secondsPerHour;
    seconds -= hours*Duration.secondsPerHour;
    final minutes = seconds~/Duration.secondsPerMinute;
    seconds -= minutes*Duration.secondsPerMinute;

    final List<String> tokens = [];
    if (days != 0) {
      tokens.add('${days}d');
    }
    if (tokens.isNotEmpty || hours != 0){
      tokens.add('${hours}h');
    }
    if (tokens.isNotEmpty || minutes != 0) {
      tokens.add('${minutes}m');
    }
    tokens.add('${seconds}s');

    return tokens.join('-');
  }

  @override
  Widget build(BuildContext context) {    double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
    return RefreshIndicator(

      onRefresh: ()async{
        await _home_getxController.getLastAucations();
      },
      child: Scaffold(
        backgroundColor: AppColors.background_color,

        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0.2,
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios,color: AppColors.darkgray_color),
              onPressed: () {
                Get.back();
              }),
          title: Text(
            'Reserved'.tr,
            style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black_color),
          ),

        ),
        body: Stack(
          children: [
            Padding(
              padding:  EdgeInsets.only(top: 35.h,right: 10.w,left: 10.w),
              child: GetX<profile_GetxController>(
                  builder: ( profile_GetxController controller) {
                    return (controller.isLoadingMyblockAuction.isTrue) ?
                    GridView.builder(
                        shrinkWrap: true,
                        // scrollDirection: Axis.horizontal,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: 6,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 275.h,
                            childAspectRatio: 290 / 250,
                            crossAxisSpacing: 15.w,
                            mainAxisSpacing: 15.h,
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {

                          return GestureDetector(
                            onTap: ()async{

                            },
                            child: Container(
                              height: 203.h,
                              width: 170.w,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(

                                children: [
                                  Shimmer.fromColors(
                                      baseColor:  Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade200,
                                      child:  Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                                        child: Container(
                                          width: width,
                                          height: 154.h,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                      )
                                  ),



                                  Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Divider(
                                          color: Colors.transparent,
                                        ),

                                        Shimmer.fromColors(
                                          baseColor:  Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade200,
                                          child: Container(
                                            width: 100.w,
                                            height: 12.h,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade300,
                                                borderRadius: BorderRadius.circular(8)
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10.h,),

                                        Shimmer.fromColors(
                                          baseColor:  Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade200,
                                          child: Container(
                                            width: 50.w,
                                            height: 10.h,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade300,
                                                borderRadius: BorderRadius.circular(8)
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10.h,),
                                        Shimmer.fromColors(
                                          baseColor:  Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade200,
                                          child: Container(
                                            width: 70.w,
                                            height: 10.h,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade300,
                                                borderRadius: BorderRadius.circular(8)
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 9.h,),
                                        Shimmer.fromColors(
                                          baseColor:  Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade200,
                                          child: Container(
                                            width: 110.w,
                                            height: 11.h,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade300,
                                                borderRadius: BorderRadius.circular(8)
                                            ),
                                          ),
                                        ),


                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }) :
                    GridView.builder(
                        shrinkWrap: true,
                        // scrollDirection: Axis.horizontal,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: controller.myBlockAuction_Model!
                            .data!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 275.h,
                            childAspectRatio: 290 / 250,
                            crossAxisSpacing: 15.w,
                            mainAxisSpacing: 15.h,
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          DateTime now = DateTime.now();
                          DateTime dt1 = DateTime.parse(
                              controller.myBlockAuction_Model!.data![index].auction!.auctionTo
                                  .toString());
                          Duration diff = dt1.difference(now);
                          return GestureDetector(
                            onTap: ()async{
                              singleAucations_Model?
                              singleAucation =
                              await _home_getxController
                                  .getAucationByID(
                                  context:  context,

                                  ID:   controller.myBlockAuction_Model!.data![index].auction!.id
                                      .toString());
                              if(singleAucation!=null){
                                if(singleAucation.data.user!.id==_profile_getxController.profile_model!.data.userId){
                                  Get.to(mySingleAucation_Screen(
                                      aucations_model: singleAucation));
                                  print('my');
                                }else{
                                  await Get.to(singleAucation_Screen(aucations_model: singleAucation));
                                  print('no');

                                }




                              }

                            },
                            child:  lastAucations_widget(
                              title:  controller.myBlockAuction_Model!.data![index].auction!.title
                                  .toString(),
                              width: 290.w,
                              img:  controller.myBlockAuction_Model!.data![index].auction!.photo
                                  .toString(),
                              paragraph:  controller.myBlockAuction_Model!.data![index].auction!
                                  .description
                                  .toString(),
                              name: '',
                              bidCount:  controller.myBlockAuction_Model!.data![index].auction!
                                  .wishlist
                                  .toString(),
                              time: diff.inSeconds <= 0
                                  ? 'Aucation Ended'.tr
                                  : '${formatDuration(diff)}',
                              price: controller.myBlockAuction_Model!.data![index].auction!.price
                                  .toString(),
                            ),
                          );
                        })

                    ;
                  }),
            ),
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
        ),

      ),
    );
  }
}
