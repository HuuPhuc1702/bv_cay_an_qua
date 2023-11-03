import 'dart:async';

import 'package:bv_cay_an_qua/page/components/image_picker.dart';
import 'package:bv_cay_an_qua/page/components/widget_video.dart';
import 'package:bv_cay_an_qua/page/news/controllers/userpost_controller.dart';
import 'package:bv_cay_an_qua/services/graphql/crud_repo.dart';
import 'package:bv_cay_an_qua/shared/util_convert/datetime_convert.dart';
import 'package:bv_cay_an_qua/shared/widget/widget-circle-avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../export.dart';
import '../detail_userpost_page.dart';

class ListUserPost extends StatefulWidget {
  final String tag;
  QueryInput? queryInput;

  // static Function(String)? search;

  ListUserPost({Key? key, required this.tag, this.queryInput})
      : super(key: key);

  @override
  _ListUserPostState createState() => _ListUserPostState();
}

class _ListUserPostState extends State<ListUserPost> {
  late UserPostController _controller;

  ScrollController scrollController = ScrollController();

  StreamController _streamIssueTopic = StreamController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        Get.put(UserPostController(query: widget.queryInput), tag: widget.tag);

    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _controller.loadMore();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamIssueTopic.close();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserPostController>(
      tag: widget.tag,
      builder: (controller) {
        return RefreshIndicator(
          onRefresh: () async {
            _controller.loadAll();
          },
          child: ListView.builder(
              controller: scrollController,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
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
                    if (controller.loadMoreItems.value[index].id != null) {
                      Get.to(DetailUserPostPage(
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
                                color: ColorConst.borderInputColor, width: 2))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(children: <Widget>[
                          WidgetCircleAvatar(
                            url: controller
                                    .loadMoreItems.value[index].owner?.avatar ??
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
                                    color: ColorConst.grey),
                              )
                            ])),
                          ),
                        ]),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                              controller.loadMoreItems.value[index].content ??
                                  'None',
                              maxLines: 3,
                              textAlign: TextAlign.justify,
                              style: StyleConst.regularStyle(height: 1.5)),
                        ),
                        Visibility(
                          visible:
                              controller.loadMoreItems.value[index].images !=
                                      null &&
                                  (controller.loadMoreItems.value[index].images
                                              ?.length ??
                                          0) >
                                      0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(bottom: 16),
                            height: 60,
                            child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: controller
                                    .loadMoreItems.value[index].images!
                                    .map<Widget>(
                                      (item) => item.split(".").last == "mp4"
                                          ? WidgetVideo(
                                              url: item,
                                              size: 64,
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.only(
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
                          children: <Widget>[
                            Expanded(
                              flex: 6,
                              child: Row(
                                children: [
                                  Text(
                                    controller.loadMoreItems.value[index]
                                                    .commentCount ==
                                                null ||
                                            controller
                                                    .loadMoreItems
                                                    .value[index]
                                                    .commentCount ==
                                                0
                                        ? 'Chưa có bình luận'
                                        : 'Có ${controller.loadMoreItems.value[index].commentCount} bình luận',
                                    style: StyleConst.regularStyle(
                                        fontSize: miniSize),
                                  ),
                                  Text(
                                    " (Đã có ${controller.loadMoreItems.value[index].viewCount} xem)",
                                    style: StyleConst.regularStyle(
                                        fontSize: miniSize),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
        );
      },
    );
  }
}
