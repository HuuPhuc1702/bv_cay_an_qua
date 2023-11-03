// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'rank_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RankResult _$RankResultFromJson(Map<String, dynamic> json) {
  return _RankResult.fromJson(json);
}

/// @nodoc
class _$RankResultTearOff {
  const _$RankResultTearOff();

  _RankResult call({List<RankUser>? me, required List<RankUser> top10}) {
    return _RankResult(
      me: me,
      top10: top10,
    );
  }

  RankResult fromJson(Map<String, Object> json) {
    return RankResult.fromJson(json);
  }
}

/// @nodoc
const $RankResult = _$RankResultTearOff();

/// @nodoc
mixin _$RankResult {
  List<RankUser>? get me => throw _privateConstructorUsedError;
  List<RankUser> get top10 => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RankResultCopyWith<RankResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RankResultCopyWith<$Res> {
  factory $RankResultCopyWith(
          RankResult value, $Res Function(RankResult) then) =
      _$RankResultCopyWithImpl<$Res>;
  $Res call({List<RankUser>? me, List<RankUser> top10});
}

/// @nodoc
class _$RankResultCopyWithImpl<$Res> implements $RankResultCopyWith<$Res> {
  _$RankResultCopyWithImpl(this._value, this._then);

  final RankResult _value;
  // ignore: unused_field
  final $Res Function(RankResult) _then;

  @override
  $Res call({
    Object? me = freezed,
    Object? top10 = freezed,
  }) {
    return _then(_value.copyWith(
      me: me == freezed
          ? _value.me
          : me // ignore: cast_nullable_to_non_nullable
              as List<RankUser>?,
      top10: top10 == freezed
          ? _value.top10
          : top10 // ignore: cast_nullable_to_non_nullable
              as List<RankUser>,
    ));
  }
}

/// @nodoc
abstract class _$RankResultCopyWith<$Res> implements $RankResultCopyWith<$Res> {
  factory _$RankResultCopyWith(
          _RankResult value, $Res Function(_RankResult) then) =
      __$RankResultCopyWithImpl<$Res>;
  @override
  $Res call({List<RankUser>? me, List<RankUser> top10});
}

/// @nodoc
class __$RankResultCopyWithImpl<$Res> extends _$RankResultCopyWithImpl<$Res>
    implements _$RankResultCopyWith<$Res> {
  __$RankResultCopyWithImpl(
      _RankResult _value, $Res Function(_RankResult) _then)
      : super(_value, (v) => _then(v as _RankResult));

  @override
  _RankResult get _value => super._value as _RankResult;

  @override
  $Res call({
    Object? me = freezed,
    Object? top10 = freezed,
  }) {
    return _then(_RankResult(
      me: me == freezed
          ? _value.me
          : me // ignore: cast_nullable_to_non_nullable
              as List<RankUser>?,
      top10: top10 == freezed
          ? _value.top10
          : top10 // ignore: cast_nullable_to_non_nullable
              as List<RankUser>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RankResult implements _RankResult {
  const _$_RankResult({this.me, required this.top10});

  factory _$_RankResult.fromJson(Map<String, dynamic> json) =>
      _$_$_RankResultFromJson(json);

  @override
  final List<RankUser>? me;
  @override
  final List<RankUser> top10;

  @override
  String toString() {
    return 'RankResult(me: $me, top10: $top10)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RankResult &&
            (identical(other.me, me) ||
                const DeepCollectionEquality().equals(other.me, me)) &&
            (identical(other.top10, top10) ||
                const DeepCollectionEquality().equals(other.top10, top10)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(me) ^
      const DeepCollectionEquality().hash(top10);

  @JsonKey(ignore: true)
  @override
  _$RankResultCopyWith<_RankResult> get copyWith =>
      __$RankResultCopyWithImpl<_RankResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_RankResultToJson(this);
  }
}

abstract class _RankResult implements RankResult {
  const factory _RankResult(
      {List<RankUser>? me, required List<RankUser> top10}) = _$_RankResult;

  factory _RankResult.fromJson(Map<String, dynamic> json) =
      _$_RankResult.fromJson;

  @override
  List<RankUser>? get me => throw _privateConstructorUsedError;
  @override
  List<RankUser> get top10 => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RankResultCopyWith<_RankResult> get copyWith =>
      throw _privateConstructorUsedError;
}
