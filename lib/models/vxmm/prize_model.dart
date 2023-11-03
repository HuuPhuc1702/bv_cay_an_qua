import 'package:bv_cay_an_qua/models/vxmm/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'prize_model.freezed.dart';

part 'prize_model.g.dart';

@freezed
abstract class PrizeModel with _$PrizeModel {
  // @JsonSerializable(explicitToJson: true)
  const factory PrizeModel({String? prizeName}) = _PrizeModel;

  factory PrizeModel.fromJson(Map<String, dynamic> json) =>
      _$PrizeModelFromJson(json);
}
