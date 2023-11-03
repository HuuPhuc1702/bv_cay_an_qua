import 'dart:async';
import 'dart:convert';

import 'package:bv_cay_an_qua/config/backend.dart';
import 'package:bv_cay_an_qua/page/issue/issue_detail_page.dart';
import 'package:bv_cay_an_qua/page/login/controllers/auth_controller.dart';
import 'package:bv_cay_an_qua/page/notification/notification_controller.dart';
import 'package:bv_cay_an_qua/page/notification/notification_detail_page.dart';
import 'package:bv_cay_an_qua/page/post/post_detail_page.dart';
import 'package:bv_cay_an_qua/repositories/auth_repo.dart';
import 'package:bv_cay_an_qua/shared/helper/print_log.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../config/app_key.dart';
import '../../export.dart';
import '../../services/spref.dart';
import 'firebase_auth.dart';

class ConfigFirebaseMessages {
  static String _vapidKey =
      // "AAAATKunCTo:APA91bH6AWumS9ZkQpgAEH-OZgNFY1obHdOuQy-kN4l197qCwLUo9-3lyGQhGeXtgju8AwAstfuE1CQsNIILOyoWXW4AxdZaziHSLsA0zn_3Sfz07dHMDNVjU9yKSGFdcOzeJwHctjc_";
      "AAAAIKZLozY:APA91bHghBJ3HlJoacfUlumXrpq9IqF60KqMM579Lhvj2F_jhRiuuqVKBLL9TrTV-c7lVGAhlhunjfVhyIVQHdrqmblbL6updeeXJDcG00HAoqk7rmDVscsrzxBG2e-65T3_NGfb56pr";

  static init() async {
    PermissionHelper.init();

    // WidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    // Elsewhere in your code
    // FirebaseCrashlytics.instance.crash();
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.subscribeToTopic("mcom.asia.bvanqua");
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

    // Set the background messaging handler early on, as a named top-level function
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    // await getToken();

    FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(seconds: 5),
    ));
    // remoteConfig.setDefaults(<String, dynamic>{
    //   'backend': 'host default',
    // });
    RemoteConfigValue(null, ValueSource.valueStatic);
    bool updated = await remoteConfig.fetchAndActivate();

    String httpKey = "http_product";
    String apiKey = "api_product";
    String wssKey = "wss_product";
    // String httpKey = "http_dev";
    // String apiKey = "api_dev";
    // String wssKey = "wss_dev";

    if (updated) {
      // the config has been updated, new parameter values are available.
      print(" BACKEND_HTTP1----- ${remoteConfig.getString(httpKey)}");
      print(" BACKEND_API1----- ${remoteConfig.getString(apiKey)}");
      print(" BACKEND_WSS1----- ${remoteConfig.getString(wssKey)}");
      if (remoteConfig.getString(httpKey).isNotEmpty) {
        BackendHost.BACKEND_HTTP = remoteConfig.getString(httpKey);
      }
      if (remoteConfig.getString(wssKey).isNotEmpty) {
        BackendHost.BACKEND_WSS = remoteConfig.getString(wssKey);
      }
      if (remoteConfig.getString(apiKey).isNotEmpty) {
        BackendHost.BACKEND_API = remoteConfig.getString(apiKey);
      }
    } else {
      // the config values were previously updated.
      print(" BACKEND_HTTP2----- ${remoteConfig.getString(httpKey)}");
      print(" BACKEND_API2----- ${remoteConfig.getString(apiKey)}");
      print(" BACKEND_WSS2----- ${remoteConfig.getString(wssKey)}");
      if (remoteConfig.getString(httpKey).isNotEmpty) {
        BackendHost.BACKEND_HTTP = remoteConfig.getString(httpKey);
      }
      if (remoteConfig.getString(wssKey).isNotEmpty) {
        BackendHost.BACKEND_WSS = remoteConfig.getString(wssKey);
      }
      if (remoteConfig.getString(apiKey).isNotEmpty) {
        BackendHost.BACKEND_API = remoteConfig.getString(apiKey);
      }
    }
  }

  static initEvent(BuildContext context) async {
    FirebaseMessaging.instance.getInitialMessage().then((value) async {
      printLog("getInitialMessage ------------ ${value?.data["body"]}");
      if (value != null) _openPage(value);
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        printLog("onMessage------------ ${message.data["action"]}");
        // await  _showNotificationCustomSound();
        // NotifyEvent.callListener(key: "NotificationPage", dataValue: "");

        //action: {"_id":"61890620b257b81b9c420419","type":"ISSUE","issueId":"6189061fb257b8d3a5420413"}
        Get.find<AuthController>().userGetMe();
        showSnackBar(
            title: "${message.notification?.title ?? ""}",
            body: "${message.notification?.body ?? ""}",
            onTap: (GetBar<Object> data) {
              _openPage(message);
            });
      }
    });

    FirebaseMessaging.onBackgroundMessage((message) async {
      printLog("onBackgroundMessage-----");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      printLog(
          'A new onMessageOpenedApp event was published!!!!!!!!!!!!!!!!!!!!!!!!!!');

      printLog("message.data---${message.data["notifyId"]}");
      printLog("message.data---${message.data}");
      _openPage(message);
    });
  }

  static _openPage(RemoteMessage message) {
    if (message.data["action"] != null) {
      var action = jsonDecode(message.data["action"]) as Map<String, dynamic>;
      if (action["type"] == "ISSUE") {
        Get.to(IssueDetailPage(
          id: action["issueId"] ?? "",
          tag: "",
        ));
        return;
      }
      if (action["type"] == "POST") {
        Get.to(PostDetailPage(id: action["postId"] ?? ""));
        return;
      }
    }
    if (message.data["notifyId"] != null) {
      Get.put(NotificationController());
      Get.to(NotificationDetailPage(
        id: message.data["notifyId"],
      ));
    }
  }

  /// Define a top-level named handler which background/terminated messages will
  /// call.
  ///
  /// To verify things are working, check out the native platform logs.
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();
    printLog('Handling a background message ${message.messageId}');
  }

  static getToken() async {
    var userCredential = ConfigFirebaseAuth.intent.auth.currentUser;
    String? idToken = await userCredential?.getIdToken();
    await FirebaseMessaging.instance
        .getToken(vapidKey: _vapidKey)
        .then((value) async {
      printLog("idToken: $idToken");
      printLog("firebase token: $value");
      printLog("firebase token old: ${SPref.instance.get(AppKey.deviceToken)}");

      // await SPref.instance.set(AppKey.deviceToken, value ?? "");

      if (value != null &&
          SPref.instance.get(AppKey.deviceToken).toString().isNotEmpty &&
          SPref.instance.get(AppKey.deviceToken) != value) {
        if (idToken != null) {
          await SPref.instance.set(AppKey.deviceToken, value);
          printLog(
              "firebase token old2: ${SPref.instance.get(AppKey.deviceToken)}");
          var data = await authRepository.loginRepo(idToken: idToken);
          if (data.token != null && data.token!.isNotEmpty) {
            await SPref.instance.set(AppKey.xToken, data.token ?? "");
          }
        }
      } else {
        if (value != null && SPref.instance.get(AppKey.deviceToken) != value) {
          await SPref.instance.set(AppKey.deviceToken, value);
          printLog(
              "firebase token old2: ${SPref.instance.get(AppKey.deviceToken)}");
        }
      }

      return value;
    });
  }

  static refreshToken() async {
    print(
        "refreshToken token: --------------------------------------------------");
    FirebaseMessaging.instance.onTokenRefresh.listen((event) {
      print("refresh token: $event");
    });
  }
}

class PermissionHelper {
  static init() async {
    if (await Permission.notification.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      // You can request multiple permissions at once.
      Map<Permission, PermissionStatus> statuses =
          await [Permission.notification].request();
      print("statuses[Permission.location]-----");
    }
  }
}
