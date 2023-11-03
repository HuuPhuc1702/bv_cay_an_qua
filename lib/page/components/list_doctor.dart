import 'dart:async';

import 'package:bv_cay_an_qua/config/theme/color-constant.dart';
import 'package:bv_cay_an_qua/config/theme/style-constant.dart';
import 'package:bv_cay_an_qua/export.dart';
import 'package:bv_cay_an_qua/models/doctor_model.dart';
import 'package:bv_cay_an_qua/page/controllers/doctor_controller.dart';
import 'package:bv_cay_an_qua/services/graphql/crud_repo.dart';
import 'package:bv_cay_an_qua/shared/helper/print_log.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_image_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

showListDoctor(
    {required BuildContext context,
    String? doctorType,

    ///LOC_TROI, SOFRI
    Function(
      DoctorModel? doctor,
      String? note,
    )?
        callBack}) {
  late DoctorController _doctorController;

  if (doctorType != null) {
    _doctorController = Get.put(DoctorController(
        query: QueryInput(filter: {"doctorType": "$doctorType"})));
  } else {
    _doctorController = Get.put(DoctorController());
  }

  DoctorModel? _doctor;
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _searchEditingController = TextEditingController();

  BehaviorSubject<String> _searchChangeBehavior =
      BehaviorSubject<String>.seeded("");
  //FocusNode focusNode = FocusNode();

  _searchChangeBehavior
      .debounceTime(Duration(milliseconds: 500))
      .listen((queryString) {
    // printLog(queryString);
    // if(_doctorController.queryInput!=null){
    //     _doctorController.loadAll(
    //         query: mapData(_doctorController.queryInput!.toJson(),
    //             QueryInput(limit: 20, page: 1, search: "$queryString").toJson()));
    // }
    _doctorController.loadAll(
        query: QueryInput(limit: 20, page: 1, search: queryString));
  });

  ScrollController scrollController = ScrollController();
  scrollController.addListener(() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      _doctorController.loadMore();
    }
  });

  // ScrollController scrollHideController = ScrollController();
  // scrollHideController.addListener(() {
  //   print(scrollHideController.position.pixels);
  //   if (focusNode.hasFocus){
  //   scrollHideController.animateTo(100, duration: Duration(milliseconds: 100), curve: Curves.ease);
  //   }
  // });

  showModalBottomSheet<void>(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      Widget _textField = WidgetTextField(
        //focusNode: focusNode,
        controller: _textEditingController,
        hintText: "Vui lòng nhập ghi chú nếu có",
        keyboardType: TextInputType.multiline,
        padding: EdgeInsets.all(10),
        maxLine: 10,
        minLine: 10,
      );

      final StreamController _streamController = StreamController();
      return AnimatedPadding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        duration: Duration(milliseconds: 200),
        child: Container(
          height: MediaQuery.of(context).size.height / 1.5,
          child: Container(
            color: Colors.transparent,
            child: Column(
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
                        "Danh sách bệnh bác sĩ",
                        style: StyleConst.boldStyle(color: Colors.white),
                      ),
                      GestureDetector(
                          onTap: () {
                            _searchChangeBehavior.close();
                            _streamController.close();
                            //scrollHideController.dispose();
                            //focusNode.dispose();
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
                    child: StreamBuilder<dynamic>(
                        stream: _streamController.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data == 2) {
                            return Container(
                              color: Colors.white,
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: ColorConst
                                                          .primaryColor)),
                                              padding: const EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  top: 10,
                                                  bottom: 10),
                                              margin: const EdgeInsets.only(
                                                  bottom: 20),
                                              child: Container(
                                                child: Row(
                                                  children: [
                                                    WidgetImageNetWork(
                                                      url: "",
                                                      width: 67,
                                                      height: 67,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      child: RichText(
                                                          text: TextSpan(
                                                              children: [
                                                            TextSpan(
                                                                text:
                                                                    "${_doctor?.name ?? "Chưa cập nhật"}",
                                                                style: StyleConst
                                                                    .boldStyle(
                                                                        color: ColorConst
                                                                            .primaryColor)),
                                                            TextSpan(
                                                                text:
                                                                    "\nHọc vị: ",
                                                                style: StyleConst
                                                                    .regularStyle(
                                                                        height:
                                                                            1.5,
                                                                        color: ColorConst
                                                                            .primaryColor)),
                                                            TextSpan(
                                                                text:
                                                                    "${_doctor?.degree ?? "Chưa cập nhật"}",
                                                                style: StyleConst
                                                                    .regularStyle())
                                                          ])),
                                                    ),
                                                    Icon(Icons.navigate_next)
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "Ghi chú",
                                              style: StyleConst.mediumStyle(
                                                  color:
                                                      ColorConst.primaryColor),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            _textField,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .padding
                                            .bottom,
                                        top: 5,
                                        left: 16,
                                        right: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: Text(
                                                "${snapshot.data ?? 1}/2")),
                                        Expanded(
                                            child: WidgetButton(
                                          text: "Quay lại",
                                          textColor: ColorConst.primaryColor,
                                          backgroundColor: Colors.white,
                                          radiusColor: Colors.white,
                                          onTap: () {
                                            _doctor = null;
                                            _streamController.sink.add(1);
                                          },
                                        )),
                                        Expanded(
                                            child: WidgetButton(
                                          text: "Tiếp tục",
                                          textColor: Colors.white,
                                          onTap: () {
                                            _searchChangeBehavior.close();
                                            _streamController.close();
                                            Navigator.pop(context);
                                            callBack?.call(_doctor,
                                                _textEditingController.text);
                                          },
                                        )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          ////////////////////////////////////////////////////////////////////////
                          return Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(.1),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          top: 2,
                                          bottom: 2,
                                          right: 5),
                                      child: Icon(
                                        Icons.search,
                                        size: titleSize * 1.8,
                                        color: Colors.grey.withOpacity(.6),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextField(
                                        controller: _searchEditingController,
                                        style: StyleConst.mediumStyle(),
                                        cursorColor: ColorConst.primaryColor,
                                        onChanged:
                                            _searchChangeBehavior.sink.add,
                                        decoration: InputDecoration(
                                          hintText: "Tìm kiếm...",
                                          isDense: true,
                                          hintStyle: StyleConst.mediumStyle(
                                              color: Colors.grey),
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5,
                                          top: 2,
                                          bottom: 2,
                                          right: 10),
                                      child: StreamBuilder<String>(
                                        stream: _searchChangeBehavior.stream,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData == false ||
                                              (snapshot.data?.isEmpty ?? true))
                                            return SizedBox();
                                          return GestureDetector(
                                            onTap: () {
                                              _searchChangeBehavior.sink
                                                  .add('');
                                              _searchEditingController.clear();
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
                              GetBuilder<DoctorController>(
                                  builder: (controller) {
                                return Expanded(
                                  child: ListView.builder(
                                    controller: scrollController,
                                    itemCount:
                                        controller.loadMoreItems.value.length +
                                            1,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      if (index ==
                                          controller
                                              .loadMoreItems.value.length) {
                                        if (controller.loadMoreItems.value
                                                    .length >=
                                                (controller.pagination.value
                                                        .limit ??
                                                    10) ||
                                            controller.loadMoreItems.value
                                                    .length ==
                                                0) {
                                          return WidgetLoading(
                                            notData: controller.lastItem,
                                            count: controller
                                                .loadMoreItems.value.length,
                                          );
                                        } else {
                                          return SizedBox.shrink();
                                        }
                                      }
                                      if (controller.lastItem == false &&
                                          controller
                                                  .loadMoreItems.value.length ==
                                              0) {
                                        return WidgetLoading();
                                      }
                                      return GestureDetector(
                                        onTap: () {
                                          _doctor = controller
                                              .loadMoreItems.value[index];
                                          controller.update();
                                        },
                                        child: Container(
                                          color: (_doctor?.id ?? "") ==
                                                  controller.loadMoreItems
                                                      .value[index].id
                                              ? ColorConst.primaryColor
                                                  .withOpacity(.4)
                                              : Colors.white,
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            child: Row(
                                              children: [
                                                WidgetImageNetWork(
                                                  url: controller.loadMoreItems
                                                      .value[index].avatar,
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
                                                            color: ColorConst
                                                                .primaryColor)),
                                                    TextSpan(
                                                        text: "\nHọc vị: ",
                                                        style: StyleConst
                                                            .regularStyle(
                                                                height: 1.5,
                                                                color: ColorConst
                                                                    .primaryColor)),
                                                    TextSpan(
                                                        text:
                                                            "${controller.loadMoreItems.value[index].degree ?? "Chưa cập nhật"}",
                                                        style: StyleConst
                                                            .regularStyle())
                                                  ])),
                                                ),
                                                Icon(Icons.navigate_next)
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }),
                              Container(
                                color: Colors.white,
                                padding: EdgeInsets.only(
                                    bottom:
                                        MediaQuery.of(context).padding.bottom +
                                            10,
                                    top: 5,
                                    left: 16,
                                    right: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child:
                                            Text("${(snapshot.data ?? 1)}/2")),
                                    Expanded(
                                        child: WidgetButton(
                                      text: "Tiếp tục",
                                      textColor: Colors.white,
                                      onTap: () {
                                        if (_doctor != null) {
                                          _streamController.sink.add(2);
                                        } else {
                                          showSnackBar(
                                              title: "Lưu ý",
                                              body: "Vui lòng chọn bác sĩ",
                                              backgroundColor: Colors.red);
                                        }
                                      },
                                    )),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
