import 'dart:async';

import 'package:flutter/material.dart';
import '../../shared/widget/widget-combobox.dart';
import '../../export.dart';

///example
//        WidgetTextField(
//                 controller: TextEditingController(),
//                 hintText: "Nhập số điện thoại",
//               ),

class DropModel {
  List<FormComboBox>? listUnit;
  FormComboBox? unit;

  DropModel({this.listUnit, this.unit});
}

class WidgetTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final bool? obscureText;
  final ValueChanged<String>? onSubmitted;
  final TextEditingController controller;
  final bool? checkValidate;
  final int? maxLine;
  final int? maxLength;
  final int? minLine;
  final double? borderWith;
  final bool? enabled;
  final bool? turnOffValidate;
  final TextInputType? keyboardType;
  final String? helperText;
  final Function(String)? onChange;
  final DropModel? dropModel;
  final double? radius;
  final EdgeInsetsGeometry? padding;

  final ScrollController? scrollController;
  final FocusNode? focusNode;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final String? suffix;

  WidgetTextField(
      {Key? key,
      this.suffix,
      this.labelText,
      this.onChange,
      required this.controller,
      this.hintText,
      this.enabled,
      this.turnOffValidate,
      this.onSubmitted,
      this.obscureText,
      this.maxLine,
      this.maxLength,
      this.minLine,
      this.borderWith,
      this.keyboardType,
      this.dropModel,
      this.checkValidate,
      this.radius,
      this.scrollController,
      this.focusNode,
      this.padding,
      this.labelStyle,
      this.hintStyle,
      this.textStyle,
      this.helperText})
      : super(key: key);

  @override
  _WidgetTextFieldState createState() => _WidgetTextFieldState();
}

class _WidgetTextFieldState extends State<WidgetTextField> {
  Color borderColor = ColorConst.borderInputColor;

  GlobalKey globalKey = GlobalKey();
  FormComboBox? unit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if ((widget.dropModel?.listUnit?.length ?? 0) > 0) {
      unit = widget.dropModel!.listUnit!.first;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // widget.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double radius = 10.0;
    String errorText = "";
    // var _enabledBorder = OutlineInputBorder(
    //   borderSide: BorderSide(color: ColorConst.borderInputColor, width: 1.0),
    //   borderRadius: BorderRadius.circular(radius),
    // );
    // var _focusedBorder = OutlineInputBorder(
    //   borderSide: BorderSide(color: ColorConst.primaryColor, width: 1.0),
    //   borderRadius: BorderRadius.circular(radius),
    // );
    // print(" ${controller.text} - $checkValidate");
    if ((widget.controller.text.isEmpty || widget.checkValidate == false) &&
        widget.turnOffValidate == false) {
      errorText = errorText;
      borderColor = Colors.red;
      // _enabledBorder = OutlineInputBorder(
      //   borderSide: BorderSide(color: Colors.red, width: 1.0),
      //   borderRadius: BorderRadius.circular(radius),
      // );
      // _focusedBorder = OutlineInputBorder(
      //   borderSide: BorderSide(color: Colors.red, width: 1.0),
      //   borderRadius: BorderRadius.circular(radius),
      // );
    }
    return FocusScope(
        child: Focus(
            onFocusChange: (focus) async {
              setState(() {
                borderColor = focus
                    ? ColorConst.primaryColor
                    : ColorConst.borderInputColor;
              });
              await Future.delayed(Duration(milliseconds: 200), () {
                if (focus) {
                  if (context.findRenderObject() != null) {
                    widget.scrollController?.position.ensureVisible(
                      context.findRenderObject() ?? RenderObjectTemple(),
                      alignment: 0.0,
                      // How far into view the item should be scrolled (between 0 and 1).
                      duration: const Duration(milliseconds: 200),
                    );
                  }
                }
              });
            },
            child: Container(
              key: globalKey,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.radius ?? 10),
                  border: Border.all(
                      color: borderColor, width: widget.borderWith ?? 1.0),
                  color: Colors.white),
              // height: widget.maxLine == null ? 52 : null,
              padding: widget.padding ??
                  EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      focusNode: widget.focusNode,
                      controller: widget.controller,
                      enabled: widget.enabled,
                      obscureText: widget.obscureText ?? false,
                      style: widget.textStyle ??
                          StyleConst.mediumStyle(color: ColorConst.textPrimary),
                      keyboardType: widget.keyboardType ?? TextInputType.text,
                      maxLines: widget.maxLine ?? 1,
                      minLines: widget.minLine ?? 1,
                      maxLength: widget.maxLength,
                      onChanged: widget.onChange,
                      onSubmitted: this.widget.onSubmitted,
                      decoration: InputDecoration(
                          // enabledBorder: _enabledBorder,
                          // focusedBorder: _focusedBorder,
                          // disabledBorder: _enabledBorder,

                          // fillColor: Colors.white, filled: true,
                          suffixText: widget.suffix ?? "",
                          counterText: "",
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          helperText: widget.helperText,
                          border: InputBorder.none,
                          labelText: widget.labelText,
                          labelStyle:
                              widget.labelStyle ?? StyleConst.mediumStyle(),
                          hintStyle: widget.hintStyle ??
                              StyleConst.mediumStyle(color: ColorConst.grey),
                          hintText: widget.hintText),
                    ),
                  ),
                  Visibility(
                      visible: widget.dropModel?.listUnit != null,
                      child: Container(
                          padding: EdgeInsets.only(left: 5),
                          margin: EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                              border: Border(
                                  left: BorderSide(
                                      color: ColorConst.borderInputColor))),
                          child: dropFilter(
                              listData: widget.dropModel?.listUnit ?? [],
                              unit: unit,
                              style: widget.textStyle ??
                                  StyleConst.mediumStyle(
                                      color: ColorConst.textPrimary),
                              dataResult: (valueResult) {
                                // widget.unit = valueResult;
                                widget.dropModel?.unit = valueResult;
                                unit = valueResult;
                                setState(() {
                                  // print("widget.unit.title--${widget.unit?.title}");
                                  // widget.unit=valueResult;
                                });
                              })
                          // child: Text("xxx"),

                          ))
                ],
              ),
            )));
  }
}

Widget dropFilter(
    {required List<FormComboBox> listData,
    FormComboBox? unit,
    TextStyle? style,
    required Function(FormComboBox) dataResult}) {
  return DropdownButton<FormComboBox>(
    value: unit,
    isDense: true,
    icon: const Icon(
      Icons.arrow_drop_down_sharp,
      color: ColorConst.textPrimary,
    ),
    iconSize: titleSize,
    itemHeight: kMinInteractiveDimension,
    // elevation: 16,
    style: style ?? StyleConst.regularStyle(color: ColorConst.textPrimary),
    underline: Container(
      // height: 2,
      color: Colors.transparent,
    ),
    onChanged: (FormComboBox? newValue) {
      print("onChanged: ${newValue?.title}");
      unit = newValue;
      if (newValue != null) dataResult.call(newValue);
    },
    items: listData.map<DropdownMenuItem<FormComboBox>>((FormComboBox value) {
      return DropdownMenuItem<FormComboBox>(
        value: value,
        child: Text(
          value.title,
          style:
              style ?? StyleConst.regularStyle(color: ColorConst.textPrimary),
        ),
      );
    }).toList(),
  );
}

//
// class WidgetTextField extends StatelessWidget {
//   final String? labelText;
//   final String? hintText;
//   final bool? obscureText;
//   final ValueChanged<String>? onSubmitted;
//   final TextEditingController controller;
//   final int? maxLine;
//   final int? minLine;
//   final TextInputType? keyboardType;
//   final Function(String)? onChange;
//
//   const WidgetTextField(
//       {Key? key,
//       this.labelText,
//       required this.controller,
//       this.hintText,
//       this.onSubmitted,
//       this.obscureText,
//       this.maxLine,
//       this.minLine,
//       this.keyboardType,
//       this.onChange})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: (maxLine ?? 1) > 1 ? 10 : 0),
//       decoration: BoxDecoration(
//           color: Colors.transparent,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: ColorConst.borderInputColor, width: 1)),
//       child: TextField(
//         controller: controller,
//         obscureText: obscureText ?? false,
//         style: StyleConst.mediumStyle(),
//         maxLines: maxLine ?? 1,
//         minLines: minLine ?? 1,
//         onChanged: onChange,
//         keyboardType: keyboardType ?? TextInputType.text,
//         onSubmitted: this.onSubmitted,
//         decoration: InputDecoration(
//             contentPadding:
//                 EdgeInsets.only(left: 15, right: 15, bottom: -5, top: -5),
//             border: InputBorder.none,
//             labelText: labelText,
//             labelStyle: StyleConst.mediumStyle(),
//             hintStyle: StyleConst.mediumStyle(),
//             hintText: hintText),
//       ),
//     );
//   }
// }

class RenderObjectTemple extends RenderObject {
  @override
  void debugAssertDoesMeetConstraints() {
    // TODO: implement debugAssertDoesMeetConstraints
  }

  @override
  // TODO: implement paintBounds
  Rect get paintBounds => throw UnimplementedError();

  @override
  void performLayout() {
    // TODO: implement performLayout
  }

  @override
  void performResize() {
    // TODO: implement performResize
  }

  @override
  // TODO: implement semanticBounds
  Rect get semanticBounds => throw UnimplementedError();
}
