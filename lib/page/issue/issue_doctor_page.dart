import 'dart:io';

import 'package:bv_cay_an_qua/page/home/components/doctor_filter_question.dart';
import 'package:bv_cay_an_qua/page/home/controllers/home_controller.dart';
import 'package:bv_cay_an_qua/page/issue/components/list_issue.dart';
import 'package:bv_cay_an_qua/page/issue/controllers/issue_controller.dart';
import 'package:bv_cay_an_qua/page/login/controllers/auth_controller.dart';
import 'package:bv_cay_an_qua/page/notification/notification_page.dart';
import 'package:bv_cay_an_qua/page/profile/setting_page.dart';
import 'package:bv_cay_an_qua/services/graphql/crud_repo.dart';
import 'package:bv_cay_an_qua/services/graphql/graphql_list_provider.dart';
import 'package:bv_cay_an_qua/shared/helper/print_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../export.dart';

class IssueDoctorPage extends StatefulWidget {
  // final String? tag;
  // final QueryInput? queryInput;
  const IssueDoctorPage({
    Key? key,
    // this.tag,this.queryInput
  }) : super(key: key);

  @override
  _IssueDoctorPageState createState() => _IssueDoctorPageState();
}

class _IssueDoctorPageState extends State<IssueDoctorPage>
    with SingleTickerProviderStateMixin {
  late MediaQueryData mediaQueryData;
  final _searchChangeBehavior = PublishSubject<String>();
  TextEditingController _searchController = TextEditingController();
  HomeController homeController = Get.find<HomeController>();
  int sortCheck = 0;
  late TabController _tabController;
  late bool isFiltering;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isFiltering = false;
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

    // if(widget.tag!=null){
    //   this.tag=widget.tag!;
    //   if(widget.queryInput!=null){
    //     this.queryInput=mapData(widget.queryInput!.toJson(), this.queryInput.toJson());
    //   }
    // }
    _searchChangeBehavior
        .debounceTime(Duration(milliseconds: 500))
        .listen((queryString) {
      try {
        var _issueController = Get.find<IssueController>(tag: getTagByIndex());

        _issueController.loadAll(
            query: QueryInput(
                order: {"createdAt": -1},
                filter: getFilterByIndex(),
                search: queryString,
                limit: 10,
                page: 1));
      } catch (error) {
        printLog("IssuePage---error: $error");
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchChangeBehavior.close();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    //Get.put(IssueController());
    //Get.find<IssueController>(tag: getTagByIndex());
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.arrow_back_ios,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.1),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 2, bottom: 2, right: 5),
                                child: Icon(
                                  Icons.search,
                                  size: titleSize * 1.8,
                                  color: Colors.grey.withOpacity(.6),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _searchController,
                                  style: StyleConst.mediumStyle(),
                                  cursorColor: ColorConst.primaryColor,
                                  onChanged: _searchChangeBehavior.sink.add,
                                  decoration: InputDecoration(
                                    hintText: "Tìm kiếm...",
                                    isDense: true,
                                    hintStyle: StyleConst.mediumStyle(),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5, top: 2, bottom: 2, right: 10),
                                child: StreamBuilder<String>(
                                  stream: _searchChangeBehavior.stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData == false ||
                                        (snapshot.data?.isEmpty ?? true))
                                      return SizedBox();
                                    return GestureDetector(
                                      onTap: () {
                                        _searchChangeBehavior.sink.add('');
                                        _searchController.clear();
                                      },
                                      child: Icon(
                                        Icons.cancel,
                                        color: Colors.grey,
                                        size: titleSize * 1.5,
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 12.0),
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
                                  AssetImage("assets/icons/notification.png"),
                                  color: Colors.black.withOpacity(0.77),
                                ),
                              ),
                              authCtrll.userCurrent.unseenNotify != 0 &&
                                      authCtrll.userCurrent.unseenNotify != null
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
                                                    fontWeight: FontWeight.w600,
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
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: ImageIcon(
                            AssetImage("assets/icons/ic_setting.png"),
                          ),
                        ),
                        onTap: () {
                          // Routing().navigate2(context, MenuScreen());
                          Get.to(SettingPage());
                        },
                      )
                    ],
                  )),
              Expanded(
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
                              width: MediaQuery.of(context).size.width,
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
                                text: "Tất cả câu hỏi",
                              ),
                              Tab(
                                text: "Yêu cầu kê đơn",
                              ),
                              // Tab(
                              //   text: "Câu hỏi thường gặp",
                              // ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: _showSortPopup,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.format_list_bulleted,
                                    size: supTitleSize,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "Sắp xếp: ",
                                      style: StyleConst.mediumStyle(),
                                    ),
                                  ),
                                  Text(
                                    sortCheck == 0 ? "Mới nhất" : "Lâu nhất",
                                    style: StyleConst.mediumStyle(
                                        color: ColorConst.primaryColor),
                                  ),
                                ],
                              ),
                            ),
                            _buildFilterButton()
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            ListIssue(
                              tag: "new",
                              queryInput: QueryInput(order: {"createdAt": -1}),
                            ),
                            ListIssue(
                              tag: "prescription",
                              queryInput: QueryInput(
                                  order: {"createdAt": -1},
                                  filter: {"prescription.status": "assigning"}),
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
                ),
              ),
              // Expanded(
              //   child: ListIssue(
              //     tag: tag,
              //     queryInput: queryInput,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSortPopup() {
    FocusScope.of(context).requestFocus(FocusNode());
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)),
                      color: ColorConst.primaryColor,
                    ),
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Sắp xếp',
                          style: StyleConst.mediumStyle(color: Colors.white),
                        ),
//                        InkWell(
//                          onTap: () {
//                            Navigator.pop(context);
//                          },
//                          child: Text(
//                            '|    Áp dụng',
//                            style: ptSubtitle(context).copyWith(color: Colors.white),
//                          ),
//                        ),
                      ],
                    ),
                  ),
                  sortItem("Câu hỏi mới nhất", 0),
                  sortItem("Câu hỏi lâu nhất", 1),
                ],
              ),
            ),
          );
        });
  }

  void _showFilterPopup() async {
    FocusScope.of(context).requestFocus(FocusNode());
    bool? filter = await showModalBottomSheet<bool>(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return DoctorFilterQuestion(
            tag: getTagByIndex(),
            filter: getFilterByIndex(),
          );
        });
    var issueController = Get.find<IssueController>(
      tag: getTagByIndex(),
    );
    setState(() {
      isFiltering = issueController.isFiltering;
    });
    print(isFiltering);
  }

  Widget sortItem(String title, int check) {
    return InkWell(
      onTap: () {
        setState(() {
          sortCheck = check;
        });
        Navigator.of(context).pop();
        if (check == 0) {
          Get.find<IssueController>(
            tag: getTagByIndex(),
          ).loadAll(
              query: QueryInput(
                  order: {"createdAt": -1},
                  page: 1,
                  search: _searchController.text));
        } else {
          Get.find<IssueController>(
            tag: getTagByIndex(),
          ).loadAll(
              query: QueryInput(
                  order: {"createdAt": 1},
                  page: 1,
                  search: _searchController.text));
        }
      },
      child: Column(
        children: <Widget>[
          Padding(
            padding:
                EdgeInsets.only(top: 18.0, bottom: 10, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  maxLines: 1,
                  style: StyleConst.mediumStyle(),
                ),
                check == sortCheck
                    ? Icon(Icons.check,
                        color: ColorConst.primaryColor, size: titleSize)
                    : Container()
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  getTagByIndex() {
    if (_tabController.index == 0) {
      return "new";
    }
    if (_tabController.index == 1) {
      return "prescription";
    }
    if (_tabController.index == 2) {
      return "frequent";
    }
    return "";
  }

  getFilterByIndex() {
    if (_tabController.index == 0) {
      return Map<String, dynamic>();
    }
    if (_tabController.index == 1) {
      return {"prescription.status": "assigning"};
    }
    if (_tabController.index == 2) {
      var _issueController = Get.find<IssueController>(tag: getTagByIndex());
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

  _buildFilterButton() {
    return GestureDetector(
      onTap: _showFilterPopup,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.filter_list,
              size: supTitleSize,
              color: isFiltering ? ColorConst.primaryColor : Colors.black),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              "Bộ lọc",
              style: StyleConst.mediumStyle(
                  color: isFiltering ? ColorConst.primaryColor : Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
