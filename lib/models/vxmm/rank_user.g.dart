// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rank_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RankUser _$_$_RankUserFromJson(Map<String, dynamic> json) {
  return _$_RankUser(
    id: json['id'] as String?,
    total: json['total'] as int?,
    rank: json['rank'] as int?,
    info: json['info'] == null
        ? null
        : UserModel.fromJson(json['info'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_RankUserToJson(_$_RankUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'total': instance.total,
      'rank': instance.rank,
      'info': instance.info,
    };
