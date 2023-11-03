import 'package:bv_cay_an_qua/models/disease_model.dart';
import 'package:bv_cay_an_qua/models/user/user_model.dart';
import 'package:bv_cay_an_qua/shared/util_convert/converts.dart';

import '../doctor_model.dart';
import '../hospital_model.dart';
import '../prescription/prescription_model.dart';
import 'attachment_model.dart';
import 'comment_model.dart';
import '../user/plant_model.dart';

/// id : "6149a8ac2f4ae01a53d2ae40"
/// createdAt : "2021-09-21T09:41:00.675Z"
/// title : "test app"
/// desc : "test app"
/// images : ["https://i.imgur.com/x4k1jRi.jpeg"]
/// commentCount : 0
/// viewCount : 0
/// rateCount : 0
/// plant : {"id":"614989092f4ae0c0f8d2adda","name":"Cây xoài","image":"https://i.imgur.com/5vf7KAF.png"}
/// doctor : {"id":"61400a2232cae81d80a973aa","name":"Nguyễn Nhật Ninh","email":"bacsi1@gmail.com","phone":null}
/// hospital : {"id":"614008a332cae81d80a973a5","name":"BV TEST","place":{"fullAddress":"458 Huỳnh Tấn Phát, Phú Xuân, Nhà Bè, Thành phố Hồ Chí Minh, Việt Nam","location":{"type":"Point","coordinates":[106.7529681,10.6784992],"_id":"614008a332cae81d80a973a7"}},"logo":"https://maivangthuduc.com/wp-content/uploads/2017/12/20-C%C3%82Y-XANH.jpg","phone":null}
/// comments : []

class IssueModel {
  String? id;
  String? code;
  String? createdAt;
  String? title;
  String? desc;
  bool? doctorCommented;
  List<String>? images;
  num? commentCount;
  num? viewCount;
  num? rateCount;
  RateStats? rateStats;
  PlantModel? plant;
  DiseaseModel? disease;
  DoctorModel? doctor;
  DoctorModel? fromDoctor;
  HospitalModel? hospital;
  User? owner;
  AttachmentModel? audio;
  AttachmentModel? video;
  PrescriptionModel? prescription;
  List<CommentModel>? comments;

  IssueModel(
      {this.id,
      this.code,
      this.createdAt,
      this.title,
      this.desc,
      this.doctorCommented,
      this.images,
      this.commentCount,
      this.viewCount,
      this.rateCount,
      this.plant,
      this.doctor,
      this.fromDoctor,
      this.disease,
      this.hospital,
      this.owner,
      this.audio,
      this.video,
      this.prescription,
      this.comments});

  IssueModel.fromJson(dynamic json) {
    id = json['id'];
    code = json['code'];
    createdAt = json['createdAt'];
    title = json['title'];
    desc = json['desc'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    commentCount = json['commentCount'];
    // viewCount = json['viewCount'];
    viewCount = (json['viewCount'] ?? 0) > 0
        ? this.viewCount = json['viewCount'] * 10
        : json['viewCount'];

    rateCount = json['rateCount'];
    doctorCommented = json['doctorCommented'];
    plant = json['plant'] != null ? PlantModel.fromJson(json['plant']) : null;
    disease =
        json['disease'] != null ? DiseaseModel.fromJson(json['disease']) : null;
    doctor =
        json['doctor'] != null ? DoctorModel.fromJson(json['doctor']) : null;
    fromDoctor = json['fromDoctor'] != null
        ? DoctorModel.fromJson(json['fromDoctor'])
        : null;
    hospital = json['hospital'] != null
        ? HospitalModel.fromJson(json['hospital'])
        : null;
    owner = json['owner']["profile"] != null
        ? User.fromJson(json['owner']["profile"])
        : null;
    audio =
        json['audio'] != null ? AttachmentModel.fromJson(json['audio']) : null;
    video =
        json['video'] != null ? AttachmentModel.fromJson(json['video']) : null;
    prescription = json['prescription'] != null
        ? PrescriptionModel.fromJson(json['prescription'])
        : null;
    rateStats = json['rateStats'] != null
        ? RateStats.fromJson(json['rateStats'])
        : null;

    if (json['comments'] != null) {
      comments = [];
      json['comments'].forEach((v) {
        comments?.add(CommentModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['title'] = title;
    map['desc'] = desc;
    map['images'] = images;
    map['commentCount'] = commentCount;
    map['viewCount'] = viewCount;
    map['rateCount'] = rateCount;
    if (plant != null) {
      map['plant'] = plant?.toJson();
    }
    if (doctor != null) {
      map['doctor'] = doctor?.toJson();
    }
    if (fromDoctor != null) {
      map['fromDoctor'] = fromDoctor?.toJson();
    }
    if (hospital != null) {
      map['hospital'] = hospital?.toJson();
    }
    if (comments != null) {
      map['comments'] = comments?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class RateStats {
  String? id;
  num? total;
  num? rate;

  RateStats.fromJson(dynamic json) {
    this.id = json["_id"];
    this.total = json["total"];
    this.rate = roundDouble(double.parse(json["rate"].toString()), 1);
  }
}
