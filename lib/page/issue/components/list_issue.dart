import 'dart:async';

import 'package:bv_cay_an_qua/page/components/image_picker.dart';
import 'package:bv_cay_an_qua/page/components/widget_video.dart';
import 'package:bv_cay_an_qua/page/issue/controllers/issue_controller.dart';
import 'package:bv_cay_an_qua/services/graphql/crud_repo.dart';
import 'package:bv_cay_an_qua/shared/util_convert/datetime_convert.dart';
import 'package:bv_cay_an_qua/shared/widget/widget-circle-avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../export.dart';
import '../issue_detail_page.dart';

class ListIssue extends StatefulWidget {
  final String tag;
  QueryInput? queryInput;

  // static Function(String)? search;

  ListIssue({Key? key, required this.tag, this.queryInput}) : super(key: key);

  @override
  _ListIssueState createState() => _ListIssueState();
}

class _ListIssueState extends State<ListIssue> {
  late IssueController _controller;

  ScrollController scrollController = ScrollController();

  StreamController _streamIssueTopic = StreamController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        Get.put(IssueController(query: widget.queryInput), tag: widget.tag);
    // _controller.getAllHospital();
    // _controller.getAllDoctor();
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _controller.loadMore();
      }
    });
    // ListIssue.search = (value) {
    //   print("value---$value");
    //   try {
    //     final queryInput = mapData(_controller.query.toJson(),
    //         QueryInput(limit: 10, page: 1, search: value).toJson());
    //     _controller.loadAll(query: queryInput);
    //   } catch (error) {
    //     print("ListIssue---error: $error");
    //   }
    // };
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamIssueTopic.close();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IssueController>(
      tag: widget.tag,
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: widget.tag == "frequent",
              child: StreamBuilder<dynamic>(
                  stream: _streamIssueTopic.stream,
                  builder: (context, snapshot) {
                    return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(
                              _controller.listIssueTopics.length,
                              (index) => GestureDetector(
                                    onTap: () {
                                      _controller.lastItem = false;
                                      if (_controller
                                              .listIssueTopics[index].id !=
                                          null) {
                                        _controller.loadAll(
                                            query: QueryInput(order: {
                                          "createdAt": -1
                                        }, filter: {
                                          ...{
                                            "isFAQ": true,
                                            "topicIds": [
                                              "${_controller.listIssueTopics[index].id}"
                                            ]
                                          },
                                          ..._controller.doctorFilter
                                        }, limit: 10, page: 1));
                                      } else {
                                        _controller.loadAll(
                                            query: QueryInput(order: {
                                          "createdAt": -1
                                        }, filter: {
                                          ...{
                                            "isFAQ": true,
                                          },
                                          ..._controller.doctorFilter
                                        }, limit: 10, page: 1));
                                      }
                                      _controller.countIssueTopic = index;
                                      _streamIssueTopic.sink.add(index);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 20),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                              color:
                                                  _controller.countIssueTopic ==
                                                          index
                                                      ? ColorConst.primaryColor
                                                      : Colors.grey.shade300)),
                                      child: Text(
                                        "${_controller.listIssueTopics[index].name}",
                                        style: StyleConst.mediumStyle(
                                            color:
                                                _controller.countIssueTopic ==
                                                        index
                                                    ? ColorConst.primaryColor
                                                    : Colors.black),
                                      ),
                                    ),
                                  )),
                        ));
                  }),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  _controller.refreshData();
                },
                child: ListView.builder(
                    controller: scrollController,
                    padding: EdgeInsets.only(bottom: 50),
                    itemCount: controller.loadMoreItems.value.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == controller.loadMoreItems.value.length) {
                        if (controller.loadMoreItems.value.length >=
                                (controller.pagination.value.limit ?? 10) ||
                            controller.loadMoreItems.value.length == 0) {
                          return WidgetLoading(
                            notData: controller.lastItem,
                            count: controller.loadMoreItems.value.length,
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      }
                      if (controller.lastItem == false &&
                          controller.loadMoreItems.value.length == 0) {
                        return WidgetLoading();
                      }
                      return InkWell(
                        onTap: () {
                          // Routing().navigate2(context, QuestionDetailScreen(question: question));
                          if (controller.loadMoreItems.value[index].id !=
                              null) {
                            Get.to(IssueDetailPage(
                              id: controller.loadMoreItems.value[index].id!,
                              tag: widget.tag,
                            ));
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: ColorConst.borderInputColor,
                                      width: 2))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(children: <Widget>[
                                WidgetCircleAvatar(
                                  url: controller.loadMoreItems.value[index]
                                          .owner?.avatar ??
                                      "",
                                  height: 39,
                                  width: 39,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                      text:
                                          "${controller.loadMoreItems.value[index].owner?.name ?? ""}",
                                      style: StyleConst.mediumStyle(),
                                    ),
                                    TextSpan(
                                      text:
                                          "\nCập nhật ${formatTime(controller.loadMoreItems.value[index].createdAt ?? "")}",
                                      style: StyleConst.regularStyle(
                                          fontSize: miniSize,
                                          height: 1.5,
                                          color: ColorConst.greyBlack),
                                    )
                                  ])),
                                ),
                                Visibility(
                                  visible: controller.loadMoreItems.value[index]
                                              .prescription !=
                                          null &&
                                      (controller.loadMoreItems.value[index]
                                                  .prescription?.status ==
                                              "fulfilled" ||
                                          controller.loadMoreItems.value[index]
                                                  .prescription?.status ==
                                              "assigning"),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Image.asset(
                                        'assets/icons/icon_show_ketoa.png',
                                        color: controller
                                                    .loadMoreItems
                                                    .value[index]
                                                    .prescription
                                                    ?.status ==
                                                "assigning"
                                            ? Colors.grey
                                            : ColorConst.primaryColor,
                                        width: 20.0),
                                  ),
                                ),
                                Visibility(
                                  visible: controller.loadMoreItems.value[index]
                                          .doctorCommented ??
                                      false,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Image.asset(
                                        'assets/images/doctor-comment.png',
                                        width: 22.0),
                                  ),
                                )
                              ]),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                    controller
                                            .loadMoreItems.value[index].desc ??
                                        'None',
                                    maxLines: 3,
                                    textAlign: TextAlign.justify,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        StyleConst.regularStyle(height: 1.5)),
                              ),
                              Visibility(
                                visible: controller.loadMoreItems.value[index]
                                            .images !=
                                        null &&
                                    (controller.loadMoreItems.value[index]
                                                .images?.length ??
                                            0) >
                                        0,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(
                                    bottom: 16,
                                  ),
                                  height: 60,
                                  child: ListView(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      children: controller
                                          .loadMoreItems.value[index].images!
                                          .map<Widget>(
                                            (item) => item.split(".").last ==
                                                    "mp4"
                                                ? WidgetVideo(
                                                    url: item,
                                                    size: 64,
                                                  )
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: ImagePickerWidget(
                                                      context: context,
                                                      size: 65,
                                                      listImage: controller
                                                          .loadMoreItems
                                                          .value[index]
                                                          .images,
                                                      resourceUrl: item,
                                                    ),
                                                  ),
                                          )
                                          .toList()),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: defaultSize * 2,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text:
                                            "${controller.loadMoreItems.value[index].rateStats?.rate ?? 0} - ",
                                        style: StyleConst.regularStyle(),
                                      ),
                                      TextSpan(
                                        text: controller
                                                        .loadMoreItems
                                                        .value[index]
                                                        .commentCount ==
                                                    null ||
                                                controller
                                                        .loadMoreItems
                                                        .value[index]
                                                        .commentCount ==
                                                    0
                                            ? 'Chưa có bình luận'
                                            : 'Có ${controller.loadMoreItems.value[index].commentCount} bình luận',
                                        style: StyleConst.regularStyle(),
                                      ),
                                    ]),
                                  )),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(right: 3.0),
                                        child: Text(
                                          "Chi tiết",
                                          style: StyleConst.mediumStyle(
                                              color: ColorConst.primaryColor),
                                        ),
                                      ), // text
                                      Icon(
                                        Icons.chevron_right,
                                        color: ColorConst.primaryColor,
                                        size: defaultSize,
                                      ), // icon
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        );
      },
    );
  }
}
