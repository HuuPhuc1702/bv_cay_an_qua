// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$_$_UserModelFromJson(Map<String, dynamic> json) {
  return _$_UserModel(
    id: json['id'] as String?,
    email: json['email'] as String?,
    name: json['name'] as String?,
    fullName: json['fullName'] as String?,
    phone: json['phone'] as String?,
    address: json['address'] as String?,
    avatar: json['avatar'] as String?,
  );
}

Map<String, dynamic> _$_$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'fullName': instance.fullName,
      'phone': instance.phone,
      'address': instance.address,
      'avatar': instance.avatar,
    };
