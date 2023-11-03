// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'prize_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PrizeModel _$PrizeModelFromJson(Map<String, dynamic> json) {
  return _PrizeModel.fromJson(json);
}

/// @nodoc
class _$PrizeModelTearOff {
  const _$PrizeModelTearOff();

  _PrizeModel call({String? prizeName}) {
    return _PrizeModel(
      prizeName: prizeName,
    );
  }

  PrizeModel fromJson(Map<String, Object> json) {
    return PrizeModel.fromJson(json);
  }
}

/// @nodoc
const $PrizeModel = _$PrizeModelTearOff();

/// @nodoc
mixin _$PrizeModel {
  String? get prizeName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PrizeModelCopyWith<PrizeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrizeModelCopyWith<$Res> {
  factory $PrizeModelCopyWith(
          PrizeModel value, $Res Function(PrizeModel) then) =
      _$PrizeModelCopyWithImpl<$Res>;
  $Res call({String? prizeName});
}

/// @nodoc
class _$PrizeModelCopyWithImpl<$Res> implements $PrizeModelCopyWith<$Res> {
  _$PrizeModelCopyWithImpl(this._value, this._then);

  final PrizeModel _value;
  // ignore: unused_field
  final $Res Function(PrizeModel) _then;

  @override
  $Res call({
    Object? prizeName = freezed,
  }) {
    return _then(_value.copyWith(
      prizeName: prizeName == freezed
          ? _value.prizeName
          : prizeName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$PrizeModelCopyWith<$Res> implements $PrizeModelCopyWith<$Res> {
  factory _$PrizeModelCopyWith(
          _PrizeModel value, $Res Function(_PrizeModel) then) =
      __$PrizeModelCopyWithImpl<$Res>;
  @override
  $Res call({String? prizeName});
}

/// @nodoc
class __$PrizeModelCopyWithImpl<$Res> extends _$PrizeModelCopyWithImpl<$Res>
    implements _$PrizeModelCopyWith<$Res> {
  __$PrizeModelCopyWithImpl(
      _PrizeModel _value, $Res Function(_PrizeModel) _then)
      : super(_value, (v) => _then(v as _PrizeModel));

  @override
  _PrizeModel get _value => super._value as _PrizeModel;

  @override
  $Res call({
    Object? prizeName = freezed,
  }) {
    return _then(_PrizeModel(
      prizeName: prizeName == freezed
          ? _value.prizeName
          : prizeName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PrizeModel implements _PrizeModel {
  const _$_PrizeModel({this.prizeName});

  factory _$_PrizeModel.fromJson(Map<String, dynamic> json) =>
      _$_$_PrizeModelFromJson(json);

  @override
  final String? prizeName;

  @override
  String toString() {
    return 'PrizeModel(prizeName: $prizeName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PrizeModel &&
            (identical(other.prizeName, prizeName) ||
                const DeepCollectionEquality()
                    .equals(other.prizeName, prizeName)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(prizeName);

  @JsonKey(ignore: true)
  @override
  _$PrizeModelCopyWith<_PrizeModel> get copyWith =>
      __$PrizeModelCopyWithImpl<_PrizeModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_PrizeModelToJson(this);
  }
}

abstract class _PrizeModel implements PrizeModel {
  const factory _PrizeModel({String? prizeName}) = _$_PrizeModel;

  factory _PrizeModel.fromJson(Map<String, dynamic> json) =
      _$_PrizeModel.fromJson;

  @override
  String? get prizeName => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PrizeModelCopyWith<_PrizeModel> get copyWith =>
      throw _privateConstructorUsedError;
}
