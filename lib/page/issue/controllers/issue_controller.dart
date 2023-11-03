import 'dart:convert';

import 'package:bv_cay_an_qua/models/topic_model.dart';
import 'package:bv_cay_an_qua/services/files/service_file.dart';
import 'package:bv_cay_an_qua/shared/helper/print_log.dart';

import '../../../export.dart';
import '../../../models/disease_model.dart';
import '../../../models/doctor_model.dart';
import '../../../models/hospital_model.dart';
import '../../../models/issue/issue_model.dart';
import '../../../models/user/plant_model.dart';
import '../../../repositories/auth_repo.dart';
import '../../../repositories/issue_repo.dart';
import '../../../repositories/prescription_repo.dart';
import '../../../services/graphql/crud_repo.dart';
import '../../../services/graphql/graphql_list_load_more_provider.dart';
import '../../../shared/helper/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IssueProvider extends CrudRepository<IssueModel> {
  IssueProvider() : super(apiName: "Issue");

  @override
  IssueModel fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return IssueModel.fromJson(json);
  }
}

class IssueController extends GraphqlListLoadMoreProvider<IssueModel> {
  List<PlantModel> listPants = [PlantModel(name: "Tất cả")];

  List<HospitalModel> listHospital = [HospitalModel(name: "Tất cả")];
  List<HospitalModel> listHospitalInput = [];

  List<DoctorModel> listDoctor = [DoctorModel(name: "Tất cả")];
  List<DoctorModel> listDoctorInput = [];
  List<DiseaseModel> listDisease = [DiseaseModel(name: "Tất cả")];
  List<TopicModel> listIssueTopics = [TopicModel(name: "Tất cả")];

  HospitalModel? hospitalValue;
  DoctorModel? doctorValue;
  PlantModel? plantValue;
  DiseaseModel? diseaseValue;

  bool myQuestion = false;
  bool noneAnswer = false;
  int countIssueTopic = 0;

  Map<String, dynamic> doctorFilter = Map();
  bool isFiltering = false;

  IssueModel? detail;

  // QueryInput? queryInput;

  static IssueProvider _provider = IssueProvider();

  IssueController({query})
      : super(service: _provider, query: query, fragment: """
       id code createdAt title desc images commentCount viewCount rateCount rateStats doctorCommented
        plant{ id name image }
        doctor{ id name email phone }
        fromDoctor{ id name email phone }
        hospital{ id name place{ fullAddress location } logo phone }
        comments{ id createdAt content image replyToId issueId updatedAt viewCount
                  rateStats
                  owner{
                    id
                    name
                    phone
                    email
                    profile{
                        ${authRepository.param}
                      }
                  }
        }
        disease{
          ${authRepository.queryDisease}
        }
        
        video{
          id
          mimetype
          size
          downloadUrl
          name
        }
        audio{
          id
          mimetype
          size
          downloadUrl
          name
        }
        
        prescription{
          status
          assignerId
          prescriberId
          detail{
              medicineId
              medicineName
              medicineCode
              dosage
              sprayingArea
            }
          images
          note
        }
       owner{
           profile{
               ${authRepository.param}
              }
          }
      """) {
    // this.queryInput = query;
  }

  refreshData() {
    // if (queryInput == null) {
    //   queryInput = QueryInput(order: {"createdAt": -1});
    // }
    // this.loadAll(query: this.queryInput);
    _provider.clearCache();
    this.loadAll();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getAllPlant();
    await getAllDisease();
    await getAllHospital();
    await getAllIssueTopic();
    update();
  }

  refreshDataDetail() async {
    _provider.clearCache();
    printLog("IssueController---refreshDataDetail: ${detail?.id}");
    detail = await _provider.getOne(id: detail?.id, fragment: this.fragment);
    update();
  }

  getOneIssue(String id) async {
    detail = null;
    detail = await _provider.getOne(id: id, fragment: this.fragment);
    update();
  }

  getAllDisease() async {
    listDisease = [DiseaseModel(name: "Tất cả")];
    listDisease.addAll(await authRepository.getAllDisease());
  }

  getAllPlant() async {
    listPants = [PlantModel(name: "Tất cả")];
    listPants.addAll(await authRepository.getAllPlant());
  }

  getAllHospital() async {
    listHospital = [HospitalModel(name: "Tất cả")];
    listHospitalInput = [];
    listHospital.addAll(await authRepository.getAllHospital());
    listHospitalInput.addAll(await authRepository.getAllHospital());
  }

  getAllDoctor({String? hospitalId}) async {
    listDoctor = [DoctorModel(name: "Tất cả")];
    listDoctorInput = [];
    listDoctor
        .addAll(await authRepository.getAllDoctor(hospitalId: hospitalId));
    listDoctorInput
        .addAll(await authRepository.getAllDoctor(hospitalId: hospitalId));
    update();
  }

  getAllIssueTopic({String? hospitalId}) async {
    listIssueTopics = [TopicModel(name: "Tất cả")];
    listIssueTopics.addAll(await authRepository.getAllIssueTopic());
    update();
  }

  assignPrescription({
    required String issueId,
    required BuildContext context,
  }) async {
    WaitingDialog.show(context);
    var data =
        await prescriptionRepository.assignPrescription(issueId: issueId);
    WaitingDialog.turnOff();
    if (data == true) {
      showSnackBar(title: "Thông báo", body: "Gửi yêu cầu kê đơn thành công");
      refreshData();
    } else {
      showSnackBar(
          title: "Thông báo",
          body: "Gửi yêu cầu kê đơn thất bại",
          backgroundColor: Colors.red);
    }
  }

  assignIssueDisease({required String diseaseId}) async {
    if (detail?.id == null) {
      showSnackBar(
          title: "Thông báo",
          body: "Cập nhật thất bại",
          backgroundColor: Colors.red);
    }
    var data = await issueRepository.assignIssueDisease(
        issueId: detail?.id ?? "", diseaseId: diseaseId);
    if (data == true) {
      showSnackBar(title: "Thông báo", body: "Cập nhật thành công");
      refreshDataDetail();
      refreshData();
    } else {
      showSnackBar(
          title: "Thông báo",
          body: "Cập nhật thất bại",
          backgroundColor: Colors.red);
    }
  }

  transferIssueDoctor(
      {required String? doctorId, required dynamic reason}) async {
    if (detail?.id == null) {
      showSnackBar(
          title: "Thông báo",
          body: "Chuyển bác sĩ thất bại",
          backgroundColor: Colors.red);
    }
    var data = await issueRepository.transferIssueDoctor(
        issueId: detail?.id ?? "", doctorId: doctorId, reason: reason);
    if (data == true) {
      showSnackBar(title: "Thông báo", body: "Cập nhật thành công");
      refreshDataDetail();
      refreshData();
    } else {
      showSnackBar(
          title: "Thông báo",
          body: "Cập nhật thất bại",
          backgroundColor: Colors.red);
    }
  }

  transferIssueHospital(
      {required String? hospitalId, required dynamic reason}) async {
    if (detail?.id == null) {
      showSnackBar(
          title: "Thông báo",
          body: "Chuyển bác sĩ thất bại",
          backgroundColor: Colors.red);
    }
    var data = await issueRepository.transferIssueHospital(
        issueId: detail?.id ?? "", hospitalId: hospitalId, reason: reason);
    if (data == true) {
      showSnackBar(title: "Thông báo", body: "Cập nhật thành công");
      refreshDataDetail();
      refreshData();
    } else {
      showSnackBar(
          title: "Thông báo",
          body: "Cập nhật thất bại",
          backgroundColor: Colors.red);
    }
  }

  createIssue(
      {required BuildContext context,
      String? tag,
      String? title,
      String? desc,
      String? plantId,
      String? diseaseId,
      String? hospitalId,
      String? doctorId,
      String? videoPath,
      String? audioPath,
      List<String>? images}) async {
    WaitingDialog.show(context);
    try {
      String? videoId;
      String? audioId;

      if (videoPath != null) {
        print(videoPath);
        var dataVideoResult =
            jsonDecode(await serviceFile.uploadFile(pathFile: videoPath) ?? "");
        videoId = dataVideoResult["id"];
      }

      if (audioPath != null) {
        var dataAudioResult =
            jsonDecode(await serviceFile.uploadFile(pathFile: audioPath) ?? "");
        audioId = dataAudioResult["id"];
      }
      List<String>? imageNetworks;
      if (images != null) {
        imageNetworks = [];
        for (int i = 0; i < images.length; i++) {
          await serviceFile.updateImageImgur(images[i], onUpdateImage: (value) {
            if (value != null) imageNetworks!.add(value);
          });
        }
      }

      final data = await issueRepository.createIssue(
          title: title,
          desc: desc,
          doctorId: doctorId,
          diseaseId: diseaseId,
          hospitalId: hospitalId,
          images: imageNetworks,
          plantId: plantId,
          audioId: audioId,
          videoId: videoId);
      if (data) {
        try {
          if (tag != null) {
            final controller = Get.find<IssueController>(tag: tag);
            controller.loadAll();
          }
        } catch (error) {
          print(error);
        }
        // Get.back();
        Navigator.of(context).pop();
        Future.delayed(const Duration(milliseconds: 500), () {
          showSnackBar(title: "Thông báo", body: "Gửi câu hỏi thành công.");
        });
      }
    } catch (error) {
      print("createIssue--- error: $error");
    }
    WaitingDialog.turnOff();
  }

  createComment(
      {required String issueId,
      required BuildContext context,
      String? replyToId,
      String? content,
      String? image}) async {
    WaitingDialog.show(context);
    try {
      String? _image;
      if (image != null)
        await serviceFile.updateImageImgur(image, onUpdateImage: (value) {
          if (value != null) _image = value;
        });
      var data = await issueRepository.createComment(
          issueId: issueId, content: content, image: _image);
      WaitingDialog.turnOff();
      if (data) {
        showSnackBar(title: "Thông báo", body: "Bình luận đã được tạo");
        refreshData();
        getOneIssue(issueId);
        return true;
      }
      return false;
    } catch (error) {
      WaitingDialog.turnOff();
      return false;
    }
  }

  setIsFilter(bool check) {
    isFiltering = check;
    update();
  }
}
