/// id : "61512b3786c15d19ac9be201"
/// userId : "6131d7dce0c61533a78a05ac"
/// username : "test app"
/// message : "Đăng nhập tài khoản"
/// createdAt : "2021-09-27T02:23:51.947Z"

class HistoryActivityModel {
  HistoryActivityModel({
      this.id, 
      this.userId, 
      this.username, 
      this.message, 
      this.createdAt,});

  HistoryActivityModel.fromJson(dynamic json) {
    id = json['id'];
    userId = json['userId'];
    username = json['username'];
    message = json['message'];
    createdAt = json['createdAt'];
  }
  String? id;
  String? userId;
  String? username;
  String? message;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userId'] = userId;
    map['username'] = username;
    map['message'] = message;
    map['createdAt'] = createdAt;
    return map;
  }

}