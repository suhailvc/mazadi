import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mazzad/Screens/BN_Screens/main_Screen.dart';
import 'package:mazzad/Utils/asset_images.dart';

import '../../Utils/AppColors.dart';
import '../../Utils/customElevatedButton.dart';

class selectCity_Screen extends StatefulWidget {
  const selectCity_Screen({Key? key}) : super(key: key);

  @override
  State<selectCity_Screen> createState() => _selectCity_ScreenState();
}

class _selectCity_ScreenState extends State<selectCity_Screen> {





  List<String> cities = ['الدوحة',];
  List<String> street = ['اسم الحي',];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,

        backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: (){
          Get.back();
        },
        tooltip: 'رجوع',
        icon: Icon(Icons.arrow_back_ios,color: Colors.black),
      )
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Divider(color: Colors.transparent),
            SizedBox(
              height: 120.h,
            ),
            Image.asset(AppImages.map),
            SizedBox(
              height: 65.h,
            ),
            Row(
              children: [
                Text(
                  'المدينة',
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black_color.withOpacity(0.8)),
                ),
              ],
            ),
            SizedBox(
 width: 314.w,
              child: DropdownButton(
                value: 'الدوحة',
                icon: const Icon(Icons.keyboard_arrow_down),
                items: cities
                    .map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black_color,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {

                },
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              children: [
                Text(
                  'الحي',
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black_color.withOpacity(0.8)),
                ),
              ],
            ),
            SizedBox(
              width: 314.w,
              child: DropdownButton(
                value: 'اسم الحي',

                icon: const Icon(Icons.keyboard_arrow_down,),
                items: street
                    .map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black_color,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {

                },
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            customElevatedButton(
              onTap: (){
                Get.offAll(main_Screen());
              },
              color: AppColors.main_color,
              child: Text(
                'تأكيد',
                style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
