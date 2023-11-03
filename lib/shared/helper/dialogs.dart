import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../config/theme/color-constant.dart';
import '../../config/theme/style-constant.dart';

class WaitingDialog {
  static BuildContext? _buildContext;

  static void turnOff() {
    try {
      if (_buildContext != null) {
        Navigator.of(_buildContext!).pop();
        _buildContext = null;
      }
    } catch (error) {
      print("WaitingDialog----$error");
    }
  }

  static void show(BuildContext context, {String? message}) {
    _buildContext = context;
    showDialog(
        context: _buildContext!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final spinkit = Center(child: CircularProgressIndicator());
          // final spinkit = SpinKitCircle(
          //   color: ColorConst.primaryColor,
          //   size: 50.0,
          // );
          return AlertDialog(
//          width: 300.0,
//          height: 300.0,
              backgroundColor: Colors.white,
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // CircularProgressIndicator(
                  //     backgroundColor: ColorConst.backgroundColor,
                  //     value: .1,
                  //     strokeWidth: 3,
                  //     valueColor: AlwaysStoppedAnimation(
                  //       ColorConst.primaryColor,
                  //     )),
                  // CircularProgressIndicator(
                  //     valueColor: AlwaysStoppedAnimation<Color>(
                  //         Theme.of(context).primaryColor)),
                  spinkit,
                  Padding(
                      padding: EdgeInsets.only(top: 18.0),
                      child: Text(
                        message ?? 'Đang xử lý ...',
                        style: StyleConst.regularStyle(),
                      ))
                ],
              ));
        });
  }
}
