import 'package:flutter/material.dart';
import '../../export.dart';


class WidgetButton extends StatelessWidget {
  final String text;
  final Function? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? radiusColor;
  final double? widthRadius;
  final double? radius;

  final TextStyle? styleText;
  // final double? height;
  final double? paddingBtnWidth;
  final double? paddingBtnHeight;

  const WidgetButton({
    Key? key,
    required this.text,
    this.onTap,
    this.backgroundColor,
    this.textColor,
    this.widthRadius,
    this.radius,
    this.styleText,
    // this.height,
    this.paddingBtnWidth,
    this.paddingBtnHeight,
    this.radiusColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(),
      child: Container(
        // height: height ?? 40,
        padding: EdgeInsets.symmetric(
            vertical: paddingBtnHeight ?? 15,
            horizontal: paddingBtnWidth ?? 15),
        decoration: BoxDecoration(
            // border: Border.all(color: radiusColor ?? ColorConst.primaryColor),
            border: Border.all(color: radiusColor ?? Colors.transparent,width: widthRadius??2),
            borderRadius: BorderRadius.circular(radius ?? 10.0),
            color: backgroundColor ?? ColorConst.primaryColor,
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                backgroundColor ?? ColorConst.primaryColor,
                backgroundColor ?? ColorConst.primaryColor,
              ],
            )),

        child: Center(
          child: Text(
            text.toUpperCase(),
            style: styleText??StyleConst.boldStyle(color: textColor ?? ColorConst.textPrimary),
            // style: StyleConst.boldStyle(color:  ColorConst.textPrimary),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
