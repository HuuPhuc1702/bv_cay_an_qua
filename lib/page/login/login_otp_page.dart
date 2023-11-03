import 'dart:async';

import 'package:bv_cay_an_qua/page/login/controllers/auth_controller.dart';
import 'package:bv_cay_an_qua/services/firebase/firebase_auth.dart';
import 'package:bv_cay_an_qua/shared/helper/dialogs.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_otp_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../export.dart';

class LoginOTPPage extends StatefulWidget {
  final String phoneNumber;
  final bool isFb;

  const LoginOTPPage({Key? key, required this.phoneNumber, required this.isFb})
      : super(key: key);

  @override
  _LoginOTPPageState createState() => _LoginOTPPageState();
}

class _LoginOTPPageState extends State<LoginOTPPage> {
  late Size size;
  Timer? _timer;
  int _start = 0;
  String? stringOTP;
  AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      startTimer();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Image.asset(
                      AssetsConst.backgroundLogin,
                      width: size.width,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 8, bottom: 20, right: 20, left: 20),
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                                text:
                                    'Vui lòng nhập mã 6 số trong tin nhắn SMS mà chúng tôi vừa gửi qua số ',
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.black)),
                            TextSpan(
                                text: widget.phoneNumber,
                                style: StyleConst.boldStyle())
                          ])),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: WidgetOTPInput(
                    length: 6,
                    appContext: context,
                    onChange: (String value) {
                      stringOTP = value;
                    },
                    onSubmit: (String value) {
                      // Get.find<AuthController>()
                      //     .login(phone: widget.phone,code: value);
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: GestureDetector(
                    onTap: () async {
                      if (_start == 0) {
                        WaitingDialog.show(context);
                        await authController.requestOTP(
                            context: context, phoneNumber: widget.phoneNumber);
                        startTimer();
                        WaitingDialog.turnOff();
                      }
                    },
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Chưa nhận được? ',
                          style: StyleConst.regularStyle()),
                      TextSpan(
                          text: "Gửi lại ${_start > 0 ? _start : ""}",
                          style: StyleConst.boldStyle(
                            color: _start > 0
                                ? Colors.grey
                                : ColorConst.primaryColor,
                          ))
                    ])),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Row(
                    children: [
                      Expanded(
                          child: WidgetButton(
                        text: "Quay lại".toUpperCase(),
                        backgroundColor: Colors.white,
                        styleText: StyleConst.regularStyle(),
                        onTap: () {
                          Get.back();
                        },
                      )),
                      Expanded(
                          child: WidgetButton(
                        text: "Xác nhận".toUpperCase(),
                        textColor: Colors.white,
                        onTap: () {
                          // if (widget.isFb)
                          //   Get.find<AuthController>().loginConform(
                          //       phone: widget.phoneNumber,
                          //       code: stringOTP ?? "",
                          //       context: context);
                          // else
                          Get.find<AuthController>().userLoginWithOTP(
                              context: context,
                              phoneNumber: widget.phoneNumber,
                              otp: stringOTP ?? "");
                        },
                      )),
                    ],
                  ),
                ),
                Image.asset(
                  AssetsConst.backgroundBottomLogin,
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                  // height: 130,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void startTimer() {
    _start = ConfigFirebaseAuth.intent.timeOutSeconds;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
}
