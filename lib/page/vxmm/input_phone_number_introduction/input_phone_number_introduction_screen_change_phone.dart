import 'package:bv_cay_an_qua/config/theme/assets-constant.dart';
import 'package:bv_cay_an_qua/export.dart';
import 'package:bv_cay_an_qua/models/vxmm/check_user_in_campaign_response.dart';
import 'package:bv_cay_an_qua/models/vxmm/user_model.dart';
import 'package:bv_cay_an_qua/repositories/vxmm_repo.dart';
import 'package:bv_cay_an_qua/shared/hex_color.dart';
import 'package:bv_cay_an_qua/shared/widget/app_bar.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_image_network.dart';
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:bv_cay_an_qua/constants/constants.dart';
import 'input_phone_number_introduction_screen.dart';
import 'package:bv_cay_an_qua/models/vxmm/campaign_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'input_phone_number_introduction_screen_success.dart';

class InputPhoneNumberIntroductionScreenChangePhone extends StatefulWidget {
  const InputPhoneNumberIntroductionScreenChangePhone({
    Key? key,
    required this.titleHeader,
    this.campaign,
  }) : super(key: key);
  final String titleHeader;
  final CampaignModel? campaign;
  @override
  State<InputPhoneNumberIntroductionScreenChangePhone> createState() =>
      _InputPhoneNumberIntroductionScreenChangePhoneState();
}

class _InputPhoneNumberIntroductionScreenChangePhoneState
    extends State<InputPhoneNumberIntroductionScreenChangePhone> {
  late TextEditingController phoneController;
  late StatusUser status;
  CheckUserInCampaignResponse? responseCheck;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    status = StatusUser.initial;

    phoneController.addListener(() {
      if (phoneController.text.isNotEmpty) {
        // phone number start with 0xxxxxxxx
        if (phoneController.text[0] == '0') {
          if (phoneController.text.length == 10) {
            checkExistCodeWithPhone(
                widget.campaign?.id ?? '', phoneController.text);
          }
        }
        // phone number start with +84xxxxxxxxx
        else if (phoneController.text[0] == '+') {
          if (phoneController.text.length == 12) {
            checkExistCodeWithPhone(
                widget.campaign?.id ?? '', phoneController.text);
          }
        }
      }
    });
  }

  checkExistCodeWithPhone(String campaignId, String phoneNumber) async {
    CheckUserInCampaignResponse? result = await vxmmRepository
        .checkExistCodeWithPhone(campaignId: campaignId, phone: phoneNumber);
    if (result != null) {
      setState(() {
        responseCheck = result;
        if (responseCheck?.valid == true) {
          status = StatusUser.confirm;
        } else {
          status = StatusUser.not_ok;
        }
      });
    }
  }

  Future<bool> registerReferral(String campaignId, String phoneNumber) async {
    CheckUserInCampaignResponse result = await vxmmRepository.registerReferral(
        campaignId: campaignId, phone: phoneNumber);
    if (result != null) {
      return Future.value(result.valid);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: buildAppBar(context, title: widget.titleHeader),
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
                  HexColor(appColor2).withOpacity(0.2),
                  Colors.white,
                ],
              )),
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                              : Image.asset("assets/images/app_logo.png"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, right: 20, left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Số điện thoại giới thiệu",
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30.0),
                                      child: Container(
                                        color: const Color(0xFF0ca711)
                                            .withOpacity(0.5),
                                        padding: EdgeInsets.all(
                                            deviceWidth(context) * 0.03),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextField(
                                            controller: phoneController,
                                            cursorColor: Colors.white,
                                            decoration: InputDecoration(
                                              hintText: "VD: 0988888888",
                                              contentPadding:
                                                  EdgeInsets.all(10.0),
                                              // hintStyle: ptTitle(context)
                                              //     .copyWith(
                                              //         fontSize: 15,
                                              //         fontStyle:
                                              //             FontStyle.italic,
                                              //         color:
                                              //             HexColor(appText)),
                                              border: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              if (status == StatusUser.initial)
                                const SizedBox()
                              else if (status == StatusUser.confirm)
                                Container(
                                  child: responseCheck?.active == true
                                      ? Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 50),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        responseCheck
                                                                ?.staff?.name ??
                                                            responseCheck?.staff
                                                                ?.fullName ??
                                                            '',
                                                      ),
                                                      Text(responseCheck
                                                              ?.staff?.phone ??
                                                          '')
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              margin: EdgeInsets.only(left: 30),
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF0ca711)
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Color(0xFF0ca711)
                                                        .withOpacity(0.5),
                                                radius: 30,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(90),
                                                  child: WidgetImageNetWork(
                                                    url: responseCheck
                                                        ?.staff?.avatar,
                                                    height: 50,
                                                    width: 50,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      : SizedBox(),
                                )
                              else
                                Container(
                                  padding: EdgeInsets.only(top: 15),
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      if (status == StatusUser.not_ok)
                                        Text(
                                          responseCheck?.msg ?? "",
                                          style:
                                              TextStyle(color: ColorConst.red),
                                        )
                                    ],
                                  ),
                                ),
                              const SizedBox(height: 15),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30.0),
                                      child: InkWell(
                                        onTap: () async {
                                          // send api
                                          if (status == StatusUser.confirm) {
                                            bool check = await registerReferral(
                                                widget.campaign?.id ?? '',
                                                phoneController.text);
                                            if (check == true) {
                                              Navigator.of(context)
                                                  .pop(responseCheck?.staff);
                                            }
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: status ==
                                                    StatusUser.confirm
                                                ? LinearGradient(
                                                    colors: [
                                                      const Color(0xFF0ca711),
                                                      const Color(0xFF41de46),
                                                    ],
                                                    begin:
                                                        const FractionalOffset(
                                                            0.0, 0.0),
                                                    end: const FractionalOffset(
                                                        1.0, 0.0),
                                                    stops: [0.0, 1.0],
                                                    tileMode: TileMode.clamp)
                                                : LinearGradient(
                                                    colors: [
                                                      const Color(0xFF0ca711)
                                                          .withOpacity(0.5),
                                                      const Color(0xFF41de46)
                                                          .withOpacity(0.5),
                                                    ],
                                                    begin:
                                                        const FractionalOffset(
                                                            0.0, 0.0),
                                                    end: const FractionalOffset(
                                                        1.0, 0.0),
                                                    stops: [0.0, 1.0],
                                                    tileMode: TileMode.clamp),
                                          ),
                                          padding: EdgeInsets.all(
                                              deviceWidth(context) * 0.03),
                                          // height: ScaleUtil.getInstance()
                                          //     .setWidth(50),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Xác nhận",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context)
                                              .pop(UserModel());
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [
                                                  const Color(0xFF0ca711),
                                                  const Color(0xFF41de46),
                                                ],
                                                begin: const FractionalOffset(
                                                    0.0, 0.0),
                                                end: const FractionalOffset(
                                                    1.0, 0.0),
                                                stops: [0.0, 1.0],
                                                tileMode: TileMode.clamp),
                                          ),
                                          padding: EdgeInsets.all(
                                              deviceWidth(context) * 0.03),
                                          // height: ScaleUtil.getInstance()
                                          //     .setWidth(50),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Hủy",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ]),
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
