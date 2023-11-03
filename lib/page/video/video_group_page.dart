import 'dart:io';

import 'package:bv_cay_an_qua/page/issue/input_issue_page.dart';
import 'package:bv_cay_an_qua/page/video/video_page.dart';
import 'package:bv_cay_an_qua/services/graphql/crud_repo.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_appbar.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_image_network.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_search.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../export.dart';
import 'controllers/video_controller.dart';
import 'controllers/video_group_controller.dart';
import 'video_view.dart';

class VideoGroupPage extends StatefulWidget {
  VideoGroupPage({Key? key}) : super(key: key);

  @override
  _VideoGroupPageState createState() => _VideoGroupPageState();
}

class _VideoGroupPageState extends State<VideoGroupPage> {
  late MediaQueryData _mediaQueryData;

  // TextEditingController _searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  // BehaviorSubject<String> _searchChangeBehavior =
  //     BehaviorSubject<String>.seeded("");

  late VideoGroupController videoGroupController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoGroupController = Get.put(VideoGroupController());

    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        videoGroupController.loadMore();
      }
    });

    // _searchChangeBehavior
    //     .debounceTime(Duration(milliseconds: 500))
    //     .listen((queryString) {
    //   videoGroupController.loadAll(query: QueryInput(search: queryString));
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _searchChangeBehavior.close();
  }

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);

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
      //       Text("Danh mục video",
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
      //
      //         // Routing().navigate2(context, CreatQuestionScreen());
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
            title: "Danh mục video",
            onChangeSearch: (value) {
              videoGroupController.loadAll(query: QueryInput(search: value));
            },
          ),
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
                    //       color: ColorConst.primaryColor.withOpacity(.8),
                    //         // gradient: LinearGradient(
                    //         //     begin: Alignment.topRight,
                    //         //     end: Alignment.bottomLeft,
                    //         //     colors: [
                    //         //   ColorConst.primaryColor,
                    //         //   ColorConst.primaryColor.withOpacity(.8)
                    //         // ])
                    //         ),
                    //     child: Center(
                    //        child:  WidgetSearch(
                    //        hintText: "Tìm kiếm...",
                    //        onChange: _searchChangeBehavior.sink.add,
                    //        controller:_searchController,
                    //        onSubmitted: (query) {
                    //                 _searchChangeBehavior.sink.add(query);
                    //        } ,
                    //         )
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
                    GestureDetector(
                      onTap: () {
                        Get.to(VideoPage(
                          title: "Danh sách video",
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "xem tất cả video".toUpperCase(),
                          style: StyleConst.regularStyle(
                              color: ColorConst.primaryColor),
                        ),
                      ),
                    ),
                    Expanded(child: GetBuilder<VideoGroupController>(
                      builder: (controller) {
                        return RefreshIndicator(
                          onRefresh: () async {
                            controller.refreshData();
                          },
                          child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount:
                                  controller.loadMoreItems.value.length + 1,
                              controller: scrollController,
                              itemBuilder: (context, index) {
                                if (index ==
                                    controller.loadMoreItems.value.length) {
                                  if (controller.loadMoreItems.value.length >=
                                          (controller.pagination.value.limit ??
                                              10) ||
                                      controller.loadMoreItems.value.length ==
                                          0) {
                                    return WidgetLoading(
                                      notData: controller.lastItem,
                                      count:
                                          controller.loadMoreItems.value.length,
                                    );
                                  } else {
                                    return SizedBox.shrink();
                                  }
                                }
                                if (controller.lastItem == false &&
                                    controller.loadMoreItems.value.length ==
                                        0) {
                                  return WidgetLoading();
                                }

                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(18),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  width: 1, color: Colors.grey),
                                              top: BorderSide(
                                                  width: 1,
                                                  color: Colors.grey))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${controller.loadMoreItems.value[index].name}"
                                                .toUpperCase(),
                                            style: StyleConst.boldStyle(),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Get.to(VideoPage(
                                                title: controller.loadMoreItems
                                                        .value[index].name ??
                                                    "None",
                                                groupId: controller
                                                    .loadMoreItems
                                                    .value[index]
                                                    .id,
                                              ));
                                            },
                                            child: Text(
                                              "Xem thêm",
                                              style: StyleConst.mediumStyle(
                                                  color:
                                                      ColorConst.primaryColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: List.generate(
                                            controller
                                                    .loadMoreItems
                                                    .value[index]
                                                    .videos
                                                    ?.length ??
                                                0, (index2) {
                                          var dataItem = controller
                                              .loadMoreItems
                                              .value[index]
                                              .videos![index2];
                                          return Container(
                                              padding: EdgeInsets.all(18.0),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      child: InkWell(
                                                        child:
                                                            WidgetImageNetWork(
                                                          width:
                                                              double.infinity,
                                                          height: 200.0,
                                                          fit: BoxFit.cover,
                                                          url: dataItem.thumb ??
                                                              "",
                                                        ),
                                                        onTap: () async {
                                                          String? videoId;
                                                          print(
                                                              "https://www.youtube.com/watch?v=${dataItem.videoId}");
                                                          videoId = YoutubePlayer
                                                              .convertUrlToId(
                                                                  "https://www.youtube.com/watch?v=${dataItem.videoId}");
                                                          print(videoId);

                                                          if (videoId != null) {
                                                            Get.to(VideoView(
                                                              videoId: videoId,
                                                            ));
                                                          }
                                                        },
                                                      )),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 8.0),
                                                      child: Text(
                                                        dataItem.title ??
                                                            'Không có tiêu đề',
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: StyleConst
                                                            .boldStyle(),
                                                      )),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 8.0),
                                                      child: Text(
                                                        dataItem.published ??
                                                            '',
                                                        style: StyleConst
                                                            .regularStyle(),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      )),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 8.0),
                                                    child: Text(
                                                        dataItem.description ??
                                                            'Không có mô tả',
                                                        style: TextStyle(
                                                            fontSize: 14.0,
                                                            color: Colors
                                                                .black87)),
                                                  ),
                                                ],
                                              ));
                                        }),
                                      ),
                                    )
                                  ],
                                );
                              }),
                        );
                      },
                    )),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
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
    );
  }
}
