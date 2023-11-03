// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'check_user_in_campaign_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CheckUserInCampaignResponse _$CheckUserInCampaignResponseFromJson(
    Map<String, dynamic> json) {
  return _CheckUserInCampaignResponse.fromJson(json);
}

/// @nodoc
class _$CheckUserInCampaignResponseTearOff {
  const _$CheckUserInCampaignResponseTearOff();

  _CheckUserInCampaignResponse call(
      {bool? active, bool? valid, String? msg, UserModel? staff}) {
    return _CheckUserInCampaignResponse(
      active: active,
      valid: valid,
      msg: msg,
      staff: staff,
    );
  }

  CheckUserInCampaignResponse fromJson(Map<String, Object> json) {
    return CheckUserInCampaignResponse.fromJson(json);
  }
}

/// @nodoc
const $CheckUserInCampaignResponse = _$CheckUserInCampaignResponseTearOff();

/// @nodoc
mixin _$CheckUserInCampaignResponse {
  bool? get active => throw _privateConstructorUsedError;
  bool? get valid => throw _privateConstructorUsedError;
  String? get msg => throw _privateConstructorUsedError;
  UserModel? get staff => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CheckUserInCampaignResponseCopyWith<CheckUserInCampaignResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckUserInCampaignResponseCopyWith<$Res> {
  factory $CheckUserInCampaignResponseCopyWith(
          CheckUserInCampaignResponse value,
          $Res Function(CheckUserInCampaignResponse) then) =
      _$CheckUserInCampaignResponseCopyWithImpl<$Res>;
  $Res call({bool? active, bool? valid, String? msg, UserModel? staff});

  $UserModelCopyWith<$Res>? get staff;
}

/// @nodoc
class _$CheckUserInCampaignResponseCopyWithImpl<$Res>
    implements $CheckUserInCampaignResponseCopyWith<$Res> {
  _$CheckUserInCampaignResponseCopyWithImpl(this._value, this._then);

  final CheckUserInCampaignResponse _value;
  // ignore: unused_field
  final $Res Function(CheckUserInCampaignResponse) _then;

  @override
  $Res call({
    Object? active = freezed,
    Object? valid = freezed,
    Object? msg = freezed,
    Object? staff = freezed,
  }) {
    return _then(_value.copyWith(
      active: active == freezed
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
      valid: valid == freezed
          ? _value.valid
          : valid // ignore: cast_nullable_to_non_nullable
              as bool?,
      msg: msg == freezed
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String?,
      staff: staff == freezed
          ? _value.staff
          : staff // ignore: cast_nullable_to_non_nullable
              as UserModel?,
    ));
  }

  @override
  $UserModelCopyWith<$Res>? get staff {
    if (_value.staff == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.staff!, (value) {
      return _then(_value.copyWith(staff: value));
    });
  }
}

/// @nodoc
abstract class _$CheckUserInCampaignResponseCopyWith<$Res>
    implements $CheckUserInCampaignResponseCopyWith<$Res> {
  factory _$CheckUserInCampaignResponseCopyWith(
          _CheckUserInCampaignResponse value,
          $Res Function(_CheckUserInCampaignResponse) then) =
      __$CheckUserInCampaignResponseCopyWithImpl<$Res>;
  @override
  $Res call({bool? active, bool? valid, String? msg, UserModel? staff});

  @override
  $UserModelCopyWith<$Res>? get staff;
}

/// @nodoc
class __$CheckUserInCampaignResponseCopyWithImpl<$Res>
    extends _$CheckUserInCampaignResponseCopyWithImpl<$Res>
    implements _$CheckUserInCampaignResponseCopyWith<$Res> {
  __$CheckUserInCampaignResponseCopyWithImpl(
      _CheckUserInCampaignResponse _value,
      $Res Function(_CheckUserInCampaignResponse) _then)
      : super(_value, (v) => _then(v as _CheckUserInCampaignResponse));

  @override
  _CheckUserInCampaignResponse get _value =>
      super._value as _CheckUserInCampaignResponse;

  @override
  $Res call({
    Object? active = freezed,
    Object? valid = freezed,
    Object? msg = freezed,
    Object? staff = freezed,
  }) {
    return _then(_CheckUserInCampaignResponse(
      active: active == freezed
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
      valid: valid == freezed
          ? _value.valid
          : valid // ignore: cast_nullable_to_non_nullable
              as bool?,
      msg: msg == freezed
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String?,
      staff: staff == freezed
          ? _value.staff
          : staff // ignore: cast_nullable_to_non_nullable
              as UserModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CheckUserInCampaignResponse implements _CheckUserInCampaignResponse {
  const _$_CheckUserInCampaignResponse(
      {this.active, this.valid, this.msg, this.staff});

  factory _$_CheckUserInCampaignResponse.fromJson(Map<String, dynamic> json) =>
      _$_$_CheckUserInCampaignResponseFromJson(json);

  @override
  final bool? active;
  @override
  final bool? valid;
  @override
  final String? msg;
  @override
  final UserModel? staff;

  @override
  String toString() {
    return 'CheckUserInCampaignResponse(active: $active, valid: $valid, msg: $msg, staff: $staff)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CheckUserInCampaignResponse &&
            (identical(other.active, active) ||
                const DeepCollectionEquality().equals(other.active, active)) &&
            (identical(other.valid, valid) ||
                const DeepCollectionEquality().equals(other.valid, valid)) &&
            (identical(other.msg, msg) ||
                const DeepCollectionEquality().equals(other.msg, msg)) &&
            (identical(other.staff, staff) ||
                const DeepCollectionEquality().equals(other.staff, staff)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(active) ^
      const DeepCollectionEquality().hash(valid) ^
      const DeepCollectionEquality().hash(msg) ^
      const DeepCollectionEquality().hash(staff);

  @JsonKey(ignore: true)
  @override
  _$CheckUserInCampaignResponseCopyWith<_CheckUserInCampaignResponse>
      get copyWith => __$CheckUserInCampaignResponseCopyWithImpl<
          _CheckUserInCampaignResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CheckUserInCampaignResponseToJson(this);
  }
}

abstract class _CheckUserInCampaignResponse
    implements CheckUserInCampaignResponse {
  const factory _CheckUserInCampaignResponse(
      {bool? active,
      bool? valid,
      String? msg,
      UserModel? staff}) = _$_CheckUserInCampaignResponse;

  factory _CheckUserInCampaignResponse.fromJson(Map<String, dynamic> json) =
      _$_CheckUserInCampaignResponse.fromJson;

  @override
  bool? get active => throw _privateConstructorUsedError;
  @override
  bool? get valid => throw _privateConstructorUsedError;
  @override
  String? get msg => throw _privateConstructorUsedError;
  @override
  UserModel? get staff => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CheckUserInCampaignResponseCopyWith<_CheckUserInCampaignResponse>
      get copyWith => throw _privateConstructorUsedError;
}
