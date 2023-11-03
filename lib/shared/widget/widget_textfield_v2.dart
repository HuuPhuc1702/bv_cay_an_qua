import 'package:flutter/material.dart';

///example
//        WidgetTextFieldV2(
//                 controller: TextEditingController(),
//                 hintText: "Nhập số điện thoại",
//               ),
class WidgetTextFieldV2 extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final bool? obscureText;
  final BorderRadiusGeometry ?borderRadius;
  final ValueChanged<String> ?onSubmitted;
  final TextEditingController ?controller;
  final int? maxLine;
  final int? minLine;
  final bool? enabled;
  final bool ?turnOffValidate;
  final TextInputType? keyboardType;
  final String ?helperText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? backgroundColor;
  final Function(String) ?onChange;
  final Function()? onTap;
  final EdgeInsetsGeometry ?padding;
  final bool ?autofocus;
  final BoxBorder ?border;

  WidgetTextFieldV2(
      {Key ?key,
      this.autofocus,
      this.borderRadius,
      this.labelText,
      this.onChange,
      this.onTap,
      this.backgroundColor,
      @required this.controller,
      this.hintText,
      this.enabled,
      this.turnOffValidate = true,
      this.onSubmitted,
      this.obscureText,
      this.maxLine,
      this.minLine,
      this.keyboardType,
      this.suffixIcon,
      this.prefixIcon,
      this.padding,
      this.border,
      this.helperText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String errorText = "";
    Color borderColor = Color(0xffD2D8CF);

    if ((controller?.text.isEmpty??false) && turnOffValidate == false) {
      errorText = errorText;
      borderColor = Colors.red;
    }

    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(30),
          
            // border: Border.all(color: borderColor),
            color: backgroundColor ?? const Color(0xFFA8D198)),
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          children: [
            prefixIcon ?? const SizedBox(),
            Expanded(
              child: TextField(
                controller: controller,
                enabled: enabled,
                autofocus: autofocus ?? false,
                obscureText: obscureText ?? false,
                style: TextStyle(fontSize: 16),
                keyboardType: keyboardType ?? TextInputType.text,
                maxLines: maxLine ?? 1,
                minLines: minLine ?? 1,
                onChanged: (value) {
                  onChange?.call(value);
                },
                onSubmitted: onSubmitted,
                onTap: () {
                  onTap?.call();
                },
                decoration: InputDecoration(
                  helperText: helperText,
                  // contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  isDense: true,
                  labelText: labelText,
                  labelStyle: TextStyle(fontSize: 16),
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                  hintText: hintText,
                ),
              ),
            ),
            suffixIcon ?? const SizedBox()
          ],
        ),
      ),
    );
  }
}
