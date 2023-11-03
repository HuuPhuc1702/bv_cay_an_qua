import 'dart:async';

import 'package:bv_cay_an_qua/export.dart';
import 'package:bv_cay_an_qua/models/vxmm/campaign_model_qr_code.dart';
import 'package:bv_cay_an_qua/models/vxmm/check_user_in_campaign_response.dart';
import 'package:bv_cay_an_qua/repositories/vxmm_repo.dart';

import 'package:bv_cay_an_qua/shared/widget/widget_image_network.dart';

import 'package:flutter/material.dart';

import '../input_phone_number_introduction/input_phone_number_introduction_screen.dart';

class QrcodeDialog extends StatefulWidget {
  QrcodeDialog({Key? key, this.campaignModel, this.onClose}) : super(key: key);
  final CampaignModelQRCode? campaignModel;
  final Function()? onClose;

  @override
  State<QrcodeDialog> createState() => _QrcodeDialogState();
}

class _QrcodeDialogState extends State<QrcodeDialog> {
  TextEditingController textEditingController = TextEditingController();
  StatusUser status = StatusUser.initial;
  bool? canEdit;
  CheckUserInCampaignResponse? responseCheck;
  CampaignModelQRCode? currentCampaign;
  final StreamController _streamController = StreamController();

  @override
  void initState() {
    super.initState();
    _streamController.sink.add(0);
    currentCampaign = widget.campaignModel;
    status = StatusUser.initial;

    textEditingController.addListener(() {
      print("textEditingController.text---${textEditingController.text}");
      if (textEditingController.text.isNotEmpty) {
        // phone number start with 0xxxxxxxx
        if (textEditingController.text[0] == '0') {
          if (textEditingController.text.length == 10) {
            checkExistCodeWithPhone(
                currentCampaign?.id ?? '', textEditingController.text);
          }
        }
        // phone number start with +84xxxxxxxxx
        else if (textEditingController.text[0] == '+') {
          if (textEditingController.text.length == 12) {
            checkExistCodeWithPhone(
                currentCampaign?.id ?? '', textEditingController.text);
          }
        }
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await checkExistCode(currentCampaign?.id ?? '');
      if (responseCheck?.active == true) {
        textEditingController.text = responseCheck?.staff?.phone ?? '';
        setState(() {
          status = StatusUser.confirm;
          canEdit = false;
        });
      } else {
        setState(() {
          status = StatusUser.not_ok;
        });
      }
    });
  }

  @override
  void dispose() {
    _streamController.close();
    textEditingController.dispose();
    super.dispose();
  }

  Future<void> checkExistCode(String campaignId) async {
    CheckUserInCampaignResponse? result =
        await vxmmRepository.checkExistCode(campaignId: campaignId);
    if (result != null) {
      setState(() {
        responseCheck = result;
      });
    }
  }

  Future<void> checkExistCodeWithPhone(
      String campaignId, String phoneNumber) async {
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
    // ignore: unnecessary_null_comparison
    if (result != null) {
      return Future.value(result.valid);
    }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
        margin: EdgeInsets.only(
            left: 30,
            right: 30,
            bottom: MediaQuery.of(context).size.height / 7,
            top: 40),
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
            color: Color(0xFFDFECCE), borderRadius: BorderRadius.circular(30)),
        child: Material(
          color: Color(0xFFDFECCE),
          child: SingleChildScrollView(
            child: StreamBuilder<dynamic>(
                stream: _streamController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data == 0)
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        WidgetImageNetWork(
                          url: "",
                          fit: BoxFit.contain,
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Số điện thoại giới thiệu",
                          // style: ptButton(context)
                          //     .copyWith(color: Color(0xFF0ca711), fontSize: 16),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        WidgetTextField(
                          controller: textEditingController,
                          hintText: "VD: 0988888888",
                          padding: EdgeInsets.all(10),
                        ),
                        // WidgetTextFieldV2(
                        //     enabled: canEdit,
                        //     controller: textEditingController,
                        //     hintText: "VD: 0123456789"),
                        const SizedBox(
                          height: 10,
                        ),
                        if (status == StatusUser.initial)
                          const SizedBox()
                        else if (status == StatusUser.confirm)
                          Container(
                            child: responseCheck?.active == true ||
                                    responseCheck?.valid == true
                                ? getItemDataByPhone(
                                    context: context,
                                    name: responseCheck?.staff?.name ??
                                        responseCheck?.staff?.fullName,
                                    image: responseCheck?.staff?.avatar,
                                    phone: responseCheck?.staff?.phone)
                                : Text(
                                    responseCheck?.msg ?? "Không tìm thấy",
                                  ),
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
                                  )
                              ],
                            ),
                          ),
                        const SizedBox(
                          height: 15,
                        ),
                        WidgetButton(
                          text: "Xác nhận",
                          // textColor: Colors.white,
                          radiusColor: ColorConst.primaryColor,
                          backgroundColor: Colors.transparent,
                          onTap: () async {
                            if (status == StatusUser.confirm) {
                              bool check = await registerReferral(
                                  currentCampaign?.id ?? '',
                                  textEditingController.text);
                              if (check == true) {
                                _streamController.sink.add(1);
                              } else {}
                            }
                          },
                        ),
                        // WidgetButtonV2(
                        //   title: "Xác nhận",
                        //   callBack: () async {
                        //     if (status == StatusUser.confirm) {
                        //       bool check = await registerReferral(currentCampaign?.id ?? '', textEditingController.text);
                        //       if (check == true) {
                        //         _streamController.sink.add(1);
                        //       } else {}
                        //     }
                        //   },
                        // ),
                        const SizedBox(
                          height: 10,
                        ),
                        WidgetButton(
                          text: "Bỏ qua",
                          // textColor: Colors.white,
                          radiusColor: ColorConst.primaryColor,
                          backgroundColor: Colors.transparent,
                          onTap: () async {
                            _streamController.close();
                            FocusScope.of(context).unfocus();
                            Navigator.of(context).pop(true);
                          },
                        ),
                        // WidgetButtonV2(
                        //     title: "Bỏ qua",
                        //     callBack: () async {
                        //       _streamController.close();
                        //       FocusScope.of(context).unfocus();
                        //       Navigator.of(context).pop(true);

                        //       // widget.onClose.call();
                        //     }),
                      ],
                    );
                  else if (snapshot.hasData && snapshot.data == 1)
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        WidgetImageNetWork(
                          url: "",
                          fit: BoxFit.contain,
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          "Nhập số điện thoại giới thiệu\n thành công",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        WidgetButton(
                          text: "Tiếp tục quét QR Code",
                          // textColor: Colors.white,
                          radiusColor: ColorConst.primaryColor,
                          backgroundColor: Colors.transparent,
                          onTap: () async {
                            _streamController.close();
                            FocusScope.of(context).unfocus();
                            Navigator.of(context).pop(true);
                          },
                        ),
                        // WidgetButtonV2(
                        //     title: "Tiếp tục quét QR Code",
                        //     callBack: () {
                        //       _streamController.close();
                        //       FocusScope.of(context).unfocus();
                        //       Navigator.of(context).pop(true);
                        //       // widget.onClose.call();
                        //     }),
                      ],
                    );
                  else
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                }),
          ),
        ),
      ),
    );
  }

  getItemDataByPhone(
      {required BuildContext context,
      String? image,
      String? name,
      String? phone}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 10),
      height: 60,
      child: Center(
        child: Stack(
          children: [
            Positioned(
              top: 8,
              left: 30,
              bottom: 8,
              child: Container(
                width: MediaQuery.of(context).size.width - 120 - 30,
                padding: EdgeInsets.only(left: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(100),
                      bottomRight: Radius.circular(100)),
                  color: Color(0xFFA8D198),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name ?? "Chưa cập nhật".toUpperCase(),
                      ),
                      Text(
                        phone ?? "Chưa cập nhật",
                      ),
                    ]),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              height: 60,
              width: 60,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color(0xFFA8D198),
                ),
                child: Center(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                          color: Colors.white,
                          child: WidgetImageNetWork(
                            url: image ?? "",
                            width: 50,
                            height: 50,
                          ))),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
