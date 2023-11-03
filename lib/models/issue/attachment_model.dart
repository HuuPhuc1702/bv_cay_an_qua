import 'dart:convert';

import 'package:bv_cay_an_qua/shared/helper/print_log.dart';

/// id : "618c9770df94ea0a00d59b76"
/// mimetype : "application/octet-stream"
/// size : 175404
/// downloadUrl : "http://bv-cay-an-qua_minio:9000/dev/618c9770df94ea0a00d59b76-1636603733898.mp3?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=KY0K7H0YYDQFH27FXCAK%2F20211111%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20211111T075533Z&X-Amz-Expires=60&X-Amz-SignedHeaders=host&X-Amz-Signature=b82946dc030cf63e2fbeed83bec14678a690d1f2d32d791e01eb61572b0e8215"
/// name : "1636603733898.mp3"

class AttachmentModel {
  AttachmentModel({
    this.id,
    this.mimetype,
    this.size,
    this.downloadUrl,
    this.path,
    this.name,
  });

  AttachmentModel.fromJson(dynamic json) {
    id = json['id'];
    mimetype = json['mimetype'];
    size = json['size'];
    downloadUrl = json['downloadUrl'];
    name = json['name'];
    path = json['path'];
  }
  String? id;
  String? mimetype;
  num? size;
  String? downloadUrl;
  String? name;
  String? path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['mimetype'] = mimetype;
    map['size'] = size;
    map['downloadUrl'] = downloadUrl;
    map['name'] = name;
    map['path'] = path;
    return map;
  }
}
