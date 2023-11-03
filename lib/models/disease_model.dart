/// id : "614d74f65c700f7312281577"
/// name : "123"
/// thumbnail : "https://i.imgur.com/LZ6dW0Z.jpg"

class DiseaseModel {
  String? id;
  String? name;
  String? thumbnail;
  String? code;
  String? type;
  String? alternativeName;
  String? scienceName;

  DiseaseModel({
      this.id, 
      this.name, 
      this.code,
      this.type,
      this.alternativeName,
      this.scienceName,
      this.thumbnail});

  DiseaseModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    thumbnail = json['thumbnail'];
    code = json['code'];
    type = json['type'];
    alternativeName = json['alternativeName'];
    scienceName = json['scienceName'];
  }

  // Map<String, dynamic> toJson() {
  //   var map = <String, dynamic>{};
  //   map['id'] = id;
  //   map['name'] = name;
  //   map['thumbnail'] = thumbnail;
  //   return map;
  // }

}