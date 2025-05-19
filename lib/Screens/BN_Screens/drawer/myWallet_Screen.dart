import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mazzad/Screens/BN_Screens/drawer/myBlockedAucations_Screen.dart';

import '../../../Controllers/GetxController/profileController.dart';
import '../../../Utils/AppColors.dart';
import '../../../Utils/asset_images.dart';
import 'addWalletAmount_Screen.dart';

class myWallet_Screen extends StatefulWidget {
  const myWallet_Screen({Key? key}) : super(key: key);

  @override
  State<myWallet_Screen> createState() => _myWallet_ScreenState();
}

class _myWallet_ScreenState extends State<myWallet_Screen> {
  // var _auth_getxController = Get.find<Auth_GetxController>();
  var _profile_getxController = Get.find<profile_GetxController>();


  String Date(date){
   var x = DateTime.tryParse(date);
   var format = DateFormat.yMd();
   var dateString = format.format(DateTime.parse(date));
    return dateString;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            'Wallet'.tr,
            style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black_color),
          ),
        ),
        body: GetBuilder<profile_GetxController>(
            builder: (profile_GetxController controller) {
          return controller.isLoadingMyWallet.isTrue
              ? Center(
                  child: Container(
                    height: 60.h,
                    width: 60.w,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.background_color),
                    child: LoadingAnimationWidget.fourRotatingDots(
                      color: AppColors.main_color,
                      size: 40,
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(top: 35.h, left: 10.w, right: 10.w,bottom: 15.h),
                  child:RefreshIndicator(
                    onRefresh: ()async{

                      await controller.get_MyBalance();
                    },
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),

                      child: Column(
                        children: [
                          Container(
                            constraints: BoxConstraints(),
                            clipBehavior: Clip.antiAlias,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            decoration: BoxDecoration(
                                color: AppColors.main_color,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'total balance'.tr,
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.wallet_model!.data.total.toString()+' '+'Qar'.tr,
                                      style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.white),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: (){
                                        Get.to(addWalletAmount_Screen());
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 20.w,
                                            height: 20.h,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.white),
                                            child: Icon(Icons.add,
                                                color: AppColors.main_color, size: 20),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            'add credit'.tr,
                                            style: TextStyle(
                                                fontFamily: 'Cairo',
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  // Get.to(myBlockedAucations_Screen());
                                },
                                child: Container(
                                  height: 182.h,
                                  width: 171.w,
                                  constraints: BoxConstraints(),
                                  clipBehavior: Clip.antiAlias,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 10.h),
                                  decoration: BoxDecoration(
                                      color: AppColors.gold,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Reserved'.tr,
                                        style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.white),
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      Text(
                                        controller.wallet_model!.data.blocked.toString()+' '+'Qar'.tr,
                                        style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontSize: 26.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 182.h,
                                width: 171.w,
                                constraints: BoxConstraints(),
                                clipBehavior: Clip.antiAlias,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                decoration: BoxDecoration(
                                    color: AppColors.messageColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'available balance'.tr,
                                      style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.white),
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    Text(
                                      controller.wallet_model!.data.free.toString()+' '+'Qar'.tr,
                                      style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 26.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.white),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 35.h,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(AppImages.circle),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                'last transactions'.tr,
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black_color),
                              ),
                            ],
                          ),



                          Padding(
                            padding:  EdgeInsets.only(
                              top: 35.h,
                            ),
                            child: SizedBox(
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount:  controller.wallet_model!.data.transactions!.length,
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: 14.h,
                                    );
                                  },
                                  itemBuilder: (context, index) {

                                    return  Row(
                                      children: [

                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              if(index==0)    Text(
                                                'Date'.tr,
                                                style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.black_color),
                                              ),
                                              if(index==0)  SizedBox(
                                                height: 14.h,
                                              ),

                                              Text(

                                    Date(controller.wallet_model!.data.transactions![index].createdAt).toString(),
                                                style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.gray_color),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,

                                            children: [
                                              if(index==0)    Text(
                                                'Amount'.tr,
                                                style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.black_color),
                                              ),
                                              if(index==0)  SizedBox(
                                                height: 14.h,
                                              ),

                                              Text(

                                                controller.wallet_model!.data.transactions![index].amount.toString()+' '+'Qar'.tr,
                                                style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.gray_color),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),

                                        Expanded(
                                          child: Column(

                                            crossAxisAlignment: CrossAxisAlignment.center,

                                            children: [
                                              if(index==0)    Text(
                                                'transaction'.tr,
                                                style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.black_color),
                                              ),
                                              if(index==0)  SizedBox(
                                                height: 14.h,
                                              ),

                                              Text(

                                                controller.wallet_model!.data.transactions![index].type.toString(),
                                                style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.gray_color),
                                              ),
                                            ],
                                          ),
                                        ),


                                      ],);
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        }));
  }
}
