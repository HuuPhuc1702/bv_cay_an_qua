import 'package:bv_cay_an_qua/config/theme/assets-constant.dart';
import 'package:bv_cay_an_qua/export.dart';
import 'package:bv_cay_an_qua/models/vxmm/user_model.dart';
import 'package:bv_cay_an_qua/shared/hex_color.dart';
import 'package:bv_cay_an_qua/shared/widget/app_bar.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_image_network.dart';
import 'package:flutter/material.dart';
import 'package:bv_cay_an_qua/constants/constants.dart';
import 'package:extended_image/extended_image.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'input_phone_number_introduction_screen_change_phone.dart';
import 'package:bv_cay_an_qua/models/vxmm/campaign_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class InputPhoneNumberIntroductionScreenSuccess extends StatefulWidget {
  const InputPhoneNumberIntroductionScreenSuccess(
      {Key? key,
      this.titleHeader,
      this.campaign,
      this.canEditPhone,
      required this.staff})
      : super(key: key);
  final String? titleHeader;
  final CampaignModel? campaign;
  final bool? canEditPhone;
  final UserModel staff;

  @override
  State<InputPhoneNumberIntroductionScreenSuccess> createState() =>
      _InputPhoneNumberIntroductionScreenSuccessState();
}

class _InputPhoneNumberIntroductionScreenSuccessState
    extends State<InputPhoneNumberIntroductionScreenSuccess> {
  bool? canEditPhone;
  late UserModel staff;

  @override
  void initState() {
    super.initState();
    staff = widget.staff;

    canEditPhone = widget.canEditPhone;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context,
            title: widget.titleHeader ?? '', doubleBack: true),
        body: Stack(fit: StackFit.expand, children: [
          Container(
            //  height: MediaQuery.of(context).size.height,
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
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Nhập số điện thoại giới thiệu\n thành công",
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
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
        ]));
  }
}
