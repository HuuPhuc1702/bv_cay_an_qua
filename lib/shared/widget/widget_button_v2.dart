import 'package:flutter/material.dart';

class WidgetButtonV2 extends StatelessWidget {
  final String? title;
  final Function? callBack;
  final EdgeInsetsGeometry? padding;
  final double? width;

  WidgetButtonV2({Key? key, this.title, this.callBack,this.padding,this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).pop();
        callBack?.call();
      },
      child: Container(
        padding:padding?? EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          gradient: LinearGradient(
              colors: [
                const Color(0xFF0ca711),
                const Color(0xFF41de46),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Center(
          child: Text(
            title ?? "",
            textAlign:TextAlign.center ,
          
          ),
        ),
      ),
    );
  }
}
