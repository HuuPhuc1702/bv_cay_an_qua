import 'package:bv_cay_an_qua/shared/widget/widget_image_network.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../export.dart';

class WidgetCircleAvatar extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final Function? onTap;
  final double? radius;
  final Color? borderColor;

  const WidgetCircleAvatar(
      {Key? key,
      this.url,
      this.height,
      this.width,
      this.onTap,
      this.radius,
      this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          border: Border.all(color: borderColor ?? ColorConst.borderInputColor),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: WidgetImageNetWork(
            height: this.height ?? MediaQuery.of(context).size.width / 5,
            width: this.width ?? MediaQuery.of(context).size.width / 5,
            url: url ?? "",
            fit: BoxFit.cover,
          ),
          // child: CachedNetworkImage(
          //   height: this.height ?? MediaQuery.of(context).size.width / 5,
          //   width: this.width ?? MediaQuery.of(context).size.width / 5,
          //   fit: BoxFit.cover,
          //   imageUrl: url??"",
          //   // imageUrl: url != null && url!.contains("http") ? url.toString() : "https://www.opti2020.eu/wp-content/themes/evolve/library/media/images/no-thumbnail.jpg",
          //   placeholder: (context, url) => Container(
          //       height: this.height ?? MediaQuery.of(context).size.width / 5,
          //       width: this.width ?? MediaQuery.of(context).size.width / 5,
          //       child: Center(
          //           child: CircularProgressIndicator(
          //         backgroundColor: Colors.red,
          //       ))),
          //   errorWidget: (context, url, error) => Image(
          //     height: this.height ?? MediaQuery.of(context).size.width / 5,
          //     width: this.width ?? MediaQuery.of(context).size.width / 5,
          //     image: AssetImage(AssetsConst.errorPlaceHolder),
          //     fit: BoxFit.cover,
          //   ),
          // ),
        ),
      ),
    );
  }
}
