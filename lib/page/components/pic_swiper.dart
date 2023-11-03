import 'dart:async';
import 'dart:math';

import 'package:bv_cay_an_qua/config/theme/color-constant.dart';
import 'package:extended_image/extended_image.dart';
import 'dart:ui';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/rendering.dart';

class PicSwiper extends StatefulWidget {
  final int index;
  final List pics;
  PicSwiper(this.index, this.pics);
  @override
  _PicSwiperState createState() => _PicSwiperState();
}

class _PicSwiperState extends State<PicSwiper>
    with SingleTickerProviderStateMixin {
  var rebuildIndex = StreamController<int>.broadcast();
  var rebuildSwiper = StreamController<bool>.broadcast();
  AnimationController? _animationController;
  Animation<double>? _animation;
  Function? animationListener;
//  CancellationToken _cancelToken;
//  CancellationToken get cancelToken {
//    if (_cancelToken == null || _cancelToken.isCanceled)
//      _cancelToken = CancellationToken();
//
//    return _cancelToken;
//  }
  List<double> doubleTapScales = <double>[1.0, 2.0];

  late int currentIndex;
  bool _showSwiper = true;

  @override
  void initState() {
    currentIndex = widget.index;
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 150), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    rebuildIndex.close();
    rebuildSwiper.close();
    _animationController?.dispose();
    clearGestureDetailsCache();
    //cancelToken?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Widget result = Material(

        /// if you use ExtendedImageSlidePage and slideType =SlideType.onlyImage,
        /// make sure your page is transparent background
        color: Colors.black,
        shadowColor: Colors.black,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            ExtendedImageGesturePageView.builder(
              itemBuilder: (BuildContext context, int index) {
                var item = widget.pics[index];
                Widget image = ExtendedImage.network(
                  item,
                  fit: BoxFit.contain,
                  enableSlideOutPage: true,
                  mode: ExtendedImageMode.gesture,
                  initGestureConfigHandler: (state) {
                    double initialScale = 1.0;

                    if (state.extendedImageInfo != null &&
                        state.extendedImageInfo?.image != null) {
                      initialScale = _initalScale(
                          size: size,
                          initialScale: initialScale,
                          imageSize: Size(
                              state.extendedImageInfo!.image.width.toDouble(),
                              state.extendedImageInfo!.image.height
                                  .toDouble()));
                    }
                    return GestureConfig(
                        inPageView: true,
                        initialScale: initialScale,
                        maxScale: max(initialScale, 5.0),
                        animationMaxScale: max(initialScale, 5.0),
                        //you can cache gesture state even though page view page change.
                        //remember call clearGestureDetailsCache() method at the right time.(for example,this page dispose)
                        cacheGesture: false);
                  },
                  onDoubleTap: (ExtendedImageGestureState state) {
                    ///you can use define pointerDownPosition as you can,
                    ///default value is double tap pointer down postion.
                    var pointerDownPosition = state.pointerDownPosition;
                    double begin = state.gestureDetails?.totalScale ?? 0.0;
                    double end;

                    //remove old
                    if (animationListener != null) {
                      _animation?.removeListener(animationListener?.call());
                    }

                    //stop pre
                    _animationController?.stop();

                    //reset to use
                    _animationController?.reset();

                    if (begin == doubleTapScales[0]) {
                      end = doubleTapScales[1];
                    } else {
                      end = doubleTapScales[0];
                    }

                    animationListener = () {
                      //print(_animation.value);
                      state.handleDoubleTap(
                          scale: _animation?.value,
                          doubleTapPosition: pointerDownPosition);
                    };
                    _animation = _animationController
                        ?.drive(Tween<double>(begin: begin, end: end));

                    _animation?.addListener(animationListener?.call());

                    _animationController?.forward();
                  },
                  // loadStateChanged: (ExtendedImageState state) {
                  //   switch (state.extendedImageLoadState) {
                  //     case LoadState.loading:
                  //       _animationController.reset();
                  //       return Container(
                  //         color: Colors.black,
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: <Widget>[
                  //             CircularProgressIndicator(
                  //                 backgroundColor: ptPrimaryColor(context).withOpacity(0.1),
                  //                 valueColor: AlwaysStoppedAnimation<Color>(ptPrimaryColor(context).withOpacity(0.3))),
                  //             Padding(
                  //               padding: EdgeInsets.only(left: 18.0),
                  //               child: JumpingText(
                  //                 'Đang tải...',
                  //                 style: ptSubtitle(context).copyWith(color: ptPrimaryColor(context)),
                  //               ),
                  //             ),
                  //             SizedBox(
                  //               width: 30,
                  //             )
                  //           ],
                  //         ),
                  //       );
                  //       break;
                  //     case LoadState.completed:
                  //       _animationController.forward();
                  //       return FadeTransition(
                  //         opacity: _animationController,
                  //         child:
                  //             // ZoomImageAsset(
                  //             //   imageProvider: NetworkImage(
                  //             //     item,
                  //             //     // width: ScaleUtil.instance.setWidth(600),
                  //             //     // height: ScaleUtil.instance.setWidth(400),
                  //             //   ),
                  //             // ),
                  //             ExtendedRawImage(
                  //           image: state.extendedImageInfo?.image,

                  //           width: ScaleUtil.instance.setWidth(600),
                  //           height: ScaleUtil.instance.setWidth(400),
                  //         ),
                  //       );
                  //       break;
                  //     case LoadState.failed:
                  //       _animationController.reset();
                  //       return GestureDetector(
                  //         child: Stack(
                  //           fit: StackFit.expand,
                  //           children: <Widget>[
                  //             Positioned(
                  //               bottom: 0.0,
                  //               left: 0.0,
                  //               right: 0.0,
                  //               child: Text(
                  //                 "Tải ảnh thất bại! Nhấn để thử lại",
                  //                 style: ptBody1(context),
                  //                 textAlign: TextAlign.center,
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //         onTap: () {
                  //           state.reLoadImage();
                  //         },
                  //       );
                  //       break;
                  //   }
                  // },
                );
                image = GestureDetector(
                  child: image,
                  onTap: () {
                    Navigator.pop(context);
                  },
                );

                if (index == currentIndex) {
                  return Hero(
                    tag: item + index.toString(),
                    child: image,
                  );
                } else {
                  return image;
                }
              },
              itemCount: widget.pics.length,
              onPageChanged: (int index) {
                currentIndex = index;
                rebuildIndex.add(index);
              },
              controller: PageController(
                initialPage: currentIndex,
              ),
              scrollDirection: Axis.horizontal,

              // physics: BouncingScrollPhysics(),

              // physics: ClampingScrollPhysics(),
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
            )
            // StreamBuilder<bool>(
            //   builder: (c, d) {
            //     if (d.data == null || !d.data) return Container();

            //     return Positioned(
            //       bottom: 0.0,
            //       left: 0.0,
            //       right: 0.0,
            //       child: MySwiperPlugin(widget.pics, currentIndex, rebuildIndex),
            //     );
            //   },
            //   initialData: true,
            //   stream: rebuildSwiper.stream,
            // )
          ],
        ));

    return ExtendedImageSlidePage(
      child: result,
      slideAxis: SlideAxis.both,
      slideType: SlideType.onlyImage,
      onSlidingPage: (state) {
        ///you can change other widgets' state on page as you want
        ///base on offset/isSliding etc
        //var offset= state.offset;
        var showSwiper = !state.isSliding;
        if (showSwiper != _showSwiper) {
          // do not setState directly here, the image state will change,
          // you should only notify the widgets which are needed to change
          // setState(() {
          // _showSwiper = showSwiper;
          // });

          _showSwiper = showSwiper;
          rebuildSwiper.add(_showSwiper);
        }
      },
    );
  }

  double _initalScale(
      {required Size imageSize,
      required Size size,
      required double initialScale}) {
    var n1 = imageSize.height / imageSize.width;
    var n2 = size.height / size.width;
    if (n1 > n2) {
      final FittedSizes fittedSizes =
          applyBoxFit(BoxFit.contain, imageSize, size);
      //final Size sourceSize = fittedSizes.source;
      Size destinationSize = fittedSizes.destination;
      return size.width / destinationSize.width;
    } else if (n1 / n2 < 1 / 4) {
      final FittedSizes fittedSizes =
          applyBoxFit(BoxFit.contain, imageSize, size);
      //final Size sourceSize = fittedSizes.source;
      Size destinationSize = fittedSizes.destination;
      return size.height / destinationSize.height;
    }

    return initialScale;
  }
}

// class MySwiperPlugin extends StatelessWidget {
//   final List<PicSwiperItem> pics;
//   final int index;
//   final StreamController<int> reBuild;
//   MySwiperPlugin(this.pics, this.index, this.reBuild);
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<int>(
//       builder: (BuildContext context, data) {
//         return DefaultTextStyle(
//           style: TextStyle(color: ptPrimaryColor(context)),
//           child: Container(
//             height: 50.0,
//             width: double.infinity,
//             color: Colors.grey.withOpacity(0.2),
//             child: Row(
//               children: <Widget>[
//                 Container(
//                   width: 10.0,
//                 ),
//                 Text(
//                   "${data.data + 1}",
//                 ),
//                 Text(
//                   " / ${pics.length}",
//                 ),
//                 Expanded(
//                     child: Text(pics[data.data].des ?? "",
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(fontSize: 16.0, color: ptPrimaryColor(context)))),
//                 Container(
//                   width: 10.0,
//                 ),
//                 GestureDetector(
//                   child: Container(
//                     padding: EdgeInsets.only(right: 10.0),
//                     alignment: Alignment.center,
//                     child: Text(
//                       "Save",
//                       style: TextStyle(fontSize: 16.0, color: ptPrimaryColor(context)),
//                     ),
//                   ),
//                   onTap: () {
//                     // saveNetworkImageToPhoto(pics[index].picUrl).then((bool done) {
//                     //   showToast(done ? "save succeed" : "save failed",
//                     //       position: ToastPosition(align: Alignment.topCenter));
//                     // });
//                   },
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//       initialData: index,
//       stream: reBuild.stream,
//     );
//   }
// }

class PicSwiperItem {
  String picUrl;
  // String des;
  // PicSwiperItem(this.picUrl, this.des);
  PicSwiperItem(this.picUrl);
}
