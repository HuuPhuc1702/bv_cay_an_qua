/// id : "92"
/// province : "Thành phố Cần Thơ"

class WardModel {
  String? id;
  String? ward;

  WardModel({
    this.id,
    this.ward});

  WardModel.fromJson(dynamic json) {
    id = json['id'];
    ward = json['ward'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['ward'] = ward;
    return map;
  }

}