import 'package:flutter/material.dart';

///AppColor
const String appColor = "#19A611";
const String appColor2 = "#2D8D47";
const String appColorOrange = "#43c366";
const String appShadowColor = "#00000030";
const String appBorderColor = "#00000005";
const String appText = "#1D2226";
const String appText2 = "#8A9EAD";
const String appText60 = "#1D222660";
const String appWhite = "#FFFFFF";
const String appLine = "#EBEBEB";

Color ptPrimaryColor(BuildContext context) => Theme.of(context).primaryColor;
double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
double scaleWidth(BuildContext context) => MediaQuery.of(context).size.width / 375;
double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;


///FontStyle
class FONT {
  static const String Bold = "OpenSans-Bold";
  static const String BoldItalic = "OpenSans-BoldItalic";
  static const String ExtraBold = "OpenSans-ExtraBold";
  static const String ExtraBoldItalic = "OpenSans-ExtraBoldItalic";
  static const String Italic = "OpenSans-Italic";
  static const String Light = "OpenSans-Light";
  static const String LightItalic = "OpenSans-LightItalic";
  static const String Regular = "OpenSans-Regular";
  static const String SemiBold = "OpenSans-SemiBold";
  static const String SemiBoldItalic = "OpenSans-SemiBoldItalic";
}
