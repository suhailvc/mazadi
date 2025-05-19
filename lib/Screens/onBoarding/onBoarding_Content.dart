import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../Utils/AppColors.dart';
import '../../Utils/CustomText.dart';


class OnBoardingContent extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  OnBoardingContent({
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 255.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Container(child: Image.asset(image,fit: BoxFit.cover,),),
          CachedNetworkImage(
            fit: BoxFit.cover,
            width: 175.w,
            height: 175.h,
            imageUrl: image,
          ),
          SizedBox(height: 66.h,),
          Center(
            child: Text( title,textAlign: TextAlign.center,
              style:
              TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black_color),

            ),
          ),
          SizedBox(height: 18.h,),

          Text( description,
            textAlign: TextAlign.center,
            style:
            TextStyle(

                fontFamily: 'Cairo',
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black_color.withOpacity(0.8)),

          ),



        ],
      ),
    );
  }
}