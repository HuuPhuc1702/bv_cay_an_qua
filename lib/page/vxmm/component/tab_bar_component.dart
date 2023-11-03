import 'package:bv_cay_an_qua/shared/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:bv_cay_an_qua/constants/constants.dart';
import 'tab_bar.dart';

class TabBarComponent extends StatelessWidget {
  const TabBarComponent(
      {Key? key,
      this.currentTabIs1,
      this.callBack,
      this.isLockReferral = false})
      : super(key: key);
  final bool? currentTabIs1;
  final Function(bool)? callBack;
  final bool isLockReferral;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: currentTabIs1 == true
                  ? AssetImage("assets/images/tab_bar_line_1.png")
                  : AssetImage("assets/images/tab_bar_line_2.png"))),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              callBack?.call(true);
            },
            child: currentTabIs1 == true
                ? Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: CustomPaint(
                      size:
                          Size(MediaQuery.of(context).size.width / 2 + 55, 50),
                      painter: TabBarLeftPainter(
                          textColor: HexColor(appColor2),
                          fillColor: HexColor(appWhite),
                          topWidth: MediaQuery.of(context).size.width / 2 - 5,
                          bottomWidth:
                              MediaQuery.of(context).size.width / 2 + 60,
                          height: 65,
                          text: "QR Code"),
                    ),
                  )
                : CustomPaint(
                    size: Size(MediaQuery.of(context).size.width / 2, 50),
                    painter: TabBarLeftPainter(
                        textColor: HexColor(appWhite),
                        fillColor: HexColor(appColor2),
                        topWidth: MediaQuery.of(context).size.width / 2,
                        bottomWidth: MediaQuery.of(context).size.width / 2 - 65,
                        height: 65,
                        text: "QR Code"),
                  ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: () {
                    if (isLockReferral) {
                      callBack?.call(true);
                    } else {
                      callBack?.call(false);
                    }
                  },
                  child: currentTabIs1 == true
                      ? CustomPaint(
                          size: Size(MediaQuery.of(context).size.width / 2, 50),
                          painter: TabBarRightPainter(
                              textColor: HexColor(appWhite),
                              fillColor: isLockReferral
                                  ? Colors.grey
                                  : HexColor(appColor2),
                              topWidth: MediaQuery.of(context).size.width / 2,
                              bottomWidth:
                                  MediaQuery.of(context).size.width / 2 - 65,
                              height: 65,
                              text: "Giới thiệu"),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: CustomPaint(
                            size: Size(
                                MediaQuery.of(context).size.width / 2 + 55, 50),
                            painter: TabBarRightPainter(
                                textColor: HexColor(appColor2),
                                fillColor: isLockReferral
                                    ? Colors.grey
                                    : HexColor(appWhite),
                                topWidth:
                                    MediaQuery.of(context).size.width / 2 - 5,
                                bottomWidth:
                                    MediaQuery.of(context).size.width / 2 + 60,
                                height: 65,
                                text: "Giới thiệu"),
                          ),
                        )),
            ],
          ),
        ],
      ),
    );
  }
}
