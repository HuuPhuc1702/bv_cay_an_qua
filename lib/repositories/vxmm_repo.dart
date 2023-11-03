import 'dart:convert';
import 'dart:convert';

import 'package:bv_cay_an_qua/apis/core/base_service.dart';
import 'package:bv_cay_an_qua/models/qrcode_model.dart';
import 'package:bv_cay_an_qua/models/user/user_model.dart' as user;
import 'package:bv_cay_an_qua/models/vxmm/campaign_log.dart';
import 'package:bv_cay_an_qua/models/vxmm/campaign_model.dart';
import 'package:bv_cay_an_qua/models/vxmm/campaign_model_qr_code.dart';
import 'package:bv_cay_an_qua/models/vxmm/check_user_in_campaign_response.dart';
import 'package:bv_cay_an_qua/models/vxmm/rank_result.dart';
import 'package:bv_cay_an_qua/models/vxmm/rank_user.dart';
import 'package:bv_cay_an_qua/models/vxmm/user_model.dart';
import 'package:bv_cay_an_qua/page/vxmm/ranking/ranking_list.dart';
import 'package:bv_cay_an_qua/services/graphql/graphql_repo.dart';
import 'package:bv_cay_an_qua/shared/helper/print_log.dart';
import 'package:bv_cay_an_qua/models/history_lucky_spin_model.dart';

_VXMMRepository vxmmRepository = _VXMMRepository();

class _VXMMRepository extends GraphqlRepository {
  Future<QRCodeModel?> postScanQRCode(String qrcode) async {
    try {
      // final url = [LoopBackConfig.getPath(), LoopBackConfig.getApiVersion(), "campaign/scanqr"].join('/');
      // final result = await this.request(method: 'POST', url: url, postBody: {"qrcode": qrcode}, isWrapBaseResponse: false);
      // if (result["code"] == 200) {
      //   return QRCodeModel.fromJson(result["data"]);
      // }
      var result = await this.mutate(
        """
        scanQR(qr: "$qrcode"){
          campaignId,scanIndex,cumulativeSales,
      prizes{
        prizeImage
      }
      }
    """,
      );

      this.handleException(result);
      print('result.data---${result.data}');
      if (result.exception?.graphqlErrors.first.message != null) {
        return QRCodeModel(
            success: false,
            message: result.exception?.graphqlErrors.first.message);
      } else if (result.data?["g0"] != null) {
        try {
          if (result.data?["g0"]["prizes"]?[0]?['prizeImage'] != null)
            return QRCodeModel(
                success: true,
                image: result.data?["g0"]["prizes"]?[0]?['prizeImage']);
          else
            return QRCodeModel(
                success: true,
                message:
                    'BẠN ĐÃ TÍCH LUỸ ${result.data?["g0"]["cumulativeSales"]} ĐIỂM');
        } catch (err) {
          return QRCodeModel(
              success: true,
              message:
                  'BẠN ĐÃ TÍCH LUỸ ${result.data?["g0"]["cumulativeSales"]} ĐIỂM');
        }
      }
      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<CampaignModelQRCode?> postCheckQRCode(String qrcode) async {
    try {
      //final url = [LoopBackConfig.getPath(), LoopBackConfig.getApiVersion(), "campaign/check"].join('/');
      //final result = await this.request(method: 'POST', url: url, postBody: {"qrCode": qrcode}, isWrapBaseResponse: false);
      // if (result["code"] == 200) {
      //   printLog("postCheckQRCode---${result["data"]}");
      //   return CampaignModelQRCode.fromJson(result["data"]["data"]);
      // }

      var result = await this.mutate(
        """
        checkQR(qr: "$qrcode"){
            active
            activeAt
            code
            content
            createdAt
            endDate
            icon
            id
            image
            name
            startDate
      }
    """,
      );

      this.handleException(result);
      print('result.data---${result}');
      if (result.data?["g0"] != null) {
        print(result.data?["g0"]["data"]);
        CampaignModel model = CampaignModel.fromJson(result.data?["g0"]);
        return CampaignModelQRCode(
            id: model.id,
            name: model.name,
            title: model.name,
            image: model.image);
      }

      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<List<CampaignModel>?> getCampaignList() async {
    try {
      var result = await this.query(
        """
          getAllCampaign {
            data {
              active
              activeAt
              code
              content
              createdAt
              endDate
              icon
              id
              image
              name
              startDate
              updatedAt
              topup {
                username
              }
            }
          }
        """,
      );

      this.handleException(result);
      if (result.data?["g0"] != null) {
        print(result.data?["g0"]["data"]);

        return List<CampaignModel>.from(
            result.data?["g0"]["data"].map((d) => CampaignModel.fromJson(d)));
      }
      return [];
    } catch (error) {
      print(error);
      return [];
    }
  }

  Future<CampaignModel?> getCampaignDetail(String id) async {
    try {
      this.clearCache();
      var result = await this.query(
        """
          getOneCampaign(id: "$id"){
            active
            activeAt
            code
            content
            createdAt
            endDate
            icon
            id
            image
            name
            startDate
            updatedAt
            topup {
              username
            }
          }
        """,
      );
      this.handleException(result);
      if (result.data?["g0"] != null) {
        print(result.data?["g0"]["data"]);
        return CampaignModel.fromJson(result.data?["g0"]);
      }
      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<RankResult?> getRankResultList(String campaignId, RankType type,
      {int pageIndex = 1}) async {
    try {
      var result;
      if (type == RankType.scan)
        result = await this.query(
          """
            scanTop10(campaignId: "$campaignId")
          """,
        );
      else
        result = await this.query(
          """
            referralTop10(campaignId: "$campaignId")
          """,
        );

      this.handleException(result);
      print(result);
      if (result.data?["g0"] != null) {
        RankResult resultRankResult =
            RankResult.fromJson(result.data?["g0"][0]);
        if (resultRankResult.me == null)
          return resultRankResult.copyWith(me: [RankUser()]);
        return resultRankResult;
      }
      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<List<HistoryLuckySpinModel>?> getAllLuckySpinByFarmer(
      {String search = "",
      required String farmerId,
      int pageIndex = 1,
      String? campaignId}) async {
    try {
      if (farmerId == '') {
        this.clearCache();
        var resultGetCurrentUser = await this.query("""
                                                      userGetMe{
                                                            id
                                                            phone
                                                        }
                                                      """);
        this.handleException(resultGetCurrentUser);
        if (resultGetCurrentUser.data?["g0"] != null) {
          user.User currentUser =
              user.User.fromJson(resultGetCurrentUser.data?["g0"]);
          farmerId = currentUser.id ?? '';
        }
      }

      var result = await this.query(
        """
              getAllCampaignLog(q:{
                limit:100
                filter : {
                  farmerId: "$farmerId"
                }
                page: $pageIndex
                    }){
                      data {
                        id
                        farmerId
                        createdAt
                        prizes {
                          prizeName
                        }
                        
                        campaign {
                          id
                          createdAt
                          name
                          code
                          startDate
                          endDate
                          active
                          activeAt
                        }
                      }
              }
            """,
      );
      this.handleException(result);
      print(result);
      if (result.data?["g0"] != null) {
        var resultCampaignLog = List<CampaignLog>.from(
            result.data?["g0"]["data"].map((d) => CampaignLog.fromJson(d)));
        List<HistoryLuckySpinModel> list = [];
        resultCampaignLog.forEach((element) {
          element.prizes?.forEach((e) {
            list.add(HistoryLuckySpinModel(
                campaignId: CampaignId(
                    id: '${element.campaign?.id}',
                    name: '${element.campaign?.name}'),
                createdAt: '${DateTime.tryParse('${element.createdAt}')}',
                prizeName: e.prizeName));
          });
        });

        return list;
      }
      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<List<HistoryLuckySpinModel>?> getAllLuckySpinByFarmerReferral(
      {required String phone,
      String search = "",
      int pageIndex = 1,
      String? campaignId}) async {
    try {
      if (phone == '') {
        this.clearCache();
        var resultGetCurrentUser = await this.query("""
                                                      userGetMe{
                                                            id
                                                            phone
                                                        }
                                                      """);
        this.handleException(resultGetCurrentUser);
        if (resultGetCurrentUser.data?["g0"] != null) {
          user.User currentUser =
              user.User.fromJson(resultGetCurrentUser.data?["g0"]);
          phone = currentUser.phone ?? '';
        }
      }
      phone = phone.replaceAll('+84', '0');
      var result = await this.query(
        """
              getAllCampaignLog(q:{
                limit:100
                filter : {
                  refId:"$phone"
                }
                page: $pageIndex
                    }){
                      data {
                        id
                        createdAt
                        farmerId
                        prizes {
                          prizeName
                        }
                        campaign {
                          id
                          activeUser {
                            id
                            phone
                          }
                          createdAt
                          name
                          code
                          startDate
                          endDate
                          active
                          activeAt
                        }
                      }
              }
            """,
      );
      this.handleException(result);
      print(result);
      if (result.data?["g0"] != null) {
        print(result.data?["g0"]);
        var resultCampaignLog = List<CampaignLog>.from(
            result.data?["g0"]["data"].map((d) => CampaignLog.fromJson(d)));
        List<HistoryLuckySpinModel> list = [];
        resultCampaignLog.forEach((element) {
          element.prizes?.forEach((e) {
            list.add(HistoryLuckySpinModel(
                campaignId: CampaignId(
                    id: '${element.campaign?.id}',
                    name: element.campaign?.name),
                createdAt: '${DateTime.tryParse('${element.createdAt}')}',
                prizeName: e.prizeName));
          });
        });

        return list;
      }
      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<CheckUserInCampaignResponse?> checkExistCode(
      {required String campaignId}) async {
    try {
      this.clearCache();
      var result = await this.query(
        """
          campaignReferralFarmerInfo(campaignId: "$campaignId")
          {
            active,
            valid,
            msg,
            staff{
                fullName,
                phone,
                avatar
            }
                
          }
        """,
      );
      this.handleException(result);
      if (result.data?["g0"] != null) {
        print(result.data?["g0"]["data"]);
        print("campaignReferralFarmerInfoSuccess-${result.data}");
        return CheckUserInCampaignResponse.fromJson(result.data?["g0"]);
      } else if (result.exception?.graphqlErrors.first.message != null) {
        print(
            "campaignReferralFarmerInfoError-${result.exception?.graphqlErrors.first.message}");
        return CheckUserInCampaignResponse(
            valid: false,
            active: false,
            msg: result.exception?.graphqlErrors.first.message);
      }
      //else {
      //   return CheckUserInCampaignResponse(valid: true, active: true, staff: UserModel(name: "Không rõ", address: "Không rõ"));
      // }
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<CheckUserInCampaignResponse?> checkExistCodeWithPhone(
      {required String campaignId, required String phone}) async {
    try {
      this.clearCache();
      var result = await this.query(
        """
          campaignReferralCheckValid(campaignId: "$campaignId",refId: "$phone")
          {
            active,
            valid,
            msg,
            staff{
                fullName,
                phone,
                avatar
            }
          }
        """,
      );
      // this.handleException(result);
      // if (result.exception?.graphqlErrors.first.message != null) {
      //   return CheckUserInCampaignResponse(valid: false, active: false, msg: result.exception?.graphqlErrors.first.message);
      // } else {
      //   return CheckUserInCampaignResponse(valid: true, active: true, staff: UserModel(name: "Không rõ"));
      // }
      this.handleException(result);
      if (result.data?["g0"] != null) {
        print(result.data?["g0"]["data"]);
        print("campaignReferralCheckValidSuccess-${result.data}");
        return CheckUserInCampaignResponse.fromJson(result.data?["g0"]);
      } else if (result.exception?.graphqlErrors.first.message != null) {
        print(
            "campaignReferralCheckValidError-${result.exception?.graphqlErrors.first.message}");
        return CheckUserInCampaignResponse(
            valid: false,
            active: false,
            msg: result.exception?.graphqlErrors.first.message);
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future registerReferral(
      {required String campaignId, required String phone}) async {
    try {
      this.clearCache();
      var result = await this.mutate("""
        createCampaignReferralLog(data:{
        campaignId:"$campaignId",
        refId:"$phone"
            }){
              id
            }
            """);
      this.handleException(result);
      if (result.exception?.graphqlErrors.first.message != null) {
        print("createCampaignReferralLogError-${result.data}");
        return CheckUserInCampaignResponse(
            valid: false,
            active: false,
            msg: result.exception?.graphqlErrors.first.message);
      } else {
        print("createCampaignReferralLogSuccess-${result.data}");
        return CheckUserInCampaignResponse(
            valid: true, active: true, staff: UserModel(name: ""));
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  @override
  fromJson(Map<String, Object> item) {
    // TODO: implement fromJson
    // throw UnimplementedError();
  }

  @override
  String getModelPath() {
    return '';
    // TODO: implement getModelPath
    // throw UnimplementedError();
  }
}
