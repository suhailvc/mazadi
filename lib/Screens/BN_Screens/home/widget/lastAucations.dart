import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mazzad/Utils/asset_images.dart';

import '../../../../Utils/AppColors.dart';



class lastAucations_widget extends StatelessWidget {
  late String title;

  late String img;

  late double width;

  late String name;
  late String paragraph;
  late String time;
  late String price;
  late String bidCount;


  lastAucations_widget({
    required this.title,
    required this.img,
    required this.width,
    required this.name,
    required this.paragraph,
    required this.time,
    required this.price,
    required this.bidCount,

  });

  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170.w,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.only(bottom: 5.h),
      child: Column(
mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              height: 154.h,
              width: width,
              imageUrl: img,
        ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 170.w,
                  // height: 50.h,
                  child: Text(
                    title,
                    style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 12.sp,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black_color),
                  ),
                ),
                SizedBox(height: 5.h,),
/*
                SizedBox(
                  width: 150.w,
                  child: Text(
                   paragraph,maxLines: 2,
                    style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 9.sp,
                        overflow: TextOverflow.clip,
                        fontWeight: FontWeight.w600,
                        color:
                        AppColors.black_color.withOpacity(0.54)),
                  ),
                ),


                SizedBox(height: 10.h,),
                 */

                SizedBox(
                  width: 150.w,
                  child: Row(

                    children: [
                      SvgPicture.asset(AppImages.clock),
                      SizedBox(width: 5.w,),
                      Text(
                        time,
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 11.sp,
                            overflow: TextOverflow.clip,
                            fontWeight: FontWeight.w500,
                            color: AppColors.red),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(AppImages.judge,width: 12.w,color: AppColors.gray_color),
                    SizedBox(width: 1.w,),
                    Text(
                      bidCount,
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 10.sp,
                          overflow: TextOverflow.clip,
                          color: AppColors.gray_color),
                    ),
                  ],
                ),
                SizedBox(height: 5.h,),

                SizedBox(
                  width: 150.w,
                  child: Row(

                    children: [
                      Image.asset(AppImages.price),
                      SizedBox(width: 5.w,),
                      Text(
                        price+' '+'Qar'.tr,
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 14.sp,
                            overflow: TextOverflow.clip,
                            fontWeight: FontWeight.bold,
                            color: AppColors.main_color),
                      ),
                      // Spacer(),
                      // Text(
                      //   'عرض',
                      //   style: TextStyle(
                      //       fontFamily: 'Cairo',
                      //       fontSize: 10.sp,
                      //       overflow: TextOverflow.clip,
                      //       fontWeight: FontWeight.bold,
                      //       color: AppColors.black_color),
                      // ),
                      // SvgPicture.asset(AppImages.view,width: 20.w),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
