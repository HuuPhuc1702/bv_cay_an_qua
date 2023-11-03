import 'package:bv_cay_an_qua/shared/helper/check_update_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../export.dart';
import 'controllers/auth_controller.dart';

class ChangePinPage extends StatefulWidget {
  const ChangePinPage({Key? key}) : super(key: key);

  @override
  _ChangePinPageState createState() => _ChangePinPageState();
}

class _ChangePinPageState extends State<ChangePinPage> {
  TextEditingController pinController = TextEditingController();

  late Size size;
  String pin = '';

  AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkUpdateApp(context);
    });
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
              children: [
                Column(
                  children: [
                    Image.asset(
                      AssetsConst.backgroundLogin,
                      width: size.width,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: TextField(
                        controller: pinController,
                        obscureText: true,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],
                        cursorColor: ColorConst.primaryColor,
                        style: StyleConst.mediumStyle(),
                        decoration: InputDecoration(
                          hintText: 'Nhập mã pin mới',
                          fillColor: ColorConst.primaryColor,
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                                color: ColorConst.primaryColor, width: 3),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: ColorConst.grey, width: 3),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            this.pin = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      width: size.width,
                      padding: EdgeInsets.only(top: 10.0),
                      child: Row(
                        children: [
                          Expanded(child: SizedBox()),
                          Opacity(
                              opacity: 1,
                              child: WidgetButton(
                                text: "Đổi mật khẩu".toUpperCase(),
                                textColor: Colors.white,
                                onTap: () {
                                  if (pin.length == 6)
                                    authController.changePin(
                                        context: context, pin: pin);
                                  else
                                    showSnackBar(
                                        title: "Thông báo",
                                        body: "Mật khẩu phải bao gồm 6 số");
                                },
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
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
}
