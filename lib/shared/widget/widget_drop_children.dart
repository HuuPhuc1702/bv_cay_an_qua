import 'package:flutter/material.dart';

import '../../export.dart';

class WidgetDropChildren extends StatefulWidget {
  final String title;
  final TextStyle? styleTitle;

  final Widget? iconDrop;
  final Widget? iconUp;
  final Widget child;
  final EdgeInsetsGeometry? paddingTitle;

  const WidgetDropChildren(
      {Key? key,
      required this.title,
      required this.child,
      this.iconDrop,
      this.iconUp,
      this.paddingTitle,
      this.styleTitle})
      : super(key: key);

  @override
  _WidgetDropChildrenState createState() => _WidgetDropChildrenState();
}

class _WidgetDropChildrenState extends State<WidgetDropChildren> {
  Widget? icon;

  bool isShowDetail = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  changeIcon() {
    if (!isShowDetail) {
      icon = widget.iconDrop ?? Icon(Icons.keyboard_arrow_down_outlined);
    } else {
      icon = widget.iconUp ?? Icon(Icons.keyboard_arrow_up_outlined);
    }
  }

  @override
  Widget build(BuildContext context) {
    changeIcon();

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isShowDetail = !isShowDetail;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: ColorConst.primaryColor.withOpacity(.3),
            ),
            padding: widget.paddingTitle ?? EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                icon ?? SizedBox.shrink(),
                SizedBox(width: 16,),
                Text("${widget.title}",
                    style: widget.styleTitle ??
                        StyleConst.regularStyle(fontSize: titleSize)),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Visibility(
          visible: isShowDetail,
          child: widget.child,
        ),
        Visibility(
            visible: isShowDetail,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Divider(
                height: 2,
                color: ColorConst.borderInputColor,
              ),
            )),
      ],
    );
  }
}
