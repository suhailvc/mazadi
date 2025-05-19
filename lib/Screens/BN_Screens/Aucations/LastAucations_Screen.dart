
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
import 'mySingleAucation_Screen.dart';

class LastAucations_Screen extends StatefulWidget {
  const LastAucations_Screen({Key? key}) : super(key: key);

  @override
  State<LastAucations_Screen> createState() => _LastAucations_ScreenState();
}

class _LastAucations_ScreenState extends State<LastAucations_Screen> {
  bool isWaitingsAucations = true;
  bool isEndedAucations = false;
  bool isCompletedAucations = false;
  bool isCanceldAucations = false;
  // var  _home_getxController = Get.find<home_GetxController>();
  var  _aucations_getxController = Get.find<Aucations_GetxController>();
  var  _home_getxController = Get.find<home_GetxController>();
  var _profile_getxController = Get.find<profile_GetxController>();


  late ScrollController scrollController ;

  Future scrollListen() async {

    scrollController.addListener(() async {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent) {
        _home_getxController.getLastAucations(is_Refresh: true);
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
            'Last Aucations'.tr,
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
              child: GetX<home_GetxController>(
                  builder: ( home_GetxController controller) {
                    return (controller.isLoadingLastAucation.isTrue) ?
                    auctionShimmerGridView(width: width) :
                    GridView.builder(
                        shrinkWrap: true,
                        // scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        controller: scrollController,
                        padding: EdgeInsets.zero,
                        itemCount: controller.lastAucations_model!
                            .data!.data!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: Helper.childAspectRatio(1.1),

                            crossAxisSpacing: 15.w,
                            mainAxisSpacing: 15.h,
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          DateTime now = DateTime.now();
                          DateTime dt1 = DateTime.parse(
                              controller.lastAucations_model!.data!
                                  .data![index].auctionTo
                                  .toString());
                          Duration diff = dt1.difference(now);
                          return GestureDetector(
                            onTap: ()async{      if(await Helper().checkInternet()){

  singleAucations_Model?
                              singleAucation =
                              await controller
                                  .getAucationByID(
                                  context:  context,

                                  ID: controller
                                      .lastAucations_model!
                                      .data!
                                      .data![index]
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
                                  subTitle: 'Try Again'.tr);                              }

                            },
                            child:  lastAucations_widget(
                              title: controller.lastAucations_model!
                                  .data.data[index].title
                                  .toString(),
                              width: 290.w,
                              img: controller.lastAucations_model!
                                  .data.data[index].photo
                                  .toString(),
                              paragraph: controller
                                  .lastAucations_model!
                                  .data
                                  .data[index]
                                  .description
                                  .toString(),
                              name: '',
                              bidCount: controller
                                  .lastAucations_model!
                                  .data
                                  .data[index]
                                  .bidsCount
                                  .toString(),
                              time: diff.inSeconds <= 0
                                  ? 'Aucation Ended'.tr
                                  : '${Helper.formatDuration(diff)}',
                              price:
                              controller
                                  .lastAucations_model!
                                  .data
                                  .data[index]
                                  .bidsCount!>0?
                              controller.lastAucations_model!
                                  .data.data[index].lastBid
                                  .toString():controller.lastAucations_model!
                                  .data.data[index].minBid
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

class auctionShimmerGridView extends StatelessWidget {
  const auctionShimmerGridView({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        // scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: 6,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: Helper.childAspectRatio(1.2),
            crossAxisSpacing: 15.w,
            mainAxisSpacing: 15.h,
            crossAxisCount: 2),
        itemBuilder: (context, index) {

          return GestureDetector(
            onTap: ()async{

            },
            child: Container(
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
        });
  }
}
