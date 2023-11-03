// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'topup_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TopupModel _$TopupModelFromJson(Map<String, dynamic> json) {
  return _TopupModel.fromJson(json);
}

/// @nodoc
class _$TopupModelTearOff {
  const _$TopupModelTearOff();

  _TopupModel call({String? username}) {
    return _TopupModel(
      username: username,
    );
  }

  TopupModel fromJson(Map<String, Object> json) {
    return TopupModel.fromJson(json);
  }
}

/// @nodoc
const $TopupModel = _$TopupModelTearOff();

/// @nodoc
mixin _$TopupModel {
  String? get username => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TopupModelCopyWith<TopupModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopupModelCopyWith<$Res> {
  factory $TopupModelCopyWith(
          TopupModel value, $Res Function(TopupModel) then) =
      _$TopupModelCopyWithImpl<$Res>;
  $Res call({String? username});
}

/// @nodoc
class _$TopupModelCopyWithImpl<$Res> implements $TopupModelCopyWith<$Res> {
  _$TopupModelCopyWithImpl(this._value, this._then);

  final TopupModel _value;
  // ignore: unused_field
  final $Res Function(TopupModel) _then;

  @override
  $Res call({
    Object? username = freezed,
  }) {
    return _then(_value.copyWith(
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$TopupModelCopyWith<$Res> implements $TopupModelCopyWith<$Res> {
  factory _$TopupModelCopyWith(
          _TopupModel value, $Res Function(_TopupModel) then) =
      __$TopupModelCopyWithImpl<$Res>;
  @override
  $Res call({String? username});
}

/// @nodoc
class __$TopupModelCopyWithImpl<$Res> extends _$TopupModelCopyWithImpl<$Res>
    implements _$TopupModelCopyWith<$Res> {
  __$TopupModelCopyWithImpl(
      _TopupModel _value, $Res Function(_TopupModel) _then)
      : super(_value, (v) => _then(v as _TopupModel));

  @override
  _TopupModel get _value => super._value as _TopupModel;

  @override
  $Res call({
    Object? username = freezed,
  }) {
    return _then(_TopupModel(
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TopupModel implements _TopupModel {
  const _$_TopupModel({this.username});

  factory _$_TopupModel.fromJson(Map<String, dynamic> json) =>
      _$_$_TopupModelFromJson(json);

  @override
  final String? username;

  @override
  String toString() {
    return 'TopupModel(username: $username)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TopupModel &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(username);

  @JsonKey(ignore: true)
  @override
  _$TopupModelCopyWith<_TopupModel> get copyWith =>
      __$TopupModelCopyWithImpl<_TopupModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_TopupModelToJson(this);
  }
}

abstract class _TopupModel implements TopupModel {
  const factory _TopupModel({String? username}) = _$_TopupModel;

  factory _TopupModel.fromJson(Map<String, dynamic> json) =
      _$_TopupModel.fromJson;

  @override
  String? get username => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$TopupModelCopyWith<_TopupModel> get copyWith =>
      throw _privateConstructorUsedError;
}
