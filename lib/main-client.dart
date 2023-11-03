import 'package:bv_cay_an_qua/config/theme/color-constant.dart';
import 'package:bv_cay_an_qua/models/user/user_model.dart';
import 'package:bv_cay_an_qua/page/home/controllers/splash_controller.dart';
import 'package:bv_cay_an_qua/page/home/home_page.dart';
import 'package:bv_cay_an_qua/page/home/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app_config.dart';
import 'config/app_key.dart';
import 'page/login/controllers/auth_controller.dart';
import 'page/login/login_page.dart';
import 'services/firebase/firebase_auth.dart';
import 'services/firebase/firebase_messages.dart';
import 'services/spref.dart';
import 'shared/helper/permission.dart';

// List<CameraDescription> cameras = [];
//

void main() async {
  appConfig = AppConfig(appName: "", appType: AppType.FARMER);
  WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.bottom]);
  await Firebase.initializeApp();
  await SPref.init();
  await ConfigFirebaseMessages.init();

  // cameras = await availableCameras();
  await SentryFlutter.init(
    (options) {
      print("init sentry");

      options.dsn =
          'https://9e4c4de24fdd405597900f65a4648fb4@o1286215.ingest.sentry.io/6538293';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      //options.release = 'bv-cayanqua-app@1.2.13+114';
      options.sampleRate = 1.0;
      options.autoSessionTrackingIntervalMillis = 60000;
      options.debug = true;
      options.diagnosticLevel = SentryLevel.debug;
    },
    appRunner: () => runApp(MyApp()),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    ConfigFirebaseMessages.initEvent(context);
    Get.put(AuthController());
    Get.put(SplashController());
    ConfigFirebaseAuth.intent.auth.authStateChanges().listen((user) {
      if (user != null) {
        print("authStateChanges---${user.phoneNumber}");
      } else {
        print("authStateChanges---null");
      }
    });
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      supportedLocales: [
        const Locale('en'), // English
        const Locale('vi'), // VietNam
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      theme: ThemeData(
          primarySwatch: Colors.blue, primaryColor: ColorConst.primaryColor),
      home: checkFirst(),
      // home: NavigatorBottomPage(),
    );
  }

  Widget checkFirst() {
    String? xToken = SPref.instance.get(AppKey.xToken);
    String name = SPref.instance.get(AppKey.staffName) ?? "";
    String area = SPref.instance.get(AppKey.staffArea) ?? "";
    String firstTime = SPref.instance.get(AppKey.firstTime);

    // print("Check first time $firstTime");
    // print("Check xToken $xToken");
    // print("Check area $area");

    // String? staffId = SPref.instance.get(AppKey.staffId);
    return GetBuilder<SplashController>(builder: (splashController) {
      if (firstTime == "true" && splashController.listImage.length > 0) {
        print(
            "Check splash listimage length ${splashController.listImage.length}");
        return SplashPage();
      }
      if (xToken != null && xToken.isNotEmpty) {
        if (name.isEmpty && area == "0") {
          // print("INTO LOGIN");
          return LoginPage();
        } else {
          bool isExpired = Jwt.isExpired(xToken);
          print("=======================================");
          print(isExpired);
          if (isExpired) {
            Get.find<AuthController>().logout();
            return LoginPage();
          }
        }
        // print("INTO HOME");
        return HomePage();
      } else {
        // print("INTO LOGIN");
        return LoginPage();
      }
    });
  }
}
