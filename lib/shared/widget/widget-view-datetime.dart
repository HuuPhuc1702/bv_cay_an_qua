import 'package:flutter/material.dart';
import '../../shared/util_convert/datetime_convert.dart';
import '../../export.dart';


class WidgetViewDateTime extends StatelessWidget {
  final DateTime? dateTime;
  final double? horizontal;
  final double? vertical;

  const WidgetViewDateTime(
      {Key? key, required this.dateTime, this.horizontal, this.vertical})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: horizontal ?? 5, vertical: vertical ?? 20),
      decoration: BoxDecoration(
          color: ColorConst.primaryColor.withOpacity(.15),
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(
          "${dateTimeConvertString(dateTime: dateTime!, dateType: "MMM\n dd")}",
          textAlign: TextAlign.center,
          style: StyleConst.boldStyle(
              color: ColorConst.primaryColor, fontSize: titleSize),
        ),
      ),
    );
  }
}
