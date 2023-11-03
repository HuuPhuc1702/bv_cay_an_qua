import 'package:bv_cay_an_qua/models/issue/comment_model.dart';
import 'package:bv_cay_an_qua/models/user/plant_model.dart';
import 'package:bv_cay_an_qua/models/user/user_model.dart';

/// id : "618383cc95e9f02b247acee1"
/// createdAt : "2021-11-04T06:55:08.764Z"
/// type : "doctor"
/// code : "UP10015"
/// content : "11111111111111111111"
/// images : []
/// commentIds : []
/// commentCount : 0
/// viewCount : 0
/// owner : {"profile":{"id":"6180e1ffac08f35571a51c8b","name":"bác sĩ lộc trời","avatar":"","email":"bacsiloctroi@gmail.com","phone":"0909123123"}}

class UserPostModel {
  UserPostModel({
    this.id,
    this.createdAt,
    this.type,
    this.code,
    this.content,
    this.images,
    this.commentIds,
    this.commentCount,
    this.viewCount,
    this.owner,
  });

  UserPostModel.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['createdAt'];
    type = json['type'];
    code = json['code'];
    content = json['content'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    commentIds =
        json['commentIds'] != null ? json['commentIds'].cast<String>() : [];
    commentCount = json['commentCount'];
    viewCount = json['viewCount'];
    owner = json['owner']["profile"] != null
        ? User.fromJson(json['owner']["profile"])
        : null;
    plant = json['plant'] != null ? PlantModel.fromJson(json['plant']) : null;
    if (json['comments'] != null) {
      comments = [];
      json['comments'].forEach((v) {
        comments?.add(CommentModel.fromJson(v));
      });
    }
  }

  String? id;
  String? createdAt;
  String? type;
  String? code;
  String? content;
  List<String>? images;
  List<String>? commentIds;
  num? commentCount;
  num? viewCount;
  User? owner;
  PlantModel? plant;
  List<CommentModel>? comments;

//
// Map<String, dynamic> toJson() {
//   final map = <String, dynamic>{};
//   map['id'] = id;
//   map['createdAt'] = createdAt;
//   map['type'] = type;
//   map['code'] = code;
//   map['content'] = content;
//   map['commentCount'] = commentCount;
//   map['viewCount'] = viewCount;
//   if (owner != null) {
//     map['owner'] = owner?.toJson();
//   }
//   return map;
// }
}
