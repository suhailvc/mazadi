import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';




class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerItem({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  // late VideoPlayerController videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;

  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(
      widget.videoUrl,
    )..addListener(() => setState(() {}));
print(widget.videoUrl);
    _initializeVideoPlayerFuture = controller.initialize();

    print('Video ready');

    controller.play();
    controller.setLooping(true);


  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
        onTap: () {
          if (controller.value.isPlaying) {
            controller.pause();
          } else {
            controller.play();
          }
          setState(() {});
        },
        child: FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Stack(
                  children: [
                    Container(
                      // width: size.width,
                      // height: size.height,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                      ),
                      child: VideoPlayer(controller),
                    ),



                    if (!controller.value.isPlaying)
                      Center(
                        child: Center(
                            child: Icon(
                          Icons.play_arrow,
                          size: 80.spMin,
                          color: Colors.white.withOpacity(0.5),
                        )),
                      ),
                  ],
                );
              } else {

                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
