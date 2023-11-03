/// id : "61309d035f043e075f25c5b9"
/// name : "Chủ đề tài liệu kỹ thuật"
/// key : "CHU_DE_TLKT"
/// value : ["Giống","Kỹ thuật canh tác","Bảo vệ thực vật","Kỹ thuật xử lí ra hoa","Dinh dưỡng","Thu hoạch và bảo quản"]

class SettingModel {
  String? id;
  String? name;
  String? key;
  bool? isActive;
  dynamic value;

  SettingModel({
      this.id, 
      this.name, 
      this.key, 
      this.isActive,
      this.value});

  SettingModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    key = json['key'];
    isActive = json['isActive'];
    value = json['value'] ;
    // value = json['value'] != null ? json['value'].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['key'] = key;
    map['value'] = value;
    return map;
  }

}