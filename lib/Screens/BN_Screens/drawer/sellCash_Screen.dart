import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Controllers/GetxController/profileController.dart';
import '../../../Models/sendCard_Model.dart';
import '../../../Utils/AppColors.dart';
import '../../../Utils/customElevatedButton.dart';
import '../../Login/Register_Screen.dart';

class sellCash_Screen extends StatefulWidget {
  const sellCash_Screen({Key? key}) : super(key: key);

  @override
  State<sellCash_Screen> createState() => _sellCash_ScreenState();
}

class _sellCash_ScreenState extends State<sellCash_Screen> {
  int SelectedIndex = 0;
  var _profile_getxController = Get.find<profile_GetxController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            'sellCash'.tr,
            style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black_color),
          ),
        ),
        body: GetX(
          builder: (profile_GetxController profile_getx) {
            return profile_getx.isGettingAllCards.isFalse
                ? Padding(
                    padding:
                        EdgeInsets.only(top: 20.h, right: 20.w, left: 20.w),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'chooseCashAmount'.tr,
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black_color),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            SizedBox(
                              height: 100.h,
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (BuildContext context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        SelectedIndex = index;
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 100.h,
                                        width: 100.w,
                                        decoration: BoxDecoration(
                                            color: AppColors.white,
                                            border: Border.all(
                                                color: SelectedIndex == index
                                                    ? AppColors.main_color
                                                    : Colors.transparent),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                          child: Text(
                                            '${profile_getx.allCard_model!.data[index].amount}',
                                            style: TextStyle(
                                                fontFamily: 'Cairo',
                                                fontSize: 30.sp,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    AppColors.lightgray_color),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, index) {
                                    return SizedBox(
                                      width: 10.w,
                                    );
                                  },
                                  itemCount:
                                      profile_getx.allCard_model!.data.length),
                            ),
                            SizedBox(
                              height: 100.h,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.all(8),
                              child: profileTextField(
                                controller: profile_getx.phoneController,
                                label: 'phone Number'.tr,
                                hint: 'write user phone'.tr,
                                textInputType: TextInputType.number,
                                Validation: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please fill in this field'.tr;
                                  } else if (!GetUtils.isPhoneNumber(value)) {
                                    return 'Make sure the Phone is correct'.tr;
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 100.h,
                            ),
                            GetX(
                                builder: (profile_GetxController profile_getx) {
                              return customElevatedButton(
                                isLoading: profile_getx.isSendingCard.value,
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {

                                        await profile_getx.Send_Card(context,
                                            cardAmount: profile_getx
                                                .allCard_model!
                                                .data[SelectedIndex]
                                                .amount
                                                .toString());


                                  }
                                },
                                color: AppColors.main_color,
                                child: Text(
                                  'شحن الرصيد',
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  )
                : Center(child: CircularProgressIndicator());
          },
        ));
  }
}
