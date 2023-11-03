import 'package:bv_cay_an_qua/shared/util_convert/datetime_convert.dart';

class VideoModel {
  String? id;
  String? createdAt;
  String? published;
  String? videoId;
  String? title;
  String? description;
  String? thumb;

  VideoModel(
      {this.id,
      this.title,
      this.createdAt,
      this.published,
      this.description,
      this.thumb,
      this.videoId});

  VideoModel.fromJson(dynamic json) {
    id = json['id'];
    // createdAt = json['createdAt'];
    createdAt = json['createdAt'] != null
        ? dateTimeConvertString(
            dateTime: DateTime.parse(json['createdAt']),
            dateType: "HH:mm dd/MM/yyyy")
        : null;
    published = json['published'] != null
        ? dateTimeConvertString(
            dateTime: DateTime.parse(json['published']),
            dateType: "HH:mm dd/MM/yyyy")
        : null;

    title = json['title'];
    description = json['description'];
    thumb = json['thumb'];
    videoId = json['videoId'];
  }
}

class GroupVideoModel {
  String? id;
  String? name;
  List<VideoModel>? videos;

  GroupVideoModel({this.id, this.name, this.videos});

  GroupVideoModel.fromJson(dynamic json) {
    this.id = json["id"];
    this.name = json["name"];
    this.videos = json["videos"] != null
        ? List<VideoModel>.from(
            json["videos"].map((d) => VideoModel.fromJson(d)))
        : null;
    // if(this.videos==null)this.videos=[];
    // this.videos!.addAll( List<VideoModel>.from(
    //     json["videos"].map((d) => VideoModel.fromJson(d)))
    //     );
    // this.videos!.addAll( List<VideoModel>.from(
    //     json["videos"].map((d) => VideoModel.fromJson(d)))
    // );
  }
}
