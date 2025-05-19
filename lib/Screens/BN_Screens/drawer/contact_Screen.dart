import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mazzad/Utils/Helper.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Controllers/GetxController/homeController.dart';
import '../../../Controllers/GetxController/profileController.dart';
import '../../../Utils/AppColors.dart';
import '../../../Utils/asset_images.dart';
import '../../../Utils/customElevatedButton.dart';

class contact_Screen extends StatefulWidget {
  const contact_Screen({Key? key}) : super(key: key);

  @override
  State<contact_Screen> createState() => _contact_ScreenState();
}

class _contact_ScreenState extends State<contact_Screen> {
  var _profile_GetxController = Get.find<profile_GetxController>();
  var _home_getxController = Get.find<home_GetxController>();



  void send_Email({
    required String email,
    required String subject,
    required String body,
  }) async {
    String url = "mailto:$email?subject=$subject&body=$body";
    await launchUrl(Uri.parse(url));
  }




  TextEditingController NameController = TextEditingController();
  TextEditingController PhoneController = TextEditingController();
  TextEditingController arTitleController = TextEditingController();
  TextEditingController arDescriptionController = TextEditingController();
refresh(){
  setState(() {

  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      floatingActionButton: AnimatedFloatingActionButton(
        //Fab list
          fabButtons: <Widget>[
            float1(), float2()
          ],
          // key : key,
          colorStartAnimation: Colors.blue,
          colorEndAnimation: Colors.red,
          animatedIconData: AnimatedIcons.menu_close //To principal button
      ),


       */
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
          'Technical support'.tr,
          style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black_color),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 35.h,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 15.w),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    profileTextField(
                      label: 'user Name'.tr,
                      hint: 'write user Name'.tr,
                      controller: NameController,  onChanged: (x){
                      setState(() {

                      });
                    },
                    ),
                    profileTextField(
                      label: 'phone Number'.tr,
                      hint: 'write user phone'.tr,
                      controller: PhoneController,
                      onChanged: (x){
                        setState(() {

                        });
                      },
                    ),
                    profileTextField(
                      label: 'title'.tr,
                      hint: 'write title'.tr,
                      controller: arTitleController,  onChanged: (x){
                      setState(() {

                      });
                    },
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(AppImages.circle),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              'message'.tr,
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black_color),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 13.h,
                        ),
                        Container(
                          height: 200.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.background_color),
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: TextField(
                            controller: arDescriptionController,onChanged: (x){
                              setState(() {

                              });
                          },
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black_color,
                              fontFamily: 'Cairo',
                            ),
                            minLines: 1,
                            maxLines: 7,
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              hintText: 'write message'.tr,
                              hintStyle: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                                fontFamily: 'Cairo',
                              ),
                              contentPadding: EdgeInsets.only(bottom: 5.h),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    GetX<profile_GetxController>(
                        builder: (profile_GetxController controller) {
                      return (controller.isAddingContact.isTrue)
                          ? customElevatedButton(
                              onTap: () async {},
                              color: AppColors.main_color,
                              child: LoadingAnimationWidget.waveDots(
                                color: AppColors.white,
                                size: 40,
                              ),
                            )
                          : customElevatedButton(
                              onTap: ()async {
                                if(NameController.text.isNotEmpty &&PhoneController.text.isNotEmpty &&arTitleController.text.isNotEmpty &&arDescriptionController.text.isNotEmpty ){
                                bool isSaved=  await controller.add_contact(name: NameController.text, mobile: PhoneController.text, title: arTitleController.text, message: arDescriptionController.text);
                             if(isSaved){
                               clear();
                               show_SuccessDialog(context: context);

                             } else{
                               show_ErrorDialog(context: context);
                             }
                             }


                              },
                              color: NameController.text.isNotEmpty &&PhoneController.text.isNotEmpty &&arTitleController.text.isNotEmpty &&arDescriptionController.text.isNotEmpty ?AppColors.main_color:AppColors.gray_color,
                              child: Text(
                                'send Now'.tr,
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white),
                              ),
                            );
                    }),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'OR'.tr,
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black_color),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    customElevatedButton(
                      onTap: ()async {
                      Helper().send_Whatsapp(phoneNum:_home_getxController.setting_model!.data.whatsapp,massege: '' );
                      },
                      color: AppColors.whatsabColor,
                      child: Text(
                        'whatsapp'.tr,
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white),
                      ),
                    ),SizedBox(
                      height: 15.h,
                    ),
                    customElevatedButton(
                      onTap: ()async {

                        send_Email(email:  _home_getxController.setting_model!.data.email??'', subject: '', body: '');
                      },
                      color: AppColors.phoneCallColor,
                      child: Text(
                        'email'.tr,
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white),
                      ),
                    ),



                  ],
                ),
              ),
            ),
            SizedBox(
              height: 35.h,
            )
          ],
        ),
      ),
    );
  }
  clear(){
    NameController.clear();
    PhoneController.clear();
    arTitleController.clear();
    arDescriptionController.clear();
    setState(() {

    });
  }
  Future show_SuccessDialog({
    required BuildContext context,
  }) async {

    await showDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Color(0xff242424).withOpacity(0.5),
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              child:  Container(
                width: 314.w,
                height: 314.h,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(15)

                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Stack(
                      children: [
                        Image.asset(AppImages.win, color: Colors.white.withOpacity(0.3), colorBlendMode: BlendMode.modulate,),
                        Positioned(
                            bottom: 25.h,
                            right: 65.w,
                            child: Image.asset(AppImages.success_circle,)),
                      ],
                    ),


                    Text(
                      'send successfully'.tr,
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black_color),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      'send successfully subTitle'.tr,
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black_color),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),


                  ],
                ),

              ),

            );
          });
        });
  }


  Future show_ErrorDialog({
    required BuildContext context,
  }) async {

    await showDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Color(0xff242424).withOpacity(0.5),
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              child:  Container(
                width: 314.w,
                height: 314.h,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(15)

                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Stack(
                      children: [
                        Image.asset(AppImages.win, color: Colors.white.withOpacity(0.3), colorBlendMode: BlendMode.modulate,),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [ SizedBox(
                              height: 70.h,
                            ),
                              Image.asset(AppImages.error,width: 71.w,height: 71.h,),
                              SizedBox(
                                height: 40.h,
                              ),
                              Text(
                                'send failed'.tr,
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black_color),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                'send failed subTitle'.tr,
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.black_color),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),





                  ],
                ),

              ),

            );
          });
        });
  }
}

class profileTextField extends StatelessWidget {
  late String label;
  late String hint;
  late TextEditingController controller;
  late Function(String) onChanged;
  TextInputType textInputType = TextInputType.text;

  profileTextField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.onChanged,
    this.textInputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(AppImages.circle),
            SizedBox(
              width: 5.w,
            ),
            Text(
              label,
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black_color),
            ),
          ],
        ),
        SizedBox(
          height: 13.h,
        ),
        Container(
          height: 45.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.background_color),
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black_color,
              fontFamily: 'Cairo',
            ),
            keyboardType: textInputType,
            minLines: 1,
            maxLines: 1,
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
                fontFamily: 'Cairo',
              ),
              contentPadding: EdgeInsets.only(bottom: 5.h),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}
Widget float1() {
  return Container(
    child: FloatingActionButton(
      onPressed: null,
      heroTag: "btn1",
      tooltip: 'Email',
      child: Icon(Icons.email),
    ),
  );
}

Widget float2() {
  return Container(
    child: FloatingActionButton(
      onPressed: null,
      heroTag: "btn2",
      tooltip: 'Whatsapp',
      child: SvgPicture.asset(AppImages.whatsab),
      backgroundColor: AppColors.whatsabColor,
    ),
  );
}