import 'package:bv_cay_an_qua/config/theme/color-constant.dart';
import 'package:bv_cay_an_qua/export.dart';
import 'package:bv_cay_an_qua/page/issue/input_issue_page.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

AppBar buildAppBar(BuildContext context,
    {required String title, bool? doubleBack}) {
  return AppBar(
    leading: BackIconButton(doubleBack: doubleBack),
    actions: <Widget>[
      NewQuestionButton(),
    ],
    brightness: Brightness.light,
    title: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('${title}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: StyleConst.boldStyle(
                color: ColorConst.red, fontSize: titleSize))
      ],
    ),
    elevation: 2,
    backgroundColor: Colors.white,
    bottom: PreferredSize(
        child: Container(
          height: 8,
        ),
        preferredSize: Size.fromHeight(8)),
  );
}

class NewQuestionButton extends StatelessWidget {
  const NewQuestionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(InputIssuePage());
      },
      child: Padding(
        padding: EdgeInsets.all(3),
        child: ExtendedImage.asset(
          "assets/images/question.png",
        ),
      ),
    );
  }
}

class BackIconButton extends StatelessWidget {
  final bool? doubleBack;
  const BackIconButton({Key? key, this.doubleBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (doubleBack == true) Navigator.pop(context);
        Navigator.pop(context);
      },
      child: Padding(
        padding: EdgeInsets.all(14.0),
        child: Image.asset(
          "assets/images/ic_back.png",
          fit: BoxFit.cover,
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}
