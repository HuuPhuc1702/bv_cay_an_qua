// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_user_in_campaign_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CheckUserInCampaignResponse _$_$_CheckUserInCampaignResponseFromJson(
    Map<String, dynamic> json) {
  return _$_CheckUserInCampaignResponse(
    active: json['active'] as bool?,
    valid: json['valid'] as bool?,
    msg: json['msg'] as String?,
    staff: json['staff'] == null
        ? null
        : UserModel.fromJson(json['staff'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_CheckUserInCampaignResponseToJson(
        _$_CheckUserInCampaignResponse instance) =>
    <String, dynamic>{
      'active': instance.active,
      'valid': instance.valid,
      'msg': instance.msg,
      'staff': instance.staff,
    };
