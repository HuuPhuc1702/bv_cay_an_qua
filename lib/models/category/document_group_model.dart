/// id : "6125e9243e3d6d9c1ad0efa4"
/// name : "Quy trình phòng trừ"
/// code : "quy-trinh-phong-tru"
/// priority : 30
/// icon : null
/// active : true

class DocumentGroupModel {
  String? id;
  String? name;
  String? code;
  int? priority;
  dynamic? icon;
  bool? active;

  DocumentGroupModel({
      this.id, 
      this.name, 
      this.code, 
      this.priority, 
      this.icon, 
      this.active});

  DocumentGroupModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    priority = json['priority'];
    icon = json['icon'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['code'] = code;
    map['priority'] = priority;
    map['icon'] = icon;
    map['active'] = active;
    return map;
  }

}