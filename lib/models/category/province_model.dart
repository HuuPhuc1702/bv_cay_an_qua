/// id : "92"
/// province : "Thành phố Cần Thơ"

class ProvinceModel {
  String? id;
  String? province;

  ProvinceModel({
      this.id, 
      this.province});

  ProvinceModel.fromJson(dynamic json) {
    id = json['id'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['province'] = province;
    return map;
  }

}