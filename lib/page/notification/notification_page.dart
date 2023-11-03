import 'package:bv_cay_an_qua/shared/widget/widget_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../export.dart';
import 'notification_controller.dart';
import 'notification_detail_page.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool isSearch = false;
  TextEditingController _searchController = TextEditingController();
  NotificationController notificationController =
      Get.put(NotificationController());

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        notificationController.loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
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
          //         "assets/images/ic_back.png",
          //         fit: BoxFit.cover,
          //         width: 24,
          //         height: 24,
          //       ),
          //     ),
          //   ),
          //   actions: <Widget>[
          //     !isSearch
          //         ? IconButton(
          //             icon: Icon(Icons.search),
          //             color: ColorConst.textPrimary,
          //             onPressed: () {
          //               setState(() {
          //                 isSearch = true;
          //               });
          //             },
          //           )
          //         : IconButton(
          //             icon: Icon(Icons.clear),
          //             color: ColorConst.textPrimary,
          //             onPressed: () {
          //               setState(() {
          //                 isSearch = false;
          //                 _searchController.text = '';
          //               });
          //             },
          //           )
          //   ],
          //   brightness: Brightness.light,
          //   title: !isSearch
          //       ? Column(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: <Widget>[
          //             Text('Thông báo',
          //                 style: StyleConst.boldStyle(
          //                         color: ColorConst.red, fontSize: titleSize)
          //                     .copyWith(
          //                         color: Colors.red,
          //                         fontWeight: FontWeight.bold)),
          //             Text('www.benhviencaylua.vn',
          //                 style: StyleConst.mediumStyle(
          //                     color: ColorConst.primaryColor)),
          //           ],
          //         )
          //       : TextField(
          //           controller: _searchController,
          //           decoration: InputDecoration(
          //             hintText: "Tìm kiếm... ",
          //             contentPadding: EdgeInsets.only(
          //               left: 20,
          //               right: _searchController.text.isNotEmpty ? 0 : 20,
          //               top: 16,
          //               bottom: 16,
          //             ),
          //             hintStyle: StyleConst.mediumStyle(),
          //             fillColor: Theme.of(context).primaryColor,
          //             focusedBorder: OutlineInputBorder(
          //               borderRadius: BorderRadius.all(Radius.circular(20.0)),
          //               borderSide: BorderSide(
          //                   color: Theme.of(context).primaryColor, width: 2.0),
          //             ),
          //             enabledBorder: OutlineInputBorder(
          //               borderRadius: BorderRadius.all(Radius.circular(20.0)),
          //               borderSide: BorderSide(
          //                   color: ColorConst.borderInputColor, width: 2.0),
          //             ),
          //           ),
          //           onChanged: (String value) {
          //             // searchNoti(value);
          //             notificationController.search(value);
          //           },
          //           onSubmitted: (String value) {
          //             notificationController.search(value);
          //           },
          //         ),
          //   elevation: 2,
          //   backgroundColor: Colors.white,
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
            title: "Thông báo",
            onChangeSearch: (value) {
              notificationController.search(value);
            },
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      // bottom: 70+ MediaQuery.of(context).padding.bottom),
                      bottom: MediaQuery.of(context).padding.bottom),
                  child: RefreshIndicator(
                    color: ColorConst.primaryColor,
                    onRefresh: () async {
                      notificationController.refreshData();
                    },
                    child: GetBuilder<NotificationController>(
                      builder: (controller) {
                        return ListView.builder(
                            itemCount:
                                controller.loadMoreItems.value.length + 1,
                            controller: scrollController,
                            padding: EdgeInsets.zero,
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
                                  controller.loadMoreItems.value.length == 0) {
                                return WidgetLoading();
                              }
                              return GestureDetector(
                                onTap: () {
                                  controller.itemClick(
                                      notify: controller
                                          .loadMoreItems.value[index]);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: controller.loadMoreItems.value[index]
                                                .seen ??
                                            false
                                        ? Colors.white
                                        : ColorConst.primaryColor
                                            .withOpacity(.2),
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1,
                                            color:
                                                Colors.grey.withOpacity(0.2))),
                                  ),
                                  child: ListTile(
                                    leading: Image.asset(
                                      "assets/images/logo2.png",
                                      width: 60,
                                      height: 60,
                                    ),
                                    title: Text(
                                      controller.loadMoreItems.value[index]
                                              .title ??
                                          "",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: StyleConst.mediumStyle(),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          controller.loadMoreItems.value[index]
                                                  .body ??
                                              "",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: StyleConst.regularStyle(),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  controller
                                                          .loadMoreItems
                                                          .value[index]
                                                          .createdAt ??
                                                      "",
                                                  style:
                                                      StyleConst.regularStyle(
                                                          color: ColorConst
                                                              .primaryColor
                                                              .withOpacity(.5)),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                controller
                                                            .loadMoreItems
                                                            .value[index]
                                                            .seen ??
                                                        false
                                                    ? ''
                                                    : '● Chưa đọc',
                                                style: StyleConst.mediumStyle(
                                                    color: ColorConst
                                                        .primaryColor
                                                        .withOpacity(.5)),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: Icon(Icons.chevron_right),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 18, horizontal: 16),

                                    // isThreeLine: true,
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                  ),
                ),
                // Positioned(
                //   bottom: 0,
                //   child: Image.asset(
                //     "assets/images/home_bottom.png",
                //     width: MediaQuery.of(context).size.width,
                //     fit: BoxFit.cover,
                //     alignment: Alignment.bottomCenter,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
