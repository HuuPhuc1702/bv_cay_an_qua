import 'package:bv_cay_an_qua/shared/helper/check_update_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../export.dart';
import 'controllers/auth_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController phoneController = TextEditingController();

  late Size size;
  String phone = '';

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
                        controller: phoneController,
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
                          hintText: 'Số điện thoại đăng ký',
                          // hintStyle: ptTitle(context).copyWith(),
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
                            this.phone = value;
                          });
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showNow();
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: RichText(
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(children: [
                              TextSpan(
                                text: 'Tôi đồng ý với ',
                                style: StyleConst.regularStyle(),
                              ),
                              TextSpan(
                                text: "điều kiện và điều khoản sử dụng",
                                style: StyleConst.regularStyle(
                                    color: ColorConst.primaryColor
                                        .withOpacity(.6)),
                              ),
                              TextSpan(
                                text: ' của ',
                                style: StyleConst.regularStyle(),
                              ),
                              TextSpan(
                                text: "Bệnh viện cây ăn quả",
                                style: StyleConst.regularStyle(
                                    color: ColorConst.primaryColor
                                        .withOpacity(.6)),
                              ),
                            ])),
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
                              opacity:
                                  phoneController.text.length < 9 ? 0.5 : 1,
                              child: WidgetButton(
                                text: "Đăng ký".toUpperCase(),
                                textColor: Colors.white,
                                onTap: () {
                                  authController.requestOTP(
                                      context: context, phoneNumber: phone);
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

  showNow() {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black12.withOpacity(0.6),
      // background color
      barrierDismissible: false,
      // should dialog be dismissed when tapped outside
      barrierLabel: "Dialog",
      // label for barrier
      transitionDuration: Duration(milliseconds: 400),
      // how long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // your widget implementation
        return Container(
          width: size.width,
          height: size.height,
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        top: kToolbarHeight / 2, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Điều kiện và điều khoản sử dụng ',
                            style: StyleConst.boldStyle(),
                            softWrap: true,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white54,
                            child: Icon(
                              Icons.close,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 16,
                          ),
                          Image.asset(
                            "assets/pdf/page1.jpg",
                            fit: BoxFit.contain,
                            width: size.width,
                          ),
                          Image.asset(
                            "assets/pdf/page2.jpg",
                            fit: BoxFit.contain,
                            width: size.width,
                          ),
                          Image.asset(
                            "assets/pdf/page3.jpg",
                            fit: BoxFit.contain,
                            width: size.width,
                          ),
                          Image.asset(
                            "assets/pdf/page4.jpg",
                            fit: BoxFit.contain,
                            width: size.width,
                          ),
                          Image.asset(
                            "assets/pdf/page5.jpg",
                            fit: BoxFit.contain,
                            width: size.width,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
