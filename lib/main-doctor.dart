import 'package:bv_cay_an_qua/models/user/user_model.dart';
import 'package:jwt_decode/jwt_decode.dart';

import 'config/theme/color-constant.dart';
import 'page/home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'app_config.dart';
import 'config/app_key.dart';
import 'page/login/controllers/auth_controller.dart';
import 'page/login/login_doctor_page.dart';
import 'services/firebase/firebase_auth.dart';
import 'services/firebase/firebase_messages.dart';
import 'services/spref.dart';

void main() async {
  appConfig = AppConfig(appName: "", appType: AppType.DOCTOR);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SPref.init();
  await ConfigFirebaseMessages.init();

  // cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ConfigFirebaseMessages.initEvent(context);
    Get.put(AuthController());
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

    // String? staffId = SPref.instance.get(AppKey.staffId);
    if (xToken != null && xToken.isNotEmpty) {
      if (name.isEmpty && area == "0") {
        return LoginDoctorPage();
        // return UpdateProfilePage();
      } else {
        bool isExpired = Jwt.isExpired(xToken);
        print("=======================================");
        print(isExpired);
        if (isExpired) {
          Get.find<AuthController>().logout();
          return LoginDoctorPage();
        }
      }
      // return HomeDoctorPage();
      return HomePage();
    } else {
      return LoginDoctorPage();
    }
  }
}
