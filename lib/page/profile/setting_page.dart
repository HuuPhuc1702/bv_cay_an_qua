import 'dart:convert';
import 'dart:io';

import 'package:bv_cay_an_qua/page/login/controllers/auth_controller.dart';
import 'package:bv_cay_an_qua/page/login/login_doctor_page.dart';
import 'package:bv_cay_an_qua/page/login/login_page.dart';
import 'package:bv_cay_an_qua/page/notification/notification_page.dart';
import 'package:bv_cay_an_qua/shared/widget/widget-version.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../export.dart';
import '../components/image_picker.dart';
import 'change_password_doctor.dart';
import 'information_app_page.dart';
import 'update_profile_page.dart';
import 'package:bv_cay_an_qua/page/login/change_pin_page.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    print(
        "authController.userCurrent.avatar ${jsonEncode(authController.userCurrent)}");

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
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
        ),
        automaticallyImplyLeading: true,
        brightness: Brightness.light,
        title:
            Text('Thiết lập', style: StyleConst.boldStyle(fontSize: titleSize)),
        //centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
            child: Container(
              color: ColorConst.primaryColor,
              height: 8,
            ),
            preferredSize: Size.fromHeight(8)),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                children: [
                  Material(
                    animationDuration: Duration(milliseconds: 500),
                    elevation: 2.0,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    shadowColor: ColorConst.backgroundColor,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorConst.primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      padding: EdgeInsets.all(10),
                      child: GetBuilder<AuthController>(builder: (controller) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ImagePickerWidget(
                              context: context,
                              size: 80.0,
                              quality: 100,
                              avatar: true,
                              resourceUrl:
                                  (authController.userCurrent.avatar ?? ""),
                              onFileChanged: (fileUri, fileType) {
                                setState(() {
                                  authController.userCurrent.avatar = fileUri;
                                });
                              },
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    20.0, 0.0, 2.0, 0.0),
                                child: Text(
                                    authController.userCurrent.name ?? "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Material(
                    animationDuration: Duration(milliseconds: 500),
                    elevation: 2.0,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    shadowColor: ColorConst.backgroundColor,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        border: Border.all(color: ColorConst.primaryColor),
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: <Widget>[
                              ListTile(
                                onTap: () {
                                  // Routing().navigate2(context, InfoUserScreen());
                                  Get.to(UpdateProfilePage());
                                },
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 30.0,
                                ),
                                leading: Image.asset(
                                    "assets/icons/icon_setting_info.png",
                                    height: 30,
                                    width: 30,
                                    fit: BoxFit.cover),
                                title: Text("Thông tin cá nhân",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                              ),
                              ListTile(
                                onTap: () {
                                  // Routing()
                                  //     .navigate2(context, NotificationScreen());
                                  Get.to(NotificationPage());
                                },
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 30.0,
                                ),
                                leading: Image.asset(
                                    "assets/icons/icon_setting_noti.png",
                                    height: 30,
                                    width: 30,
                                    fit: BoxFit.cover),
                                title: Text("Thông báo",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                              ),
                              //                                          ListTile(
                              //                                            onTap: () {
                              //                                              MyNavigator.goToSetting(context);
                              //                                            },
                              //                                            contentPadding: EdgeInsets.symmetric(
                              //                                              horizontal: 30.0,
                              //                                            ),
                              //                                            leading: Icon(
                              //                                              Icons.settings,
                              //                                              color:  ColorConst.primaryColor,
                              //                                              size: 25,
                              //                                            ),
                              //                                            title: Text("Cài đặt",
                              //                                                maxLines: 1,
                              //                                                overflow: TextOverflow.ellipsis,
                              //                                                style: Theme.of(context).textTheme.title),
                              //                                          ),
                              ListTile(
                                onTap: () async {
                                  String url = "";

                                  if (appConfig.appType == AppType.DOCTOR) {
                                    if (Platform.isAndroid) {
                                      url =
                                          "https://play.google.com/store/apps/details?id=mcom.asia.bsanqua";
                                      // Android-specific code
                                    } else if (Platform.isIOS) {
                                      // iOS-specific code
                                      url =
                                          "https://apps.apple.com/us/app/plant-doctor/id1483705696";
                                    }
                                  } else {
                                    if (Platform.isAndroid) {
                                      url =
                                          "https://play.google.com/store/apps/details?id=mcom.asia.bvanqua";
                                      // Android-specific code
                                    } else if (Platform.isIOS) {
                                      // iOS-specific code
                                      url =
                                          "https://apps.apple.com/us/app/b%E1%BB%87nh-vi%E1%BB%87n-c%C3%A2y-%C4%83n-qu%E1%BA%A3/id1485347190";
                                    }
                                  }
                                  await canLaunch(url)
                                      ? await launch(url)
                                      : throw 'Could not launch $url';
                                  // if (_appBloc.isDoctor) {
                                  //   StoreRedirect.redirect(
                                  //       androidAppId: "mcom.asia.bsanqua", iOSAppId: "1483705696");
                                  // } else {
                                  //   StoreRedirect.redirect(
                                  //       androidAppId: "mcom.asia.bvanqua", iOSAppId: "1485347190");
                                  // }
                                },
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 30.0,
                                ),
                                leading: Image.asset(
                                    "assets/icons/icon_setting_rate.png",
                                    height: 30,
                                    width: 30,
                                    fit: BoxFit.cover),
                                title: Text("Đánh giá",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                              ),
                              ListTile(
                                onTap: () {
                                  // Routing().navigate2(context, ChangePasswordScreen());
                                  appConfig.appType == AppType.DOCTOR
                                      ? Get.to(ChangePasswordDoctorPage())
                                      : Get.to(ChangePinPage());
                                },
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 30.0,
                                ),
                                leading: Icon(
                                  Icons.security,
                                  color: ColorConst.primaryColor,
                                  size: 25,
                                ),
                                title: Text("Đổi mật khẩu",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                              ),

                              ListTile(
                                onTap: () {
                                  // Routing().navigate2(
                                  //     context,
                                  //     TermsOfUse(
                                  //       isYes: true,
                                  //     ));

                                  Get.to(InformationAppPage());
                                },
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 30.0,
                                ),
                                leading: Image.asset(
                                    "assets/icons/icon_setting_about.png",
                                    height: 30,
                                    width: 30,
                                    fit: BoxFit.cover),
                                title: Text("Về chúng tôi",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                              ),
                              ListTile(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            "Thông báo",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                          content: Text(
                                            "Bạn chắc chắn muốn đăng xuất?",
                                            style: StyleConst.mediumStyle(
                                                fontSize: titleSize),
                                          ),
                                          actions: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                WidgetButton(
                                                    //    fillColor: ColorConst.primaryColor,

                                                    onTap: () {
                                                      Navigator.pop(
                                                          context, true);
                                                    },
                                                    text: "Đóng".toUpperCase(),
                                                    textColor: ColorConst.white
                                                    // child: Text(
                                                    //   "Đóng",
                                                    //   style: StyleConst.mediumStyle(
                                                    //           fontSize: titleSize)
                                                    //       .copyWith(
                                                    //           color: Colors.white),
                                                    // ),
                                                    ),
                                                WidgetButton(
                                                  onTap: _handleLogout,
                                                  text:
                                                      "Đăng xuất".toUpperCase(),
                                                  backgroundColor:
                                                      ColorConst.white,
                                                  textColor: Colors.black,
                                                  // child: Text(
                                                  //   "Đăng xuất",
                                                  //   style: Theme.of(context)
                                                  //       .textTheme
                                                  //       .title,
                                                  // ),
                                                )
                                              ],
                                            )
                                          ],
                                        );
                                      });
                                },
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 30.0,
                                ),
                                leading: Image.asset(
                                    "assets/icons/icon_setting_signout.png",
                                    height: 30,
                                    width: 30,
                                    fit: BoxFit.cover),
                                title: Text(
                                  "Đăng xuất",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  AppVersion()
                ],
              ),
            )),
            // Image.asset(
            //   "assets/images/home_bottom.png",
            //   width: MediaQuery.of(context).size.width,
            //   fit: BoxFit.cover,
            //   alignment: Alignment.bottomCenter,
            //   // height: 130,
            // ),
          ],
        ),
      ),
    );
  }

  _handleLogout() async {
    // NotiService().unregisterFcm(_appBloc.deviceId);

    // clean cache
    // LoopBackAuth().clear();
    // Routing().popToRoot(context);
    // Routing().navigate2(context, _appBloc.isDoctor ? LoginDoctorScreen() : LoginScreen(), replace: true);

    authController.logout();
    if (appConfig.appType == AppType.DOCTOR) {
      Get.offAll(LoginDoctorPage());
    } else {
      Get.offAll(LoginPage());
    }
  }
}
