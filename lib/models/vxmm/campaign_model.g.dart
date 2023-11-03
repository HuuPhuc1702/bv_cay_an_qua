// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CampaignModel _$_$_CampaignModelFromJson(Map<String, dynamic> json) {
  return _$_CampaignModel(
    active: json['active'] as bool?,
    activeAt: json['activeAt'] == null
        ? null
        : DateTime.parse(json['activeAt'] as String),
    code: json['code'] as String?,
    content: json['content'] as String?,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    endDate: json['endDate'] == null
        ? null
        : DateTime.parse(json['endDate'] as String),
    icon: json['icon'] as String?,
    id: json['id'] as String,
    image: json['image'] as String?,
    name: json['name'] as String,
    startDate: DateTime.parse(json['startDate'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
    activeUser: json['activeUser'] == null
        ? null
        : UserModel.fromJson(json['activeUser'] as Map<String, dynamic>),
    topup: json['topup'] == null
        ? null
        : TopupModel.fromJson(json['topup'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_CampaignModelToJson(_$_CampaignModel instance) =>
    <String, dynamic>{
      'active': instance.active,
      'activeAt': instance.activeAt?.toIso8601String(),
      'code': instance.code,
      'content': instance.content,
      'createdAt': instance.createdAt?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'icon': instance.icon,
      'id': instance.id,
      'image': instance.image,
      'name': instance.name,
      'startDate': instance.startDate.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'activeUser': instance.activeUser,
      'topup': instance.topup,
    };
