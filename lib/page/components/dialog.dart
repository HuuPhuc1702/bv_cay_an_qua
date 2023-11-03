import 'package:bv_cay_an_qua/config/theme/color-constant.dart';
import 'package:bv_cay_an_qua/config/theme/style-constant.dart';
import 'package:bv_cay_an_qua/shared/widget/widget-button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

Future<bool> showAlertDialog(BuildContext context, String errorMessage,
    {Function? confirmTap, String? confirmLabel, Widget? widgetChild}) async {
  Color primaryColor = Theme.of(context).primaryColor;
  return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          content: Text(errorMessage, style: TextStyle(fontSize: 18.0)),
          actions: <Widget>[
            widgetChild ??
                Row(
                  children: [
                    TextButton(
                        child: Text('Cancel',
                            style: TextStyle(color: primaryColor)),
                        onPressed: () => Navigator.pop(ctx, true)),
                    TextButton(
                        child: Text(confirmLabel != null ? confirmLabel : 'Ok',
                            style: TextStyle(color: primaryColor)),
                        onPressed: confirmTap != null
                            ? () {
                                confirmTap.call();
                                Navigator.pop(ctx, true);
                              }
                            : () => Navigator.pop(ctx, true)),
                  ],
                )
          ],
        );
      });
}

class GeneralDialog extends StatelessWidget {
  GeneralDialog({required this.onValueChanged, this.commentId});

  Function(Map<String, dynamic>) onValueChanged;
  String? commentId;

  int ratingTemp = -1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Đánh giá",
                  style:
                      StyleConst.mediumStyle(color: ColorConst.primaryColor)),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.clear, color: ColorConst.primaryColor))
            ],
          ),
          RatingBar.builder(
            initialRating: 0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            unratedColor: Colors.grey.withAlpha(50),
            itemCount: 5,
            itemSize: 30.0,
            itemPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            glowColor: Colors.yellow,
            onRatingUpdate: (rating) {
              print("yyyy");
              ratingTemp = rating.toInt();
            },
            tapOnlyMode: true,
            updateOnDrag: true,
          ),
          SizedBox(height: 10),
          WidgetButton(
            onTap: () {
              if (ratingTemp != -1) {
                Map<String, dynamic> map = {};
                map["rating"] = ratingTemp.toInt();
                if (commentId != null) {
                  map["commentId"] = commentId;
                  print("===== Rate for comment =====");
                } else
                  print("====== Rate for issue =====");
                Navigator.pop(context);
                onValueChanged.call(map);
              }
            },
            text: "Xác nhận",
            textColor: Colors.white,
            backgroundColor: ColorConst.primaryColor,
          )
        ],
      ),
      contentPadding: EdgeInsets.only(bottom: 20, top: 20, left: 20, right: 20),
    );
  }
}
