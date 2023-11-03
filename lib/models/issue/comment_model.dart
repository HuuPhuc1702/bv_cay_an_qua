import 'package:bv_cay_an_qua/models/user/user_model.dart';
import 'package:bv_cay_an_qua/shared/util_convert/converts.dart';

/// id : null
/// createdAt : "2021-09-08T02:41:40.161Z"
/// content : "First Comment"
/// image : null
/// replyToId : null
/// owner : {"id":"612f3f3e29f8e488db538abd","name":"LL","phone":null,"email":"liemly98@gmail.com"}

class CommentModel {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? content;
  num? viewCount;
  dynamic image;
  dynamic replyToId;
  Owner? owner;
  CommentModel? replies;
  bool editing = false;
  RateStats? rateStats;

  CommentModel(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.content,
      this.image,
      this.replyToId,
      this.viewCount,
      this.owner,
      this.replies});

  CommentModel.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    content = json['content'];
    image = json['image'];
    // viewCount = json['viewCount'];
    viewCount = (json['viewCount'] ?? 0) > 0
        ? this.viewCount = json['viewCount'] * 10
        : json['viewCount'];

    replyToId = json['replyToId'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    replies =
        json['replies'] != null ? CommentModel.fromJson(json['replies']) : null;
    rateStats = json['rateStats'] != null
        ? RateStats.fromJson(json['rateStats'])
        : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['content'] = content;
    map['image'] = image;
    map['replyToId'] = replyToId;
    if (owner != null) {
      map['owner'] = owner?.toJson();
    }
    return map;
  }
}

/// id : "612f3f3e29f8e488db538abd"
/// name : "LL"
/// phone : null
/// email : "liemly98@gmail.com"

class Owner {
  String? id;
  String? name;
  String? phone;
  String? email;
  User? profile;

  Owner({this.id, this.name, this.phone, this.email});

  Owner.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    profile = json['profile'] != null ? User.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['phone'] = phone;
    map['email'] = email;
    return map;
  }
}

class RateStats {
  num? total;
  num? rate;

  RateStats.fromJson(dynamic json) {
    this.total = json["total"];
    this.rate = roundDouble(double.parse(json["rate"].toString()), 1);
  }
}
