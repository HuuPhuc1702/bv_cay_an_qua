/// id : "612f4afd29f8e488db538ac2"
/// name : "Lorem ipsum tag"
/// slug : "lorem-ipsum-tag"
/// image : ""
/// createdAt : "2021-09-01T09:42:21.795Z"

class TopicModel {
  String? id;
  String? name;
  String? slug;
  String? group;
  String? image;

  TopicModel({
    this.id,
    this.name,
    this.slug,
    this.group,
    this.image,
  });

  TopicModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    group = json['group'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['group'] = group;
    map['image'] = image;
    return map;
  }
}
