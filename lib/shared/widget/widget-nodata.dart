import 'package:flutter/material.dart';

import '../../config/theme/style-constant.dart';

class WidgetNoData extends StatelessWidget {
  final String? text;
  const WidgetNoData({Key? key,this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
         text?? "Không có dữ liệu",
          style: StyleConst.mediumStyle(),
        ),
      ),
    );
  }
}
