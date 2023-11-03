
class PrescriptionParam {
  String? medicineId;
  String? medicineName;
  String? medicineCode;
  String? dosage;
  String? sprayingArea;

  PrescriptionParam(
      {this.medicineId,
        this.medicineName,
        this.medicineCode,
        this.dosage,
        this.sprayingArea});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['medicineId'] = "$medicineId";
    map['medicineName'] = "$medicineName";
    map['medicineCode'] = "$medicineCode";
    map['dosage'] = dosage;
    map['sprayingArea'] = sprayingArea;
    return map;
  }
}