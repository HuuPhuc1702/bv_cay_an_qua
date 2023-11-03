import 'dart:convert';

import 'package:bv_cay_an_qua/models/topic_model.dart';
import 'package:bv_cay_an_qua/page/issue/input_issue_page.dart';
import 'package:bv_cay_an_qua/page/login/controllers/auth_controller.dart';
import 'package:bv_cay_an_qua/page/post/post_page.dart';
import 'package:bv_cay_an_qua/page/technical_document/technical_document_page.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_appbar.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_image_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../export.dart';

class LibraryPage extends StatelessWidget {
  // List<String> tags = ["thu-vien-sach", "thu-vien-hinh-anh"];

  LibraryPage({Key? key}) : super(key: key);

  AuthController authController = Get.find<AuthController>();
  List<TopicModel> listTopic = [];

  @override
  Widget build(BuildContext context) {
    listTopic.add(
        TopicModel(slug: 'thu-vien-sach', name: "Thư viện sách", image: ""));

    try {
      print("listTopic---lenght: ${authController.listTopic.length}");
      var topicId = authController.listTopic
          .firstWhere((element) => element.slug == "thu-vien-hinh-anh")
          .id;
      listTopic.add(TopicModel(
          slug: 'thu-vien-hinh-anh',
          name: "Thư viện hình ảnh",
          image: "",
          id: topicId));
    } catch (error) {
      print(error);
    }

    return Scaffold(
      // appBar: AppBar(
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
      //       Text('Thư viện',
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
            title: "Thư viện",
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
    return GestureDetector(
      onTap: () {
        Get.to(TechnicalDocumentPage(
          // tags: ["tai-lieu-ky-thuat", "thu-vien-sach"],
          tags: ["${data?.slug}"],
          title: "${data?.name}",
        ));
        // if (data?.slug == "thu-vien-sach") {
        //   Get.to(TechnicalDocumentPage(
        //     tags: ["tai-lieu-ky-thuat", "thu-vien-sach"],
        //     title: "${data?.name}",
        //   ));
        // } else {
        //   Get.to(PostPage(
        //     topicID: data?.id ?? "",
        //     title: data?.name ?? "",
        //   ));
        // }
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
  }
}
