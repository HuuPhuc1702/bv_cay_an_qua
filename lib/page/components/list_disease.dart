import 'dart:async';

import 'package:bv_cay_an_qua/config/theme/color-constant.dart';
import 'package:bv_cay_an_qua/config/theme/style-constant.dart';
import 'package:bv_cay_an_qua/export.dart';
import 'package:bv_cay_an_qua/models/disease_model.dart';
import 'package:bv_cay_an_qua/page/controllers/disease_controller.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_image_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showListDisease(
    {required BuildContext context,
    Function(
      DiseaseModel? disease,
    )?
        callBack}) {
  DiseaseController _diseaseController = Get.put(DiseaseController());
  DiseaseModel? _disease;
  TextEditingController _textEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();
  scrollController.addListener(() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      _diseaseController.loadMore();
    }
  });

  showModalBottomSheet<void>(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      Widget _textField = WidgetTextField(
        controller: _textEditingController,
        hintText: "Vui lòng nhập ghi chú nếu có",
        keyboardType: TextInputType.multiline,
        padding: EdgeInsets.all(10),
        maxLine: 10,
        minLine: 10,
      );

      final StreamController _streamController = StreamController();
      return SizedBox(
        height: MediaQuery.of(context).size.height / 1.5,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: ColorConst.primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Danh sách bệnh loại bệnh",
                      style: StyleConst.boldStyle(color: Colors.white),
                    ),
                    GestureDetector(
                        onTap: () {
                          _streamController.close();
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.clear,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: GetBuilder<DiseaseController>(builder: (controller) {
                    return ListView.builder(
                      controller: scrollController,
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
                        return GestureDetector(
                          onTap: () {
                            _disease = controller.loadMoreItems.value[index];
                            controller.update();
                          },
                          child: Container(
                            color: (_disease?.id ?? "") ==
                                    controller.loadMoreItems.value[index].id
                                ? ColorConst.primaryColor.withOpacity(.4)
                                : Colors.white,
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              child: Row(
                                children: [
                                  WidgetImageNetWork(
                                    url: controller
                                        .loadMoreItems.value[index].thumbnail,
                                    width: 67,
                                    height: 67,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text:
                                              "${controller.loadMoreItems.value[index].name}",
                                          style: StyleConst.boldStyle(
                                              color: ColorConst.primaryColor)),
                                      TextSpan(
                                          text: "\nMã bệnh: ",
                                          style: StyleConst.regularStyle(
                                              height: 1.5,
                                              color: ColorConst.primaryColor)),
                                      TextSpan(
                                          text:
                                              "${controller.loadMoreItems.value[index].code ?? "Chưa cập nhật"}",
                                          style: StyleConst.regularStyle())
                                    ])),
                                  ),
                                  Icon(Icons.navigate_next)
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom + 10,
                    top: 5,
                    left: 16,
                    right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: WidgetButton(
                      text: "Quay lại",
                      textColor: ColorConst.primaryColor,
                      backgroundColor: Colors.white,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    )),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: WidgetButton(
                      text: "Xác nhận",
                      textColor: Colors.white,
                      onTap: () {
                        if (_disease == null) {
                          showSnackBar(
                              title: "Thông báo",
                              body: "vui lòng chọn loại bệnh",
                              backgroundColor: Colors.red);
                        } else {
                          Navigator.of(context).pop();
                          callBack?.call(_disease);
                        }
                      },
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
