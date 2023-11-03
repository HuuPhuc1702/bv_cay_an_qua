// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CampaignLog _$_$_CampaignLogFromJson(Map<String, dynamic> json) {
  return _$_CampaignLog(
    id: json['id'] as String?,
    farmerId: json['farmerId'] as String?,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    campaign: json['campaign'] == null
        ? null
        : CampaignModel.fromJson(json['campaign'] as Map<String, dynamic>),
    prizes: (json['prizes'] as List<dynamic>?)
        ?.map((e) => PrizeModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$_$_CampaignLogToJson(_$_CampaignLog instance) =>
    <String, dynamic>{
      'id': instance.id,
      'farmerId': instance.farmerId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'campaign': instance.campaign,
      'prizes': instance.prizes,
    };
