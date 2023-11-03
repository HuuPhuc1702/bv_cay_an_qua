// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rank_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RankResult _$_$_RankResultFromJson(Map<String, dynamic> json) {
  return _$_RankResult(
    me: (json['me'] as List<dynamic>?)
        ?.map((e) => RankUser.fromJson(e as Map<String, dynamic>))
        .toList(),
    top10: (json['top10'] as List<dynamic>)
        .map((e) => RankUser.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$_$_RankResultToJson(_$_RankResult instance) =>
    <String, dynamic>{
      'me': instance.me,
      'top10': instance.top10,
    };
