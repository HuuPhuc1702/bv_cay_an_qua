import 'package:bv_cay_an_qua/models/user/user_model.dart';
import 'package:bv_cay_an_qua/shared/helper/print_log.dart';

class PrescriptionModel {
  String? status;
  String? assignerId;
  String? prescriberId;
  dynamic logs;
  List<DetailPrescriptionModel>? details;
  User? assigner;
  User? prescriber;
  String? note;
  List<String>? images;

  PrescriptionModel.fromJson(dynamic json) {
    this.note = json["note"];
    this.images = json['images'] != null ? json['images'].cast<String>() : [];
    this.status = json["status"];
    this.assignerId = json["assignerId"];
    this.prescriberId = json["prescriberId"];
    this.logs = json["logs"];
    this.details = json["detail"] != null
        ? List<DetailPrescriptionModel>.from(
            json["detail"].map((d) => DetailPrescriptionModel.fromJson(d)))
        : null;
    this.assigner =
        json["assigner"] != null ? User.fromJson(json["assigner"]) : null;
    this.prescriber =
        json["prescriber"] != null ? User.fromJson(json["prescriber"]) : null;
  }
}

class DetailPrescriptionModel {
  String? medicineId;
  String? medicineName;
  String? medicineCode;
  String? dosage;
  num? sprayingArea;

  DetailPrescriptionModel.fromJson(dynamic json) {
    this.medicineId = json["medicineId"];
    this.medicineName = json["medicineName"];
    this.medicineCode = json["medicineCode"];
    this.dosage = json["dosage"];
    this.sprayingArea = json["sprayingArea"];
  }
}
