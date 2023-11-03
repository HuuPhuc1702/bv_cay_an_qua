import 'dart:convert';

import 'package:bv_cay_an_qua/config/theme/color-constant.dart';
import 'package:bv_cay_an_qua/config/theme/style-constant.dart';
import 'package:bv_cay_an_qua/models/disease_model.dart';
import 'package:bv_cay_an_qua/models/doctor_model.dart';
import 'package:bv_cay_an_qua/models/hospital_model.dart';
import 'package:bv_cay_an_qua/models/plant_model.dart';
import 'package:bv_cay_an_qua/models/user/plant_model.dart';
import 'package:bv_cay_an_qua/page/issue/controllers/issue_controller.dart';
import 'package:bv_cay_an_qua/page/login/controllers/auth_controller.dart';
import 'package:bv_cay_an_qua/services/graphql/crud_repo.dart';
import 'package:bv_cay_an_qua/services/graphql/graphql_list_provider.dart';
import 'package:bv_cay_an_qua/shared/helper/print_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorFilterQuestion extends StatefulWidget {
  String? tag;
  Map<String, dynamic> filter;

  DoctorFilterQuestion({Key? key, this.tag, required this.filter})
      : super(key: key);

  @override
  _DoctorFilterQuestionState createState() => _DoctorFilterQuestionState();
}

class _DoctorFilterQuestionState extends State<DoctorFilterQuestion> {
  late IssueController issueController =
      Get.find<IssueController>(tag: widget.tag);
  AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    issueController.hospitalValue =
        issueController.hospitalValue ?? issueController.listHospital.first;
    issueController.doctorValue =
        issueController.doctorValue ?? issueController.listDoctor.first;
    issueController.plantValue =
        issueController.plantValue ?? issueController.listPants.first;
    issueController.diseaseValue =
        issueController.diseaseValue ?? issueController.listDisease.first;
  }

  _applyFilter() {
    // DoctorQuestionFilter filter = _appBloc.getDoctorFilterLatest;
    // filter = filter.copyWith(
    //   hospitalId: hospitalValue.id,
    //   doctorId: doctorValue.id,
    //   plantId: treeValue.id,
    //   myQuestion: _myQuestion,
    //   noneAnswer: _noneAnswer,
    // );
    // _appBloc.filterDoctorQuestion(filter);

    Map<String, dynamic> filter = Map();
    issueController.lastItem = false;
    List<String> doctorId = [];
    if (issueController.myQuestion) {
      doctorId.add(authController.userCurrent.id ?? "");
    }
    if (issueController.noneAnswer) {
      filter["doctorCommented"] = !issueController.noneAnswer;
    }
    if (issueController.hospitalValue?.id != null) {
      filter["hospitalId"] = issueController.hospitalValue?.id;
    }
    if (issueController.diseaseValue?.id != null) {
      filter["diseaseId"] = issueController.diseaseValue?.id;
    }
    if (issueController.plantValue?.id != null) {
      filter["plantId"] = issueController.plantValue?.id;
    }
    if (issueController.doctorValue?.id != null) {
      doctorId.add(issueController.doctorValue?.id ?? "");
    }
    if (doctorId.length > 0) {
      filter["doctorId"] = doctorId;
    }
    filter.forEach((key, value) {
      issueController.doctorFilter[key] = value;
    });

    widget.filter.forEach((key, value) {
      if (key == "isFAQ") {
        filter["topicIds"] = [
          "${issueController.listIssueTopics[issueController.countIssueTopic].id}"
        ];
      }
      filter[key] = value;
    });

    printLog("xxxxOld---${issueController.query.toJson()}");
    printLog("xxxxNew---${QueryInput(filter: filter, page: 1).toJson()}");
    issueController.loadAll(query: QueryInput(filter: filter, page: 1));
    print("-------------filter ---------------------$filter");
    if (filter.isNotEmpty)
      issueController.setIsFilter(true);
    else
      issueController.setIsFilter(false);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        margin: EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0)),
                color: ColorConst.primaryColor,
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                      child: Text(
                    'Bộ lọc',
                    style: StyleConst.mediumStyle(color: Colors.white),
                  )),
                  Text(
                    '   |   ',
                    style: StyleConst.mediumStyle(color: Colors.white),
                  ),
                  InkWell(
                    onTap: _applyFilter,
                    child: Container(
                        child: Text(
                          'Áp dụng',
                          style: StyleConst.mediumStyle(color: Colors.white),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 14.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(width: 1, color: Colors.white),
                        )),
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Row(children: <Widget>[
                  Switch(
                    activeColor: ColorConst.primaryColor,
                    value: issueController.myQuestion,
                    onChanged: (v) {
                      setState(() {
                        issueController.myQuestion = v;
                      });
                    },
                  ),
                  Expanded(
                      child: Text('Chỉ hiển thị câu hỏi của tôi',
                          style: StyleConst.boldStyle(
                              color: ColorConst.primaryColor)))
                ])),
            Container(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Row(children: <Widget>[
                  Switch(
                    activeColor: ColorConst.primaryColor,
                    value: issueController.noneAnswer,
                    onChanged: (v) {
                      setState(() {
                        issueController.noneAnswer = v;
                      });
                    },
                  ),
                  Expanded(
                      child: Text('Câu hỏi chưa trả lời',
                          style: StyleConst.boldStyle(
                              color: ColorConst.primaryColor)))
                ])),
            filterItem<HospitalModel>(
                context,
                "Chọn trung tâm",
                issueController.hospitalValue,
                issueController.listHospital, onChanged: (v) {
              setState(() {
                issueController.hospitalValue = v;
                issueController.getAllDoctor(hospitalId: v?.id);
                issueController.doctorValue = issueController.listDoctor.first;
              });
            }),
            GetBuilder<IssueController>(
                tag: widget.tag,
                builder: (controller) {
                  return filterItem<DoctorModel>(
                      context,
                      "Chọn bác sĩ",
                      issueController.doctorValue,
                      issueController.listDoctor, onChanged: (v) {
                    setState(() {
                      issueController.doctorValue = v;
                    });
                  });
                }),
            // GetBuilder<IssueController>(
            //     tag: widget.tag,
            //     builder: (controller) {
            //       return filterItem<DoctorModel>(
            //           context,
            //           "Chọn bác sĩ chỉ định",
            //           issueController.fromDoctorValue,
            //           issueController.listDoctor, onChanged: (v) {
            //         setState(() {
            //           issueController.fromDoctorValue = v;
            //         });
            //       });
            //     }),
            filterItem<PlantModel>(
                context,
                "Chọn cây trồng",
                issueController.plantValue,
                issueController.listPants, onChanged: (v) {
              setState(() {
                issueController.plantValue = v;
              });
            }),
            filterItem<DiseaseModel>(
                context,
                "Chọn loại bệnh",
                issueController.diseaseValue,
                issueController.listDisease, onChanged: (v) {
              setState(() {
                issueController.diseaseValue = v;
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget filterItem<T>(
      BuildContext context, String title, T? dropdownValue, List<T> listItem,
      {Function(T?)? onChanged}) {
    return InkWell(
      onTap: () {
        // updateSortCheck(check);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding:
                EdgeInsets.only(top: 10.0, bottom: 10, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  maxLines: 1,
                  style:
                      StyleConst.regularStyle(color: ColorConst.primaryColor),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      border: Border.all(
                          width: 1, color: ColorConst.borderInputColor)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: DropdownButton<T>(
                      value: dropdownValue,
                      isExpanded: true,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 30,
                      style: StyleConst.regularStyle(),
                      underline: Container(
                        height: 0,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: onChanged,
                      items: listItem.map<DropdownMenuItem<T>>((value) {
                        // if (value is HospitalModel) {
                        //   return DropdownMenuItem<T>(
                        //     value: value,
                        //     child: Text(value.name.toString()),
                        //   );
                        // } else if (value is DoctorModel) {
                        //   return DropdownMenuItem<T>(
                        //     value: value,
                        //     child: Text(value.name.toString()),
                        //   );
                        // } else if (value is PlantModel) {
                        //   return DropdownMenuItem<T>(
                        //     value: value,
                        //     child: Text(value.name.toString()),
                        //   );
                        // }
                        return DropdownMenuItem<T>(
                          value: value,
                          child: Text((value as dynamic).name.toString()),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
