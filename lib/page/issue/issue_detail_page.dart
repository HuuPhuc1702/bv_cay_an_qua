import 'package:bv_cay_an_qua/models/issue/comment_model.dart';
import 'package:bv_cay_an_qua/models/prescription/prescription_param.dart';
import 'package:bv_cay_an_qua/page/components/dialog.dart';
import 'package:bv_cay_an_qua/page/components/image_picker.dart';
import 'package:bv_cay_an_qua/page/components/list_disease.dart';
import 'package:bv_cay_an_qua/page/components/list_hospital.dart';
import 'package:bv_cay_an_qua/page/components/widget_video.dart';
import 'package:bv_cay_an_qua/page/issue/controllers/issue_controller.dart';
import 'package:bv_cay_an_qua/page/login/controllers/auth_controller.dart';
import 'package:bv_cay_an_qua/repositories/issue_repo.dart';
import 'package:bv_cay_an_qua/shared/helper/image_helper.dart';

import 'package:bv_cay_an_qua/shared/util_convert/datetime_convert.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_appbar.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_image_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../export.dart';
import 'components/item_comment.dart';

import 'components/item_prescription.dart';
import 'components/widget_file.dart';
import 'controllers/prescription_controller.dart';
import 'prescription_page.dart';

class IssueDetailPage extends StatefulWidget {
  final String id;
  final String tag;

  IssueDetailPage({Key? key, required this.id, required this.tag})
      : super(key: key);

  @override
  _IssueDetailPageState createState() => _IssueDetailPageState();
}

class _IssueDetailPageState extends State<IssueDetailPage> {
  AuthController authController = Get.find<AuthController>();
  TextEditingController _commentController = TextEditingController();
  TextEditingController editController = TextEditingController();
  List<String> imageComment = [];
  late IssueController _controller;
  PrescriptionController _prescriptionController =
      Get.put(PrescriptionController());

  // double _initialRating = 0.0;
  double _horizontal = 30;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      _controller = Get.find<IssueController>(tag: widget.tag);
    } catch (error) {
      _controller = Get.put(IssueController());
    }
    _controller.getOneIssue(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    //print(_controller?.detail?.)

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: WillPopScope(
        onWillPop: () => showExist(context).then((value) => value ?? false),
        child: Scaffold(
          backgroundColor: Colors.white,
          // appBar: AppBar(
          //   leading: GestureDetector(
          //     onTap: () async {
          //       await showExist(context).then((value) {
          //         // print(value);
          //         if (value == true) {
          //           Navigator.pop(context);
          //         }
          //       });
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
          //       Text("Chi tiết câu hỏi",
          //           style: StyleConst.boldStyle(
          //                   color: ColorConst.red, fontSize: titleSize)
          //               .copyWith(
          //                   color: Colors.red, fontWeight: FontWeight.bold)),
          //       Text('www.benhviencayanqua.vn',
          //           style:
          //               StyleConst.mediumStyle(color: ColorConst.primaryColor)),
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
              WidgetAppbar(
                title: "Chi tiết câu hỏi",
                turnOnSendIssue: false,
                callBack: () async {
                  await showExist(context).then((value) {
                    // print(value);
                    if (value == true) {
                      Navigator.pop(context);
                    }
                  });
                },
              ),
              Expanded(
                child: RefreshIndicator(
                  color: ColorConst.primaryColor,
                  onRefresh: () async {
                    // _controller.getOneIssue(widget.id);
                    _controller.refreshDataDetail();
                  },
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              child: GetBuilder<IssueController>(
                                tag: widget.tag,
                                builder: (controller) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        color: Colors.white,
                                        padding: EdgeInsets.only(
                                            left: _horizontal,
                                            right: _horizontal,
                                            top: 30),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        "ID Câu hỏi",
                                                        style: StyleConst
                                                            .regularStyle(
                                                                color: ColorConst
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                    ),
                                                    Visibility(
                                                      visible: _controller
                                                                  .detail
                                                                  ?.prescription !=
                                                              null &&
                                                          (_controller
                                                                      .detail
                                                                      ?.prescription
                                                                      ?.status ==
                                                                  "fulfilled" ||
                                                              _controller
                                                                      .detail
                                                                      ?.prescription
                                                                      ?.status ==
                                                                  "assigning"),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8.0),
                                                        child: Image.asset(
                                                            'assets/icons/icon_show_ketoa.png',
                                                            color: _controller
                                                                        .detail
                                                                        ?.prescription
                                                                        ?.status ==
                                                                    "assigning"
                                                                ? Colors.grey
                                                                : ColorConst
                                                                    .primaryColor,
                                                            width: 20.0),
                                                      ),
                                                    ),
                                                    Visibility(
                                                      visible: _controller
                                                              .detail
                                                              ?.doctorCommented ??
                                                          false,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8.0),
                                                        child: Image.asset(
                                                            'assets/images/doctor-comment.png',
                                                            width: 22.0),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10.0),
                                                  child: Text(
                                                    _controller.detail?.code ??
                                                        'Rỗng',
                                                    style: StyleConst
                                                        .regularStyle(),
                                                    textAlign:
                                                        TextAlign.justify,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10.0),
                                                  child: Divider(),
                                                ),
                                              ],
                                            ),
                                            buildFarmerInfo(),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    "Câu hỏi và mô tả chi tiết",
                                                    style:
                                                        StyleConst.regularStyle(
                                                            color: ColorConst
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10.0),
                                                    child: Text(
                                                      _controller
                                                              .detail?.title ??
                                                          'Rỗng',
                                                      style: StyleConst
                                                          .regularStyle(
                                                              height: 1.5),
                                                      textAlign:
                                                          TextAlign.justify,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10.0),
                                                    child: Divider(),
                                                  ),
                                                  Text(
                                                    "Loại cây trồng",
                                                    style:
                                                        StyleConst.regularStyle(
                                                            color: ColorConst
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10.0),
                                                    child: Text(
                                                      _controller.detail?.plant
                                                              ?.name ??
                                                          'Chưa cập nhật',
                                                      style: StyleConst
                                                          .regularStyle(),
                                                      textAlign:
                                                          TextAlign.justify,
                                                    ),
                                                  ),
                                                  // Padding(
                                                  //   padding: EdgeInsets.symmetric(
                                                  //       vertical: 10.0),
                                                  //   child: Divider(),
                                                  // ),
                                                  // Row(
                                                  //   children: [
                                                  //     Expanded(
                                                  //       child: Column(
                                                  //         crossAxisAlignment:
                                                  //             CrossAxisAlignment.start,
                                                  //         children: [
                                                  //           Text(
                                                  //             "Loại sâu bệnh",
                                                  //             style: StyleConst
                                                  //                 .regularStyle(
                                                  //                     color: ColorConst
                                                  //                         .primaryColor,
                                                  //                     fontWeight:
                                                  //                         FontWeight
                                                  //                             .w600),
                                                  //           ),
                                                  //           Padding(
                                                  //             padding: EdgeInsets.only(
                                                  //                 top: 10.0),
                                                  //             child: Text(
                                                  //               _controller
                                                  //                       .detail
                                                  //                       ?.disease
                                                  //                       ?.name ??
                                                  //                   'Chưa cập nhật',
                                                  //               style: StyleConst
                                                  //                   .regularStyle(),
                                                  //               textAlign:
                                                  //                   TextAlign.justify,
                                                  //             ),
                                                  //           ),
                                                  //         ],
                                                  //       ),
                                                  //     ),
                                                  //     Visibility(
                                                  //       visible: authController
                                                  //                   .userCurrent
                                                  //                   .doctorType ==
                                                  //               "LOC_TROI" &&
                                                  //           appConfig.appType ==
                                                  //               AppType.DOCTOR &&
                                                  //           authController
                                                  //                   .userCurrent.id ==
                                                  //               _controller
                                                  //                   .detail?.doctor?.id,
                                                  //       child: WidgetButton(
                                                  //         text: "Phân loại bệnh",
                                                  //         radiusColor:
                                                  //             ColorConst.primaryColor,
                                                  //         backgroundColor: Colors.white,
                                                  //         paddingBtnHeight: 10,
                                                  //         paddingBtnWidth: 10,
                                                  //         widthRadius: 1,
                                                  //         styleText:
                                                  //             StyleConst.regularStyle(
                                                  //           color:
                                                  //               ColorConst.primaryColor,
                                                  //         ),
                                                  //         onTap: () {
                                                  //           showListDisease(
                                                  //             context: context,
                                                  //             callBack:
                                                  //                 (disease) async {
                                                  //               await _controller
                                                  //                   .assignIssueDisease(
                                                  //                       diseaseId:
                                                  //                           disease?.id ??
                                                  //                               "");
                                                  //             },
                                                  //           );
                                                  //         },
                                                  //       ),
                                                  //     )
                                                  //   ],
                                                  // ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10.0),
                                                    child: Divider(),
                                                  ),
                                                  Text(
                                                    "Trung tâm",
                                                    style:
                                                        StyleConst.regularStyle(
                                                            color: ColorConst
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10.0),
                                                    child: Text(
                                                      _controller
                                                              .detail
                                                              ?.hospital
                                                              ?.name ??
                                                          'Chưa cập nhật',
                                                      style: StyleConst
                                                          .regularStyle(),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10.0),
                                                    child: Divider(),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Bác sĩ",
                                                              style: StyleConst.regularStyle(
                                                                  color: ColorConst
                                                                      .primaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top:
                                                                          10.0),
                                                              child: Text(
                                                                _controller
                                                                        .detail
                                                                        ?.doctor
                                                                        ?.name ??
                                                                    'Chưa cập nhật',
                                                                style: StyleConst
                                                                    .regularStyle(),
                                                              ),
                                                            ),
                                                          ]),
                                                      appConfig.appType ==
                                                                  AppType
                                                                      .DOCTOR &&
                                                              _controller
                                                                      .detail
                                                                      ?.doctor
                                                                      ?.id ==
                                                                  authController
                                                                      .userCurrent
                                                                      .id
                                                          ? WidgetButton(
                                                              onTap: () {
                                                                showListHospital(
                                                                    context:
                                                                        context,
                                                                    callBack: (hospital,
                                                                        doctor,
                                                                        lydo) async {
                                                                      if (_controller
                                                                              .detail !=
                                                                          null) {
                                                                        if (doctor !=
                                                                            null) {
                                                                          await _controller.transferIssueDoctor(
                                                                              //_controller.detail!.id!,
                                                                              doctorId: doctor.id,
                                                                              reason: lydo
                                                                              //_controller
                                                                              //    .detail!.id!,
                                                                              //{
                                                                              // "hospitalId":
                                                                              //     "${hospital.id}",
                                                                              //"doctorId":
                                                                              //    "${doctor.id}"

                                                                              //}
                                                                              );
                                                                        } else {
                                                                          await _controller.transferIssueHospital(
                                                                              hospitalId: hospital.id,
                                                                              reason: lydo);
                                                                        }

                                                                        _controller
                                                                            .refreshDataDetail();
                                                                      }
                                                                    });
                                                              },
                                                              text:
                                                                  "Chuyển bác sĩ",
                                                              radiusColor:
                                                                  ColorConst
                                                                      .primaryColor,
                                                              backgroundColor:
                                                                  Colors.white,
                                                              paddingBtnHeight:
                                                                  10,
                                                              paddingBtnWidth:
                                                                  10,
                                                              widthRadius: 1,
                                                              styleText: StyleConst
                                                                  .regularStyle(
                                                                color: ColorConst
                                                                    .primaryColor,
                                                              ),
                                                            )
                                                          : SizedBox()
                                                    ],
                                                  ),

                                                  Visibility(
                                                    visible: _controller.detail
                                                            ?.fromDoctor !=
                                                        null,
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        10.0),
                                                            child: Divider(),
                                                          ),
                                                          Text(
                                                            "Bác sĩ chỉ định",
                                                            style: StyleConst.regularStyle(
                                                                color: ColorConst
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 10.0),
                                                            child: Text(
                                                              _controller
                                                                      .detail
                                                                      ?.fromDoctor
                                                                      ?.name ??
                                                                  'Chưa cập nhật',
                                                              style: StyleConst
                                                                  .regularStyle(),
                                                            ),
                                                          ),
                                                        ]),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10.0),
                                                    child: Divider(),
                                                  ),
                                                  Text(
                                                    "Hình ảnh đính kèm",
                                                    style: StyleConst.boldStyle(
                                                        color: ColorConst
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  (_controller.detail?.images
                                                                  ?.length ??
                                                              0) >
                                                          0
                                                      ? Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          height: 76,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 12.0),
                                                          child: ListView(
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            children:
                                                                _controller
                                                                    .detail!
                                                                    .images!
                                                                    .map<
                                                                        Widget>(
                                                                      (item) => item.split(".").last ==
                                                                              "mp4"
                                                                          ? WidgetVideo(
                                                                              url: item,
                                                                              size: 65,
                                                                            )
                                                                          : Padding(
                                                                              padding: const EdgeInsets.only(right: 5),
                                                                              child: ImagePickerWidget(
                                                                                context: context,
                                                                                size: 65,
                                                                                listImage: _controller.detail!.images,
                                                                                resourceUrl: item,
                                                                                onFileChanged: (fileUri, fileType) {
                                                                                  setState(() {
                                                                                    item = fileUri;
                                                                                  });
                                                                                },
                                                                              ),
                                                                            ),
                                                                    )
                                                                    .toList(),
                                                          ),
                                                        )
                                                      : Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      12.0),
                                                          child: Text(
                                                              'Không có ảnh đính kèm',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      500]))),
                                                  Visibility(
                                                    visible: _controller
                                                            .detail?.video !=
                                                        null,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Divider(),
                                                          Text(
                                                            "Video đính kèm",
                                                            style: StyleConst.boldStyle(
                                                                color: ColorConst
                                                                    .primaryColor),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          WidgetFileAttachment(
                                                            attachmentModel:
                                                                _controller
                                                                    .detail
                                                                    ?.video,
                                                            type: TypeAttachment
                                                                .video,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Visibility(
                                                    visible: _controller
                                                            .detail?.audio !=
                                                        null,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 0, bottom: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Divider(),
                                                          Text(
                                                            "Ghi âm đính kèm",
                                                            style: StyleConst.boldStyle(
                                                                color: ColorConst
                                                                    .primaryColor),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          WidgetFileAttachment(
                                                            attachmentModel:
                                                                _controller
                                                                    .detail
                                                                    ?.audio,
                                                            type: TypeAttachment
                                                                .audio,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(),
                                            // rating
                                            Text("Đánh giá và lượt xem",
                                                style: StyleConst.regularStyle(
                                                    color: ColorConst
                                                        .primaryColor)),

                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                        size: defaultSize * 2,
                                                      ),
                                                      SizedBox(width: 10),
                                                      Text(
                                                          "${_controller.detail?.rateStats?.rate ?? "0"}",
                                                          style: StyleConst
                                                              .mediumStyle()),
                                                      SizedBox(width: 10),
                                                      Visibility(
                                                        visible: _controller
                                                                .detail
                                                                ?.owner
                                                                ?.id !=
                                                            authController
                                                                .userCurrent.id,
                                                        child: GestureDetector(
                                                          onTap: () =>
                                                              showDialogRate
                                                                  .call(
                                                                      context),
                                                          child: Text(
                                                              "Đánh giá",
                                                              style: StyleConst
                                                                  .regularStyle(
                                                                      color: ColorConst
                                                                          .primaryColor)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    (_controller
                                                                    .detail
                                                                    ?.rateStats
                                                                    ?.total ??
                                                                0) >
                                                            0
                                                        ? "(có ${_controller.detail?.rateStats?.total ?? 0} đánh giá)"
                                                        : "(Chưa có đánh giá)",
                                                    style:
                                                        StyleConst.regularStyle(
                                                            color: ColorConst
                                                                .greyBlack),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            //region thông tin đơn thuốc
                                            Visibility(
                                                visible: _controller.detail
                                                            ?.prescription !=
                                                        null &&
                                                    _controller
                                                            .detail
                                                            ?.prescription
                                                            ?.status ==
                                                        "fulfilled",
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 16),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 10.0),
                                                        child: Divider(),
                                                      ),
                                                      Text(
                                                        "Đơn thuốc",
                                                        style: StyleConst
                                                            .mediumStyle(
                                                                color: ColorConst
                                                                    .primaryColor),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10,
                                                                vertical: 10),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        .4))),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            ItemPrescription(
                                                              inputDetails: _controller
                                                                          .detail
                                                                          ?.prescription
                                                                          ?.details !=
                                                                      null
                                                                  ? List<PrescriptionParam>.from(_controller
                                                                      .detail!
                                                                      .prescription!
                                                                      .details!
                                                                      .map((d) => PrescriptionParam(
                                                                          medicineName: d
                                                                              .medicineName,
                                                                          sprayingArea: d
                                                                              .sprayingArea
                                                                              .toString(),
                                                                          dosage:
                                                                              d.dosage)))
                                                                  : [],
                                                            ),
                                                            Text(
                                                              "Ghi chú: ${_controller.detail?.prescription?.note}",
                                                              style: StyleConst
                                                                  .regularStyle(),
                                                            ),
                                                            SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              child: Row(
                                                                children: List
                                                                    .generate(
                                                                        _controller.detail?.prescription?.images?.length ??
                                                                            0,
                                                                        (index) =>
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
                                                                              child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(5),
                                                                                child: WidgetImageNetWork(
                                                                                  url: _controller.detail?.prescription?.images![index],
                                                                                  width: 67,
                                                                                  height: 67,
                                                                                ),
                                                                              ),
                                                                            )),
                                                              ),
                                                            ),
                                                            Visibility(
                                                              visible: _controller
                                                                      .detail
                                                                      ?.prescription
                                                                      ?.prescriberId ==
                                                                  authController
                                                                      .userCurrent
                                                                      .id,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            20),
                                                                child:
                                                                    WidgetButton(
                                                                  text:
                                                                      "Xoá đơn thuốc",
                                                                  textColor:
                                                                      Colors
                                                                          .white,
                                                                  onTap:
                                                                      () async {
                                                                    if (_controller
                                                                            .detail
                                                                            ?.id !=
                                                                        null) {
                                                                      await _prescriptionController.deletePrescription(
                                                                          issueId: _controller
                                                                              .detail!
                                                                              .id!);
                                                                      _controller
                                                                          .refreshDataDetail();
                                                                      _controller
                                                                          .refreshData();
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            //endregion
                                            Visibility(
                                              visible: _controller.detail !=
                                                      null &&
                                                  authController.userCurrent
                                                          .doctorType ==
                                                      "SOFRI" &&
                                                  (_controller.detail
                                                              ?.prescription ==
                                                          null ||
                                                      _controller
                                                              .detail
                                                              ?.prescription
                                                              ?.status ==
                                                          "empty") &&
                                                  appConfig.appType ==
                                                      AppType.DOCTOR,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 16),
                                                child: WidgetButton(
                                                  text: "Yêu cầu LTG kê đơn",
                                                  textColor: Colors.white,
                                                  onTap: () async {
                                                    await _controller
                                                        .assignPrescription(
                                                            context: context,
                                                            issueId: _controller
                                                                .detail!.id!);
                                                    _controller
                                                        .refreshDataDetail();
                                                    // showListDoctor(
                                                    //     context: context,
                                                    //     doctorType: "LOC_TROI",
                                                    //     callBack: (doctor, note) async {
                                                    //       if (_controller.detail !=
                                                    //               null &&
                                                    //           doctor != null) {
                                                    //         await _controller
                                                    //             .assignPrescription(
                                                    //                 issueId: _controller
                                                    //                     .detail!.id!,
                                                    //                 doctorId:
                                                    //                     doctor.id!);
                                                    //         _controller
                                                    //             .refreshDataDetail();
                                                    //       }
                                                    //     });
                                                  },
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible:
                                                  _controller.detail != null &&
                                                      authController.userCurrent
                                                              .doctorType ==
                                                          "LOC_TROI" &&
                                                      _controller
                                                              .detail
                                                              ?.prescription
                                                              ?.status !=
                                                          "fulfilled" &&
                                                      appConfig.appType ==
                                                          AppType.DOCTOR,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 16),
                                                child: WidgetButton(
                                                  text: "Kê đơn",
                                                  textColor: Colors.white,
                                                  onTap: () {
                                                    if (_controller
                                                            .detail?.id !=
                                                        null)
                                                      Get.to(PrescriptionPage(
                                                        issueId: _controller
                                                                .detail?.id ??
                                                            "",
                                                        tag: widget.tag,
                                                      ));
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: _horizontal),
                                        margin: EdgeInsets.only(bottom: 16),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: ColorConst
                                                        .borderInputColor),
                                                top: BorderSide(
                                                    color: ColorConst
                                                        .borderInputColor))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                _controller.detail == null
                                                    ? "Đang tải bình luận..."
                                                    : 'Có ${_controller.detail?.commentCount} bình luận',
                                                style: StyleConst.regularStyle(
                                                    color: ColorConst.grey),
                                                maxLines: 1,
                                              ),
                                            ),
                                            Icon(
                                              Icons.remove_red_eye_outlined,
                                              color: ColorConst.grey,
                                            ),
                                            Text(
                                              _controller.detail == null
                                                  ? "Đang tải lượt xem..."
                                                  : ' ${_controller.detail?.viewCount} lượt xem',
                                              style: StyleConst.regularStyle(
                                                  color: ColorConst.grey),
                                              maxLines: 1,
                                            )
                                          ],
                                        ),
                                      ),
                                      _buildComments(),
                                    ],
                                  );
                                },
                              ))),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            imageComment.length > 0
                                ? Container(
                                    margin: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.18,
                                        bottom: 10),
                                    height: 100,
                                    child: ListView(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      children: imageComment
                                          .map(
                                            (item) => InkWell(
                                              child: Container(
                                                child: ImagePickerWidget(
                                                  context: context,
                                                  size: 150,
                                                  quality: 150,
                                                  isRemove: true,
                                                  resourceUrl: item,
                                                ),
                                              ),
                                              onTap: () =>
                                                  _handleRemoveImage(item),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  )
                                : Container(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ImagePickerWidget(
                                  context: context,
                                  size:
                                      MediaQuery.of(context).size.width * 0.12,
                                  avatar: true,
                                  resourceUrl:
                                      authController.userCurrent.avatar ?? '',
                                  quality: 100,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 20),
                                  width:
                                      MediaQuery.of(context).size.width * 0.85 -
                                          20,
                                  child: TextField(
                                    controller: _commentController,
                                    onSubmitted: _handleSendComment,
                                    onChanged: (text) {
                                      setState(() {
                                        // this.text = text;
                                      });
                                    },
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    textInputAction: TextInputAction.newline,
                                    keyboardType: TextInputType.multiline,
                                    minLines: 1,
                                    maxLines: 8,
                                    decoration: InputDecoration(
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          GestureDetector(
                                            child: Icon(
                                              Icons.image,
                                              size: 20,
                                              color:
                                                  this.imageComment.length > 0
                                                      ? Color(0xFFBBB7B7)
                                                      : ColorConst.primaryColor,
                                            ),
                                            onTap: this.imageComment.length > 0
                                                ? () {}
                                                : () => _handleUploadImage
                                                    .call(context),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.send,
                                              size: 20,
                                              color: _commentController
                                                          .text.isEmpty &&
                                                      _commentController
                                                              .text.length ==
                                                          0
                                                  ? Color(0xFFBBB7B7)
                                                  : ColorConst.primaryColor,
                                            ),
                                            onPressed: () {
                                              _handleSendComment(
                                                  _commentController.text);
                                            },
                                          ),
                                        ],
                                      ),

                                      // labelText: "Tìm kiếm... ",
                                      hintText: "Viết bình luận",
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 16, horizontal: 20),
                                      hintStyle: StyleConst.regularStyle(),
                                      fillColor: Theme.of(context).primaryColor,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Theme.of(context).primaryColor,
                                            width: 2.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorConst.borderInputColor,
                                            width: 2.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildFarmerInfo() {
    if (appConfig.appType == AppType.FARMER) return Container();
    if (authController.userCurrent.id == null) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Nông dân",
              style: StyleConst.regularStyle(
                  color: ColorConst.primaryColor, fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text("Đang tải thông tin ...",
                  style: StyleConst.regularStyle()),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Divider(),
            ),
          ]);
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Nông dân",
              style: StyleConst.regularStyle(
                  color: ColorConst.primaryColor, fontWeight: FontWeight.w600)),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              "${_controller.detail?.owner?.name == null || _controller.detail!.owner!.name!.isEmpty ? 'Chưa cập nhật họ tên' : _controller.detail?.owner?.name}${_controller.detail?.owner?.name == _controller.detail?.owner?.phone ? '' : '  (${_controller.detail?.owner?.phone})'} ",
              style: StyleConst.regularStyle(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Divider(),
          ),
          Text(
            "Địa chỉ nông dân",
            style: StyleConst.regularStyle(
                color: ColorConst.primaryColor, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              "${_controller.detail?.owner?.place?.fullAddress ?? 'Chưa xác định'}",
              style: StyleConst.regularStyle(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Divider(),
          ),
          Text(
            "Diện tích",
            style: StyleConst.regularStyle(
                color: ColorConst.primaryColor, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              "${_controller.detail?.owner?.area ?? 0.0} ha",
              style: StyleConst.regularStyle(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Divider(),
          ),
        ]);
  }

  Widget _buildComments() {
    if ((_controller.detail?.comments?.length ?? 0) > 0) {
      return Column(
          children:
              _controller.detail!.comments!.map<Widget>((CommentModel item) {
        if ((item.owner?.id == authController.userCurrent.id ||
                appConfig.appType == AppType.DOCTOR) ||
            item.owner?.profile?.hospital != null) {
          return Container(
            padding: EdgeInsets.only(top: 10.0, bottom: 15),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: _horizontal),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: ImagePickerWidget(
                          context: context,
                          size: 60,
                          avatar: true,
                          resourceUrl: item.owner?.profile?.avatar ?? '',
                          quality: 80,
                        ),
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      item.owner?.name ?? 'Khách bình luận',
                                      maxLines: 1,
                                      textAlign: TextAlign.justify,
                                      overflow: TextOverflow.ellipsis,
                                      style: StyleConst.mediumStyle(),
                                    ),
                                    Visibility(
                                        visible: _isCommentOfDoctor(item),
                                        child: Text(
                                          "${item.owner?.profile?.hospital?.name ?? "Chưa cập nhật"}",
                                          maxLines: 1,
                                          textAlign: TextAlign.justify,
                                          overflow: TextOverflow.ellipsis,
                                          style: StyleConst.regularStyle(
                                              color: ColorConst.primaryColor),
                                        ))
                                  ],
                                ),
                              ),
                              Visibility(
                                  visible: _isCommentOfDoctor(item),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 5, top: 5, right: 5),
                                    child: Image.asset(
                                      "assets/images/doctor-comment.png",
                                      width: 25,
                                      height: 25,
                                    ),
                                  )),
                              Visibility(
                                visible: canEdit(item),
                                child: InkWell(
                                  onTap: item.editing
                                      ? () => updateComment(
                                          item, editController.text.toString())
                                      : () {
                                          _controller.detail!.comments!
                                              .where((c) => c.id != item.id)
                                              .forEach(
                                                  (c) => c.editing = false);
                                          editController =
                                              TextEditingController(
                                                  text: item.content);
                                          setState(() {
                                            item.editing = !item.editing;
                                          });
                                        },
                                  child: Card(
                                    child: Icon(
                                        item.editing ? Icons.save : Icons.edit,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              )
                            ],
                          ),
                          item.image != '' && item.image != null
                              ? Container(
                                  margin: EdgeInsets.only(top: 8),
                                  height: 100,
                                  child: item.image.split(".").last == "mp4"
                                      ? WidgetVideo(
                                          url: item.image,
                                          size: 150,
                                        )
                                      : ImagePickerWidget(
                                          context: context,
                                          size: 150,
                                          quality: 150,
                                          resourceUrl: item.image,
                                        ),
                                )
                              : SizedBox(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10, top: 5),
                            child: itemComment(
                                context: context,
                                commentModel:
                                    _isCommentOfDoctor(item) ? item : null,
                                content: item.content ?? ""),
                          ),
                          item.editing
                              ? TextField(
                                  controller: editController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                )
                              : Container(),
                          item.editing
                              ? Padding(
                                  padding: EdgeInsets.only(top: 12.0),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        ElevatedButton(
                                            child: Text('Cập nhật',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor)),
                                            onPressed: () => updateComment(item,
                                                editController.text.toString()))
                                      ]),
                                )
                              : Container(),
                        ],
                      )),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  margin: EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: ColorConst.greyLight, width: 10),
                          top: BorderSide(color: ColorConst.borderInputColor))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: _horizontal),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Visibility(
                            visible: item.owner?.profile?.hospital != null,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: miniSize * 2,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    "${item.rateStats?.rate ?? 0}",
                                    style: StyleConst.regularStyle(),
                                  ),
                                ),
                                Visibility(
                                  visible: item.owner?.profile?.id !=
                                      authController.userCurrent.id,
                                  child: GestureDetector(
                                      onTap: () {
                                        showDialogRateComment.call(item.id);
                                      },
                                      child: Text("Đánh giá",
                                          style: StyleConst.regularStyle(
                                              color: ColorConst.primaryColor))),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          formatTime(item.updatedAt),
                          style:
                              StyleConst.regularStyle(color: ColorConst.grey),
                          maxLines: 3,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return SizedBox();
      }).toList());
    }
    return SizedBox();
  }

  canEdit(CommentModel comment) {
    if (appConfig.appType == AppType.DOCTOR &&
        (comment.owner == null ||
            comment.owner?.id == authController.userCurrent.id)) return true;
    return false;
  }

  updateComment(CommentModel comment, String content) async {
    try {
      print("updateComment---${comment.id}");
      print("updateComment---$content");
      final value = await issueRepository.updateComment(
          id: comment.id!, content: content);
      if (value) {
        _controller.getOneIssue(widget.id);
      }
    } catch (e) {
      showAlertDialog(
          context, 'Sửa bình luận thất bại\n Mã lỗi: ${e.toString()}');
    }
    setState(() {
      comment.editing = false;
    });
  }

  bool _isCommentOfDoctor(CommentModel comment) {
    if (comment.owner?.profile?.hospital != null) {
      return true;
    }

    return false;
  }

  _handleSendComment(String comment) async {
    // print( _controller.detail?.disease?.id);
    // print( _controller.detail?.disease?.name);

    if (_controller.detail?.disease?.id == null &&
        appConfig.appType == AppType.DOCTOR) {
      await showListDisease(
        context: context,
        callBack: (disease) async {
          _controller.detail?.disease = disease;
          await _controller.assignIssueDisease(diseaseId: disease?.id ?? "");
          _handleSendComment(comment);
        },
      );
      return;
    }
    var result = await _controller.createComment(
        issueId: widget.id,
        content: comment,
        image: imageComment.length > 0 ? imageComment.first : null,
        context: context);

    if (result == true) {
      _commentController.text = '';
      setState(() {
        imageComment = [];
      });
    }
    // print("result: $result");
  }

  _handleRemoveImage(item) async {
    setState(() {
      imageComment.remove(item);
    });
  }

  _handleUploadImage(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    showSelectMoreFile(
        context: context,
        callBack: (value) {
          if (value is List<String> && value.length > 0) {
            imageComment.addAll(value);
            setState(() {});
          } else {
            setState(() {
              imageComment.add(value);
            });
          }
        });
  }

  showDialogRate(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return GeneralDialog(
            onValueChanged: _onWantToRate,
          );
        });
  }

  showDialogRateComment(String? id) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return GeneralDialog(
              onValueChanged: (map) {
                _onWantToRateComment.call(map);
              },
              commentId: id);
        });
  }

  void _onWantToRate(Map<String, dynamic> map) async {
    try {
      await issueRepository.rateIssue(widget.id, map["rating"]);
      showSnackBar(title: "Thông báo", body: "Đánh giá thành công");
      _controller.refreshData();
      _controller.getOneIssue(widget.id);
    } catch (e) {
      print(e.toString());
    }
  }

  void _onWantToRateComment(Map<String, dynamic> map) async {
    try {
      await issueRepository.rateComment(
          rating: map["rating"], commentId: map["commentId"]);
      showSnackBar(title: "Thông báo", body: "Đánh giá thành công");
      // _controller.refreshData();
      await _controller.refreshDataDetail();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool?> showExist(BuildContext contextMain) async {
    int _i = _controller.detail?.comments?.indexWhere((element) =>
            element.owner?.profile?.hospital != null &&
            (element.rateStats?.total ?? 0) == 0) ??
        -1;
    print(_i);
    if (_i >= 0 &&
        _controller.detail?.owner?.id == authController.userCurrent.id) {
      print(_i);
      return showDialog<bool>(
        context: contextMain,
        builder: (c) => AlertDialog(
          title: Text('Thông báo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'Vui lòng đánh giá câu trả lời của Bác sĩ để chúng tôi tư vấn được tốt hơn.'),
              Padding(
                padding: const EdgeInsets.only(
                    right: 10, left: 10, top: 16, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SizedBox(),
                      // child: WidgetButton(
                      //     text: 'Không',
                      //     textColor: ColorConst.primaryColor,
                      //     backgroundColor: Colors.white,
                      //     onTap: () {
                      //       Navigator.pop(c, true);
                      //     }),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: WidgetButton(
                        text: 'Đồng ý',
                        textColor: Colors.white,
                        onTap: () {
                          Navigator.pop(c, false);
                          if (_controller.detail?.comments != null) {
                            int _i = _controller.detail?.comments
                                    ?.lastIndexWhere((element) =>
                                        element.owner?.profile?.hospital !=
                                            null &&
                                        (element.rateStats?.total ?? 0) == 0) ??
                                -1;
                            if (_i >= 0)
                              showDialogRateComment(
                                  _controller.detail?.comments?[_i].id);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
    return true;
  }
}
