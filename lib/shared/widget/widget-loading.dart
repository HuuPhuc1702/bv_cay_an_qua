import 'package:flutter/material.dart';
import '../../export.dart';

class WidgetLoading extends StatelessWidget {
  final bool notData;
  final int? count;
  final String? title;
  final String? titleNotData;

  const WidgetLoading(
      {Key? key,
      this.notData = false,
      this.title,
      this.titleNotData,
      this.count = 0})
      : super(key: key);

  getTextNotData() {
    if (count == 0) {
      return "Đang cập nhật...";
    }
    return "Hiện tại không còn dữ liệu để hiển thị.";
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: notData
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                titleNotData ?? getTextNotData(),
                style: StyleConst.mediumStyle(fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.0,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(ColorConst.primaryColor),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  title ?? "Đang tải...",
                  style: StyleConst.regularStyle(),
                ),
              ],
            ),
    );
  }
}
