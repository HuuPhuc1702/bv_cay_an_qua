import 'dart:async';

import 'package:bv_cay_an_qua/export.dart';
import 'package:bv_cay_an_qua/repositories/vxmm_repo.dart';
import 'package:bv_cay_an_qua/shared/waiting_loading.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:vibration/vibration.dart';
import 'qrcode_dialog.dart';
import 'qrcode_dialog_spin_lucky.dart';
import 'package:url_launcher/url_launcher.dart';

class QRCodePage extends StatefulWidget {
  QRCodePage({Key? key}) : super(key: key);

  @override
  _QRCodePageState createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool startScan = false;

  late QRView viewQR;

  BuildContext? _context;
  StreamController streamController = StreamController.broadcast();
  bool success = true;
  String? qrCode = "";

  /// Mark campaign asked regis referal to skip
  String askedCampaignIds = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    viewQR = QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    streamController.close();
    controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    viewQR,
                    Image.asset(
                      "assets/images/background_qrcode.png",
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 7,
                      width: MediaQuery.of(context).size.width,
                      child: StreamBuilder(
                          stream: streamController.stream,
                          builder: (context, snapShot) {
                            if (snapShot.data != null) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "${snapShot.data}".toUpperCase(),
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: StyleConst.mediumStyle().copyWith(
                                      color: (success)
                                          ? Colors.white
                                          : Colors.red),
                                ),
                              );
                            }
                            return SizedBox();
                          }),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(14.0),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/ic_back.png",
                              fit: BoxFit.cover,
                              width: 24,
                              height: 24,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Quay lại",
                              // style: ptTitle(context).copyWith(
                              //     color: Colors.white,
                              //     fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: WidgetButton(
                  text: !startScan ? 'Bắt đầu quét QR code' : "Dừng quét",
                  // textColor: Colors.white,
                  radiusColor: ColorConst.primaryColor,
                  backgroundColor: Colors.transparent,
                  onTap: () {
                    success = true;
                    streamController.sink.add(null);
                    qrCode = "";
                    setState(() {
                      startScan = !startScan;
                    });
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom + 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null &&
          (scanData.code?.isNotEmpty ?? false) &&
          startScan) {
        print('starting checking the qrcode');
        _openWebBrowserhURL(scanData.code);
      }
    });
  }

  ///not support simulator IOS
  _openWebBrowserhURL(url) async {
    /** If url is empty, then ignore */
    if (url.isEmpty || url == null) {
      return;
    }
    /** If url is duplicate, then ignore */
    if (url == qrCode) {
      return;
    }

    /** Stop scan */
    setState(() {
      startScan = false;
      qrCode = url;
      WaitingDialog.show(context);
      streamController.sink.add(null);
    });
    print("Checking QRCode: $qrCode");
    print(startScan);
    //await Future.delayed(const Duration(milliseconds: 100));
    /** Vibrate phone after scanning in 100ms */
    //Vibration.vibrate(duration: 100);
    try {
      /** Check Qrcode Campaign 
     * 1/ If campaign is not exist, then skip regis invite referral user
     * 2/ If campaign is exist, then check current user is set invite referral user or not
     * 2.1/ If current user is not set invite referral user, then show dialog to set invite referral user
     * 2.2/ If current user is set invite referral user, then skip regis invite referral user
     */
      print("Checking code campaign..." + qrCode!);
      final campaign = await vxmmRepository.postCheckQRCode(qrCode ?? '');
      print("Check campaign" + campaign.toString());
      if (campaign != null) {
        print("Code has campaign, checking referral info...");
        /** If campaign asked before, then ignore check referral */
        if (askedCampaignIds == campaign.id) {
          print("Campaign has been asked before, skip check referral");
        } else {
          askedCampaignIds = campaign.id ?? '';
          final referralInfo = await vxmmRepository.checkExistCode(
              campaignId: campaign.id ?? '');
          print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" +
              referralInfo.toString());
          if (referralInfo == null || referralInfo.active == false) {
            print(
                "Current user is not set invite referral user, show dialog to set invite referral user");
            /** Show regis referral user dialog */
            await showDialog(
                context: _context!,
                barrierColor: Colors.black.withOpacity(0.90),
                builder: (BuildContext context) {
                  return QrcodeDialog(
                      campaignModel: campaign,
                      onClose: () {
                        // setState(() {

                        //   startScan = false;
                        //   qrCode = null;
                        // });
                      });
                });
          } else {
            print(
                "Current user is set invite referral user, skip regis invite referral user");
            print(referralInfo.msg);
          }
        }
      } else {
        print("Code has no campaign");
        streamController.sink.add(
            "MÃ QR CODE NÀY KHÔNG CÓ CHƯƠNG TRÌNH KHUYẾN MÃI TRÊN ỨNG DỤNG BVCAQ");
      }

      /** Post Scan Qrcode */
      final result = await vxmmRepository.postScanQRCode(qrCode ?? '');
      print("Post Scan Qrcode" + result.toString());
      if (result == null) {
        print("No QRcode model found. Scan Qrcode fail");
        return;
      }

      if (result.success == false) {
        print(qrCode);
        print("Scan Qrcode fail: ${result.message}");
        /** If scan error, show error message */
        streamController.sink.add(result.message);
      } else {
        print("Scan Qrcode success: ${result.message}");
        // if (result.luckySpin != null) {
        //   print("Scan Qrcode success, show lucky spin");
        //   /** If scan result has lukcySpin reward, then launch browser to play */
        //   final token = ''; // await LoopBackAuth().getPersist("accessToken");
        //   final url = '${result.luckySpin?.url}&token=$token';
        //   if (url != '') {
        //     if (await canLaunch(Uri.encodeFull(url))) {
        //       await launch(Uri.encodeFull(url));
        //     } else {
        //       throw 'Could not launch $url';
        //     }
        //   }
        // } else
        if (result.image != null) {
          print("Scan Qrcode success, show topup:${result.image} ");
          /** If scan result has topup reward, then show reward dialog */
          await showDialog(
              context: _context!,
              barrierColor: Colors.black.withOpacity(0.90),
              builder: (BuildContext context) {
                return QrcodeDialogSpinLucky(url: result.image);
              });
          setState(() {
            startScan = false;
            WaitingDialog.turnOff();
            qrCode = null;
          });
          return;
        } else {
          print("Scan Qrcode success, show reward");
          /** If scan result has another reward, then show reward message */
          streamController.sink.add(result.message);
        }
      }
    } catch (err) {
      /** If scan has error, then show default error message */
      streamController.sink
          .add("Quét mã không thành công, vui lòng thử lại sau");
      print('Error when scan qrcode: $err');
    } finally {
      print("SetState");
      setState(() {
        startScan = true;
        WaitingDialog.turnOff();
        // qrCode = null;
        // qrCode = null;
      });
      /** Stop scan */
      // setState(() {
      //   startScan = false;
      //   WaitingDialog.turnOff();
      //   qrCode = null;
      // });
    }
  }
}
