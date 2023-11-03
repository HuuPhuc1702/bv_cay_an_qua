import 'dart:ui';

import 'package:bv_cay_an_qua/config/theme/color-constant.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/rendering.dart';
import 'package:photo_view/photo_view.dart';

class ZoomImageAsset extends StatelessWidget {
  ZoomImageAsset({
    this.imageProvider,
  });

  final ImageProvider? imageProvider;

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: <Widget>[
      Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: PhotoView(
          imageProvider: imageProvider,
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 2,
        ),
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
    ]);
  }
}
