import 'package:freezed_annotation/freezed_annotation.dart';

import 'topup_model.dart';

part 'user_model.freezed.dart';

part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  // @JsonSerializable(explicitToJson: true)
  const factory UserModel({
    String? id,
    String? email,
    String? name,
    String? fullName,
    String? phone,
    String? address,
    String? avatar,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
