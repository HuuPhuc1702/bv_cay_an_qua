import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/widget/widget-textfield.dart';
import '../../export.dart';

import 'widget-button.dart';

class WidgetDialog extends StatelessWidget {
  final String? title;
  final String? body;
  final String? textButtonCancel;
  final String? textButtonSubmit;

  static eventShowDialog(
      {String? title, String? body, required BuildContext context,Function? callSuccess}) {
    showDialog(
        context: context,
        builder: (context) {
          return WidgetDialog(
            title: "$title",
            body: body,
            onConfirm: () async {
              callSuccess?.call();
            },
          );
        });
  }

  WidgetDialog(
      {Key? key,
      this.title,
      this.body,
      this.textButtonCancel,
      this.textButtonSubmit,
      required this.onConfirm})
      : super(key: key);
  final Function onConfirm;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: 16, vertical: kConstantPadding * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                title ?? "",
                style: StyleConst.boldStyle(
                    color: ColorConst.textPrimary, fontSize: titleSize),
                textAlign: TextAlign.center,

              ),
            ),
            SizedBox(height: 23,),
            Text(
              body ?? "",
              style: StyleConst.regularStyle(
                  color: ColorConst.textPrimary ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24,),
            Container(
              padding: EdgeInsets.all(kConstantPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: WidgetButton(
                    text: textButtonCancel ?? cancelDialog,
                    radiusColor: ColorConst.primaryColor,
                    textColor: ColorConst.primaryColor,
                    radius: 100,
                        backgroundColor: ColorConst.white,
                    onTap: () => Get.back(),
                  )),
                  SizedBox(
                    width: 20
                  ),
                  Expanded(
                    child: WidgetButton(
                      text: textButtonSubmit ?? acceptDialogText,
                      textColor: Colors.white,
                      radius: 100,
                      onTap: () {
                        Get.back();
                        onConfirm.call();
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class WidgetDialogEditText extends StatelessWidget {
  final String? title;
  final String? title2;
  TextEditingController textEditingController = TextEditingController();

  WidgetDialogEditText(
      {Key? key, required this.title, this.title2, required this.onConfirm})
      : super(key: key);
  final Function(String) onConfirm;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: kConstantPadding * 2, vertical: kConstantPadding * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                title ?? "",
                style: StyleConst.boldStyle(
                    color: ColorConst.textPrimary, fontSize: titleSize),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 0, left: 5, right: 5, bottom: 10),
              child: Text(
                title2 ?? "",
                style: StyleConst.regularStyle(color: ColorConst.textPrimary),
              ),
            ),
            WidgetTextField(
              controller: textEditingController,
              minLine: 5,
              maxLine: 5,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(kConstantPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: WidgetButton(
                    text: cancelDialog,
                    textColor: ColorConst.primaryColor,
                    backgroundColor: ColorConst.secondaryColor,
                    onTap: () => Get.back(),
                  )),
                  SizedBox(
                    width: kConstantPadding * 2,
                  ),
                  Expanded(
                    child: WidgetButton(
                      text: acceptDialogText,
                      onTap: () {
                        Get.back();
                        onConfirm.call(textEditingController.text);
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
