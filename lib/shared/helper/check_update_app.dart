import 'dart:io';

import 'package:bv_cay_an_qua/app_config.dart';
import 'package:bv_cay_an_qua/shared/helper/print_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_version/new_version.dart';
import 'package:url_launcher/url_launcher.dart';

checkUpdateApp(BuildContext context) async {
  final _newVersion = NewVersion(
      androidId: appConfig.appType == AppType.FARMER
          ? "mcom.asia.bvanqua"
          : "mcom.asia.bsanqua",
      iOSId: appConfig.appType == AppType.FARMER
          ? "mcom.asia.bscanqua"
          : "mcom.asia.bsanqua");

  bool isUpdate = false;

  final status = await _newVersion.getVersionStatus();

  if (status != null) {
    printLog("local version: ${status.localVersion}");
    printLog("store version: ${status.storeVersion}");
    String versionNew = status.storeVersion;

    if (status.storeVersion.split(".").length > 3) {
      versionNew = status.storeVersion
          .substring(0, status.storeVersion.lastIndexOf("."));
    }
    final _localVersion = status.localVersion.split(".");
    final _storeVersion = versionNew.split(".");
    try {
      for (int i = 0;
          i <
              (_localVersion.length > _storeVersion.length
                  ? _localVersion.length
                  : _storeVersion.length);
          i++) {
        if (int.parse(_localVersion[i]) < int.parse(_storeVersion[i])) {
          isUpdate = true;
          break;
        }
      }
    } catch (error) {
      isUpdate = false;
    }
    printLog("isUpdate--$isUpdate");
    if (isUpdate == true) {
      showDialog<bool>(
        context: context,
        barrierDismissible: true,
        builder: (c) => AlertDialog(
          title: Text('Thông báo'),
          content: Text(
              'Vui lòng cập nhật ứng dụng, hiện đã có phiên bản mới là $versionNew'),
          actions: [
            ElevatedButton(
              child: Text('Huỷ'),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: Text('Cập nhật'),
              onPressed: () async {
                String url;
                if (Platform.isAndroid) {
                  url =
                      "https://play.google.com/store/apps/details?id=${appConfig.appType == AppType.FARMER ? "mcom.asia.bscanqua" : "mcom.asia.bsanqua"}";
                } else {
                  url =
                      "https://apps.apple.com/us/app/${appConfig.appType == AppType.FARMER ? "bệnh-viện-cây-ăn-quả/id1485347190" : "plant-doctor/id1483705696"}";
                }
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
                Platform.isIOS ? exit(0) : SystemNavigator.pop();
              },
            ),
          ],
        ),
      );
    }
  }
}
