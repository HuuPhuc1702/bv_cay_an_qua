import 'package:bv_cay_an_qua/services/graphql/crud_repo.dart';
import 'package:bv_cay_an_qua/shared/util_convert/datetime_convert.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../export.dart';
import 'controllers/history_activity_controller.dart';

class HistoryActivity extends StatefulWidget {
  const HistoryActivity({Key? key}) : super(key: key);

  @override
  _HistoryActivityState createState() => _HistoryActivityState();
}

class _HistoryActivityState extends State<HistoryActivity> {
  ScrollController scrollController = ScrollController();
  late HistoryActivityController _historyActivityController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _historyActivityController = Get.put(HistoryActivityController());

    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _historyActivityController.loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
      //       Text("Lịch sử hoạt động",
      //           style: StyleConst.boldStyle(
      //                   color: ColorConst.red, fontSize: titleSize)
      //               .copyWith(color: Colors.red, fontWeight: FontWeight.bold)),
      //       Text('www.benhviencayanqua.vn',
      //           style: StyleConst.mediumStyle(color: ColorConst.primaryColor)),
      //     ],
      //   ),
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
          WidgetAppbar(title: "Lịch sử hoạt động"),
          Expanded(child: GetBuilder<HistoryActivityController>(
            builder: (controller) {
              return ListView.builder(
                  itemCount: controller.loadMoreItems.value.length + 1,
                  controller: scrollController,
                  padding: EdgeInsets.only(bottom: 50),
                  itemBuilder: (context, index) {
                    if (index == controller.loadMoreItems.value.length) {
                      if (controller.loadMoreItems.value.length >=
                              (controller.pagination.value.limit ?? 10) ||
                          controller.loadMoreItems.value.length == 0) {
                        return WidgetLoading(
                          count: controller.loadMoreItems.value.length,
                          notData: controller.lastItem,
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    }
                    if (controller.lastItem == false &&
                        controller.loadMoreItems.value.length == 0) {
                      return WidgetLoading();
                    }

                    return Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.grey, width: 1))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${controller.loadMoreItems.value[index].message}",
                            style: StyleConst.mediumStyle(),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${formatTime(controller.loadMoreItems.value[index].createdAt ?? "")}",
                            style: StyleConst.regularStyle(
                                color: ColorConst.grey, fontSize: miniSize),
                          ),
                        ],
                      ),
                    );
                  });
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
    );
  }
}
