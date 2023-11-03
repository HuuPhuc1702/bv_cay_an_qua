class ReferralModel {
  bool? active;
  bool ?checkWhitelist;
  String ?id;
  String ?notFoundErrMsg;
  String ?whitelistErrMsg;

  ReferralModel(
      {this.active,
      this.checkWhitelist,
      this.id,
      this.notFoundErrMsg,
      this.whitelistErrMsg});

  factory ReferralModel.fromJson(Map<String, dynamic> map) {
    return ReferralModel(
        active: map["active"],
        checkWhitelist: map["checkWhitelist"],
        id: map["_id"],
        notFoundErrMsg: map["notFoundErrMsg"],
        whitelistErrMsg: map["whitelistErrMsg"]);
  }
}

class CampaignModelQRCode {
  String ?id;
  String ?name;
  String ?code;
  String ?image;
  String ?title;
  ReferralModel ?referral;

  CampaignModelQRCode(
      {this.id, this.name, this.code, this.image, this.title, this.referral});

  factory CampaignModelQRCode.fromJson(Map<String, dynamic> map) {
    return CampaignModelQRCode(
        id: map["id"],
        name: map["name"],
        code: map["code"],
        image: map["image"],
        title: map["title"],
        referral: map["referral"] == null
            ? null
            : ReferralModel.fromJson(map["referral"]));
  }
}

