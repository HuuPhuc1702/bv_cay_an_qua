import 'package:freezed_annotation/freezed_annotation.dart';

part 'topup_model.freezed.dart';

part 'topup_model.g.dart';

@freezed
abstract class TopupModel with _$TopupModel {
  // @JsonSerializable(explicitToJson: true)
  const factory TopupModel({
    String? username
  }) =
      _TopupModel;

  factory TopupModel.fromJson(Map<String, dynamic> json) =>
      _$TopupModelFromJson(json);
}
