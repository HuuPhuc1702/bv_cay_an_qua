import 'package:bv_cay_an_qua/models/vxmm/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'campaign_model.dart';
import 'prize_model.dart';

part 'campaign_log.freezed.dart';

part 'campaign_log.g.dart';

@freezed
abstract class CampaignLog with _$CampaignLog {
  // @JsonSerializable(explicitToJson: true)
  const factory CampaignLog(
      {String? id,
      String? farmerId,
      DateTime? createdAt,
      CampaignModel? campaign,
      List<PrizeModel>? prizes}) = _CampaignLog;

  factory CampaignLog.fromJson(Map<String, dynamic> json) =>
      _$CampaignLogFromJson(json);
}
