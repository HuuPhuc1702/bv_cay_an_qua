// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'campaign_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CampaignLog _$CampaignLogFromJson(Map<String, dynamic> json) {
  return _CampaignLog.fromJson(json);
}

/// @nodoc
class _$CampaignLogTearOff {
  const _$CampaignLogTearOff();

  _CampaignLog call(
      {String? id,
      String? farmerId,
      DateTime? createdAt,
      CampaignModel? campaign,
      List<PrizeModel>? prizes}) {
    return _CampaignLog(
      id: id,
      farmerId: farmerId,
      createdAt: createdAt,
      campaign: campaign,
      prizes: prizes,
    );
  }

  CampaignLog fromJson(Map<String, Object> json) {
    return CampaignLog.fromJson(json);
  }
}

/// @nodoc
const $CampaignLog = _$CampaignLogTearOff();

/// @nodoc
mixin _$CampaignLog {
  String? get id => throw _privateConstructorUsedError;
  String? get farmerId => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  CampaignModel? get campaign => throw _privateConstructorUsedError;
  List<PrizeModel>? get prizes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CampaignLogCopyWith<CampaignLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CampaignLogCopyWith<$Res> {
  factory $CampaignLogCopyWith(
          CampaignLog value, $Res Function(CampaignLog) then) =
      _$CampaignLogCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String? farmerId,
      DateTime? createdAt,
      CampaignModel? campaign,
      List<PrizeModel>? prizes});

  $CampaignModelCopyWith<$Res>? get campaign;
}

/// @nodoc
class _$CampaignLogCopyWithImpl<$Res> implements $CampaignLogCopyWith<$Res> {
  _$CampaignLogCopyWithImpl(this._value, this._then);

  final CampaignLog _value;
  // ignore: unused_field
  final $Res Function(CampaignLog) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? farmerId = freezed,
    Object? createdAt = freezed,
    Object? campaign = freezed,
    Object? prizes = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      farmerId: farmerId == freezed
          ? _value.farmerId
          : farmerId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      campaign: campaign == freezed
          ? _value.campaign
          : campaign // ignore: cast_nullable_to_non_nullable
              as CampaignModel?,
      prizes: prizes == freezed
          ? _value.prizes
          : prizes // ignore: cast_nullable_to_non_nullable
              as List<PrizeModel>?,
    ));
  }

  @override
  $CampaignModelCopyWith<$Res>? get campaign {
    if (_value.campaign == null) {
      return null;
    }

    return $CampaignModelCopyWith<$Res>(_value.campaign!, (value) {
      return _then(_value.copyWith(campaign: value));
    });
  }
}

/// @nodoc
abstract class _$CampaignLogCopyWith<$Res>
    implements $CampaignLogCopyWith<$Res> {
  factory _$CampaignLogCopyWith(
          _CampaignLog value, $Res Function(_CampaignLog) then) =
      __$CampaignLogCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String? farmerId,
      DateTime? createdAt,
      CampaignModel? campaign,
      List<PrizeModel>? prizes});

  @override
  $CampaignModelCopyWith<$Res>? get campaign;
}

/// @nodoc
class __$CampaignLogCopyWithImpl<$Res> extends _$CampaignLogCopyWithImpl<$Res>
    implements _$CampaignLogCopyWith<$Res> {
  __$CampaignLogCopyWithImpl(
      _CampaignLog _value, $Res Function(_CampaignLog) _then)
      : super(_value, (v) => _then(v as _CampaignLog));

  @override
  _CampaignLog get _value => super._value as _CampaignLog;

  @override
  $Res call({
    Object? id = freezed,
    Object? farmerId = freezed,
    Object? createdAt = freezed,
    Object? campaign = freezed,
    Object? prizes = freezed,
  }) {
    return _then(_CampaignLog(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      farmerId: farmerId == freezed
          ? _value.farmerId
          : farmerId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      campaign: campaign == freezed
          ? _value.campaign
          : campaign // ignore: cast_nullable_to_non_nullable
              as CampaignModel?,
      prizes: prizes == freezed
          ? _value.prizes
          : prizes // ignore: cast_nullable_to_non_nullable
              as List<PrizeModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CampaignLog implements _CampaignLog {
  const _$_CampaignLog(
      {this.id, this.farmerId, this.createdAt, this.campaign, this.prizes});

  factory _$_CampaignLog.fromJson(Map<String, dynamic> json) =>
      _$_$_CampaignLogFromJson(json);

  @override
  final String? id;
  @override
  final String? farmerId;
  @override
  final DateTime? createdAt;
  @override
  final CampaignModel? campaign;
  @override
  final List<PrizeModel>? prizes;

  @override
  String toString() {
    return 'CampaignLog(id: $id, farmerId: $farmerId, createdAt: $createdAt, campaign: $campaign, prizes: $prizes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CampaignLog &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.farmerId, farmerId) ||
                const DeepCollectionEquality()
                    .equals(other.farmerId, farmerId)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.campaign, campaign) ||
                const DeepCollectionEquality()
                    .equals(other.campaign, campaign)) &&
            (identical(other.prizes, prizes) ||
                const DeepCollectionEquality().equals(other.prizes, prizes)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(farmerId) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(campaign) ^
      const DeepCollectionEquality().hash(prizes);

  @JsonKey(ignore: true)
  @override
  _$CampaignLogCopyWith<_CampaignLog> get copyWith =>
      __$CampaignLogCopyWithImpl<_CampaignLog>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CampaignLogToJson(this);
  }
}

abstract class _CampaignLog implements CampaignLog {
  const factory _CampaignLog(
      {String? id,
      String? farmerId,
      DateTime? createdAt,
      CampaignModel? campaign,
      List<PrizeModel>? prizes}) = _$_CampaignLog;

  factory _CampaignLog.fromJson(Map<String, dynamic> json) =
      _$_CampaignLog.fromJson;

  @override
  String? get id => throw _privateConstructorUsedError;
  @override
  String? get farmerId => throw _privateConstructorUsedError;
  @override
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @override
  CampaignModel? get campaign => throw _privateConstructorUsedError;
  @override
  List<PrizeModel>? get prizes => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CampaignLogCopyWith<_CampaignLog> get copyWith =>
      throw _privateConstructorUsedError;
}
