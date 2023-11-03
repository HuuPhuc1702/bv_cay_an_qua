import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../export.dart';

class WidgetImageNetWork extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final Function? onTap;
  final BoxFit? fit;

  const WidgetImageNetWork(
      {Key? key, this.url, this.height, this.width, this.onTap, this.fit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url != null && url!.isNotEmpty && url != "null") {

      return CachedNetworkImage(
        height: this.height ?? MediaQuery.of(context).size.width / 5,
        width: this.width ?? MediaQuery.of(context).size.width / 5,
        fit: fit??BoxFit.cover,
        imageUrl: url??"",
        // imageUrl: url != null && url!.contains("http") ? url.toString() : "https://www.opti2020.eu/wp-content/themes/evolve/library/media/images/no-thumbnail.jpg",
        placeholder: (context, url) => Container(
            height: this.height ?? MediaQuery.of(context).size.width / 5,
            width: this.width ?? MediaQuery.of(context).size.width / 5,
            child: Center(
                child: CircularProgressIndicator(
                backgroundColor:
                    ColorConst.primaryColor.withOpacity(0.1),
                valueColor: AlwaysStoppedAnimation<Color>(
                    ColorConst.primaryColor.withOpacity(0.3))))),
        errorWidget: (context, url, error) =>
            Image(
              height: this.height ?? MediaQuery.of(context).size.width / 5,
              width: this.width ?? MediaQuery.of(context).size.width / 5,
              image: AssetImage(AssetsConst.errorPlaceHolder),
              fit: fit??BoxFit.cover,
            ),
      );

      // return Image(
      //   image: NetworkImage(url ?? ""),
      //   fit: BoxFit.cover,
      //   height: this.height ?? MediaQuery.of(context).size.width / 5,
      //   width: this.width ?? MediaQuery.of(context).size.width / 5,
      //   loadingBuilder: (BuildContext _context, Widget _widget,
      //       ImageChunkEvent? imageChunkEvent) {
      //     if (imageChunkEvent == null) return _widget;
      //     return Image(
      //       height: this.height ?? MediaQuery.of(context).size.width / 5,
      //       width: this.width ?? MediaQuery.of(context).size.width / 5,
      //       image: AssetImage(AssetsConst.errorPlaceHolder),
      //       fit:fit?? BoxFit.cover,
      //     );
      //   },
      //   errorBuilder:
      //       (BuildContext context, Object exception, StackTrace? stackTrace) {
      //     return Image(
      //       height: this.height ?? MediaQuery.of(context).size.width / 5,
      //       width: this.width ?? MediaQuery.of(context).size.width / 5,
      //       image: AssetImage(AssetsConst.errorPlaceHolder),
      //       fit: fit??BoxFit.cover,
      //     );
      //   },
      // );
    }
    return Image(
      height: this.height ?? MediaQuery.of(context).size.width / 5,
      width: this.width ?? MediaQuery.of(context).size.width / 5,
      image: AssetImage(AssetsConst.errorPlaceHolder),
      fit:fit?? BoxFit.cover,
    );
  }
}
