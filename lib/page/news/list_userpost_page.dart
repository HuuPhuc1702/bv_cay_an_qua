import 'dart:async';

import 'package:bv_cay_an_qua/page/issue/input_issue_page.dart';
import 'package:bv_cay_an_qua/page/news/components/list_userpost.dart';
import 'package:bv_cay_an_qua/page/news/controllers/userpost_controller.dart';
import 'package:bv_cay_an_qua/services/graphql/crud_repo.dart';
import 'package:bv_cay_an_qua/shared/helper/print_log.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_appbar.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../export.dart';
import 'input_userpost_page.dart';

class ListUserPostPage extends StatefulWidget {
  const ListUserPostPage({Key? key}) : super(key: key);

  @override
  _ListUserPostPageState createState() => _ListUserPostPageState();
}

class _ListUserPostPageState extends State<ListUserPostPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late MediaQueryData _mediaQueryData;

  TextEditingController _searchController = TextEditingController();
  BehaviorSubject<String> _searchChangeBehavior =
      BehaviorSubject<String>.seeded("");
  late TabController _tabController;
  StreamController _streamHiddenInsertPost = StreamController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      try {
        _streamHiddenInsertPost.sink.add(_tabController.index);

        if (_searchController.text !=
            Get.find<UserPostController>(tag: getTagByIndex()).query.search) {
          Get.find<UserPostController>(tag: getTagByIndex()).loadAll(
              query: QueryInput(
                  search: _searchController.text,
                  page: 1,
                  order: {"createdAt": -1},
                  filter: getFilterByIndex()));
        }
      } catch (error) {
        printLog("_IssuePageState--initState--${error.toString()}");
      }
    });

    _searchChangeBehavior
        .debounceTime(Duration(milliseconds: 500))
        .listen((queryString) {
      print(queryString);
      try {
        var _issueController =
            Get.find<UserPostController>(tag: getTagByIndex());
        _issueController.loadAll(
            query: QueryInput(
                order: {"createdAt": -1},
                search: queryString,
                filter: getFilterByIndex(),
                limit: 10,
                page: 1));
      } catch (error) {
        print("IssuePage---error: $error");
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchChangeBehavior.close();
    _tabController.dispose();
    _streamHiddenInsertPost.close();
  }

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
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
        //       Text("Góc chia sẻ",
        //           style: StyleConst.boldStyle(
        //                   color: ColorConst.red, fontSize: titleSize)
        //               .copyWith(
        //                   color: Colors.red, fontWeight: FontWeight.bold)),
        //       Text('www.benhviencayanqua.vn',
        //           style:
        //               StyleConst.mediumStyle(color: ColorConst.primaryColor)),
        //     ],
        //   ),
        //   elevation: 2,
        //   backgroundColor: Colors.white,
        //   actions: <Widget>[
        //     StreamBuilder<dynamic>(
        //         stream: _streamHiddenInsertPost.stream,
        //         builder: (context, snapshot) {
        //           return Visibility(
        //             visible: (_tabController.index == 1 &&
        //                         appConfig.appType == AppType.DOCTOR) ||
        //                     (_tabController.index == 0 &&
        //                         appConfig.appType == AppType.FARMER),
        //             child: GestureDetector(
        //               onTap: () {
        //                 Get.to(InputUserPostPage(
        //                   tag: getTagByIndex(),
        //                 ));
        //               },
        //               child: Padding(
        //                 padding: EdgeInsets.all(3),
        //                 child: Image.asset(
        //                   "assets/icons/icon_add_post.png",
        //                 ),
        //               ),
        //             ),
        //           );
        //         }),
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
            StreamBuilder<dynamic>(
                stream: _streamHiddenInsertPost.stream,
                builder: (context, snapshot) {
                  return WidgetAppbar(
                    title: "Góc chia sẻ",
                    turnOnSendIssue: false,
                    showWidgetIcons: (_tabController.index == 1 &&
                            appConfig.appType == AppType.DOCTOR) ||
                        (_tabController.index == 0 &&
                            appConfig.appType == AppType.FARMER),
                    onChangeSearch: (value) {
                      _searchChangeBehavior.sink.add(value);
                    },
                    widgetIcons: GestureDetector(
                      onTap: () {
                        if ((_tabController.index == 1 &&
                                appConfig.appType == AppType.DOCTOR) ||
                            (_tabController.index == 0 &&
                                appConfig.appType == AppType.FARMER)) {
                          Get.to(InputUserPostPage(
                            tag: getTagByIndex(),
                          ));
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Image.asset(
                          "assets/icons/icon_add_post.png",
                        ),
                      ),
                    ),
                  );
                }),
            Expanded(
              child: Stack(
                children: [
                  Column(
                    children: [
                      // Container(
                      //   margin: EdgeInsets.only(top: 10),
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
                      //     height: 50,
                      //     width: _mediaQueryData.size.width,
                      //     decoration: BoxDecoration(
                      //         color: ColorConst.primaryColor.withOpacity(.8)
                      //         // gradient: LinearGradient(
                      //         //     begin: Alignment.topRight,
                      //         //     end: Alignment.bottomLeft,
                      //         //     colors: [
                      //         //   ColorConst.primaryColor,
                      //         //   ColorConst.primaryColor.withOpacity(.8)
                      //         // ])
                      //         ),
                      //     child: Center(
                      //         child: WidgetSearch(
                      //       hintText: "Tìm kiếm...",
                      //       onChange: _searchChangeBehavior.sink.add,
                      //       controller: _searchController,
                      //       onSubmitted: (query) {
                      //         _searchChangeBehavior.sink.add(query);
                      //       },
                      //     )),
                      //   ),
                      // ),
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.only(top: 5),
                            child: DefaultTabController(
                              length: 2, // length of tabs
                              initialIndex: 0,
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
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
                                                ColorConst.primaryColor,
                                                Color(0xFF3FB424)
                                              ])),
                                        ),
                                      ),
                                      TabBar(
                                        indicatorWeight: 3.0,
                                        indicatorColor: Colors.transparent,
                                        labelColor: Color(0xFFFEF04C),
                                        labelStyle: StyleConst.boldStyle(),
                                        unselectedLabelColor: Colors.white,
                                        labelPadding: EdgeInsets.only(
                                            top: 5, right: 10, left: 10),
                                        controller: _tabController,
                                        tabs: <Widget>[
                                          Tab(
                                            text: "Nhà nông chia sẻ",
                                          ),
                                          Tab(
                                            text: "Góc chuyên gia",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: TabBarView(
                                      controller: _tabController,
                                      children: [
                                        ListUserPost(
                                          tag: "farmer",
                                          queryInput: QueryInput(
                                              order: {"createdAt": -1},
                                              filter: {"type": "farmer"}),
                                        ),
                                        ListUserPost(
                                          tag: "doctor",
                                          queryInput: QueryInput(
                                              order: {"createdAt": -1},
                                              filter: {"type": "doctor"}),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      AssetsConst.backgroundBottomLogin,
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomCenter,
                      // height: 130,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  getTagByIndex() {
    if (_tabController.index == 0) {
      return "farmer";
    }
    if (_tabController.index == 1) {
      return "doctor";
    }
    return "";
  }

  getFilterByIndex() {
    if (_tabController.index == 0) {
      return {"type": "farmer"};
    }
    if (_tabController.index == 1) {
      return {"type": "doctor"};
    }
    return Map<String, dynamic>();
  }
}
