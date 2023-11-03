import 'package:bv_cay_an_qua/models/vxmm/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_user_in_campaign_response.freezed.dart';

part 'check_user_in_campaign_response.g.dart';

@freezed
abstract class CheckUserInCampaignResponse with _$CheckUserInCampaignResponse {
  // @JsonSerializable(explicitToJson: true)
  const factory CheckUserInCampaignResponse(
      {bool? active,
      bool? valid,
      String? msg,
      UserModel? staff}) = _CheckUserInCampaignResponse;

  factory CheckUserInCampaignResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckUserInCampaignResponseFromJson(json);
}
