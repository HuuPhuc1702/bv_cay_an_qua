import 'dart:convert';

import 'package:bv_cay_an_qua/models/issue/attachment_model.dart';
import 'package:bv_cay_an_qua/shared/helper/print_log.dart';
import 'package:bv_cay_an_qua/shared/util_convert/datetime_convert.dart';

/// id : "611e0df9db5b9f38d4550de6"
/// createdAt : "2021-08-19T07:53:29.969Z"
/// title : "Giá tiêu hôm nay 19/8: Dự báo sẽ còn tiếp tục tăng"
/// excerpt : null
/// slug : "as"
/// status : "PUBLIC"
/// publishedAt : null
/// featureImage : null
/// ogImage : "https://i.imgur.com/0iAqcvt.jpg"
/// content : "Tại thị trường thế giới, giá tiêu hôm nay 19/8 tiếp tục duy trì ổn định.\n\nTrong phiên giao dịch gần nhất, giá tiêu giao ngay tại sàn Kochi - Ấn Độ giảm 33,35 rupee/tạ, ở mức 41.300 rupee/tạ.\n\nTỷ giá tính chéo của đồng Việt Nam đối với đồng rupee Ấn Độ (INR) từ ngày 12/8 - 19/8/2021 được Ngân hàng Nhà nước áp dụng tính thuế xuất khẩu và thuế nhập khẩu là 311,41 VND/INR.\n\nNhư vậy, giá tiêu hôm nay 19/8/2021 tại thị trường Ấn Độ tiếp tục phiên đi ngang."
/// ogTitle : null
/// ogDescription : "Giá tiêu hôm nay 19/8/2021 ở trong nước duy trì ổn định, áp sát mốc 80.000 đồng/kg. Với đà tăng bền vững như này, giá hồ tiêu sẽ còn bật lên vào cuối năm nay."
/// seen : true

class PostModel {
  String? id;
  String? createdAt;
  String? title;
  dynamic? excerpt;
  String? slug;
  String? status;
  String? publishedAt;
  String? featureImage;
  String? ogImage;
  String? content;
  dynamic? ogTitle;
  String? ogDescription;
  bool? seen;
  String? url;
  num? view;
  List<AttachmentModel>? attachments;

  PostModel({
    this.id,
    this.createdAt,
    this.title,
    this.excerpt,
    this.slug,
    this.status,
    this.publishedAt,
    this.featureImage,
    this.ogImage,
    this.content,
    this.ogTitle,
    this.ogDescription,
    this.seen,
    this.view,
    this.attachments,
  });

  PostModel.fromJson(dynamic json) {
    id = json['id'];
    // createdAt = json['createdAt'];
    createdAt = json['createdAt'] != null
        ? dateTimeConvertString(
            dateTime: DateTime.parse(json['createdAt']), dateType: "dd/MM/yyyy")
        : null;
    title = json['title'];
    excerpt = json['excerpt'];
    slug = json['slug'];
    status = json['status'];
    publishedAt = json['publishedAt'] != null
        ? dateTimeConvertString(
            dateTime: DateTime.parse(json['publishedAt']),
            dateType: "dd/MM/yyyy")
        : null;
    featureImage = json['featureImage'];
    ogImage = json['ogImage'];
    content = json['content'];
    ogTitle = json['ogTitle'];
    ogDescription = json['ogDescription'];
    seen = json['seen'];
    url = json['url'];
    // view = json['view'];
    view =
        (json['view'] ?? 0) > 0 ? this.view = json['view'] * 10 : json['view'];

    if (json['attachments'] != null) {
      attachments = [];
      json['attachments'].forEach((v) {
        if (v != null) attachments?.add(AttachmentModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['title'] = title;
    map['excerpt'] = excerpt;
    map['slug'] = slug;
    map['status'] = status;
    map['publishedAt'] = publishedAt;
    map['featureImage'] = featureImage;
    map['ogImage'] = ogImage;
    map['content'] = content;
    map['ogTitle'] = ogTitle;
    map['ogDescription'] = ogDescription;
    map['seen'] = seen;
    map['view'] = view;
    return map;
  }
}
