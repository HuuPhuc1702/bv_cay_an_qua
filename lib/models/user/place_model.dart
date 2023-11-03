/// street : null
/// province : ""
/// provinceId : ""
/// district : ""
/// districtId : ""
/// ward : ""
/// wardId : ""
/// fullAddress : ""
/// location : {"type":"Point","coordinates":[-122.406417,37.785834],"_id":"61237c05269a3f5f9de6e4da"}

class PlaceModel {
  dynamic street;
  String? province;
  String? provinceId;
  String? district;
  String? districtId;
  String? ward;
  String? wardId;
  String? fullAddress;
  Location? location;

  PlaceModel({
      this.street, 
      this.province, 
      this.provinceId, 
      this.district, 
      this.districtId, 
      this.ward, 
      this.wardId, 
      this.fullAddress, 
      this.location});

  PlaceModel.fromJson(dynamic json) {
    street = json['street'];
    province = json['province'];
    provinceId = json['provinceId'];
    district = json['district'];
    districtId = json['districtId'];
    ward = json['ward'];
    wardId = json['wardId'];
    fullAddress = json['fullAddress'];
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['street'] = street;
    map['province'] = province;
    map['provinceId'] = provinceId;
    map['district'] = district;
    map['districtId'] = districtId;
    map['ward'] = ward;
    map['wardId'] = wardId;
    map['fullAddress'] = fullAddress;
    if (location != null) {
      map['location'] = location?.toJson();
    }
    return map;
  }

}

/// type : "Point"
/// coordinates : [-122.406417,37.785834]
/// _id : "61237c05269a3f5f9de6e4da"

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