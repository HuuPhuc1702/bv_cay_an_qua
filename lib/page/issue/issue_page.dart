import 'package:bv_cay_an_qua/config/app_key.dart';
import 'package:bv_cay_an_qua/models/topic_model.dart';
import 'package:bv_cay_an_qua/page/issue/controllers/issue_controller.dart';
import 'package:bv_cay_an_qua/page/login/controllers/auth_controller.dart';
import 'package:bv_cay_an_qua/services/graphql/crud_repo.dart';
import 'package:bv_cay_an_qua/shared/helper/print_log.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../export.dart';
import 'components/list_issue.dart';

class IssuePage extends StatefulWidget {
  const IssuePage({Key? key}) : super(key: key);

  @override
  _IssuePageState createState() => _IssuePageState();
}

class _IssuePageState extends State<IssuePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late MediaQueryData _mediaQueryData;

  TextEditingController _searchController = TextEditingController();

  // BehaviorSubject<String> _searchChangeBehavior =
  //     BehaviorSubject<String>.seeded("");

  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      try {
        if (_searchController.text !=
            Get.find<IssueController>(tag: getTagByIndex()).query.search) {
          Get.find<IssueController>(tag: getTagByIndex()).loadAll(
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

    // _searchChangeBehavior
    //     .debounceTime(Duration(milliseconds: 500))
    //     .listen((queryString) {
    //   print(queryString);
    //   try {
    //     var _issueController = Get.find<IssueController>(tag: getTagByIndex());
    //     _issueController.loadAll(
    //         query: QueryInput(
    //             order: {"createdAt": -1},
    //             search: queryString,
    //             filter: getFilterByIndex(),
    //             limit: 10,
    //             page: 1));
    //   } catch (error) {
    //     print("IssuePage---error: $error");
    //   }
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _searchChangeBehavior.close();
    _tabController.dispose();
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
        //       Text("Hỏi và đáp",
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
        //     GestureDetector(
        //       onTap: () {
        //         // Routing().navigate2(context, CreatQuestionScreen());
        //         Get.to(InputIssuePage(
        //           tag: getTagByIndex(),
        //         ));
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
              title: "Hỏi và đáp",
              textEditingController: _searchController,
              functionTag: getTagByIndex(),
              onChangeSearch: (value) {
                try {
                  var _issueController =
                      Get.find<IssueController>(tag: getTagByIndex());
                  _issueController.loadAll(
                      query: QueryInput(
                          order: {"createdAt": -1},
                          search: value,
                          filter: getFilterByIndex(),
                          limit: 10,
                          page: 1));
                } catch (error) {
                  print("IssuePage---error: $error");
                }
              },
            ),
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
            //       color:  ColorConst.primaryColor.withOpacity(.8)
            //         // gradient: LinearGradient(
            //         //     begin: Alignment.topRight,
            //         //     end: Alignment.bottomLeft,
            //         //     colors: [
            //         //   ColorConst.primaryColor,
            //         //   ColorConst.primaryColor.withOpacity(.8)
            //         // ])
            //         ),
            //     child: Center(
            //        child:
            //        WidgetSearch(
            //          hintText: "Tìm kiếm...",
            //          onChange: _searchChangeBehavior.sink.add,
            //          controller:_searchController,
            //          onSubmitted: (query) {
            //                   _searchChangeBehavior.sink.add(query);
            //          } ,
            //           )
            //       // TextField(
            //       //   controller: _searchController,
            //       //   style: StyleConst.boldStyle(fontSize: titleSize)
            //       //       .copyWith(color: Colors.white),
            //       //   cursorColor: Colors.white,
            //       //   onChanged: _searchChangeBehavior.sink.add,
            //       //   decoration: InputDecoration(
            //       //     hintText: "Tìm kiếm...",
            //       //     suffixIcon: StreamBuilder<String>(
            //       //       stream: _searchChangeBehavior.stream,
            //       //       builder: (context, snapshot) {
            //       //         if (snapshot.hasData == false ||
            //       //             (snapshot.data?.isEmpty ?? true))
            //       //           return SizedBox();
            //       //         return GestureDetector(
            //       //           onTap: () {
            //       //             _searchChangeBehavior.sink.add('');
            //       //             _searchController.clear();
            //       //           },
            //       //           child: Icon(
            //       //             Icons.cancel,
            //       //             color: Colors.white70,
            //       //             size: titleSize * 1.5,
            //       //           ),
            //       //         );
            //       //       },
            //       //     ),
            //       //     contentPadding: EdgeInsets.only(
            //       //         left: 20,
            //       //         right: _searchController.text.isNotEmpty ? 0 : 20,
            //       //         top: 12.0),
            //       //     hintStyle: StyleConst.boldStyle(fontSize: titleSize)
            //       //         .copyWith(color: Colors.white70),
            //       //     border: InputBorder.none,
            //       //     enabledBorder: InputBorder.none,
            //       //     disabledBorder: InputBorder.none,
            //       //     focusedBorder: InputBorder.none,
            //       //   ),
            //       // ),
            //     ),
            //   ),
            // ),
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(top: 5),
                  child: DefaultTabController(
                    length: 3, // length of tabs
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
                              labelPadding:
                                  EdgeInsets.only(top: 5, right: 10, left: 10),
                              controller: _tabController,
                              // isScrollable: true,
                              tabs: <Widget>[
                                Tab(
                                  text: "Câu hỏi mới nhất",
                                ),
                                Tab(
                                  text: "Câu hỏi của tôi",
                                ),
                              ],
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              ListIssue(
                                tag: "new",
                                queryInput:
                                    QueryInput(order: {"createdAt": -1}),
                              ),
                              ListIssue(
                                tag: "mine",
                                queryInput: QueryInput(order: {
                                  "createdAt": -1
                                }, filter: {
                                  "owner._id":
                                      "${Get.find<AuthController>().userCurrent.id}"
                                }),
                              ),
                              // ListIssue(
                              //   tag: "frequent",
                              //   queryInput: QueryInput(
                              //       order: {"createdAt": -1},
                              //       filter: {"isFAQ": true}),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
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
    );
  }

  @override
  bool get wantKeepAlive => true;

  getTagByIndex() {
    if (_tabController.index == 0) {
      return "new";
    }
    if (_tabController.index == 1) {
      return "mine";
    }
    if (_tabController.index == 2) {
      return "frequent";
    }
    return "";
  }

  getFilterByIndex() {
    var _issueController = Get.find<IssueController>(tag: getTagByIndex());
    if (_tabController.index == 0) {
      return Map<String, dynamic>();
    }
    if (_tabController.index == 1) {
      return {"owner._id": "${Get.find<AuthController>().userCurrent.id}"};
    }
    if (_tabController.index == 2) {
      Map<String, dynamic> filter = {"isFAQ": true};
      if (_issueController.countIssueTopic > 0) {
        filter["topicIds"] = [
          "${_issueController.listIssueTopics[_issueController.countIssueTopic].id}"
        ];
      }
      return filter;
    }
    return Map<String, dynamic>();
  }
}
