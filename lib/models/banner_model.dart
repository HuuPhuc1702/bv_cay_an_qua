import 'package:bv_cay_an_qua/models/issue/comment_model.dart';

/// id : "6144169aa44c6986c88649db"
/// image : "https://i.imgur.com/zVf5uq6.jpg"
/// createdAt : "2021-09-17T04:16:26.280Z"
/// action : {"type":"WEBSITE","link":"https://google.com","postId":null}

class BannerModel {
  String? id;
  String? image;
  String? createdAt;
  Action? action;
  Owner? owner;
  String? type;
  num? priority;
  bool? active;
  String? startAt;
  String? endAt;
  List? targets;

  BannerModel({
    this.id,
    this.image,
    this.createdAt,
    this.action,
    this.owner,
    this.type,
    this.priority,
    this.active,
    this.startAt,
    this.endAt,
    this.targets,
  });

  BannerModel.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    createdAt = json['createdAt'];
    action = json['action'] != null ? Action.fromJson(json['action']) : null;
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    type = json['type'];
    priority = json['priority'];
    active = json['active'];
    startAt = json['startAt'];
    endAt = json['endAt'];
    targets = json['targets'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['createdAt'] = createdAt;
    if (action != null) {
      map['action'] = action?.toJson();
    }
    if (owner != null) {
      map['owner'] = owner?.toJson();
    }
    map['type'] = type;
    map['priority'] = priority;
    map['active'] = active;
    map['startAt'] = startAt;
    map['endAt'] = endAt;
    map['targets'] = targets;
    return map;
  }
}

/// type : "WEBSITE"
/// link : "https://google.com"
/// postId : null

class Action {
  String? type;
  String? link;
  dynamic? postId;

  Action({this.type, this.link, this.postId});

  Action.fromJson(dynamic json) {
    type = json['type'];
    link = json['link'];
    postId = json['postId'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['type'] = type;
    map['link'] = link;
    map['postId'] = postId;
    return map;
  }
}
