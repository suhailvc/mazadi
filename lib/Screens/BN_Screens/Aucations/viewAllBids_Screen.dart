

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mazzad/Models/singleAucations_Model.dart';
import 'package:mazzad/Utils/AppColors.dart';

class viewAllBids_Screen extends StatefulWidget {
  late singleAucations_Model? aucations_model;

  viewAllBids_Screen({required this.aucations_model});
  @override
  State<viewAllBids_Screen> createState() => _viewAllBids_ScreenState();
}

class _viewAllBids_ScreenState extends State<viewAllBids_Screen> {
  String BidTime(String time) {
  DateTime now = DateTime.now();
  DateTime dt1 = DateTime.parse(time);
  Duration diff = now.difference(dt1);

  if(diff.inDays>0){
    return 'since'.tr+diff.inDays.toString()+'day'.tr;

  }else if(diff.inHours>0){
    return 'since'.tr+diff.inHours.toString()+'hour'.tr;


  }else{
    return 'since'.tr+diff.inMinutes.toString()+'minute'.tr;


  }
}

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background_color,
      appBar: AppBar(
        elevation: 0,centerTitle: true,
        title: Text(
          'Last Bids'.tr,
          style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black_color),
        ),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          tooltip: 'back'.tr,

          icon: Icon(Icons.arrow_back, color: AppColors.lightgray_color),
        ),

      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
        child: ListView.separated(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount:
            widget.aucations_model!.data.bidders.length,
            separatorBuilder: (context, index) {
              return Divider(
                endIndent: 15.w,
                indent: 15.w,
              );
            },
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: ListTile(
                  title: Row(
                    children: [
                      Text(
                        '${widget.aucations_model!.data.bidders[index].user!.name.toString()}',
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.lightgray_color),
                      ),
                      Spacer(),
                      Text(
                        widget.aucations_model!.data!
                            .bidders![index].time!,
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.lightgray_color),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    '${widget.aucations_model!.data.bidders[index].amount.toString()}'+' '+'Qar'.tr,
                    style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black_color),
                  ),
                ),
              );
            }),
      ),

    );
  }
}
