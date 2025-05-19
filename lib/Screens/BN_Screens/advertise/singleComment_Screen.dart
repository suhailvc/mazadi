import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Controllers/GetxController/AdvertisementsController.dart';
import '../../../Controllers/GetxController/profileController.dart';
import '../../../Models/comments_Model.dart';
import '../../../Utils/AppColors.dart';
import '../../../Utils/Helper.dart';
import '../../../Utils/asset_images.dart';
import '../../../Utils/customElevatedButton.dart';

class singleComment_Screen extends StatefulWidget {
  late CommentData commentData;

  singleComment_Screen({required this.commentData});

  @override
  State<singleComment_Screen> createState() => _singleComment_ScreenState();
}

class _singleComment_ScreenState extends State<singleComment_Screen> {
  String commentTime(String time) {
    DateTime now = DateTime.now();
    DateTime dt1 = DateTime.parse(time);
    Duration diff = now.difference(dt1);

    if (diff.inDays > 0) {
      return 'since'.tr + diff.inDays.toString() + 'day'.tr;
    } else if (diff.inHours > 0) {
      return 'since'.tr + diff.inHours.toString() + 'hour'.tr;
    } else {
      return 'since'.tr + diff.inMinutes.toString() + 'minute'.tr;
    }
  }

  TextEditingController commentController = TextEditingController();
  var _advertisements_getxController =
      Get.find<Advertisements_GetxController>();
  var _profile_getxController = Get.find<profile_GetxController>();

  int commentTypeStatus =0;
  int commentID =0;

  @override
  void initState() {
    commentController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          tooltip: 'رجوع',
          icon: Icon(Icons.arrow_back, color: AppColors.lightgray_color),
        ),
        centerTitle: true,
      ),
      bottomSheet: Container(
          width: Get.width,
          height: 140.h,
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(5)),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black_color,
                  fontFamily: 'Cairo',
                ),
                minLines: 1,
                controller: commentController,
                maxLines: 3,
                onChanged: (x) {
                  setState(() {});
                },
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  hintText: 'write your comment here'.tr,
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
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GetX(builder: (Advertisements_GetxController adv_getx){
                    return   SizedBox(
                      height: 35.h,
                      width: 70.w,
                      child: customElevatedButton(
                        onTap: () async {
                          if (commentController.text.isNotEmpty) {
                            if(commentTypeStatus==0){
                              bool commentSaved = await _advertisements_getxController
                                  .addCommentReplay(
                                  comment_ID:
                                  widget.commentData!.id.toString(),
                                  Replay: commentController.text);
                              if (commentSaved) {
                                // widget.adv_model = await _advertisements_getxController.getAdvertisementByID(ID: widget.adv_model!.data.id.toString());

                                widget.commentData.replies.add(Replies(
                                    comment: commentController.text,
                                    createdAt: DateTime.now().toIso8601String(),
                                    user: _profile_getxController
                                        .profile_model!.data));

                                commentController.clear();

                                setState(() {});
                              } else {
                                Helper().show_Dialog(
                                    context: context,
                                    title: 'There is Error'.tr,
                                    img: AppImages.error,
                                    subTitle: 'Try Again'.tr);
                              }
                            }
                            else if(commentTypeStatus==1){
                              //----> comment edit

                              bool status =await  _advertisements_getxController.updateAdvertisementComment(Advertisement_ID: commentID.toString(), comment: commentController.text);
                              if(status){
                                widget.commentData.comment=commentController.text;
                                commentController.clear();
                                commentTypeStatus=0;
                                commentID=0;
                                setState(() {

                                });
                              }

                            }
                            else{
                              //----> reply edit

                              bool status =await  _advertisements_getxController.updateAdvertisementComment(Advertisement_ID: commentID.toString(), comment: commentController.text);
                              if(status){
                                int replyIndex=    widget.commentData.replies.indexWhere((element) => element.id==commentID);

                                widget.commentData.replies[replyIndex].comment=commentController.text;
                                commentController.clear();
                                commentTypeStatus=0;
                                commentID=0;
                                setState(() {

                                });
                              }

                            }




                          }
                        },
                        isLoading:  adv_getx. isAddingComment.value,
                        color: commentController.text.isNotEmpty
                            ? AppColors.main_color
                            : AppColors.gray_color,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'send'.tr,
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),


                  if(commentTypeStatus!=0)  SizedBox(width: 15.w,),

          if(commentTypeStatus!=0)        SizedBox(
                    height: 35.h,
                    width: 100.w,
                    child: customElevatedButton(
                      onTap: () async {
                        commentController.clear();
                        commentTypeStatus=0;
                        commentID=0;

                        setState(() {

                        });
                      },
                      color:  AppColors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'edit cancel'.tr,
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
      body: Padding(
        padding: EdgeInsets.only(top: 20.h, right: 20.w, left: 20.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'comments'.tr,
                    style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black_color),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,

                leading: Container(
                  clipBehavior: Clip.antiAlias,
                  height: 60.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: widget.commentData.user!.photo.toString(),
                  ),
                ),
                title: Row(
                  children: [
                    Text(
                      widget.commentData.user!.name.toString(),
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black_color),
                    ),
                    Spacer(),
                    Text(
                      widget.commentData.time.toString(),
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkgray_color),
                    ),
                    if (_profile_getxController.profile_model!.data.id ==
                        widget.commentData.user.id)
                      PopupMenuButton(
                        onSelected: (i) {
                          if (i == 2) {
                            Get.defaultDialog(
                              title: 'are you sure'.tr,
                              content: SizedBox(
                                height: 45.h,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () async {
                                        bool status =
                                            await _advertisements_getxController
                                                .deleteAdvertisementComment(
                                                    Advertisement_ID: widget
                                                        .commentData.id
                                                        .toString());
                                        if (status) {
                                          Get.back();
                                          Get.back();

                                          _advertisements_getxController
                                              .comments_model!.data
                                              .removeWhere((element) =>
                                                  element.id ==
                                                  widget.commentData.id);
                                          setState(() {});
                                        }
                                      },
                                      child: Text(
                                        'yes'.tr,
                                        style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.gray_color),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    VerticalDivider(),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text(
                                        'no'.tr,
                                        style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.gray_color),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              radius: 10,
                              titlePadding: EdgeInsets.all(15),
                            );
                          }else{
                            commentController.text =
                                widget.commentData.comment.toString();
                            print( widget.commentData.id);
                            commentTypeStatus=1;
                            commentID=widget.commentData!.id;

                            setState(() {

                            });
                          }
                        },
                        padding: EdgeInsets.zero,
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              value: 1,
                              onTap: () {

                              },
                              child: Text("edit".tr),
                            ),
                            PopupMenuItem(
                              value: 2,
                              onTap: () {},
                              child: Text("delete".tr),
                            ),
                          ];
                        },
                      ),
                  ],
                ),
                subtitle: Text(
                  widget.commentData.comment.toString(),
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkgray_color),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'replies'.tr,
                    style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black_color),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: widget.commentData!.replies.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 14.h,
                    );
                  },
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,

                      leading: Container(
                        clipBehavior: Clip.antiAlias,
                        height: 60.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:
                              widget.commentData!.replies[index].user!.photo ??
                                  '',
                        ),
                      ),
                      title: Row(
                        children: [
                          Text(
                            widget.commentData!.replies[index].user!.name ?? '',
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black_color),
                          ),
                          Spacer(),
                          Text(
                            commentTime(widget
                                .commentData!.replies[index].createdAt
                                .toString()),
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.darkgray_color),
                          ),
                          if (_profile_getxController.profile_model!.data.id ==
                              widget.commentData!.replies[index].user!.id)
                            PopupMenuButton(
                              onSelected: (i) {
                                if (i == 2) {
                                  Get.defaultDialog(
                                    title: 'are you sure'.tr,
                                    content: SizedBox(
                                      height: 45.h,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () async {
                                              bool status =
                                                  await _advertisements_getxController
                                                      .deleteAdvertisementComment(
                                                          Advertisement_ID:
                                                              widget
                                                                  .commentData!
                                                                  .replies[
                                                                      index]
                                                                  .id
                                                                  .toString());
                                              if (status) {
                                                Get.back();
                                                widget.commentData!.replies
                                                    .removeWhere((element) =>
                                                        element.id ==
                                                        widget.commentData!
                                                            .replies[index].id);
                                                setState(() {});
                                              }
                                            },
                                            child: Text(
                                              'yes'.tr,
                                              style: TextStyle(
                                                  fontFamily: 'Cairo',
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.gray_color),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15.w,
                                          ),
                                          VerticalDivider(),
                                          SizedBox(
                                            width: 15.w,
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text(
                                              'no'.tr,
                                              style: TextStyle(
                                                  fontFamily: 'Cairo',
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.gray_color),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    radius: 10,
                                    titlePadding: EdgeInsets.all(15),
                                  );
                                }else{
                                  commentController.text = widget.commentData!.replies[index].comment.toString();
                                  commentTypeStatus=2;
                                  commentID=widget.commentData!.replies[index].id;
                                  setState(() {

                                  });
                                }
                              },
                              padding: EdgeInsets.zero,
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    value: 1,
                                    onTap: () {},
                                    child: Text("edit".tr),
                                  ),
                                  PopupMenuItem(
                                    value: 2,
                                    onTap: () {},
                                    child: Text("delete".tr),
                                  ),
                                ];
                              },
                            ),
                        ],
                      ),
                      subtitle: Text(
                        widget.commentData!.replies[index].comment.toString(),
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.darkgray_color),
                      ),
                    );
                  }),
              if (widget.commentData!.replies.isEmpty)
                Text(
                  'No Replies yet'.tr,
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black_color),
                ),
              SizedBox(
                height: 200.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
