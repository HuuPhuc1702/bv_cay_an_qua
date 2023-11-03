import 'dart:io';
import 'package:bv_cay_an_qua/page/home/controllers/home_controller.dart';
import 'package:bv_cay_an_qua/page/login/controllers/auth_controller.dart';
import 'package:bv_cay_an_qua/page/notification/notification_page.dart';
import 'package:bv_cay_an_qua/page/profile/setting_page.dart';
import 'package:bv_cay_an_qua/shared/helper/check_update_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../export.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MediaQueryData mediaQueryData;

  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();

    // if (appConfig.appType == AppType.FARMER) {
    homeController.getBanner(context);
    // }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkUpdateApp(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => showExist(context),
        child: GetBuilder<HomeController>(
          builder: (controller) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: mediaQueryData.padding.top),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          GetBuilder<AuthController>(builder: (authCtrll) {
                            print(authCtrll.userCurrent.unseenNotify);
                            return GestureDetector(
                              onTap: () {
                                Get.to(NotificationPage());
                              },
                              child: Stack(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: ImageIcon(
                                      AssetImage(
                                          "assets/icons/notification.png"),
                                      color: Colors.black.withOpacity(0.77),
                                    ),
                                  ),
                                  authCtrll.userCurrent.unseenNotify != 0 &&
                                          authCtrll.userCurrent.unseenNotify !=
                                              null
                                      ? Positioned(
                                          top: 5,
                                          left: 25,
                                          height: 15,
                                          child: Center(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(800),
                                              child: Container(
                                                height: 20,
                                                padding: EdgeInsets.all(2),
                                                color: Colors.redAccent,
                                                child: Center(
                                                  child: Text(
                                                    (authCtrll.userCurrent
                                                                    .unseenNotify ??
                                                                0) >
                                                            99
                                                        ? "99+"
                                                        : authCtrll.userCurrent
                                                            .unseenNotify
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white,
                                                        fontSize: 11),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox.shrink(),
                                ],
                              ),
                            );
                          }),

                          GestureDetector(
                            onTap: () {
                              Get.to(SettingPage());
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: ImageIcon(
                                AssetImage("assets/icons/ic_setting.png"),
                              ),
                            ),
                          )

                          // IconButton(
                          //   alignment: Alignment.bottomRight,
                          //   icon: ImageIcon(
                          //     AssetImage("assets/icons/ic_setting.png"),
                          //     color: Colors.black.withOpacity(0.77),
                          //   ),
                          //   onPressed: () {
                          //     Get.to(SettingPage());
                          //   },
                          //   tooltip: 'Cài đặt',
                          // ),
                        ],
                      ),
                      //region UI
                      Image.asset(
                        "assets/images/logo2.png",
                        width: mediaQueryData.size.width / 2.5,
                        fit: BoxFit.contain,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Bệnh viện cây ăn quả'.toUpperCase(),
                              style: StyleConst.boldStyle(
                                  fontSize: titleSize,
                                  color: ColorConst.primaryColor),
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: FittedBox(
                                child: Text(
                                  'Hệ thống Bệnh viện Cây ăn quả được thành lập bởi sự hợp tác\n'
                                  'giữa Viện Cây Ăn Quả Miền Nam & Tập Đoàn Lộc Trời',
                                  style: StyleConst.boldStyle(
                                      fontSize: miniSize, height: 1.3),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text('www.benhviencayanqua.vn',
                                  style: StyleConst.mediumStyle(
                                      color: ColorConst.primaryColor)),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   height: 8,
                      //   color: ColorConst.primaryColor,
                      //   margin: EdgeInsets.only(bottom: 10),
                      // ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     border: Border(
                      //       top: BorderSide(
                      //         color: ColorConst.primaryColor,
                      //         width: 8,
                      //       ),
                      //       bottom: BorderSide(
                      //         color: ColorConst.primaryColor,
                      //         width: 8,
                      //       ),
                      //     ),
                      //   ),
                      //   child: Container(
                      //     height: 40,
                      //     width: mediaQueryData.size.width,
                      //     decoration: BoxDecoration(
                      //         gradient: LinearGradient(
                      //             begin: Alignment.topRight,
                      //             end: Alignment.bottomLeft,
                      //             colors: [
                      //           ColorConst.primaryColorGradient1,
                      //           ColorConst.primaryColorGradient2
                      //         ])),
                      //   ),
                      // ),
                      //endregion
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Wrap(
                          children: List.generate(
                            controller.listItemHome.length,
                            (index) => Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        side: new BorderSide(
                                            color: ColorConst.primaryColor,
                                            width: 3.0),
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    child: InkWell(
                                      splashColor: ColorConst.primaryColor
                                          .withOpacity(0.2),
                                      highlightColor: ColorConst.primaryColor
                                          .withOpacity(0.2),
                                      onTap: () {
                                        controller.listItemHome[index].onTap
                                            .call();
                                        // Routing().navigate2(context, IntroduceScreen());
                                      },
                                      child: Container(
                                          width:
                                              mediaQueryData.size.width / 2.2,
                                          padding: EdgeInsets.all(10),
                                          height: 100,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  alignment: Alignment.topLeft,
                                                  // padding: ,
                                                  child: Text(
                                                    controller
                                                        .listItemHome[index]
                                                        .title,
                                                    style:
                                                        StyleConst.boldStyle(),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Image.asset(
                                                  controller.listItemHome[index]
                                                      .assetsIcon,
                                                  width: 55,
                                                  height: 55,
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                ),
                                if (controller.listItemHome[index].isHot ==
                                    true)
                                  Positioned(
                                      right: 0,
                                      child: Image.asset(
                                        'assets/icons/hot.png',
                                        width: 40,
                                        height: 40,
                                      )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    AssetsConst.backgroundBottomLogin,
                    fit: BoxFit.cover,
                    alignment: Alignment.bottomCenter,
                    // height: 130,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<bool> showExist(BuildContext context) async {
    bool result = false;
    showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text('Thông báo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Bạn có muốn thoát ứng dụng'),
            Padding(
              padding: const EdgeInsets.only(
                  right: 10, left: 10, top: 16, bottom: 0),
              child: Row(
                children: [
                  Expanded(
                    child: WidgetButton(
                        text: 'Hủy',
                        textColor: ColorConst.primaryColor,
                        backgroundColor: Colors.white,
                        onTap: () {
                          result = false;
                          Navigator.pop(c, false);
                        }),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: WidgetButton(
                      text: 'Đồng ý',
                      textColor: Colors.white,
                      onTap: () {
                        result = true;
                        return Platform.isIOS ? exit(0) : SystemNavigator.pop();
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
    return result;
  }
}
