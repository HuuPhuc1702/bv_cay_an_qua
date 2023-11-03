import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

// *** PLEASE RUN COMMAND BELOW FOR REBUILD MODELS ****
// flutter packages pub run build_runner build --delete-conflicting-outputs

@JsonSerializable(nullable: false)
class LUser {
  @JsonKey(name: '_id')
  final String id;
  final String ?uid;
  final String? fullName;
  final String? phone;
  final String ?email;
  final String ?address;
  final String ?avatar;
  final String ?position;
  final String ?plant;
  @JsonKey(nullable: true)
  final double ?area;
  final double ?locationLat;
  final double ?locationLng;
  final String ?type;
  final String ?status;
  final String ?password;
  final String ?updatedAt;
  final String ?createdAt;
  final int ?point;
  final int ?totalPoint;
  final String ?province;
  final String ?district;
  final String ?ward;
  final String ?provinceId;
  final String ?districtId;
  final String ?wardId;
  final String ?cardNumber;

  LUser(
      {required this.id,
      this.uid,
      this.fullName,
      this.phone,
      this.email,
      this.address,
      this.avatar,
      this.position,
      this.plant,
      this.area,
      this.locationLat,
      this.locationLng,
      this.type,
      this.status,
      this.password,
      this.updatedAt,
      this.createdAt,
      this.point,
      this.totalPoint,
      this.province,
      this.provinceId,
      this.district,
      this.districtId,
      this.cardNumber,
      this.ward,
      this.wardId});

  factory LUser.fromJson(Map<String, dynamic> json) {
    final user = _$LUserFromJson(json);
    return user;
  }
  Map<String, dynamic> toJson() => _$LUserToJson(this);

  bool get isClientFilledInfo =>
      fullName?.isNotEmpty == true && province?.isNotEmpty == true && district?.isNotEmpty == true && area != null;
  bool get isDoctorFilledInfo =>
      fullName?.isNotEmpty == true && address?.isNotEmpty == true && phone?.isNotEmpty == true;

  bool get isEditor => type == 'editor';

  LUser copyWith(
      {String ?id,
      String ?uid,
      String ?fullName,
      String ?phone,
      String ?email,
      String ?address,
      String ?avatar,
      String ?position,
      String ?plant,
      double ?area,
      double ?locationLat,
      double ?locationLng,
      String ?type,
      String ?status,
      String ?password,
      String ?updatedAt,
      String ?createdAt,
      String ?province,
      String ?provinceId,
      String ?district,
      String ?districtId,
      String ?cardNumber,
      String ?ward,
      String ?wardId}) {
    return LUser(
        id: id ?? this.id,
        uid: uid ?? this.uid,
        fullName: fullName ?? this.fullName,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        address: address ?? this.address,
        avatar: avatar ?? this.avatar,
        position: position ?? this.position,
        plant: plant ?? this.plant,
        area: area ?? this.area,
        locationLat: locationLat ?? this.locationLat,
        locationLng: locationLng ?? this.locationLng,
        type: type ?? this.type,
        status: status ?? this.status,
        password: password ?? this.password,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        province: province,
        provinceId: provinceId,
        district: district,
        districtId: districtId,
        ward: ward,
        cardNumber: cardNumber??this.cardNumber,
        wardId: wardId);
  }
}

// this is model for only my account
@JsonSerializable(nullable: false)
class UserModel {
  String id;
  String sex;
  String username;
  String fullname;
  String local;
  String avatar;
  String phone;
  String loginType;
  String cityCode;
  String nationalId;
  String dateOfBirth;
  String email;
  String experience;
  String workingHour;
  String expectedSalary;
  String nationalIdFrontImage;
  String nationalIdBackImage;
  String identityVideo;
  String accountType;
  double rate;
  bool isVerified;
  bool isNewUser;
  String money;
  String nameCompany;
  String avatarCompany;
  String contactNameCompany;
  String contactPhoneCompany;
  String contactEmailCompany;
  bool allowNotification;
//  @JsonKey(toJson: _branchToJson, nullable: true)
//  Department department;
//  @JsonKey(toJson: _accountListToJson, nullable: true)
//  List<Account> favouriteColleagues;
  UserModel(
      this.id,
      this.sex,
      this.username,
      this.fullname,
      this.local,
      this.avatar,
      this.phone,
      this.loginType,
      this.cityCode,
      this.nationalId,
      this.dateOfBirth,
      this.email,
      this.experience,
      this.workingHour,
      this.expectedSalary,
      this.nationalIdFrontImage,
      this.nationalIdBackImage,
      this.identityVideo,
      this.accountType,
      this.rate,
      this.isVerified,
      this.isNewUser,
      this.money,
      this.nameCompany,
      this.avatarCompany,
      this.contactNameCompany,
      this.contactPhoneCompany,
      this.contactEmailCompany,
      this.allowNotification);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final user = _$UserModelFromJson(json);
    return user;
  }
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
  @override
  String toString() {
    return """\n
      ===== USER MODEL =====
      id: $id,
      fullname: $fullname,
      phone: $phone,
      loginType: $loginType,
      cityCode: $cityCode,
      nationalId: $nationalId,
      dateOfBirth: $dateOfBirth,
      email: $email,
      experience: $experience,
      workingHour: $workingHour,
      expectedSalary: $expectedSalary,
      nationalIdFrontImage: $nationalIdFrontImage,
      nationalIdBackImage: $nationalIdBackImage,
      identityVideo: $identityVideo,
      accountType: $accountType,
      rate: $rate,
      isVerified: $isVerified,
      isNewUser: $isNewUser,
      \n
    """;
  }
}

class UserActivity {
  String ?status;
  String? id;
  String ?user;
  String ?message;
  String ?timestamp;
  String ?createAt;
  String ?updateAt;

  UserActivity({this.status, this.id, this.user, this.message, this.timestamp, this.createAt, this.updateAt});

  factory UserActivity.fromJson(Map<String, dynamic> map) {
    return UserActivity(
        status: map["status"],
        id: map['id'],
        user: map['user'],
        message: map['message'],
        timestamp: map['timestamp'],
        createAt: map['createAt'],
        updateAt: map['updateAt']);
  }
}

class GiftActivity {
  String ?status;
  String ?id;
  String? giftCode;
  String ?giftName;
  String ?user;
  int ?point;
  String ?createdAt;
  String ?updatedAt;
  String ?luckySpinName;

  GiftActivity(
      {this.status,
      this.id,
      this.user,
      this.giftCode,
      this.giftName,
      this.point,
      this.createdAt,
      this.updatedAt,
      this.luckySpinName});

  factory GiftActivity.fromJson(Map<String, dynamic> map) {
    return GiftActivity(
      status: map["status"],
      id: map['_id'],
      user: map['user'],
      giftCode: map['giftCode'] != "NONE" ? map['giftCode'] : "X",
      giftName: map['giftName'],
      point: map['point'],
      createdAt: map["createdAt"],
      updatedAt: map['updateAt'],
      luckySpinName: map["luckySpinName"] ?? "",
    );
  }
}

class PointActivity {
  String ?status;
  String ?id;
  String ?comment;
  String ?owner;
  String ?doctor;
  String ?content;
  String ?createdAt;
  String ?updatedAt;
  String ?role;
  int ?point;

  PointActivity({
    this.status,
    this.id,
    this.comment,
    this.doctor,
    this.owner,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.role,
    this.point,
  });

  factory PointActivity.fromJson(Map<String, dynamic> map) {
    return PointActivity(
      status: map["status"],
      id: map['_id'],
      comment: map['comment'],
      doctor: map['doctor'],
      owner: map['owner'],
      content: map['content'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      role: map['role'],
      point: map['point'],
    );
  }
}
