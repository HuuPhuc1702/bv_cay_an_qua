import 'dart:convert';

import 'package:bv_cay_an_qua/models/topic_model.dart';
import 'package:bv_cay_an_qua/page/issue/input_issue_page.dart';
import 'package:bv_cay_an_qua/page/login/controllers/auth_controller.dart';
import 'package:bv_cay_an_qua/page/post/post_page.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_appbar.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_image_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../export.dart';
import 'list_userpost_page.dart';

class NewsSharePage extends StatelessWidget {
  String title;

  NewsSharePage({Key? key, required this.title}) : super(key: key);

  //AuthController authController = Get.find<AuthController>();
  List<TopicModel> listTopic = [
    TopicModel(name: "Tin tức", slug: "tin-tuc"),
    TopicModel(name: "Góc chia sẻ"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          WidgetAppbar(
            title: "$title",
          ),
          Expanded(
              child: listTopic.length == 0
                  ? WidgetLoading(
                      notData: true,
                      count: listTopic.length,
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: List.generate(listTopic.length, (index) {
                          return itemRender(data: listTopic[index]);
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

  Widget itemRender({TopicModel? data}) {
    return
        //GetBuilder<AuthController>(builder: (authController){
        // return
        GestureDetector(
      onTap: () {
        AuthController authController = Get.find<AuthController>();
        print("-------Tin tức----------");
        print(authController.listTopic.length);
        if (data?.slug != null) {
          Get.to(PostPage(
            topicID: (authController.listTopic
                .firstWhere((element) => element.slug == "tin-tuc")).id,
            title: "Tin tức",
          ));
        } else {
          print("----------Chia sẻ-----------");
          Get.to(ListUserPostPage());
        }
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
              child: WidgetImageNetWork(
                url: data?.image,
                width: 60,
                height: 60,
                fit: BoxFit.fitHeight,
              ),
            ),
            Expanded(
              flex: 6,
              child: Text(
                data?.name ?? "",
                style: StyleConst.boldStyle(fontSize: titleSize),
              ),
            )
          ],
        ),
      ),
    );
    //} );
  }
}
