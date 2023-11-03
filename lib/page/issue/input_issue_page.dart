import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:bv_cay_an_qua/models/disease_model.dart';
import 'package:bv_cay_an_qua/models/doctor_model.dart';
import 'package:bv_cay_an_qua/models/hospital_model.dart';
import 'package:bv_cay_an_qua/models/user/plant_model.dart';
import 'package:bv_cay_an_qua/page/components/image_picker.dart';
import 'package:bv_cay_an_qua/page/components/widget_video.dart';
import 'package:bv_cay_an_qua/page/issue/controllers/issue_controller.dart';
import 'package:bv_cay_an_qua/services/files/path_file_local.dart';
import 'package:bv_cay_an_qua/shared/helper/dialogs.dart';
import 'package:bv_cay_an_qua/shared/helper/image_helper.dart';
import 'package:bv_cay_an_qua/shared/helper/print_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../export.dart';

class InputIssuePage extends StatefulWidget {
  String? tag;

  InputIssuePage({Key? key, this.tag}) : super(key: key);

  @override
  _InputIssuePageState createState() => _InputIssuePageState();
}

class _InputIssuePageState extends State<InputIssuePage> {
  TextEditingController questionController = TextEditingController();
  late MediaQueryData _mediaQueryData;

  List<String> listImage = [];
  PlantModel? _currentTree;
  DiseaseModel? _currentDisease;
  HospitalModel? _currentHospital;
  DoctorModel? _currentDoctor;
  late IssueController issueController;

  Map<String, dynamic> videoFile = Map();
  Map<String, dynamic> audioFile = Map();

  late FlutterAudioRecorder recorder;
  Recording? _current;
  AudioPlayer audioPlayer = AudioPlayer();

  bool isStart = false;
  bool isStartRecord = false;

  bool isValid = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    issueController = Get.put(IssueController());
    audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        isStart = false;
      });
    });
  }

  double _paddingHeight = 16;

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: WillPopScope(
        onWillPop: () => showExist(context),
        child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                showExist(context);
              },
              child: Padding(
                padding: EdgeInsets.all(14.0),
                child: Image.asset(
                  AssetsConst.iconBack,
                  fit: BoxFit.cover,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
            brightness: Brightness.light,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Tạo câu hỏi",
                    style: StyleConst.boldStyle(
                            color: ColorConst.red, fontSize: titleSize)
                        .copyWith(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                Text('www.benhviencayanqua.vn',
                    style:
                        StyleConst.mediumStyle(color: ColorConst.primaryColor)),
              ],
            ),
            elevation: 2,
            backgroundColor: Colors.white,
            bottom: PreferredSize(
                child: Container(
                  color: ColorConst.primaryColor,
                  height: 8,
                ),
                preferredSize: Size.fromHeight(8)),
          ),
          body: GetBuilder<IssueController>(builder: (controller) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Câu hỏi và mô tả chi tiết (*)",
                          style: StyleConst.boldStyle(
                              color: ColorConst.primaryColor),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: TextField(
                              controller: questionController,
                              maxLines: 4,
                              style: TextStyle(fontSize: 18.0),
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                fillColor: ColorConst.primaryColor,
                                border: OutlineInputBorder(),
                                hintText: 'Nhập câu hỏi và mô tả chi tiết',
                                errorText: isValid == false
                                    ? "Không được bỏ trống"
                                    : null,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFE2E0E0), width: 2.0),
                                ),
                                labelStyle: StyleConst.regularStyle(
                                    color: ColorConst.primaryColor),
                                // border: InputBorder.none,
                                // enabledBorder: InputBorder.none,
                                // disabledBorder: InputBorder.none,
                                // focusedBorder: InputBorder.none,
                              ),
                              onSubmitted: (String value) {},
                            )),
                        Padding(
                          padding:
                              EdgeInsets.only(top: _paddingHeight, bottom: 5),
                          child: Text(
                            "Hình ảnh đính kèm",
                            style: StyleConst.boldStyle(
                                color: ColorConst.primaryColor),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            InkWell(
                              child: Container(
                                  width: 64,
                                  height: 64,
                                  margin: EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                      border: Border.all(
                                          width: 3,
                                          color: ColorConst.borderInputColor)),
                                  child: Icon(
                                    Icons.add,
                                    color: ColorConst.grey,
                                  )),
                              onTap: () => _handleUploadImage.call(context),
                            ),
                            Container(
                              width: _mediaQueryData.size.width - 109,
                              height: 64,
                              child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: listImage
                                    .map(
                                      (item) => InkWell(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: ImagePickerWidget(
                                            context: context,
                                            size: 64,
                                            isRemove: true,
                                            resourceUrl: item,
                                            // onFileChanged: (fileUri, fileType) {
                                            //   setState(() {
                                            //     item = fileUri;
                                            //   });
                                            // },
                                          ),
                                        ),
                                        onTap: () => _handleRemoveImage(item),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: _paddingHeight),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Video đính kèm",
                                style: StyleConst.boldStyle(
                                    color: ColorConst.primaryColor),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              // WidgetVideo(
                              //   url: "https://s3.mcom.app/bv-cay-an-qua/618ce8433986288bbabaaf2e-d00244cc-9238-40fd-8f6b-5a6b622b2b851192267639127475099.mp4?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=TXYW2GBH1VGI3ROYTSUT%2F20211111%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20211111T100000Z&X-Amz-Expires=604799&X-Amz-Security-Token=eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhY2Nlc3NLZXkiOiJUWFlXMkdCSDFWR0kzUk9ZVFNVVCIsImV4cCI6MTYzNjYyODM5NywicG9saWN5IjoiY29uc29sZUFkbWluIn0.Cj4s6rxOdst8iWyTquqK6XvDh_MMwVvzJwtqcvnQvUiUXEIvgJKMz3S6MgB_m5N0RTd4uFpYcmhqTCnDHLF6-A&X-Amz-SignedHeaders=host&versionId=null&X-Amz-Signature=b068f41d70a01ae3c4c8e1e69b3aa1dd4e646080680e8abe4637715b2c6dbbfc",
                              //   size: 64,
                              //   isRemove: true,
                              // ),

                              videoFile["path"] != null
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          videoFile = Map();
                                        });
                                      },
                                      child: WidgetVideo(
                                        url: videoFile["path"],
                                        size: 64,
                                        isRemove: true,
                                      ),
                                    )
                                  : InkWell(
                                      child: Container(
                                          width: 64,
                                          height: 64,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0)),
                                              border: Border.all(
                                                  width: 3,
                                                  color: ColorConst
                                                      .borderInputColor)),
                                          child: Icon(
                                            Icons.add,
                                            color: ColorConst.grey,
                                          )),
                                      onTap: () =>
                                          _handleUploadVideo.call(context),
                                    ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 0, bottom: _paddingHeight),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ghi âm đính kèm",
                                style: StyleConst.boldStyle(
                                    color: ColorConst.primaryColor),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    child: Container(
                                        width: 67,
                                        height: 67,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.0)),
                                            border: Border.all(
                                                width: 3,
                                                color: ColorConst
                                                    .borderInputColor)),
                                        child: Icon(
                                          Icons.mic,
                                          color: isStartRecord == false
                                              ? ColorConst.grey
                                              : ColorConst.red,
                                        )),
                                    onTap: () => (isStartRecord == false)
                                        ? _handleUploadAudio.call(context)
                                        : _handleUploadAudioStop(context),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Text(
                                    "${audioFile["path"]?.toString().split("/").last ?? ""}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: StyleConst.regularStyle(),
                                  )),
                                  Visibility(
                                    visible: audioFile["path"] != null,
                                    child: GestureDetector(
                                        onTap: () async {
                                          if (!isStart) {
                                            await audioPlayer.play(
                                                _current!.path!,
                                                isLocal: true);
                                          } else {
                                            await audioPlayer.stop();
                                          }
                                          setState(() {
                                            isStart = !isStart;
                                          });
                                        },
                                        child: Icon(
                                          !isStart
                                              ? Icons.not_started_outlined
                                              : Icons.stop_circle_outlined,
                                          color: !isStart
                                              ? ColorConst.primaryColor
                                              : Colors.red,
                                        )),
                                  ),
                                  Visibility(
                                    visible: audioFile["path"] != null,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: GestureDetector(
                                          onTap: () async {
                                            setState(() {
                                              audioFile = Map();
                                            });
                                          },
                                          child: Icon(
                                            Icons.delete_outline,
                                            color: Colors.red,
                                          )),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Chọn cây trồng (*)",
                          style: StyleConst.boldStyle(
                              color: ColorConst.primaryColor),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(
                                  width: 1,
                                  color: isValid
                                      ? ColorConst.borderInputColor
                                      : ColorConst.red)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                isValid == false
                                    ? Text(
                                        "Không được bỏ trống",
                                        style: StyleConst.regularStyle(
                                            color: ColorConst.red,
                                            fontSize: miniSize),
                                      )
                                    : const SizedBox(),
                                DropdownButton<PlantModel>(
                                  value: _currentTree,
                                  isExpanded: true,
                                  hint: Text('Chọn loại cây trồng'),
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 30,
                                  style: StyleConst.regularStyle(),
                                  underline: Container(
                                    height: 0,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                  },
                                  onChanged: (newTree) {
                                    setState(() {
                                      _currentTree = newTree;
                                    });
                                  },
                                  items: issueController.listPants
                                      .map<DropdownMenuItem<PlantModel>>(
                                          (item) {
                                    return DropdownMenuItem<PlantModel>(
                                      value: item,
                                      child: Text(item.name ?? 'No name'),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: _paddingHeight,
                        ),
                        // Text(
                        //   "Chọn loại bệnh",
                        //   style: StyleConst.boldStyle(
                        //       color: ColorConst.primaryColor),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.only(top: 10),
                        //   decoration: BoxDecoration(
                        //       borderRadius:
                        //           BorderRadius.all(Radius.circular(5.0)),
                        //       border: Border.all(
                        //           width: 1,
                        //           color: ColorConst.borderInputColor)),
                        //   child: Padding(
                        //     padding: EdgeInsets.symmetric(
                        //         horizontal: 20, vertical: 5),
                        //     child: DropdownButton<DiseaseModel>(
                        //       value: _currentDisease,
                        //       isExpanded: true,
                        //       hint: Text('Chọn loại cây trồng'),
                        //       icon: Icon(Icons.arrow_drop_down),
                        //       iconSize: 30,
                        //       style: StyleConst.regularStyle(),
                        //       underline: Container(
                        //         height: 0,
                        //         color: Colors.deepPurpleAccent,
                        //       ),
                        //       onTap: () {
                        //         FocusScope.of(context)
                        //             .requestFocus(new FocusNode());
                        //       },
                        //       onChanged: (newTree) {
                        //         setState(() {
                        //           _currentDisease = newTree;
                        //         });
                        //       },
                        //       items: issueController.listDisease
                        //           .map<DropdownMenuItem<DiseaseModel>>((item) {
                        //         return DropdownMenuItem<DiseaseModel>(
                        //           value: item,
                        //           child: Text(item.name ?? 'No name'),
                        //         );
                        //       }).toList(),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: _paddingHeight,
                        // ),
                        Text(
                          "Chọn trung tâm (*)",
                          style: StyleConst.boldStyle(
                              color: ColorConst.primaryColor),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(
                                  width: 1,
                                  color: isValid
                                      ? ColorConst.borderInputColor
                                      : ColorConst.red)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                isValid == false
                                    ? Text(
                                        "Không được bỏ trống",
                                        style: StyleConst.regularStyle(
                                            color: ColorConst.red,
                                            fontSize: miniSize),
                                      )
                                    : const SizedBox(),
                                DropdownButton<HospitalModel>(
                                  value: _currentHospital,
                                  hint: Text('Chọn trung tâm'),
                                  isExpanded: true,
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 30,
                                  style: StyleConst.regularStyle(),
                                  underline: Container(
                                    height: 0,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (newHospital) {
                                    setState(() {
                                      _currentHospital = newHospital;
                                      _currentDoctor = null;
                                      issueController.getAllDoctor(
                                          hospitalId: newHospital?.id);
                                    });
                                  },
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                  },
                                  items: issueController.listHospitalInput
                                      .map<DropdownMenuItem<HospitalModel>>(
                                          (hospital) {
                                    return DropdownMenuItem<HospitalModel>(
                                      value: hospital,
                                      child: Text(hospital.name ?? 'No name'),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: _paddingHeight,
                        ),
                        Text(
                          "Chọn bác sĩ tư vấn",
                          style: StyleConst.boldStyle(
                              color: ColorConst.primaryColor),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: ColorConst.borderInputColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: DropdownButton<DoctorModel>(
                              value: _currentDoctor,
                              hint: Text('Chọn bác sĩ'),
                              isExpanded: true,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 30,
                              style: StyleConst.regularStyle(),
                              underline: Container(
                                height: 0,
                                color: Colors.deepPurpleAccent,
                              ),
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                              },
                              onChanged: (newDoctor) {
                                setState(() {
                                  _currentDoctor = newDoctor;
                                });
                              },
                              items: issueController.listDoctorInput
                                  .map<DropdownMenuItem<DoctorModel>>(
                                      (dataResult) {
                                return DropdownMenuItem<DoctorModel>(
                                  value: dataResult,
                                  child: Text(dataResult.name ?? 'No name'),
                                );
                              }).toList(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 16 + _mediaQueryData.padding.bottom),
                  child: WidgetButton(
                    text: "Gửi câu hỏi".toUpperCase(),
                    textColor: Colors.white,
                    onTap: () async {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      if (questionController.text.isEmpty ||
                          _currentTree == null ||

                          // _currentDisease == null ||
                          _currentHospital == null) {
                        setState(() {
                          isValid = false;
                        });
                        showDialog<bool>(
                          context: context,
                          builder: (c) => AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                    'Vui lòng bổ sung tất cả các mục đánh dấu (*) nếu còn trống.'),
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: 10,
                                    left: 10,
                                    top: 16,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(),
                                      WidgetButton(
                                          text: 'OK',
                                          paddingBtnWidth: 0,
                                          paddingBtnHeight: 0,
                                          textColor: ColorConst.primaryColor,
                                          backgroundColor: Colors.white,
                                          onTap: () {
                                            Navigator.pop(c, false);
                                          }),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      } else {
                        setState(() {
                          isValid = true;
                        });
                        if (_currentDoctor == null
                            // _currentDisease == null ||
                            ) {
                          showDialog(
                            context: context,
                            builder: (c) => AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Bạn có chắc không chọn bác sĩ tư vấn?'),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: 10,
                                      left: 10,
                                      top: 16,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(),
                                        WidgetButton(
                                            text: 'Không chọn',
                                            paddingBtnWidth: 0,
                                            paddingBtnHeight: 0,
                                            textColor: ColorConst.primaryColor,
                                            backgroundColor: Colors.white,
                                            onTap: () {
                                              Navigator.pop(context);
                                              _createIssue();
                                            }),
                                        WidgetButton(
                                            text: 'Có',
                                            paddingBtnWidth: 0,
                                            paddingBtnHeight: 0,
                                            textColor: ColorConst.primaryColor,
                                            backgroundColor: Colors.white,
                                            onTap: () {
                                              Navigator.pop(context);
                                            }),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        } else {
                          await issueController.createIssue(
                              context: context,
                              tag: widget.tag,
                              title: questionController.text,
                              desc: questionController.text,
                              plantId: _currentTree?.id,
                              hospitalId: _currentHospital?.id,
                              doctorId: _currentDoctor?.id,
                              diseaseId: _currentDisease?.id,
                              videoPath: videoFile["path"],
                              audioPath: audioFile["path"],
                              images: listImage);
                        }
                      }
                    },
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  _createIssue() async {
    await issueController.createIssue(
        context: context,
        tag: widget.tag,
        title: questionController.text,
        desc: questionController.text,
        plantId: _currentTree?.id,
        hospitalId: _currentHospital?.id,
        doctorId: _currentDoctor?.id,
        diseaseId: _currentDisease?.id,
        videoPath: videoFile["path"],
        audioPath: audioFile["path"],
        images: listImage);
  }

  _handleRemoveImage(item) async {
    setState(() {
      listImage.remove(item);
    });
  }

  _handleUploadImage(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    showSelectMoreFile(
        context: context,
        isMultiImage: true,
        callBack: (value) {
          if (value is List<String> && value.length > 0) {
            listImage.addAll(value);
          } else {
            listImage.add(value);
          }
          setState(() {});
        });
  }

  _handleUploadVideo(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());

    showSelectMoreFile(
        context: context,
        typeAlbum: TypeAlbum.video,
        callBack: (value) {
          printLog("gallery path - $value");
          videoFile["path"] = value;
          setState(() {});
        });

    // WaitingDialog.show(context);
    // try {
    //   final XFile? pickedFile =
    //       await ImagePicker().pickVideo(source: ImageSource.camera);
    //   printLog("gallery path - ${pickedFile?.path}");
    //   videoFile["path"] = pickedFile?.path;
    // } catch (error) {
    //   printLog("showSelectImage---- error: $error");
    // }
    // WaitingDialog.turnOff();
  }

  _handleUploadAudio(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    try {
      String customPath =
          "${(await PathFileLocals().getPathLocal(ePathType: EPathType.Cache))?.path}/${DateTime.now().millisecondsSinceEpoch.toString()}";
      print("customPath---$customPath");
      recorder = FlutterAudioRecorder(customPath, audioFormat: AudioFormat.AAC);
      await recorder.initialized;
      _current = await recorder.current(channel: 0);
      await recorder.start();
      setState(() {
        isStartRecord = true;
      });
    } catch (error) {
      printLog("showSelectImage---- error: $error");
    }
  }

  _handleUploadAudioStop(BuildContext context) async {
    var result = await recorder.stop();
    print("Stop recording: ${result.path}");
    print("Stop recording: ${result.duration}");
    File file = File(result.path!);
    print("File length: ${await file.length()}");
    setState(() {
      _current = result;
      isStartRecord = false;
      audioFile["path"] = _current?.path;
      // _currentStatus = _current?.status;
    });
  }

  Future<bool> showExist(BuildContext context) async {
    bool result = false;
    showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text('Xác nhận'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Câu hỏi chưa hoàn tất. Bạn muốn tiếp tục'),
            Padding(
              padding: const EdgeInsets.only(
                  right: 10, left: 10, top: 16, bottom: 0),
              child: Row(
                children: [
                  Expanded(
                    child: WidgetButton(
                        text: 'Hủy'.toUpperCase(),
                        backgroundColor: Colors.white,
                        onTap: () {
                          result = false;
                          Navigator.pop(c, false);
                          Navigator.pop(context, false);
                        }),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: FittedBox(
                      child: WidgetButton(
                        text: 'Tiếp tục'.toUpperCase(),
                        textColor: Colors.white,
                        onTap: () {
                          result = true;
                          Navigator.pop(c, false);
                          // return Platform.isIOS ? exit(0) : SystemNavigator.pop();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
    return result;
  }
}
