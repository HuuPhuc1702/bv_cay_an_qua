// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'rank_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RankUser _$RankUserFromJson(Map<String, dynamic> json) {
  return _RankUser.fromJson(json);
}

/// @nodoc
class _$RankUserTearOff {
  const _$RankUserTearOff();

  _RankUser call({String? id, int? total, int? rank, UserModel? info}) {
    return _RankUser(
      id: id,
      total: total,
      rank: rank,
      info: info,
    );
  }

  RankUser fromJson(Map<String, Object> json) {
    return RankUser.fromJson(json);
  }
}

/// @nodoc
const $RankUser = _$RankUserTearOff();

/// @nodoc
mixin _$RankUser {
  String? get id => throw _privateConstructorUsedError;
  int? get total => throw _privateConstructorUsedError;
  int? get rank => throw _privateConstructorUsedError;
  UserModel? get info => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RankUserCopyWith<RankUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RankUserCopyWith<$Res> {
  factory $RankUserCopyWith(RankUser value, $Res Function(RankUser) then) =
      _$RankUserCopyWithImpl<$Res>;
  $Res call({String? id, int? total, int? rank, UserModel? info});

  $UserModelCopyWith<$Res>? get info;
}

/// @nodoc
class _$RankUserCopyWithImpl<$Res> implements $RankUserCopyWith<$Res> {
  _$RankUserCopyWithImpl(this._value, this._then);

  final RankUser _value;
  // ignore: unused_field
  final $Res Function(RankUser) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? total = freezed,
    Object? rank = freezed,
    Object? info = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      total: total == freezed
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
      rank: rank == freezed
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as int?,
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as UserModel?,
    ));
  }

  @override
  $UserModelCopyWith<$Res>? get info {
    if (_value.info == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.info!, (value) {
      return _then(_value.copyWith(info: value));
    });
  }
}

/// @nodoc
abstract class _$RankUserCopyWith<$Res> implements $RankUserCopyWith<$Res> {
  factory _$RankUserCopyWith(_RankUser value, $Res Function(_RankUser) then) =
      __$RankUserCopyWithImpl<$Res>;
  @override
  $Res call({String? id, int? total, int? rank, UserModel? info});

  @override
  $UserModelCopyWith<$Res>? get info;
}

/// @nodoc
class __$RankUserCopyWithImpl<$Res> extends _$RankUserCopyWithImpl<$Res>
    implements _$RankUserCopyWith<$Res> {
  __$RankUserCopyWithImpl(_RankUser _value, $Res Function(_RankUser) _then)
      : super(_value, (v) => _then(v as _RankUser));

  @override
  _RankUser get _value => super._value as _RankUser;

  @override
  $Res call({
    Object? id = freezed,
    Object? total = freezed,
    Object? rank = freezed,
    Object? info = freezed,
  }) {
    return _then(_RankUser(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      total: total == freezed
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
      rank: rank == freezed
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as int?,
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as UserModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RankUser implements _RankUser {
  const _$_RankUser({this.id, this.total, this.rank, this.info});

  factory _$_RankUser.fromJson(Map<String, dynamic> json) =>
      _$_$_RankUserFromJson(json);

  @override
  final String? id;
  @override
  final int? total;
  @override
  final int? rank;
  @override
  final UserModel? info;

  @override
  String toString() {
    return 'RankUser(id: $id, total: $total, rank: $rank, info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RankUser &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.total, total) ||
                const DeepCollectionEquality().equals(other.total, total)) &&
            (identical(other.rank, rank) ||
                const DeepCollectionEquality().equals(other.rank, rank)) &&
            (identical(other.info, info) ||
                const DeepCollectionEquality().equals(other.info, info)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(total) ^
      const DeepCollectionEquality().hash(rank) ^
      const DeepCollectionEquality().hash(info);

  @JsonKey(ignore: true)
  @override
  _$RankUserCopyWith<_RankUser> get copyWith =>
      __$RankUserCopyWithImpl<_RankUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_RankUserToJson(this);
  }
}

abstract class _RankUser implements RankUser {
  const factory _RankUser(
      {String? id, int? total, int? rank, UserModel? info}) = _$_RankUser;

  factory _RankUser.fromJson(Map<String, dynamic> json) = _$_RankUser.fromJson;

  @override
  String? get id => throw _privateConstructorUsedError;
  @override
  int? get total => throw _privateConstructorUsedError;
  @override
  int? get rank => throw _privateConstructorUsedError;
  @override
  UserModel? get info => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RankUserCopyWith<_RankUser> get copyWith =>
      throw _privateConstructorUsedError;
}
