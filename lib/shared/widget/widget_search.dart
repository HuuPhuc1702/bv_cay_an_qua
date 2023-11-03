import 'package:flutter/material.dart';
import '../../export.dart';

class WidgetSearch extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final bool? obscureText;
  final ValueChanged<String>? onSubmitted;
  final TextEditingController controller;
  final bool? checkValidate;
  final int? maxLine;
  final int? minLine;
  final bool? enabled;
  final bool? turnOffValidate;
  final TextInputType? keyboardType;
  final String? helperText;
  final Function(String)? onChange;

  const WidgetSearch(
      {Key? key,
      this.labelText,
      this.onChange,
      required this.controller,
      this.hintText,
      this.enabled,
      this.turnOffValidate,
      this.onSubmitted,
      this.obscureText,
      this.maxLine,
      this.minLine,
      this.keyboardType,
      this.checkValidate,
      this.helperText})
      : super(key: key);

  @override
  _WidgetSearchState createState() =>
      _WidgetSearchState(controller: this.controller);
}

class _WidgetSearchState extends State<WidgetSearch> {
  final TextEditingController controller;

  _WidgetSearchState({required this.controller});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("widget.controller ${controller.text}");

    return Container(
      padding: EdgeInsets.all(4),
      //decoration: BoxDecoration(
          //borderRadius: BorderRadius.circular(100),
          //color: Colors.white,
          //border: Border.all(color: ColorConst.borderInputColor)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              enabled: widget.enabled,
              obscureText: widget.obscureText ?? false,
              style: StyleConst.mediumStyle(color: Color(0xfffd9e2d7)),
              keyboardType: widget.keyboardType ?? TextInputType.text,
              maxLines: widget.maxLine ?? 1,
              minLines: widget.minLine ?? 1,
              onChanged: (value) {
                widget.onChange?.call(value);
                setState(() {});
              },
              onSubmitted: this.widget.onSubmitted,
              decoration: InputDecoration(
                  isDense: true,
                  helperText: widget.helperText,
                  contentPadding:
                      EdgeInsets.only(left: 10, top: 0, bottom: 0, right: 10),
                  border: InputBorder.none,
                  labelText: widget.labelText,
                  labelStyle: StyleConst.mediumStyle(color: Color(0xfffd9e2d7)),
                  hintStyle: StyleConst.mediumStyle(color: Color(0xfffd9e2d7)),
                  hintText: widget.hintText),
            ),
          ),
          Visibility(
              visible: controller.text.isNotEmpty,
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      controller.clear();
                    });
                    widget.onSubmitted?.call(controller.text);
                  },
                  child: Icon(
                    Icons.cancel,
                    size: titleSize * 1.5,
                    color: Colors.white70,
                  ))),
          SizedBox(
            width: 10,
          ),
          // GestureDetector(
          //   onTap: () {
          //     this.widget.onSubmitted?.call(controller.text);
          //   },
          //   child: Container(
          //     padding:
          //         EdgeInsets.only(left: 21, right: 21.5, top: 6, bottom: 6),
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(100),
          //         color: ColorConst.primaryColor),
          //     child: 
          //     Icon(Icons.search, color: Colors.white)
          //     // ImageIcon(
          //     //   AssetImage(AssetsConst.iconSearch),
          //     //   color: ColorConst.white,
          //     //   size: 20,
          //     // ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
