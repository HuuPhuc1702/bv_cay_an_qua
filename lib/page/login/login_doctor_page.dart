import 'package:bv_cay_an_qua/page/components/dialog.dart';
import 'package:bv_cay_an_qua/shared/helper/check_update_app.dart';
import 'package:bv_cay_an_qua/shared/widget/widget-combobox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../export.dart';
import 'controllers/auth_controller.dart';

class LoginDoctorPage extends StatefulWidget {
  const LoginDoctorPage({Key? key}) : super(key: key);

  @override
  _LoginDoctorPageState createState() => _LoginDoctorPageState();
}

class _LoginDoctorPageState extends State<LoginDoctorPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late Size size;
  final focus = FocusNode();
  AuthController authController = Get.find<AuthController>();
  late DropModel dropModel;
  List<FormComboBox> listDrop = [
    FormComboBox(title: "@gmail.com", key: "@gmail.com", id: "email"),
    FormComboBox(title: "@loctroi.vn", key: "@loctroi.vn", id: "loctroi"),
    FormComboBox(title: "khác", key: "", id: "khac"),
  ];

  @override
  void initState() {
    super.initState();
    dropModel = DropModel(listUnit: listDrop, unit: listDrop.first);
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

                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: new WidgetTextField(
                        controller: emailController,
                        hintText: "Tài khoản",
                        textStyle: StyleConst.mediumStyle(
                            color: ColorConst.textPrimary),
                        dropModel: dropModel,
                        onChange: (value) {
                          setState(() {});
                        },
                        borderWith: 3,
                      ),
                    ),

                    // Container(
                    //   margin: EdgeInsets.symmetric(horizontal: 20),
                    //   padding:
                    //       EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    //   child: TextField(
                    //     controller: emailController,
                    //     keyboardType: TextInputType.emailAddress,
                    //     maxLines: 1,
                    //     textAlign: TextAlign.center,
                    //     cursorColor: ColorConst.primaryColor,
                    //     style: StyleConst.mediumStyle(),
                    //     decoration: InputDecoration(
                    //       hintText: 'Email',
                    //       // hintStyle: ptTitle(context).copyWith(),
                    //       fillColor: ColorConst.primaryColor,
                    //       focusedBorder: OutlineInputBorder(
                    //         borderRadius:
                    //             BorderRadius.all(Radius.circular(10.0)),
                    //         borderSide: BorderSide(
                    //             color: ColorConst.primaryColor, width: 3),
                    //       ),
                    //       enabledBorder: OutlineInputBorder(
                    //         borderRadius:
                    //             BorderRadius.all(Radius.circular(10.0)),
                    //         borderSide:
                    //             BorderSide(color: ColorConst.grey, width: 3),
                    //       ),
                    //     ),
                    //     onSubmitted: (String value) {
                    //       FocusScope.of(context).requestFocus(focus);
                    //     },
                    //     onChanged: (value) {
                    //       setState(() {});
                    //     },
                    //   ),
                    // ),

                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: new WidgetTextField(
                        controller: passwordController,
                        hintText: "Mật khẩu",
                        textStyle: StyleConst.mediumStyle(
                            color: ColorConst.textPrimary),
                        onChange: (value) {
                          setState(() {});
                        },
                        obscureText: true,
                        borderWith: 3,
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.symmetric(horizontal: 20),
                    //   padding:
                    //       EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    //   child: TextField(
                    //     controller: passwordController,
                    //     focusNode: focus,
                    //     maxLines: 1,
                    //     obscureText: true,
                    //     textAlign: TextAlign.center,
                    //     cursorColor: ColorConst.primaryColor,
                    //     keyboardType: TextInputType.visiblePassword,
                    //     style: StyleConst.mediumStyle(),
                    //     decoration: InputDecoration(
                    //       hintText: 'Mật khẩu',
                    //       // hintStyle: ptTitle(context).copyWith(),
                    //       fillColor: ColorConst.primaryColor,
                    //       focusedBorder: OutlineInputBorder(
                    //         borderRadius:
                    //             BorderRadius.all(Radius.circular(10.0)),
                    //         borderSide: BorderSide(
                    //             color: ColorConst.primaryColor, width: 3),
                    //       ),
                    //       enabledBorder: OutlineInputBorder(
                    //         borderRadius:
                    //             BorderRadius.all(Radius.circular(10.0)),
                    //         borderSide:
                    //             BorderSide(color: ColorConst.grey, width: 3),
                    //       ),
                    //     ),
                    //     onChanged: (value) {
                    //       setState(() {});
                    //     },
                    //   ),
                    // ),
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.only(top: 24.0, right: 20 + 10),
                        alignment: Alignment.centerRight,
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'Chưa có tài khoản? ',
                              style:
                                  StyleConst.regularStyle(color: Colors.grey)),
                          TextSpan(
                              text: "Đăng ký",
                              style: StyleConst.boldStyle(
                                  color: ColorConst.primaryColor))
                        ])),
                      ),
                      onTap: _handleRegister,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      width: size.width,
                      padding: EdgeInsets.only(top: 10.0),
                      child: Row(
                        children: [
                          Expanded(child: SizedBox()),
                          Opacity(
                              opacity: passwordController.text.length > 5 &&
                                      emailController.text.length > 0
                                  ? 1
                                  : 0.5,
                              child: WidgetButton(
                                text: "Đăng nhập".toUpperCase(),
                                textColor: Colors.white,
                                onTap: () {
                                  authController.loginEmail(
                                      context: context,
                                      email:
                                          "${emailController.text}${dropModel.unit?.key}",
                                      password: passwordController.text);
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

  _handleRegister() {
    showAlertDialog(context,
        'Vui lòng liên hệ biên tập viên để được tạo tài khoản bác sĩ cho bạn.');
//    Routing().navigate2(context, RegisterDoctorScreen());
  }
}
