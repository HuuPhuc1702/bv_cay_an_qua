/// id : "61400a2232cae81d80a973aa"
/// name : "Nguyễn Nhật Ninh"
/// email : "bacsi1@gmail.com"
/// phone : null
/// avatar : "https://i1-dulich.vnecdn.net/2019/11/29/Epson-International-Pano-2019-vnexpress-3-1575023591.jpg?w=1200&h=0&q=100&dpr=1&fit=crop&s=Q-IBOjZb35-IJd2Wc0Dh7A"
/// position : null
/// degree : null
/// subject : null
/// specialized : null
/// intro : null

class DoctorModel {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? avatar;
  String? position;
  String? degree;
  String? subject;
  String? specialized;
  String? intro;
  String? hospitalId;

  DoctorModel({
      this.id, 
      this.name, 
      this.email, 
      this.phone, 
      this.avatar, 
      this.position, 
      this.degree, 
      this.subject, 
      this.specialized, 
      this.hospitalId,
      this.intro});

  DoctorModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    avatar = json['avatar'];
    position = json['position'];
    degree = json['degree'];
    subject = json['subject'];
    specialized = json['specialized'];
    intro = json['intro'];
    hospitalId = json['hospitalId'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['avatar'] = avatar;
    map['position'] = position;
    map['degree'] = degree;
    map['subject'] = subject;
    map['specialized'] = specialized;
    map['intro'] = intro;
    return map;
  }

}