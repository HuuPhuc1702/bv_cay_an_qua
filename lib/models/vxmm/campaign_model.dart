import 'package:bv_cay_an_qua/models/vxmm/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'topup_model.dart';

part 'campaign_model.freezed.dart';

part 'campaign_model.g.dart';

@freezed
abstract class CampaignModel with _$CampaignModel {
  // @JsonSerializable(explicitToJson: true)
  const factory CampaignModel(
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
      TopupModel? topup}) = _CampaignModel;

  factory CampaignModel.fromJson(Map<String, dynamic> json) =>
      _$CampaignModelFromJson(json);
}
