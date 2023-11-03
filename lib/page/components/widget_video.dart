import 'dart:io';

import 'package:bv_cay_an_qua/services/files/path_file_local.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../export.dart';

class WidgetVideo extends StatefulWidget {
  final String url;
  final double size;
  final bool isRemove;

  WidgetVideo(
      {Key? key, required this.url, this.size = 50, this.isRemove = false})
      : super(key: key);

  @override
  _WidgetVideoState createState() => _WidgetVideoState();
}

class _WidgetVideoState extends State<WidgetVideo> {
  String? fileName;

  @override
  void initState() {
    super.initState();
    thumbnailVideo();
  }

  thumbnailVideo() async {
    try {
      String? pathFile =
          (await PathFileLocals().getPathLocal(ePathType: EPathType.Cache))
              ?.path;

      fileName = (await VideoThumbnail.thumbnailFile(
            video: widget.url,
            thumbnailPath: pathFile,
            imageFormat: ImageFormat.JPEG,
            maxHeight: 64,
            // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
            quality: 75,
          )) ??
          "";
      setState(() {});
    } catch (error) {
      fileName = "";
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isRemove == false
          ? () {
              Get.to(VideoApp(
                link: widget.url,
              ));
            }
          : null,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: ColorConst.primaryColor.withOpacity(0.5),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          border: Border.all(
              color: ColorConst.borderInputColor), /*HexColor('#fafafa')*/
        ),
        child: fileName == null
            ? Center(
                child: CircularProgressIndicator(
                backgroundColor: Colors.red,
              ))
            : Stack(
                alignment: Alignment.bottomCenter,
                // overflow: Overflow.clip,
                fit: StackFit.expand,
                children: <Widget>[
                  fileName != null && fileName!.isNotEmpty
                      ? Stack(
                          children: [
                            Center(child: Image.file(File(fileName!))),
                            Center(
                              child: Icon(
                                Icons.video_collection_outlined,
                                color: ColorConst.primaryColor,
                                size: 30,
                              ),
                            )
                          ],
                        )
                      : Icon(
                          Icons.video_collection_outlined,
                          size: widget.size / 1.5,
                        ),
                  widget.isRemove
                      ? Container(
                          width: widget.size,
                          height: widget.size,
                          decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                            border: Border.all(
                                color: ColorConst
                                    .borderInputColor), /*HexColor('#fafafa')*/
                          ),
                          child: Center(
                            child: Icon(
                              Icons.remove_circle,
                              size: widget.size * 0.3,
                              color: Colors.redAccent,
                            ),
                          ),
                        )
                      : SizedBox()
                ],
              ),
      ),
    );
  }
}

class VideoApp extends StatefulWidget {
  final String link;

  const VideoApp({Key? key, required this.link}) : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    if (widget.link.contains("http")) {
      _controller = VideoPlayerController.network(widget.link)
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        })
        ..addListener(() {
          if (_controller.value.isPlaying == false) {
            setState(() {});
          }
        });
    } else {
      _controller = VideoPlayerController.file(File(widget.link))
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        })
        ..addListener(() {
          if (_controller.value.isPlaying == false) {
            setState(() {});
          }
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Center(
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Container(),
            ),
            Positioned(
              top: 30,
              left: 15,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    color: ColorConst.primaryColor),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.7),
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: ColorConst.primaryColor,
                    size: 50,
                  ),
                ),
              ),
            )
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.white,
        //   onPressed: () {
        //     setState(() {
        //       _controller.value.isPlaying
        //           ? _controller.pause()
        //           : _controller.play();
        //     });
        //   },
        //   child: Icon(
        //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        //     color: ColorConst.primaryColor,
        //   ),
        // ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
