import 'dart:async';

import 'package:bv_cay_an_qua/models/topic_model.dart';
import 'package:bv_cay_an_qua/page/components/image_picker.dart';
import 'package:bv_cay_an_qua/page/issue/input_issue_page.dart';
import 'package:bv_cay_an_qua/page/post/post_controller.dart';
import 'package:bv_cay_an_qua/page/post/post_detail_page.dart';
import 'package:bv_cay_an_qua/services/graphql/crud_repo.dart';
import 'package:bv_cay_an_qua/services/graphql/graphql_list_provider.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_appbar.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../export.dart';
import 'package:rxdart/rxdart.dart';

class PostPage extends StatefulWidget {
  final String title;
  String? topicID;

  PostPage({Key? key, required this.title, this.topicID}) : super(key: key) {
    // print(this.tag);
    // tagParent = this.tag;
  }

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  late MediaQueryData _mediaQueryData;

  // TextEditingController _searchController = TextEditingController();
  // BehaviorSubject<String> _searchChangeBehavior =
  // BehaviorSubject<String>.seeded("");

  ScrollController scrollController = ScrollController();

  late PostController postController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postController = Get.put(
        PostController(
            query: mapData(
                PostController.queryInput.toJson(),
                QueryInput(filter: {"topicIds": "${widget.topicID!}"})
                    .toJson())),
        tag: "${widget.topicID}");

    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        postController.loadMore();
      }
    });

    // _searchChangeBehavior
    //     .debounceTime(Duration(milliseconds: 500))
    //     .listen((queryString) {
    //   postController.loadAll(
    //       query: mapData(
    //           PostController.queryInput.toJson(),
    //           QueryInput(
    //                   filter: { "topicIds" : "${widget.topicID??""}"},
    //                   limit: 10,
    //                   page: 1,
    //                   search: "$queryString")
    //               .toJson()));
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
        //       Text(widget.title,
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
              title: "${widget.title}",
              onChangeSearch: (valueSearch) {
                postController.loadAll(
                    query: mapData(
                        PostController.queryInput.toJson(),
                        QueryInput(
                                filter: {"topicIds": "${widget.topicID ?? ""}"},
                                limit: 10,
                                page: 1,
                                search: "$valueSearch")
                            .toJson()));
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
            //   // child: Container(
            //   //   height: 50,
            //   //   width: _mediaQueryData.size.width,
            //   //   decoration: BoxDecoration(
            //   //     color: ColorConst.primaryColor.withOpacity(.8),
            //   //       // gradient: LinearGradient(
            //   //       //     begin: Alignment.topRight,
            //   //       //     end: Alignment.bottomLeft,
            //   //       //     colors: [
            //   //       //   ColorConst.primaryColor,
            //   //       //   ColorConst.primaryColor.withOpacity(.8)
            //   //       // ])
            //   //       ),
            //   //   child: Center(
            //   //     child:
            //   //       WidgetSearch(
            //   //        hintText: "Tìm kiếm...",
            //   //        onChange: _searchChangeBehavior.sink.add,
            //   //        controller:_searchController,
            //   //        onSubmitted: (query) {
            //   //                 _searchChangeBehavior.sink.add(query);
            //   //        } ,
            //   //         )
            //   //     // child: TextField(
            //   //     //   controller: _searchController,
            //   //     //   style: StyleConst.boldStyle(fontSize: titleSize)
            //   //     //       .copyWith(color: Colors.white),
            //   //     //   cursorColor: Colors.white,
            //   //     //   onChanged: _searchChangeBehavior.sink.add,
            //   //     //   decoration: InputDecoration(
            //   //     //     hintText: "Tìm kiếm...",
            //   //     //     suffixIcon: StreamBuilder<String>(
            //   //     //       stream: _searchChangeBehavior.stream,
            //   //     //       builder: (context, snapshot) {
            //   //     //         if (snapshot.hasData == false ||
            //   //     //             (snapshot.data?.isEmpty ?? true)) return SizedBox();
            //   //     //         return GestureDetector(
            //   //     //           onTap: () {
            //   //     //             _searchChangeBehavior.sink.add('');
            //   //     //             _searchController.clear();
            //   //     //           },
            //   //     //           child: Icon(
            //   //     //             Icons.cancel,
            //   //     //             color: Colors.white70,
            //   //     //             size: titleSize * 1.5,
            //   //     //           ),
            //   //     //         );
            //   //     //       },
            //   //     //     ),
            //   //     //     contentPadding: EdgeInsets.only(
            //   //     //         left: 20,
            //   //     //         right: _searchController.text.isNotEmpty ? 0 : 20,
            //   //     //         top: 12.0),
            //   //     //     hintStyle: StyleConst.boldStyle(fontSize: titleSize)
            //   //     //         .copyWith(color: Colors.white70),
            //   //     //     border: InputBorder.none,
            //   //     //     enabledBorder: InputBorder.none,
            //   //     //     disabledBorder: InputBorder.none,
            //   //     //     focusedBorder: InputBorder.none,
            //   //     //   ),
            //   //     // ),
            //   //   ),
            //   // ),
            // ),
            Expanded(
                child: GetBuilder<PostController>(
              tag: widget.topicID,
              builder: (controller) {
                print(
                    "-------length of post---------${controller.loadMoreItems.value.length}");
                return RefreshIndicator(
                  onRefresh: () async {
                    controller.refreshData(topicIds: widget.topicID);
                  },
                  child: ListView.builder(
                      itemCount: controller.loadMoreItems.value.length + 1,
                      controller: scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
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
                              // Routing().navigate2(context, DocumentDetailScreen(postId: listDocument.id));
                              print(
                                  "----------${controller.loadMoreItems.value[index].id}");
                              Get.to(PostDetailPage(
                                id: controller.loadMoreItems.value[index].id ??
                                    "",
                                topicId: widget.topicID ?? "",
                              ));
                            },
                            child: Card(
                                child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ImagePickerWidget(
                                    context: context,
                                    size: 80,
                                    resourceUrl: controller.loadMoreItems
                                            .value[index].featureImage ??
                                        "",
                                    quality: 100,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.loadMoreItems.value[index]
                                                .title ??
                                            '',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: StyleConst.mediumStyle(),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        controller.loadMoreItems.value[index]
                                                .publishedAt ??
                                            'Không rõ ngày đăng',
                                        style: StyleConst.regularStyle(
                                            fontSize: miniSize,
                                            color: ColorConst.primaryColor),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  )),
                                  SizedBox(
                                      height: 80,
                                      child: Icon(Icons.chevron_right))
                                ],
                              ),
                            ))
                            //Card(
//                           child: ListTile(
//                             leading: ImagePickerWidget(
//                               context: context,
//                               size: 80,
//                               resourceUrl: controller
//                                       .loadMoreItems.value[index].featureImage ??
//                                   "",
//                               quality: 100,
//                             ),
//                             //  Image.network(listDocument.thumbnail),
//                             title: Text(
//                               controller.loadMoreItems.value[index].title ?? '',
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                               style: StyleConst.mediumStyle(),
//                             ),
//                             subtitle: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 Padding(
//                                   padding: EdgeInsets.symmetric(vertical: 5.0),
//                                   child: Text(
//                                     controller.loadMoreItems.value[index]
//                                             .publishedAt ??
//                                         'bbb',
//                                     style: StyleConst.regularStyle(fontSize: miniSize,color: ColorConst.primaryColor),
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
// //                            Padding(
// //                              padding: EdgeInsets.only(right: 5.0),
// //                              child: Icon(
// //                                Icons.remove_red_eye,
// //                                color: HexColor(appText60),
// //                                size: ptCaption(context).fontSize * 1.2,
// //                              ),
// //                            ),
//                               ],
//                             ),
//                             trailing: Icon(Icons.chevron_right),
//                             contentPadding: EdgeInsets.all(20),
//                             // isThreeLine: true,
//                           ),
//                         ),
                            );
                      }),
                );
              },
            )),
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
}
