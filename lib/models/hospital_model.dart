/// id : "614008a332cae81d80a973a5"
/// name : "BV TEST"
/// logo : "https://maivangthuduc.com/wp-content/uploads/2017/12/20-C%C3%82Y-XANH.jpg"
/// phone : null
/// place : {"fullAddress":"458 Huỳnh Tấn Phát, Phú Xuân, Nhà Bè, Thành phố Hồ Chí Minh, Việt Nam","location":{"type":"Point","coordinates":[106.7529681,10.6784992],"_id":"614008a332cae81d80a973a7"}}
/// intro : "123123"

class HospitalModel {
  String? id;
  String? name;
  String? logo;
  String? phone;
  Place? place;
  String? intro;
  String? hospitalId;

  HospitalModel({
      this.id, 
      this.name, 
      this.logo, 
      this.phone, 
      this.place, 
      this.hospitalId,
      this.intro});

  HospitalModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    phone = json['phone'];
    place = json['place'] != null ? Place.fromJson(json['place']) : null;
    intro = json['intro'];
    hospitalId = json['hospitalId'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['logo'] = logo;
    map['phone'] = phone;
    if (place != null) {
      map['place'] = place?.toJson();
    }
    map['intro'] = intro;
    return map;
  }

}

/// fullAddress : "458 Huỳnh Tấn Phát, Phú Xuân, Nhà Bè, Thành phố Hồ Chí Minh, Việt Nam"
/// location : {"type":"Point","coordinates":[106.7529681,10.6784992],"_id":"614008a332cae81d80a973a7"}

class Place {
  String? fullAddress;
  Location? location;

  Place({
      this.fullAddress, 
      this.location});

  Place.fromJson(dynamic json) {
    fullAddress = json['fullAddress'];
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['fullAddress'] = fullAddress;
    if (location != null) {
      map['location'] = location?.toJson();
    }
    return map;
  }

}

/// type : "Point"
/// coordinates : [106.7529681,10.6784992]
/// _id : "614008a332cae81d80a973a7"

class Location {
  String? type;
  List<double>? coordinates;
  String? id;

  Location({
      this.type, 
      this.coordinates, 
      this.id});

  Location.fromJson(dynamic json) {
    type = json['type'];
    coordinates = json['coordinates'] != null ? json['coordinates'].cast<double>() : [];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['type'] = type;
    map['coordinates'] = coordinates;
    map['_id'] = id;
    return map;
  }

}