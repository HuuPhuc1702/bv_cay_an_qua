/// id : "92"
/// province : "Thành phố Cần Thơ"

class DistrictModel {
  String? id;
  String? district;

  DistrictModel({
    this.id,
    this.district});

  DistrictModel.fromJson(dynamic json) {
    id = json['id'];
    district = json['district'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['district'] = district;
    return map;
  }

}