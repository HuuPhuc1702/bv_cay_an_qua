import 'history_lucky_spin_model.dart';

/// sucecss : true
/// message : "Tích luỹ thành công. Số lần quét mã: 1"

class QRCodeModel {
  QRCodeModel({
    this.success,
    this.message,
    this.image
  });

  QRCodeModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    image = json['image'];
    topup = json['topup'] != null ? Topup.fromJson(json['topup']) : null;
    luckySpin = json['luckySpin'] != null ? LuckySpinModel.fromJson(json['luckySpin']) : null;
  }
  bool? success;
  String? message;
  String? image;
  Topup? topup;
  LuckySpinModel? luckySpin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    return map;
  }



}


class LuckySpinModel{
  String? luckySpinId;
  String? luckySpinName;
  String? luckySpinCode;
  num? turnQty;
  String? url;


  LuckySpinModel.fromJson(dynamic json) {
    luckySpinId = json['luckySpinId'];
    luckySpinName = json['luckySpinName'];
    luckySpinCode = json['luckySpinCode'];
    turnQty = json['turnQty'];
    url = json['url'];
  }

}
