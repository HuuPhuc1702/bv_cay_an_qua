import 'package:bv_cay_an_qua/export.dart';
import 'package:bv_cay_an_qua/models/vxmm/check_user_in_campaign_response.dart';
import 'package:bv_cay_an_qua/repositories/vxmm_repo.dart';
import 'package:bv_cay_an_qua/shared/widget/app_bar.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_image_network.dart';
import 'package:flutter/material.dart';
import 'package:bv_cay_an_qua/constants/constants.dart';
import 'package:bv_cay_an_qua/models/vxmm/campaign_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'input_phone_number_introduction_screen_success.dart';

enum StatusUser { initial, not_ok, confirm }

class InputPhoneNumberIntroductionScreen extends StatefulWidget {
  const InputPhoneNumberIntroductionScreen(
      {Key? key, this.titleHeader, this.campaign})
      : super(key: key);
  final String? titleHeader;
  // final LPost listDocument;
  final CampaignModel? campaign;
  @override
  State<InputPhoneNumberIntroductionScreen> createState() =>
      _InputPhoneNumberIntroductionScreenState();
}

class _InputPhoneNumberIntroductionScreenState
    extends State<InputPhoneNumberIntroductionScreen> {
  late TextEditingController _phoneController;
  StatusUser _status = StatusUser.initial;
  CheckUserInCampaignResponse? _responseCheck;
  // ignore: unused_field
  bool _canEdit = true;

  @override
  void initState() {
    super.initState();

    _status = StatusUser.initial;
    _phoneController = TextEditingController();

    _phoneController.addListener(() {
      if (_phoneController.text.isNotEmpty) {
        // phone number start with 0xxxxxxxx
        if (_phoneController.text[0] == '0') {
          if (_phoneController.text.length == 10) {
            _checkExistCodeWithPhone(
                widget.campaign?.id ?? '', _phoneController.text);
          }
        }
        // phone number start with +84xxxxxxxxx
        else if (_phoneController.text[0] == '+') {
          if (_phoneController.text.length == 12) {
            _checkExistCodeWithPhone(
                widget.campaign?.id ?? '', _phoneController.text);
          }
        }
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _checkExistCode(widget.campaign?.id ?? '');
      if (_responseCheck?.active == true) {
        _phoneController.text = _responseCheck?.staff?.phone ?? '';
        setState(() {
          _status = StatusUser.confirm;
          _canEdit = false;
        });
        Get.to(InputPhoneNumberIntroductionScreenSuccess(
            campaign: widget.campaign,
            canEditPhone: false,
            titleHeader: widget.titleHeader,
            staff: _responseCheck!.staff!));
      } else {
        setState(() {
          _status = StatusUser.not_ok;
        });
      }
    });
  }

  Future<void> _checkExistCode(String campaignId) async {
    CheckUserInCampaignResponse? result =
        await vxmmRepository.checkExistCode(campaignId: campaignId);
    print(result);
    if (result != null) {
      setState(() {
        _responseCheck = result;
      });
    }
  }

  Future<void> _checkExistCodeWithPhone(
      String campaignId, String phoneNumber) async {
    CheckUserInCampaignResponse? result = await vxmmRepository
        .checkExistCodeWithPhone(campaignId: campaignId, phone: phoneNumber);
    if (result != null) {
      setState(() {
        _responseCheck = result;
        if (_responseCheck?.valid == true) {
          _status = StatusUser.confirm;
        } else {
          _status = StatusUser.not_ok;
        }
      });
    }
  }

  Future<bool> _registerReferral(String campaignId, String phoneNumber) async {
    CheckUserInCampaignResponse result = await vxmmRepository.registerReferral(
        campaignId: campaignId, phone: phoneNumber);
    // ignore: unnecessary_null_comparison
    if (result != null) {
      return Future.value(result.valid);
    }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: buildAppBar(context, title: widget.titleHeader ?? ''),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white,
                ],
              )),
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: widget.campaign?.image != null &&
                                widget.campaign?.image != ""
                            ? Image(
                                image: CachedNetworkImageProvider(
                                    widget.campaign?.image ?? ''),
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                "assets/images/app_logo.png",
                                height: 200,
                              ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Số điện thoại giới thiệu"),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: WidgetTextField(
                                        controller: _phoneController,
                                        hintText: "VD: 0988888888",
                                        padding: EdgeInsets.all(10),
                                      )),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            if (_status == StatusUser.initial)
                              const SizedBox()
                            else if (_status == StatusUser.confirm)
                              Container(
                                child: _responseCheck?.active == true ||
                                        _responseCheck?.valid == true
                                    ? Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(left: 50),
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        (_responseCheck?.staff
                                                                        ?.name ??
                                                                    _responseCheck
                                                                        ?.staff
                                                                        ?.fullName)
                                                                ?.toUpperCase() ??
                                                            'KHÔNG RÕ',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                            fontSize:
                                                                defaultSize -
                                                                    3)),
                                                    Text(
                                                      _responseCheck
                                                              ?.staff?.phone
                                                              ?.toUpperCase() ??
                                                          'KHÔNG RÕ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize:
                                                              defaultSize - 7),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            margin: EdgeInsets.only(left: 25),
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF0ca711)
                                                    .withOpacity(0.5),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(90),
                                              child: Container(
                                                color: Colors.white,
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      Color(0xFF0ca711)
                                                          .withOpacity(0.5),
                                                  radius: 30,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            90),
                                                    child: WidgetImageNetWork(
                                                      url: _responseCheck
                                                          ?.staff?.avatar,
                                                      height: 50,
                                                      width: 50,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    : Text(
                                        _responseCheck?.msg ?? "Không tìm thấy",
                                      ),
                              )
                            else
                              Container(
                                padding: EdgeInsets.only(top: 15),
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    if (_status == StatusUser.not_ok)
                                      Text(_responseCheck?.msg ?? "",
                                          style:
                                              TextStyle(color: ColorConst.red))
                                  ],
                                ),
                              ),
                            const SizedBox(height: 15),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: WidgetButton(
                                    text: "Xác nhận",
                                    // textColor: Colors.white,
                                    radiusColor: ColorConst.primaryColor,
                                    backgroundColor: Colors.transparent,
                                    onTap: () async {
                                      print('xong$_status');
                                      if (_status == StatusUser.confirm) {
                                        bool check = await _registerReferral(
                                            widget.campaign?.id ?? '',
                                            _phoneController.text);
                                        if (check == true) {
                                          Get.to(
                                              InputPhoneNumberIntroductionScreenSuccess(
                                            titleHeader:
                                                "Nhập số điện thoại giới thiệu",
                                            campaign: widget.campaign,
                                            canEditPhone: false,
                                            staff: _responseCheck!.staff!,
                                          ));
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Image.asset(
                AssetsConst.backgroundBottomLogin,
                width: deviceWidth(context),
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ],
        ));
  }
}
