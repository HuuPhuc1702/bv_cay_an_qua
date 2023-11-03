import '../../export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar(
    {required String title,
    required String body,
    Color? color,
    Color? backgroundColor,
    int? seconds,
    Function(GetBar<Object>)? onTap}) {
  Get.snackbar(
    title,
    body,
    onTap: onTap,
    snackPosition: SnackPosition.TOP,
    backgroundColor: backgroundColor ?? ColorConst.primaryColor.withOpacity(.8),
    colorText: color ?? ColorConst.white,
    duration: Duration(seconds: seconds??3),
  );
}
