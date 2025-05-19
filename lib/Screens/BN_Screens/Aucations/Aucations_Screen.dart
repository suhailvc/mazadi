
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mazzad/Database/SharedPreferences/shared_preferences.dart';
import 'package:mazzad/Utils/Helper.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Controllers/GetxController/AucationsController.dart';
import '../../../Controllers/GetxController/drawerController.dart';
import '../../../Models/singleAucationCategory_Model.dart';
import '../../../Utils/AppColors.dart';
import '../../../Utils/asset_images.dart';
import 'AucationsByCategory_Screen.dart';


class Aucations_Screen extends StatefulWidget {
  const Aucations_Screen({Key? key}) : super(key: key);

  @override
  State<Aucations_Screen> createState() => _Aucations_ScreenState();
}

class _Aucations_ScreenState extends State<Aucations_Screen> {


  // Aucations_GetxController aucations_getxController =Get.put(Aucations_GetxController());
  MyDrawerController _drawerController =Get.put(MyDrawerController());
  var  aucations_getxController = Get.find<Aucations_GetxController>();


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      onRefresh: ()async{
        aucations_getxController.getCategories();
        // aucations_getxController.getMyWaitingAuctions();
        // aucations_getxController.getMyAuctions();


      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.white,
            elevation: 0.2,
            centerTitle: true,
            leading: IconButton(
                icon: SvgPicture.asset(AppImages.drawer),
                onPressed: () {
                  _drawerController.toggleDrawer();
                }),
            title: Text(
              'Aucations'.tr,
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black_color),
            ),

          ),

        body:Padding(
          padding:  EdgeInsets.only(
            top: 35.h,
            right: 10.w,
            left: 10.w
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(

                  width: width,
                  child: GetX<Aucations_GetxController>(
                  builder: ( Aucations_GetxController controller){
                return controller.isLoading.isTrue ?
                GridView.builder(
                    shrinkWrap: true,
                    // scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: 8,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 203.h,
                        childAspectRatio: 203 / 170,
                        crossAxisSpacing: 15.w,
                        mainAxisSpacing: 15.h,
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return Container(
                        height: 203.h,
                        width: 170.w,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),color: AppColors.main_color.withOpacity(0.9)



                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Shimmer.fromColors(
                                baseColor:  Colors.grey.shade300,
                                highlightColor: Colors.grey.shade200,
                                child: Container(
                                  width: width,
                                  height: 154.h,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(10),

                                  ),
                                )

                            ),

                            SizedBox(height: 10.h,),
                            Shimmer.fromColors(
                                baseColor:  Colors.grey.shade300,
                                highlightColor: Colors.grey.shade200,
                                child: Container(
                                  width: 120.w,
                                  height: 10.h,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                )

                            ),
                            SizedBox(height: 5.h,),

                            Shimmer.fromColors(
                                baseColor:  Colors.grey.shade300,
                                highlightColor: Colors.grey.shade200,
                                child: Container(
                                  width: 90.w,
                                  height: 10.h,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                )

                            ),


                          ],
                        ),

                      );
                    }):

                GridView.builder(
                    shrinkWrap: true,
                    // scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: controller.category_model!.data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 203.h,
                        childAspectRatio: 203 / 170,
                        crossAxisSpacing: 15.w,
                        mainAxisSpacing: 15.h,
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: ()async{

    if(await Helper().checkInternet()){

    aucations_getxController.getCategoryBYID(ID:controller.category_model!.data[index].id.toString() );


                       Get.to(AucationsByCategory_Screen(categoryName:
                       SharedPreferencesController().languageCode=='en'?
                       controller.category_model!.data[index].name: controller.category_model!.data[index].name_ar,));





                        }
    else{
      Helper().show_Dialog(
          context: context,
          title: 'No Internet'.tr,
          img: AppImages.no_internet,
          subTitle: 'Try Again'.tr);
    }
                        },
                        child: Container(
height: 203.h,
                          width: 170.w,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: AppColors.main_color,
                            borderRadius: BorderRadius.circular(10)


                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CachedNetworkImage(
                                fit: BoxFit.cover,
                                height: 154.h,
                                imageUrl: controller.category_model!.data[index].icon,
                             ),
                              SizedBox(height: 10.h,),
                              Text(
                                SharedPreferencesController().languageCode=='en'?
                                controller.category_model!.data[index].name: controller.category_model!.data[index].name_ar,
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white),
                              ),


                            ],
                          ),

                        ),
                      );
                    });
                  })),
                SizedBox(height: 50.h,),
              ],
            ),
          ),

        )
      ),
    );
  }
}
