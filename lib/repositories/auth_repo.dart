import 'package:bv_cay_an_qua/models/banner_model.dart';
import 'package:bv_cay_an_qua/models/disease_model.dart';
import 'package:bv_cay_an_qua/models/doctor_model.dart';
import 'package:bv_cay_an_qua/models/hospital_model.dart';
import 'package:bv_cay_an_qua/models/plant_model.dart';
import 'package:bv_cay_an_qua/models/setting_model.dart';
import 'package:bv_cay_an_qua/models/topic_model.dart';
import 'package:bv_cay_an_qua/models/user/plant_model.dart';

import '../models/user/user_model.dart';
import '../config/app_key.dart';
import '../services/graphql/graphql_repo.dart';
import '../services/spref.dart';

class _AuthRepository extends GraphqlRepository {
  final String hospitalParam = """
            id
            name
            logo
            phone
            place{
              fullAddress
              location
            }
            intro
  """;

  String param = "";

  _AuthRepository() {
    param = """
          id
          avatar
          uid
          name
          phone
          area
          unseenNotify
          email
          role
          doctorType
          place{
            street
            province
            provinceId
            district
            districtId
            ward
            wardId
            fullAddress
            location
            note
          }
          hospital{
            $hospitalParam
          }
         plant{
            id
            createdAt
            name
            image
          }
  """;
  }

  Future<UserModel> loginByPhonePin(
      {required String phone, required String pin}) async {
    var result =
        await this.mutate("""farmerLoginByPin(phone: "$phone", pin: "$pin"){
      user{$param}
    token
     }
    """);
    print(result);
    print("login phone pin" + result.toString());

    if (result.data?["g0"] != null) {
      return UserModel.fromJson(result.data?["g0"]);
    }
    return UserModel();
  }

  Future<UserModel> userLoginWithOTP(
      {required String phone, required String otp}) async {
    var result =
        await this.mutate("""userLoginWithOTP(phone: "$phone", otp: "$otp"){
      user{$param}
    token
     }
    """);
    print(result);
    print("login with OTP" + result.toString());

    if (result.data?["g0"] != null) {
      return UserModel.fromJson(result.data?["g0"]);
    }
    return UserModel();
  }

  Future<String> requestOTP({required String phone}) async {
    var result = await this.mutate("""requestOTP(phone:"$phone")
""");
    print("request OTP" + result.toString());
    this.handleException(result);
    this.clearCache();
    if (result.data?["g0"] != null) {
      return result.data?["g0"];
    }
    throw result.exception?.graphqlErrors[0].message ?? "";
  }

  Future<String> updatePin({required String pin}) async {
    print("update phone pin");
    var result = await this.mutate("""userUpdatePinPassword(pin:"$pin")
""");
    print("update phone pin" + result.toString());
    this.handleException(result);
    this.clearCache();
    if (result.data?["g0"] != null) {
      return result.data?["g0"];
    }
    return "";
  }

  Future<UserModel> loginRepo({
    required String idToken,
  }) async {
    final deviceId = await SPref.instance.get(AppKey.deviceId);
    final deviceToken = await SPref.instance.get(AppKey.deviceToken);
    print("loginRepo-idToken.toString()- ${idToken.toString()}");
    print("loginRepo-deviceId.toString()- ${deviceId.toString()}");
    print("loginRepo-deviceToken.toString()- ${deviceToken.toString()}");

    var result = await this.mutate("""
    login(idToken:\$idToken
              ,deviceId:\$deviceId
              ,deviceToken:\$deviceToken
              )
     {
      user{$param}
    token
     }
    """,
        variables: {
          "idToken": "$idToken",
          "deviceId": "$deviceId",
          "deviceToken": "$deviceToken"
        },
        variablesParams: "(\$idToken : String!"
            ",\$deviceId: String"
            ",\$deviceToken: String"
            ")");

    this.handleException(result);
    this.clearCache();
    if (result.data?["g0"] != null) {
      return UserModel.fromJson(result.data?["g0"]);
    }
    return UserModel();
  }

  Future<User> userUpdateMe({
    required String name,
    String? avatar = "",
    String? area,
    String? address,
    String? province,
    String? provinceId,
    String? district,
    String? districtId,
    String? ward,
    String? wardId,
    String? street,
  }) async {
    var result = await this.mutate("""
         userUpdateMe(data:{
          name:"$name",
          avatar:"$avatar",
          area:$area,
          place:{
            fullAddress:"$address",
            province:"$province",
            provinceId:"$provinceId",
            district:"$district",
            districtId:"$districtId",
            ward:"$ward",
            wardId:"$wardId",
            street:"$street",
          },
        }){
        $param
        }
    """);
    this.handleException(result);
    this.clearCache();
    if (result.data?["g0"] != null) {
      // print("aaaaaa----- ${result.data?["g0"]}");
      return User.fromJson(result.data?["g0"]);
    }
    return User();
  }

  Future<User> userGetMe() async {
    this.clearCache();
    var result = await this.query("""
    userGetMe{
         $param
      }
    """);
    this.handleException(result);
    if (result.data?["g0"] != null) {
      return User.fromJson(result.data?["g0"]);
    }
    return User();
  }

  Future<List<TopicModel>> getAllTopic() async {
    var result = await this.query("""
    getAllTopic(q:{
    limit:1000
        }){
        data{
            id
            name
            slug
            image
            group
          }
      }
    """);

    this.handleException(result);
    if (result.data?["g0"] != null) {
      return List<TopicModel>.from(
          result.data?["g0"]["data"].map((d) => TopicModel.fromJson(d)));
    }
    return [];
  }

  Future<List<TopicModel>> getAllIssueTopic() async {
    var result = await this.query("""
    getAllIssueTopic(q:{
             limit:1000
            }){
              data{
                id
                name
              }
            }
    """);

    this.handleException(result);
    if (result.data?["g0"] != null) {
      return List<TopicModel>.from(
          result.data?["g0"]["data"].map((d) => TopicModel.fromJson(d)));
    }
    return [];
  }

  Future<List<BannerModel>> getAllBanner({String? type}) async {
    var filter;
    if (type != null) {
      filter = {"type": type};
    } else
      filter = null;
    var result = await this.query("""
    getAllBanner(q:{
    limit:100
    filter: $filter
        }){
      data{
        id
        image
        createdAt
        action{
          type
          link
          postId
        }
        owner {
          id
          name
        }
        type
        priority
        active
        startAt
        endAt
        targets
        
      }
    }
    """);

    this.handleException(result, showDataResult: true);
    if (result.data?["g0"] != null) {
      return List<BannerModel>.from(
          result.data?["g0"]["data"].map((d) => BannerModel.fromJson(d)));
    }
    return [];
  }

  Future<List<PlantModel>> getAllPlant() async {
    var result = await this.query("""
    getAllPlant(q:{
    limit:100
        }){
        data{
          id
          name
          image
        }
      }
    """);

    this.handleException(
      result,
    );
    if (result.data?["g0"] != null) {
      return List<PlantModel>.from(
          result.data?["g0"]["data"].map((d) => PlantModel.fromJson(d)));
    }
    return [];
  }

  final String queryDisease = """
          id
          name
          thumbnail
  """;

  Future<List<DiseaseModel>> getAllDisease() async {
    var result = await this.query("""
    getAllDisease(q:{
    limit:1000
        }){
        data{
          ${this.queryDisease}
        }
      }
    """);

    this.handleException(
      result,
    );
    if (result.data?["g0"] != null) {
      return List<DiseaseModel>.from(
          result.data?["g0"]["data"].map((d) => DiseaseModel.fromJson(d)));
    }
    return [];
  }

  Future<List<HospitalModel>> getAllHospital() async {
    var result = await this.query("""
      getAllHospital(q:{
    limit:1000
        }){
          data{
            $hospitalParam
          }
        }
    """);

    this.handleException(
      result,
    );
    if (result.data?["g0"] != null) {
      return List<HospitalModel>.from(
          result.data?["g0"]["data"].map((d) => HospitalModel.fromJson(d)));
    }
    return [];
  }

  Future<List<DoctorModel>> getAllDoctor({String? hospitalId}) async {
    var result = await this.query("""
    getAllDoctor(q:{
          filter:{
            ${hospitalId != null ? 'hospitalId:"$hospitalId"' : ""}
          },
          limit:1000
        }){
          data{
            id
            name
            email
            phone
            avatar
            position
            degree
            subject
            specialized
            intro
            hospitalId
          }
        }
    """);

    this.handleException(
      result,
    );
    if (result.data?["g0"] != null) {
      return List<DoctorModel>.from(
          result.data?["g0"]["data"].map((d) => DoctorModel.fromJson(d)));
    }
    return [];
  }

  Future<List<SettingModel>> getAllSetting() async {
    try {
      var result = await this.query("""
            getAllSetting(q:{
                  limit:1000
                  }){
                    data{
                      id
                      name
                      key
                      value
                      isActive
                      isPrivate
                      type
                    }
                  }
    """);

      this.handleException(result);
      if (result.data?["g0"] != null) {
        return List<SettingModel>.from(
            result.data?["g0"]["data"].map((d) => SettingModel.fromJson(d)));
      }
      return [];
    } catch (error) {
      print(error);
      return [];
    }
  }
}

final authRepository = new _AuthRepository();
