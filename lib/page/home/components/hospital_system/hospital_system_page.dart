import 'package:bv_cay_an_qua/page/components/zoom_image_asset.dart';
import 'package:bv_cay_an_qua/page/issue/input_issue_page.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../export.dart';

class HospitalSystemPage extends StatelessWidget {
  HospitalSystemPage({Key? key}) : super(key: key);
  late MediaQueryData _mediaQueryData;

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      // AppBar(
      //   leading: GestureDetector(
      //     onTap: () {
      //       Navigator.pop(context);
      //     },
      //     child: Padding(
      //       padding: EdgeInsets.all(14.0),
      //       child: Image.asset(
      //         AssetsConst.iconBack,
      //         fit: BoxFit.cover,
      //         width: 24,
      //         height: 24,
      //       ),
      //     ),
      //   ),
      //   brightness: Brightness.light,
      //   title: Column(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: <Widget>[
      //       Text('Hệ thống bệnh viện',
      //           style: StyleConst.boldStyle(
      //                   color: ColorConst.red, fontSize: titleSize)
      //               .copyWith(color: Colors.red, fontWeight: FontWeight.bold)),
      //       Text('www.benhviencayanqua.vn',
      //           style: StyleConst.mediumStyle(color: ColorConst.primaryColor)),
      //     ],
      //   ),
      //   elevation: 2,
      //   backgroundColor: Colors.white,
      //   actions: <Widget>[
      //     GestureDetector(
      //       onTap: () {
      //         Get.to(InputIssuePage());
      //
      //         // Routing().navigate2(context, CreatQuestionScreen());
      //       },
      //       child: Padding(
      //         padding: EdgeInsets.all(3),
      //         child: Image.asset(
      //           "assets/images/question.png",
      //         ),
      //       ),
      //     ),
      //   ],
      //   bottom: PreferredSize(
      //       child: Container(
      //         color: ColorConst.primaryColor,
      //         height: 8,
      //       ),
      //       preferredSize: Size.fromHeight(8)),
      // ),
      body: Column(
        children: [
          WidgetAppbar(
            title: "Hệ thống bệnh viện",
          ),
          Container(
            margin: EdgeInsets.only(
              top: 10,
              bottom: 20,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: ColorConst.primaryColor,
                  width: 8,
                ),
                bottom: BorderSide(
                  color: ColorConst.primaryColor,
                  width: 8,
                ),
              ),
            ),
            child: Container(
              height: 40,
              width: _mediaQueryData.size.width,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                    ColorConst.primaryColorGradient1,
                    ColorConst.primaryColorGradient2
                  ])),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sơ đồ Hệ thống bệnh viện',
                  style: StyleConst.boldStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ZoomImageAsset(
                        imageProvider:
                            AssetImage("assets/images/hehthongbenhvien.jpeg"),
                      ),
                    ),
                  );
                },
                child: Image.asset(
                  "assets/images/hehthongbenhvien.jpeg",
                  width: _mediaQueryData.size.width,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'hệ thống bệnh viện cây ăn quả tại các tỉnh thành phía nam'
                    .toUpperCase(),
                textAlign: TextAlign.center,
                style: StyleConst.regularStyle(
                    color: Colors.grey, fontSize: miniSize),
              ),
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
    );
  }
}
