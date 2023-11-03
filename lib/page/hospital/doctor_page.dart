import 'package:bv_cay_an_qua/config/theme/color-constant.dart';
import 'package:bv_cay_an_qua/config/theme/style-constant.dart';
import 'package:bv_cay_an_qua/models/doctor_model.dart';
import 'package:bv_cay_an_qua/models/hospital_model.dart';
import 'package:bv_cay_an_qua/page/components/image_picker.dart';
import 'package:bv_cay_an_qua/page/controllers/doctor_controller.dart';
import 'package:bv_cay_an_qua/services/graphql/crud_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../export.dart';

class DoctorPage extends StatefulWidget {
  final HospitalModel hospitalModel;

  DoctorPage({Key? key, required this.hospitalModel}) : super(key: key);

  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  ScrollController scrollController = ScrollController();
  late DoctorController doctorController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doctorController = Get.put(DoctorController(
        query:
            QueryInput(filter: {"hospitalId": "${widget.hospitalModel.id}"})));
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        doctorController.loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        brightness: Brightness.light,
        elevation: 2,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(28),
            child: Container(
              height: kToolbarHeight + 20,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: ColorConst.primaryColor,
                    width: 8.0,
                  ),
                ),
              ),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Image.asset(
                        "assets/images/ic_back.png",
                        fit: BoxFit.cover,
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      leading: ImagePickerWidget(
                        context: context,
                        avatar: true,
                        size: kToolbarHeight * 0.9,
                        resourceUrl: widget.hospitalModel.logo ?? "",
                        quality: 100,
                      ),
                      title: Text(
                        widget.hospitalModel.name?.trim() ?? "Chưa cập nhật",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: StyleConst.boldStyle(),
                      ),
                      subtitle: Text(
                        widget.hospitalModel.place?.fullAddress?.trim() ??
                            "Chưa cập nhật",
                        style: StyleConst.regularStyle(
                            color: ColorConst.primaryColor.withOpacity(.8)),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // contentPadding: EdgeInsets.all(20),
                      // isThreeLine: true,
                    ),
                  ),
                ],
              ),
            )),
      ),
      body: GetBuilder<DoctorController>(
        builder: (controller) {
          return ListView.builder(
              controller: scrollController,
              itemCount: controller.loadMoreItems.value.length + 1,
              itemBuilder: (cxt, index) {
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
                    showNow(controller.loadMoreItems.value[index]);
                  },
                  // padding: EdgeInsets.only(top: 19),
                  // margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 16),
                                child: ImagePickerWidget(
                                  context: context,
                                  size: 86,
                                  positionUser: 'doctor',
                                  resourceUrl: controller
                                          .loadMoreItems.value[index].avatar ??
                                      "",
                                  quality: 100,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                          controller.loadMoreItems.value[index]
                                                  .name ??
                                              "Chưa cập nhật",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: StyleConst.boldStyle(
                                            color: ColorConst.primaryColor,
                                          )),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 5, bottom: 10),
                                        child: RichText(
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            text: TextSpan(children: [
                                              TextSpan(
                                                text: 'Học vị: ',
                                                style: StyleConst.regularStyle(
                                                    color: ColorConst
                                                        .primaryColor),
                                              ),
                                              TextSpan(
                                                  text: controller.loadMoreItems
                                                          .value[index].degree
                                                          ?.trim() ??
                                                      "Chưa cập nhật",
                                                  style:
                                                      StyleConst.regularStyle())
                                            ])),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 16),
                                child: GestureDetector(
                                  onTap: () async {
                                    if (controller
                                            .loadMoreItems.value[index].phone !=
                                        null) {
                                      await canLaunch(
                                              "tel:${controller.loadMoreItems.value[index].phone}")
                                          ? await launch(
                                              "tel:${controller.loadMoreItems.value[index].phone}")
                                          : throw 'Could not launch tel:${controller.loadMoreItems.value[index].phone}';
                                      // openWebBrowerhURL(
                                      //     "tel:${hospitalModel?.phone?.trim().toString().replaceAll(' ', '')}");
                                    }
                                  },
                                  child: Icon(
                                    Icons.phone,
                                    color: controller.loadMoreItems.value[index]
                                                .phone?.isNotEmpty ??
                                            false
                                        ? ColorConst.primaryColor
                                        : Colors.grey.withAlpha(100),
                                  ),
                                ),
                              ),
                              // ListTile(
                              //   leading: Image.asset(
                              //     "assets/images/bg_splash.png",
                              //     width: 86,
                              //     height: 200,
                              //     fit: BoxFit.cover,
                              //   ),
                              //   title: Text(
                              //     'TS. NGUYỄN VĂN HÒA $index ',
                              //     maxLines: 1,
                              //     style: ptBody1(context).copyWith(fontSize: ptBody1(context).fontSize * 1.2),
                              //   ),
                              //   subtitle:  SizedBox(height: 5),RichText(
                              //       maxLines: 3,
                              //       text: TextSpan(children: [
                              //         TextSpan(
                              //           text: 'Ch��c vụ: ',
                              //           style: ptCaption(context).copyWith(color: HexColor(appColor)),
                              //         ),
                              //         TextSpan(
                              //             text: "Phó viện trưởng Viện CAQ MN, Giám đốc Bệnh viện cây trồng Trung tâm…",
                              //             style: ptCaption(context).copyWith(height: 1.5))
                              //       ])),

                              //   // trailing: Icon(Icons.chevron_right),
                              //   // contentPadding: EdgeInsets.all(20),
                              //   // isThreeLine: true,
                              // ),
                            ],
                          ),
                        ),
                      )),
                );
              });
        },
      ),
    );
  }

  showNow(DoctorModel doctor) {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black12.withOpacity(0.6),
      // background color
      barrierDismissible: false,
      // should dialog be dismissed when tapped outside
      barrierLabel: "Dialog",
      // label for barrier
      transitionDuration: Duration(milliseconds: 400),
      // how long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // your widget implementation
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              Container(
                height: 150,
                child: Image.asset(
                  AssetsConst.errorPlaceHolder,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.bottomRight,
                      height: kToolbarHeight + 20,
                      padding: EdgeInsets.only(right: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white54,
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height -
                          kToolbarHeight -
                          30,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Align(
                                  child: Column(
                                children: <Widget>[
                                  ImagePickerWidget(
                                      context: context,
                                      size: 86,
                                      quality: 100,
                                      positionUser: 'doctor',
                                      resourceUrl: doctor.avatar ?? ""),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text(
                                      doctor.name?.trim() ?? 'Chưa cập nhật',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: StyleConst.boldStyle(
                                          color: ColorConst.primaryColor),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40),
                                    child: WidgetButton(
                                      onTap: () async {
                                        if (doctor.phone != null) {
                                          await canLaunch("tel:${doctor.phone}")
                                              ? await launch(
                                                  "tel:${doctor.phone}")
                                              : throw 'Could not launch tel:${doctor.phone}';
                                        }
                                      },
                                      backgroundColor: doctor.phone != null
                                          ? ColorConst.primaryColor
                                          : Colors.grey.withAlpha(100),
                                      text: "Gọi điện thoại",
                                      textColor: doctor.phone != null
                                          ? Colors.white
                                          : ColorConst.textPrimary,
                                    ),
                                  ),
                                ],
                              )),
                              SizedBox(height: 5),
                              RichText(
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: 'Chức vụ: ',
                                      style: StyleConst.regularStyle(
                                          color: ColorConst.primaryColor),
                                    ),
                                    TextSpan(
                                        text: doctor.position?.trim() != '' &&
                                                doctor.position?.trim() != null
                                            ? doctor.position?.trim()
                                            : "Chưa cập nhật",
                                        style: StyleConst.regularStyle(
                                            height: 1.5))
                                  ])),
                              SizedBox(height: 5),
                              RichText(
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: 'Học vị: ',
                                      style: StyleConst.regularStyle(
                                          color: ColorConst.primaryColor),
                                    ),
                                    TextSpan(
                                        text: doctor.degree?.trim() != '' &&
                                                doctor.degree?.trim() != null
                                            ? doctor.degree?.trim()
                                            : "Chưa cập nhật",
                                        style: StyleConst.regularStyle(
                                            height: 1.5))
                                  ])),
                              SizedBox(height: 5),
                              RichText(
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: 'Bộ môn: ',
                                      style: StyleConst.regularStyle(
                                          color: ColorConst.primaryColor),
                                    ),
                                    TextSpan(
                                        text: doctor.subject?.trim() != '' &&
                                                doctor.subject?.trim() != null
                                            ? doctor.subject?.trim()
                                            : "Chưa cập nhật",
                                        style: StyleConst.regularStyle(
                                            height: 1.5))
                                  ])),
                              SizedBox(height: 5),
                              RichText(
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: 'Chuyên ngành: ',
                                      style: StyleConst.regularStyle(
                                          color: ColorConst.primaryColor),
                                    ),
                                    TextSpan(
                                        text: doctor.specialized?.trim() !=
                                                    '' &&
                                                doctor.specialized?.trim() !=
                                                    null
                                            ? doctor.specialized?.trim()
                                            : "Chưa cập nhật",
                                        style: StyleConst.regularStyle(
                                            height: 1.5))
                                  ])),
                              SizedBox(height: 5),
                              RichText(
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: 'Số điện thoại: ',
                                      style: StyleConst.regularStyle(
                                          color: ColorConst.primaryColor),
                                    ),
                                    TextSpan(
                                        text: doctor.phone?.trim() != '' &&
                                                doctor.phone?.trim() != null
                                            ? doctor.phone?.trim()
                                            : "Chưa cập nhật",
                                        style: StyleConst.regularStyle(
                                            height: 1.5))
                                  ])),
                              SizedBox(height: 5),
                              Text(
                                'Mô tả: ',
                                style: StyleConst.regularStyle(
                                    color: ColorConst.primaryColor),
                              ),
                              SizedBox(height: 5),
                              Text(
                                doctor.intro?.trim() ?? "Chưa cập nhật",
                                style: StyleConst.regularStyle(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
