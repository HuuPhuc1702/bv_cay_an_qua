/// prize : "GIAI3"
/// type : "PENDING"
/// status : "active"
/// _id : "5eb13017a063593600ffc1be"
/// farmerId : "5e995ca2ea72d530c81ee1bc"
/// code : "THETICHDIEM01"
/// luckySpin : "5eaf8f219b3ee2213c2e5a32"
/// phone : "string"
/// prizeName : "Thẻ cào 10.000đ"
/// idcard : "452872"
/// cardNumber : "857828"
/// fullname : "string"
/// idcardAddress : "string"
/// idcardDate : "2020-05-05T09:01:02.692Z"
/// address : "string"
/// platform : "string"
/// longitude : 4561
/// latitude : 12353
/// createdAt : "2020-05-05T09:21:27.620Z"
/// updatedAt : "2020-05-05T09:21:27.620Z"
/// __v : 0

class HistoryLuckySpinModel {
  HistoryLuckySpinModel({
    this.prize,
    this.type,
    this.status,
    this.id,
    this.farmerId,
    this.code,
    this.luckySpin,
    this.phone,
    this.prizeName,
    this.idcard,
    this.cardNumber,
    this.fullname,
    this.idcardAddress,
    this.idcardDate,
    this.address,
    this.platform,
    this.longitude,
    this.latitude,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.index,
    this.topup,
    this.campaignId,
    this.value,
    this.refId,
    this.refPrize,
    this.refPrizeIndex
  });

  HistoryLuckySpinModel.fromJson(dynamic json) {
    prize = json['prize'];
    type = json['type'];
    status = json['status'];
    id = json['_id'];

    try {
      farmerId =  ReferIdString(id: json['farmerId']);
    } catch (e) {
      farmerId = json["farmerId"] == null ? null : ReferIdMap.fromJson(json['farmerId']);
    }
    
    code = json['code'];
    luckySpin = json['luckySpin'];
    phone = json['phone'];
    prizeName = json['prizeName'];
    idcard = json['idcard'];
    cardNumber = json['cardNumber'];
    fullname = json['fullname'];
    idcardAddress = json['idcardAddress'];
    idcardDate = json['idcardDate'];
    address = json['address'];
    platform = json['platform'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    index = json['index'];
    campaignId = json['campaignId'] != null
        ? CampaignId.fromJson(json['campaignId'])
        : null;
    topup = json['topup'] != null ? Topup.fromJson(json['topup']) : null;
    value = json['value'];
    refId = json['refId'];
    refPrize = json['refPrize'] == null ? null : RefPrize.fromJson(json['refPrize']);
    refPrizeIndex = json['refPrizeIndex'];
  }

  String? prize;
  String? type;
  String? status;
  String? id;
  FarmerId ?farmerId;
  String? code;
  String ?luckySpin;
  String ?phone;
  String ?prizeName;
  String ?idcard;
  String ?cardNumber;
  String ?fullname;
  String ?idcardAddress;
  String ?idcardDate;
  String ?address;
  String ?platform;
  int ?longitude;
  int ?latitude;
  String ?createdAt;
  String ?updatedAt;
  int ?v;
  CampaignId ?campaignId;
  Topup ?topup;
  int ?index;
  int ?value;
  String ?refId;
  RefPrize ?refPrize;
  int ?refPrizeIndex;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['prize'] = prize;
    map['type'] = type;
    map['status'] = status;
    map['_id'] = id;
    map['farmerId'] = farmerId;
    map['code'] = code;
    map['luckySpin'] = luckySpin;
    map['phone'] = phone;
    map['prizeName'] = prizeName;
    map['idcard'] = idcard;
    map['cardNumber'] = cardNumber;
    map['fullname'] = fullname;
    map['idcardAddress'] = idcardAddress;
    map['idcardDate'] = idcardDate;
    map['address'] = address;
    map['platform'] = platform;
    map['longitude'] = longitude;
    map['latitude'] = latitude;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['value'] = value;
    map['refId'] = refId;
    map['refPrize'] = refPrize?.toJson();
    map['refPrizeIndex'] = refPrizeIndex;

    map['__v'] = v;
    return map;
  }
}

class FarmerId {}

class ReferIdString extends FarmerId {
  String ?id;

  ReferIdString({this.id});
}

class ReferIdMap extends FarmerId {
  String ?fullName;
  String ?phone;
  String ?avatar;
  String ?id;

  ReferIdMap({this.fullName, this.phone, this.avatar, this.id});

  ReferIdMap.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    phone = json['phone'];
    avatar = json['avatar'];
    id = json['_id'];
  }
}

class RefPrize {
  int ?topupAmount ;
  int ?commissionAmount ;
  int ?limitIssue ;
  int ?used;
  String ?id;
  String ?campaignId;
  String ?code;
  String ?type;
  int ?triggerIndex;
  bool ?active;
  String ?createdAt;
  String ?updatedAt;


  RefPrize({
    this.topupAmount,
    this.commissionAmount,
    this.limitIssue,
    this.used,
    this.id,
    this.campaignId,
    this.code,
    this.type,
    this.triggerIndex,
    this.active,
    this.createdAt,
    this.updatedAt,
  });

  RefPrize.fromJson(dynamic json) {
    topupAmount = json['topupAmount'];
    commissionAmount = json['commissionAmount'];
    limitIssue = json['limitIssue'];
    used = json['used'];
    id = json['_id'];
    campaignId = json['campaignId'];
    code = json['code'];
    type = json['type'];
    triggerIndex = json['triggerIndex'];
    active = json['active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['topupAmount'] = topupAmount;
    map['commissionAmount'] = commissionAmount;
    map['limitIssue'] = limitIssue;
    map['used'] = used;
    map['_id'] = id;
    map['campaignId'] = campaignId;
    map['code'] = code;
    map['type'] = type;
    map['triggerIndex'] = triggerIndex;
    map['active'] = active;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }

}

class CampaignId {
  String ?id;
  String ?name;

  CampaignId({this.id, this.name});

  CampaignId.fromJson(dynamic json) {
    name = json['name'];
    id = json['_id'];
  }
}
/// _id : "61723364e61cb00018ab7b24"
/// amount : 10000
/// phone : "+84356132121"
/// status : "topupError"
/// errMsg : "Error: certificate has expired"

class Topup {
  Topup({
    this.id,
    this.amount,
    this.phone,
    this.status,
    this.errMsg,});

  Topup.fromJson(dynamic json) {
    id = json['_id'];
    amount = json['amount'];
    phone = json['phone'];
    status = json['status'];
    errMsg = json['errMsg'];
  }
  String ?id;
  int ?amount;
  String ?phone;
  String ?status;
  String ?errMsg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['amount'] = amount;
    map['phone'] = phone;
    map['status'] = status;
    map['errMsg'] = errMsg;
    return map;
  }

}