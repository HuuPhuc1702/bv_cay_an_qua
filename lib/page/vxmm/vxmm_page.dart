import 'dart:convert';

import 'package:bv_cay_an_qua/models/topic_model.dart';
import 'package:bv_cay_an_qua/page/login/controllers/auth_controller.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../export.dart';
import 'campaign/campaign_list.dart';
import 'history_lucky_spin/history_lucky_spin_page.dart';
import 'qrcode/qrcode_page.dart';

class VXMMPage extends StatelessWidget {
  final List<String> tags;
  final String title;

  VXMMPage({Key? key, required this.tags, required this.title})
      : super(key: key);

  AuthController authController = Get.find<AuthController>();
  List<TopicModel> listTopic = [];

  @override
  Widget build(BuildContext context) {
    try {
      listTopic = [
        TopicModel(
            name: 'Chương trình khuyến mãi',
            image: 'assets/icons/icon_khuyen_mai.png'),
        TopicModel(name: 'Quét QR code', image: 'assets/icons/icon_qr.png'),
        TopicModel(
            name: 'Lịch sử trúng thưởng',
            image: 'assets/icons/icon_history.png')
      ];
    } catch (error) {
      print(error);
    }
    return Scaffold(
      body: Column(
        children: [
          WidgetAppbar(
            title: "$title",
          ),
          Expanded(
              child: listTopic.length == 0
                  ? WidgetLoading(notData: true, count: listTopic.length)
                  : SingleChildScrollView(
                      child: Column(
                        children: List.generate(listTopic.length, (index) {
                          return itemRender(
                              data: listTopic[index], index: index);
                        }),
                      ),
                    )),
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

  Widget itemRender({TopicModel? data, required int index}) {
    return GestureDetector(
      onTap: () {
        if (index == 1)
          Get.to(QRCodePage());
        else if (index == 2)
          Get.to(HistoryLuckySpinPage());
        else
          Get.to(CampaignList(
            titleHeader: "Chương trình khuyến mãi",
            topicSlugs: "chuong-trinh-khuyen-mai",
            // listDocument: _appBloc.getTechnicalList,
          ));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            border: Border.all(color: ColorConst.borderInputColor)),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Center(
                child: Image.asset(
                  data?.image ?? '',
                  width: 50,
                  height: 50,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: EdgeInsets.only(right: 30),
                child: Text(
                  data?.name ?? "",
                  style: StyleConst.mediumStyle(fontSize: titleSize),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
