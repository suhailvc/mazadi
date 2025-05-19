import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'AppColors.dart';

class appTextfield extends StatelessWidget {
  final TextEditingController EditingController;
  final String Errormessage;
  final String hintText;

  appTextfield({ required this.EditingController, required this.Errormessage, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      controller: EditingController,
      textAlignVertical: TextAlignVertical.bottom,
      maxLines: 1,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return Errormessage ;
        }
        return null;
      },
      style: TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.black_color,
      fontFamily: 'Cairo',
    ),

      decoration: InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: Colors.grey,
    fontFamily: 'Cairo',
    ),
        contentPadding: EdgeInsets.all(15.h),
        fillColor: AppColors.white,
        filled: true,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,

        focusedErrorBorder: InputBorder.none,

      ),
    );
  }
}
