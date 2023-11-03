import 'package:bv_cay_an_qua/models/vxmm/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rank_user.freezed.dart';

part 'rank_user.g.dart';

@freezed
abstract class RankUser with _$RankUser {
  // @JsonSerializable(explicitToJson: true)
  const factory RankUser({String? id, int? total, int? rank, UserModel? info}) =
      _RankUser;

  factory RankUser.fromJson(Map<String, dynamic> json) =>
      _$RankUserFromJson(json);
}
