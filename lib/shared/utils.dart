// import 'package:flutter/material.dart';
// import 'package:loctroi_cayluav2/apis/core/errors.dart';
// import 'package:loctroi_cayluav2/localizations/message_localizations.dart';
// import 'package:loctroi_cayluav2/ui/customs/dialog.dart';
// import 'package:loctroi_cayluav2/ui/pages/login_page.dart';
// import 'package:loctroi_cayluav2/ui/route/routing.dart';
// import 'package:intl/intl.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  static openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}

class Utils {
  static String securityPhone(String phone) {
    print('security nè');
    String phoneResult = phone.trim();
    int maxIndex = phoneResult.length;
    String strX = '';
    for (int i = 0; i < maxIndex - 3; i++) {
      strX += 'x';
    }
    phoneResult = strX + phoneResult.substring(maxIndex - 3, maxIndex);

    return phoneResult;
  }
}

bool compareContainsNoneAccent(String a, String b) {
  return (a.toLowerCase()).contains((b.toLowerCase()));
}
