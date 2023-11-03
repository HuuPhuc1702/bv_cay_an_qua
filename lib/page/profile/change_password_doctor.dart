import 'package:bv_cay_an_qua/config/theme/assets-constant.dart';
import 'package:bv_cay_an_qua/page/components/dialog.dart';
import 'package:bv_cay_an_qua/page/login/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../export.dart';

class ChangePasswordDoctorPage extends StatefulWidget {
  const ChangePasswordDoctorPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordDoctorPageState createState() =>
      _ChangePasswordDoctorPageState();
}

class _ChangePasswordDoctorPageState extends State<ChangePasswordDoctorPage> {
  TextEditingController passwordOldController = TextEditingController();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();

  late Size size;
  final focus = FocusNode();
  AuthController authController = Get.find<AuthController>();

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      AssetsConst.backgroundLogin,
                      width: size.width,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("Đổi mật khẩu".toUpperCase(),
                          style: StyleConst.boldStyle(fontSize: titleSize)),
                    ),
                    TextFormField(
                      controller: passwordOldController,
                      obscureText: true,
                      style: StyleConst.mediumStyle(),
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Icon(
                            Icons.lock,
                            color: ColorConst.grey,
                            size: 30.0,
                          ),
                        ),
                        hintText: 'Mật khẩu hiện tại',
                        hintStyle: StyleConst.mediumStyle(
                          color: ColorConst.grey,
                        ),
                        fillColor: ColorConst.primaryColor,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      maxLines: 1,
                      validator: (text) {
                        if (text?.isEmpty ?? true) {
                          return 'Vui lòng nhập mật khẩu';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: password1Controller,
                      obscureText: true,
                      style: StyleConst.mediumStyle(),
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Icon(
                            Icons.lock,
                            color: ColorConst.grey,
                            size: 30.0,
                          ),
                        ),
                        hintText: 'Mật khẩu mới',
                        hintStyle: StyleConst.mediumStyle(
                          color: ColorConst.grey,
                        ),
                        fillColor: ColorConst.primaryColor,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      maxLines: 1,
                      validator: (text) {
                        if (text?.isEmpty ?? true) {
                          return 'Vui lòng nhập mật khẩu';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: password2Controller,
                      obscureText: true,
                      style: StyleConst.mediumStyle(),
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Icon(
                            Icons.lock,
                            color: ColorConst.grey,
                            size: 30.0,
                          ),
                        ),
                        hintText: 'Nhập lại mật khẩu mới',
                        hintStyle: StyleConst.mediumStyle(
                          color: ColorConst.grey,
                        ),
                        fillColor: ColorConst.primaryColor,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      maxLines: 1,
                      validator: (text) {
                        if (text?.isEmpty ?? true) {
                          return 'Vui lòng nhập mật khẩu';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      width: size.width,
                      padding: EdgeInsets.only(top: 10.0),
                      child: Row(
                        children: [
                          WidgetButton(
                            text: "Quay lại".toUpperCase(),
                            backgroundColor: Colors.white,
                            radiusColor: ColorConst.primaryColor,
                            widthRadius: 3,
                            onTap: () {
                              Get.back();
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: WidgetButton(
                              text: "Đổi mật khẩu".toUpperCase(),
                              backgroundColor: Colors.white,
                              radiusColor: ColorConst.primaryColor,
                              widthRadius: 3,
                              onTap: () {
                                authController.changePassword(
                                    context: context,
                                    passwordOld: passwordOldController.text,
                                    passwordNew1: password1Controller.text,
                                    passwordNew2: password2Controller.text);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
