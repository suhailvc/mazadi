import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'Video_Player_item.dart';

class singleAttachment_Screen extends StatefulWidget {
  late String attachment;
  late String attachmentVideo;
  late String attachmentType;
  late bool isFromNetWork;

  singleAttachment_Screen({
    required this.attachment,
    required this.attachmentType,
    required this.attachmentVideo,
    this.isFromNetWork = true,
  });

  @override
  State<singleAttachment_Screen> createState() =>
      _singleAttachment_ScreenState();
}

class _singleAttachment_ScreenState extends State<singleAttachment_Screen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: widget.isFromNetWork
          ? Center(
              child: widget.attachmentType == 'image'
                  ? CachedNetworkImage(
                      imageUrl: widget.attachment,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress)),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )
                  : VideoPlayerItem(
                      videoUrl: widget.attachmentVideo,
                    ),
            )
          : Center(
              child: widget.attachmentType == 'image'
                  ? Image.file(File(widget.attachment), fit: BoxFit.cover)
                  : VideoPlayerItem(
                      videoUrl: widget.attachmentVideo,
                    ),
            ),
    );
  }
}
