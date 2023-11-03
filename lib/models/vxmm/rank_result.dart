import 'package:bv_cay_an_qua/models/vxmm/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'rank_user.dart';

part 'rank_result.freezed.dart';

part 'rank_result.g.dart';

@freezed
abstract class RankResult with _$RankResult {
  // @JsonSerializable(explicitToJson: true)
  const factory RankResult(
      {List<RankUser>? me, required List<RankUser> top10}) = _RankResult;

  factory RankResult.fromJson(Map<String, dynamic> json) =>
      _$RankResultFromJson(json);
}
