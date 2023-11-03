import 'package:bv_cay_an_qua/config/theme/assets-constant.dart';
import 'package:bv_cay_an_qua/config/theme/color-constant.dart';
import 'package:bv_cay_an_qua/config/theme/size-constant.dart';
import 'package:bv_cay_an_qua/config/theme/style-constant.dart';
import 'package:bv_cay_an_qua/export.dart';
import 'package:bv_cay_an_qua/page/components/zoom_webview.dart';
import 'package:bv_cay_an_qua/page/hospital/hospital_page.dart';
import 'package:bv_cay_an_qua/page/issue/input_issue_page.dart';
import 'package:bv_cay_an_qua/page/post/post_controller.dart';
import 'package:bv_cay_an_qua/services/graphql/crud_repo.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_appbar.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_html.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroducePage extends StatefulWidget {
  IntroducePage({Key? key}) : super(key: key);

  @override
  _IntroducePageState createState() => _IntroducePageState();
}

class _IntroducePageState extends State<IntroducePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late MediaQueryData _mediaQueryData;

  late TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      body: Column(
        children: [
          WidgetAppbar(
            title: "Giới thiệu tổ chức",
          ),
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      constraints: BoxConstraints.expand(height: 60),
                      margin: EdgeInsets.only(top: 10),
                      child: Stack(
                        children: <Widget>[
                          Container(
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
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                    ColorConst.primaryColorGradient1,
                                    ColorConst.primaryColorGradient2
                                  ])),
                            ),
                          ),
                          TabBar(
                            indicatorWeight: 3.0,
                            indicatorColor: Colors.transparent,
                            labelColor: Color(0xFFFEF04C),
                            labelStyle: StyleConst.boldStyle(),
                            unselectedLabelColor: Colors.white,
                            labelPadding: EdgeInsets.only(top: 8),
                            isScrollable: true,
                            tabs: <Widget>[
                              Tab(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text("Giới thiệu chung"),
                                  ),
                                ),
                                // text: "Giới thiệu chung",
                              ),
                              Tab(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text("Sơ đồ tổ chức"),
                                  ),
                                ),
                                // text: "Sơ đồ tổ chức",
                              ),
                              Tab(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text("Đội ngũ Bác sĩ"),
                                  ),
                                ),
                                // text: "Đội ngũ Bác sĩ",
                              ),
                            ],
                            controller: _tabController,
                          ),
                        ],
                      )),
                  Expanded(
                    child: TabBarView(
                        controller: _tabController,
                        // physics: NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          GetBuilder<PostController>(
                            tag: "gioi-thieu",
                            init: Get.put(
                                PostController(
                                    query: QueryInput(
                                        filter: {"slug": "gioi-thieu"})),
                                tag: "gioi-thieu"),
                            builder: (controller) {
                              if (controller.loadMoreItems.value.length == 0 &&
                                  controller.lastItem == true) {
                                return WidgetLoading(
                                  notData: true,
                                  count: controller.loadMoreItems.value.length,
                                );
                              }
                              if (controller.loadMoreItems.value.length > 0) {
                                return ZoomWebView(
                                  html: controller
                                      .loadMoreItems.value.first.content,
                                );
                              }
                              return WidgetLoading();
                            },
                          ),
                          GetBuilder<PostController>(
                            tag: "so-do-to-chuc",
                            init: Get.put(
                                PostController(
                                    query: QueryInput(
                                        filter: {"slug": "so-do-to-chuc"})),
                                tag: "so-do-to-chuc"),
                            builder: (controller) {
                              if (controller.loadMoreItems.value.length == 0 &&
                                  controller.lastItem == true) {
                                return WidgetLoading(
                                  notData: true,
                                  count: controller.loadMoreItems.value.length,
                                );
                              }
                              if (controller.loadMoreItems.value.length > 0) {
                                return ZoomWebView(
                                  html: controller
                                      .loadMoreItems.value.first.content,
                                );
                              }
                              return WidgetLoading();
                            },
                          ),
                          HospitalPage(),
                          // ZoomWebView(html: introTeam, paddingBottom: 80),
                          // ZoomWebView(html: diagramTeam, paddingBottom: 80),
                          // ListIntroTeam()
                        ]),
                  ),
                  Image.asset(
                    AssetsConst.backgroundBottomLogin,
                    width: _mediaQueryData.size.width,
                    fit: BoxFit.cover,
                    alignment: Alignment.bottomCenter,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
