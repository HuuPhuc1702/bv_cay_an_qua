import 'dart:async';

import 'package:bv_cay_an_qua/config/theme/color-constant.dart';
import 'package:bv_cay_an_qua/config/theme/style-constant.dart';
import 'package:bv_cay_an_qua/export.dart';
import 'package:bv_cay_an_qua/models/doctor_model.dart';
import 'package:bv_cay_an_qua/page/controllers/doctor_controller.dart';
import 'package:bv_cay_an_qua/page/hospital/controllers/hospital_controller.dart';
import 'package:bv_cay_an_qua/page/controllers/setting_controller.dart';
import 'package:bv_cay_an_qua/services/graphql/crud_repo.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_image_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bv_cay_an_qua/models/hospital_model.dart';
import 'package:rxdart/rxdart.dart';

showListHospital(
    {required BuildContext context,
    Function(
      HospitalModel hospital,
      DoctorModel? doctor,
      dynamic lydo,
    )?
        callBack}) {
  late HospitalController _hospitalController;
  late DoctorController _doctorController;
  late SettingController _settingController;
  int chooseIndex = 0;

  _hospitalController = Get.put(HospitalController());
  _doctorController = Get.put(DoctorController());
  _settingController = Get.put(SettingController(
      query: QueryInput(filter: {"key": "CH_LY_DO_CHUYEN_BS"})));

  HospitalModel? _hospital;
  DoctorModel? _doctor;
  TextEditingController _searchHospitalEditingController =
      TextEditingController();
  TextEditingController _searchDoctorEditingController =
      TextEditingController();
  BehaviorSubject<String> _searchHospitalChangeBehavior =
      BehaviorSubject<String>.seeded("");
  BehaviorSubject<String> _searchDoctorChangeBehavior =
      BehaviorSubject<String>.seeded("");

  _searchHospitalChangeBehavior
      .debounceTime(Duration(milliseconds: 500))
      .listen((queryString) {
    _hospitalController.loadAll(
        query: QueryInput(limit: 20, page: 1, search: queryString));
  });

  _searchDoctorChangeBehavior
      .debounceTime(Duration(milliseconds: 500))
      .listen((queryString) {
    _doctorController.loadAll(
        query: QueryInput(limit: 20, page: 1, search: "$queryString"));
  });

  ScrollController scrollController = ScrollController();
  ScrollController scrollDoctorController = ScrollController();

  scrollController.addListener(() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      _hospitalController.loadMore();
    }
  });

  scrollDoctorController.addListener(() {
    if (scrollDoctorController.position.pixels ==
        scrollDoctorController.position.maxScrollExtent) {
      _doctorController.loadMore();
    }
  });

  showModalBottomSheet<void>(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      _buildTitle(AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData && snapshot.data == 3) {
          return Text(
            "Chọn lý do",
            style: StyleConst.boldStyle(color: Colors.white),
          );
        } else if (snapshot.hasData && snapshot.data == 2) {
          return Text(
            "Chọn bác sĩ",
            style: StyleConst.boldStyle(color: Colors.white),
          );
        }
        return Text(
          "Chọn bệnh viện",
          style: StyleConst.boldStyle(color: Colors.white),
        );
      }

      _buildMainWidget(
          AsyncSnapshot<dynamic> snapshot, StreamController _streamController) {
        if (snapshot.hasData && snapshot.data == 3) {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.only(bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetBuilder<SettingController>(builder: (settingController) {
                  return Flexible(
                      child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount:
                        settingController.loadMoreItems.value[0].value.length,
                    itemBuilder: (context, index) {
                      if (settingController.lastItem == false &&
                          settingController
                                  .loadMoreItems.value[0].value.length ==
                              0) {
                        return WidgetLoading();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 15),
                        child: GestureDetector(
                          onTap: () {
                            chooseIndex = index;
                            settingController.update();
                          },
                          child: Row(children: [
                            chooseIndex == index
                                ? Icon(Icons.radio_button_checked_outlined)
                                : Icon(Icons.radio_button_off_outlined),
                            SizedBox(width: 15),
                            settingController
                                        .loadMoreItems.value[0].value[index] !=
                                    null
                                ? Text(
                                    "${settingController.loadMoreItems.value[0].value[index].toString()}",
                                    style: StyleConst.regularStyle(
                                        fontWeight: FontWeight.bold))
                                : SizedBox()
                          ]),
                        ),
                      );
                    },
                  ));
                }),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom,
                      top: 5,
                      left: 16,
                      right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(child: Text("${snapshot.data ?? 1}/3")),
                      WidgetButton(
                        text: "Quay lại",
                        textColor: ColorConst.primaryColor,
                        backgroundColor: Colors.white,
                        radiusColor: Colors.white,
                        onTap: () {
                          _hospital = null;
                          _doctor = null;
                          _streamController.sink.add(2);
                        },
                      ),
                      WidgetButton(
                        text: "Xác nhận",
                        textColor: Colors.white,
                        onTap: () {
                          Navigator.pop(context);
                          if (_hospital != null) {
                            callBack?.call(
                                _hospital!,
                                _doctor,
                                _settingController
                                    .loadMoreItems.value[0].value[chooseIndex]);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasData && snapshot.data == 2) {
          return Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                        controller: _searchDoctorEditingController,
                        style: StyleConst.mediumStyle(),
                        cursorColor: ColorConst.primaryColor,
                        onChanged: _searchDoctorChangeBehavior.sink.add,
                        decoration: InputDecoration(
                          hintText: "Tìm kiếm...",
                          isDense: true,
                          hintStyle: StyleConst.mediumStyle(color: Colors.grey),
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
                        stream: _searchDoctorChangeBehavior.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData == false ||
                              (snapshot.data?.isEmpty ?? true))
                            return SizedBox();
                          return GestureDetector(
                            onTap: () {
                              _searchDoctorChangeBehavior.sink.add('');
                              _searchDoctorEditingController.clear();
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
              GetBuilder<DoctorController>(builder: (_doctorController) {
                // print("bác sĩ ${_doctorController.loadMoreItems.value.length}");
                return Flexible(
                  child: ListView.builder(
                    controller: scrollDoctorController,
                    itemCount: _doctorController.loadMoreItems.value.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index ==
                          _doctorController.loadMoreItems.value.length) {
                        if (_doctorController.loadMoreItems.value.length >=
                                (_doctorController.pagination.value.limit ??
                                    10) ||
                            _doctorController.loadMoreItems.value.length == 0) {
                          print(_doctorController.loadMoreItems.value.length);
                          return WidgetLoading(
                            notData: _doctorController.lastItem,
                            count: _doctorController.loadMoreItems.value.length,
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      }
                      if (_doctorController.lastItem == false &&
                          _doctorController.loadMoreItems.value.length == 0) {
                        return WidgetLoading();
                      }
                      return GestureDetector(
                        onTap: () {
                          _doctor =
                              _doctorController.loadMoreItems.value[index];
                          _doctorController.update();
                        },
                        child: Container(
                          color: (_doctor?.id ?? "") ==
                                  _doctorController
                                      .loadMoreItems.value[index].id
                              ? ColorConst.primaryColor.withOpacity(.4)
                              : Colors.white,
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            child: Row(
                              children: [
                                WidgetImageNetWork(
                                  url: _doctorController
                                      .loadMoreItems.value[index].avatar,
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
                                            "${_doctorController.loadMoreItems.value[index].name}",
                                        style: StyleConst.boldStyle(
                                            color: ColorConst.primaryColor)),
                                    TextSpan(
                                        text: "\nHọc vị: ",
                                        style: StyleConst.regularStyle(
                                            height: 1.5,
                                            color: ColorConst.primaryColor)),
                                    TextSpan(
                                        text:
                                            "${_doctorController.loadMoreItems.value[index].degree ?? "Chưa cập nhật"}",
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
                  ),
                );
              }),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom + 10,
                    top: 5,
                    left: 16,
                    right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text("${snapshot.data ?? 1}/3")),
                    Expanded(
                        child: WidgetButton(
                      text: "Quay lại",
                      textColor: ColorConst.primaryColor,
                      backgroundColor: Colors.white,
                      radiusColor: Colors.white,
                      onTap: () {
                        _hospital = null;
                        _doctor = null;
                        _streamController.sink.add(1);
                      },
                    )),
                    Expanded(
                        child: WidgetButton(
                      text: "Tiếp tục",
                      textColor: Colors.white,
                      onTap: () {
                        // if (_doctor != null) {
                        //   _streamController.sink.add(3);
                        // } else {
                        //   showSnackBar(
                        //       title: "Lưu ý", body: "Vui lòng chọn bác sĩ",backgroundColor: Colors.red);
                        // }
                        _streamController.sink.add(3);
                      },
                    )),
                  ],
                ),
              ),
            ],
          );
        }
        return Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                      controller: _searchHospitalEditingController,
                      style: StyleConst.mediumStyle(),
                      cursorColor: ColorConst.primaryColor,
                      onChanged: _searchHospitalChangeBehavior.sink.add,
                      decoration: InputDecoration(
                        hintText: "Tìm kiếm...",
                        isDense: true,
                        hintStyle: StyleConst.mediumStyle(color: Colors.grey),
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
                      stream: _searchHospitalChangeBehavior.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData == false ||
                            (snapshot.data?.isEmpty ?? true)) return SizedBox();
                        return GestureDetector(
                          onTap: () {
                            _searchHospitalChangeBehavior.sink.add('');
                            _searchHospitalEditingController.clear();
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
            GetBuilder<HospitalController>(builder: (_hospitalController) {
              // print(_hospitalController.loadMoreItems.value.length);
              return Flexible(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: _hospitalController.loadMoreItems.value.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index ==
                        _hospitalController.loadMoreItems.value.length) {
                      if (_hospitalController.loadMoreItems.value.length >=
                              (_hospitalController.pagination.value.limit ??
                                  10) ||
                          _hospitalController.loadMoreItems.value.length == 0) {
                        print(_hospitalController.loadMoreItems.value.length);
                        return WidgetLoading(
                          notData: _hospitalController.lastItem,
                          count: _hospitalController.loadMoreItems.value.length,
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    }
                    if (_hospitalController.lastItem == false &&
                        _hospitalController.loadMoreItems.value.length == 0) {
                      return WidgetLoading();
                    }
                    return GestureDetector(
                      onTap: () {
                        _hospital =
                            _hospitalController.loadMoreItems.value[index];
                        _hospitalController.update();
                      },
                      child: Container(
                        color: (_hospital?.id ?? "") ==
                                _hospitalController
                                    .loadMoreItems.value[index].id
                            ? ColorConst.primaryColor.withOpacity(.4)
                            : Colors.white,
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          child: Row(
                            children: [
                              WidgetImageNetWork(
                                url: _hospitalController
                                    .loadMoreItems.value[index].logo,
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
                                          "${_hospitalController.loadMoreItems.value[index].name}",
                                      style: StyleConst.boldStyle(
                                          color: ColorConst.primaryColor)),
                                  TextSpan(
                                      text: "\nSố điện thoại: ",
                                      style: StyleConst.regularStyle(
                                          height: 1.5,
                                          color: ColorConst.primaryColor)),
                                  TextSpan(
                                      text:
                                          "${_hospitalController.loadMoreItems.value[index].phone ?? "Chưa cập nhật"}",
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
                ),
              );
            }),
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
                  Expanded(child: Text("${(snapshot.data ?? 1)}/3")),
                  Expanded(
                      child: WidgetButton(
                    text: "Tiếp tục",
                    textColor: Colors.white,
                    onTap: () {
                      if (_hospital != null) {
                        print("hospital id : ${_hospital?.id}");

                        _doctorController.loadAll(
                            query: QueryInput(
                                filter: {"hospitalId": "${_hospital?.id}"}));
                        _streamController.sink.add(2);
                      } else {
                        showSnackBar(
                            title: "Lưu ý",
                            body: "Vui lòng chọn bệnh viện",
                            backgroundColor: Colors.red);
                      }
                    },
                  )),
                ],
              ),
            ),
          ],
        );
      }

      final StreamController _streamController = StreamController();
      return AnimatedPadding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        duration: Duration(milliseconds: 200),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 1.5,
          child: Container(
            color: Colors.transparent,
            child: StreamBuilder<dynamic>(
                stream: _streamController.stream,
                builder: (context, snapshot) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                            _buildTitle(snapshot),
                            GestureDetector(
                                onTap: () {
                                  _streamController.close();
                                  _searchHospitalChangeBehavior.close();
                                  _searchDoctorChangeBehavior.close();
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
                            child:
                                _buildMainWidget(snapshot, _streamController)),
                      ),
                    ],
                  );
                }),
          ),
        ),
      );
    },
  );
}
