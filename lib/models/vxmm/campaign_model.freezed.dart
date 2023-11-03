// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'campaign_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CampaignModel _$CampaignModelFromJson(Map<String, dynamic> json) {
  return _CampaignModel.fromJson(json);
}

/// @nodoc
class _$CampaignModelTearOff {
  const _$CampaignModelTearOff();

  _CampaignModel call(
      {bool? active,
      DateTime? activeAt,
      String? code,
      String? content,
      DateTime? createdAt,
      DateTime? endDate,
      String? icon,
      required String id,
      String? image,
      required String name,
      required DateTime startDate,
      DateTime? updatedAt,
      UserModel? activeUser,
      TopupModel? topup}) {
    return _CampaignModel(
      active: active,
      activeAt: activeAt,
      code: code,
      content: content,
      createdAt: createdAt,
      endDate: endDate,
      icon: icon,
      id: id,
      image: image,
      name: name,
      startDate: startDate,
      updatedAt: updatedAt,
      activeUser: activeUser,
      topup: topup,
    );
  }

  CampaignModel fromJson(Map<String, Object> json) {
    return CampaignModel.fromJson(json);
  }
}

/// @nodoc
const $CampaignModel = _$CampaignModelTearOff();

/// @nodoc
mixin _$CampaignModel {
  bool? get active => throw _privateConstructorUsedError;
  DateTime? get activeAt => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  UserModel? get activeUser => throw _privateConstructorUsedError;
  TopupModel? get topup => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CampaignModelCopyWith<CampaignModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CampaignModelCopyWith<$Res> {
  factory $CampaignModelCopyWith(
          CampaignModel value, $Res Function(CampaignModel) then) =
      _$CampaignModelCopyWithImpl<$Res>;
  $Res call(
      {bool? active,
      DateTime? activeAt,
      String? code,
      String? content,
      DateTime? createdAt,
      DateTime? endDate,
      String? icon,
      String id,
      String? image,
      String name,
      DateTime startDate,
      DateTime? updatedAt,
      UserModel? activeUser,
      TopupModel? topup});

  $UserModelCopyWith<$Res>? get activeUser;
  $TopupModelCopyWith<$Res>? get topup;
}

/// @nodoc
class _$CampaignModelCopyWithImpl<$Res>
    implements $CampaignModelCopyWith<$Res> {
  _$CampaignModelCopyWithImpl(this._value, this._then);

  final CampaignModel _value;
  // ignore: unused_field
  final $Res Function(CampaignModel) _then;

  @override
  $Res call({
    Object? active = freezed,
    Object? activeAt = freezed,
    Object? code = freezed,
    Object? content = freezed,
    Object? createdAt = freezed,
    Object? endDate = freezed,
    Object? icon = freezed,
    Object? id = freezed,
    Object? image = freezed,
    Object? name = freezed,
    Object? startDate = freezed,
    Object? updatedAt = freezed,
    Object? activeUser = freezed,
    Object? topup = freezed,
  }) {
    return _then(_value.copyWith(
      active: active == freezed
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
      activeAt: activeAt == freezed
          ? _value.activeAt
          : activeAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: endDate == freezed
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      icon: icon == freezed
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: startDate == freezed
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      activeUser: activeUser == freezed
          ? _value.activeUser
          : activeUser // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      topup: topup == freezed
          ? _value.topup
          : topup // ignore: cast_nullable_to_non_nullable
              as TopupModel?,
    ));
  }

  @override
  $UserModelCopyWith<$Res>? get activeUser {
    if (_value.activeUser == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.activeUser!, (value) {
      return _then(_value.copyWith(activeUser: value));
    });
  }

  @override
  $TopupModelCopyWith<$Res>? get topup {
    if (_value.topup == null) {
      return null;
    }

    return $TopupModelCopyWith<$Res>(_value.topup!, (value) {
      return _then(_value.copyWith(topup: value));
    });
  }
}

/// @nodoc
abstract class _$CampaignModelCopyWith<$Res>
    implements $CampaignModelCopyWith<$Res> {
  factory _$CampaignModelCopyWith(
          _CampaignModel value, $Res Function(_CampaignModel) then) =
      __$CampaignModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool? active,
      DateTime? activeAt,
      String? code,
      String? content,
      DateTime? createdAt,
      DateTime? endDate,
      String? icon,
      String id,
      String? image,
      String name,
      DateTime startDate,
      DateTime? updatedAt,
      UserModel? activeUser,
      TopupModel? topup});

  @override
  $UserModelCopyWith<$Res>? get activeUser;
  @override
  $TopupModelCopyWith<$Res>? get topup;
}

/// @nodoc
class __$CampaignModelCopyWithImpl<$Res>
    extends _$CampaignModelCopyWithImpl<$Res>
    implements _$CampaignModelCopyWith<$Res> {
  __$CampaignModelCopyWithImpl(
      _CampaignModel _value, $Res Function(_CampaignModel) _then)
      : super(_value, (v) => _then(v as _CampaignModel));

  @override
  _CampaignModel get _value => super._value as _CampaignModel;

  @override
  $Res call({
    Object? active = freezed,
    Object? activeAt = freezed,
    Object? code = freezed,
    Object? content = freezed,
    Object? createdAt = freezed,
    Object? endDate = freezed,
    Object? icon = freezed,
    Object? id = freezed,
    Object? image = freezed,
    Object? name = freezed,
    Object? startDate = freezed,
    Object? updatedAt = freezed,
    Object? activeUser = freezed,
    Object? topup = freezed,
  }) {
    return _then(_CampaignModel(
      active: active == freezed
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
      activeAt: activeAt == freezed
          ? _value.activeAt
          : activeAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: endDate == freezed
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      icon: icon == freezed
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: startDate == freezed
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      activeUser: activeUser == freezed
          ? _value.activeUser
          : activeUser // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      topup: topup == freezed
          ? _value.topup
          : topup // ignore: cast_nullable_to_non_nullable
              as TopupModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CampaignModel implements _CampaignModel {
  const _$_CampaignModel(
      {this.active,
      this.activeAt,
      this.code,
      this.content,
      this.createdAt,
      this.endDate,
      this.icon,
      required this.id,
      this.image,
      required this.name,
      required this.startDate,
      this.updatedAt,
      this.activeUser,
      this.topup});

  factory _$_CampaignModel.fromJson(Map<String, dynamic> json) =>
      _$_$_CampaignModelFromJson(json);

  @override
  final bool? active;
  @override
  final DateTime? activeAt;
  @override
  final String? code;
  @override
  final String? content;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? endDate;
  @override
  final String? icon;
  @override
  final String id;
  @override
  final String? image;
  @override
  final String name;
  @override
  final DateTime startDate;
  @override
  final DateTime? updatedAt;
  @override
  final UserModel? activeUser;
  @override
  final TopupModel? topup;

  @override
  String toString() {
    return 'CampaignModel(active: $active, activeAt: $activeAt, code: $code, content: $content, createdAt: $createdAt, endDate: $endDate, icon: $icon, id: $id, image: $image, name: $name, startDate: $startDate, updatedAt: $updatedAt, activeUser: $activeUser, topup: $topup)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CampaignModel &&
            (identical(other.active, active) ||
                const DeepCollectionEquality().equals(other.active, active)) &&
            (identical(other.activeAt, activeAt) ||
                const DeepCollectionEquality()
                    .equals(other.activeAt, activeAt)) &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.content, content) ||
                const DeepCollectionEquality()
                    .equals(other.content, content)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.endDate, endDate) ||
                const DeepCollectionEquality()
                    .equals(other.endDate, endDate)) &&
            (identical(other.icon, icon) ||
                const DeepCollectionEquality().equals(other.icon, icon)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.startDate, startDate) ||
                const DeepCollectionEquality()
                    .equals(other.startDate, startDate)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.activeUser, activeUser) ||
                const DeepCollectionEquality()
                    .equals(other.activeUser, activeUser)) &&
            (identical(other.topup, topup) ||
                const DeepCollectionEquality().equals(other.topup, topup)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(active) ^
      const DeepCollectionEquality().hash(activeAt) ^
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(content) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(endDate) ^
      const DeepCollectionEquality().hash(icon) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(image) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(startDate) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(activeUser) ^
      const DeepCollectionEquality().hash(topup);

  @JsonKey(ignore: true)
  @override
  _$CampaignModelCopyWith<_CampaignModel> get copyWith =>
      __$CampaignModelCopyWithImpl<_CampaignModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CampaignModelToJson(this);
  }
}

abstract class _CampaignModel implements CampaignModel {
  const factory _CampaignModel(
      {bool? active,
      DateTime? activeAt,
      String? code,
      String? content,
      DateTime? createdAt,
      DateTime? endDate,
      String? icon,
      required String id,
      String? image,
      required String name,
      required DateTime startDate,
      DateTime? updatedAt,
      UserModel? activeUser,
      TopupModel? topup}) = _$_CampaignModel;

  factory _CampaignModel.fromJson(Map<String, dynamic> json) =
      _$_CampaignModel.fromJson;

  @override
  bool? get active => throw _privateConstructorUsedError;
  @override
  DateTime? get activeAt => throw _privateConstructorUsedError;
  @override
  String? get code => throw _privateConstructorUsedError;
  @override
  String? get content => throw _privateConstructorUsedError;
  @override
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @override
  DateTime? get endDate => throw _privateConstructorUsedError;
  @override
  String? get icon => throw _privateConstructorUsedError;
  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String? get image => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  DateTime get startDate => throw _privateConstructorUsedError;
  @override
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @override
  UserModel? get activeUser => throw _privateConstructorUsedError;
  @override
  TopupModel? get topup => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CampaignModelCopyWith<_CampaignModel> get copyWith =>
      throw _privateConstructorUsedError;
}
