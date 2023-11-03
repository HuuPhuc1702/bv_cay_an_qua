import 'package:bv_cay_an_qua/config/app_key.dart';
import 'package:bv_cay_an_qua/config/theme/color-constant.dart';
import 'package:bv_cay_an_qua/page/home/controllers/splash_controller.dart';
import 'package:bv_cay_an_qua/page/login/login_page.dart';
import 'package:bv_cay_an_qua/services/spref.dart';
import 'package:bv_cay_an_qua/shared/widget/widget-button.dart';
import 'package:bv_cay_an_qua/shared/widget/widget-loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//import 'home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashController splashController = Get.find<SplashController>();

  @override
  void initState() {
    super.initState();
    SPref.instance.set(AppKey.firstTime, "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<SplashController>(builder: (splashController) {
          // if (splashController.listImage.isEmpty){
          //   return WidgetLoading()
          // }
          return Padding(
            padding: EdgeInsets.only(
                top: 25,
                bottom: MediaQuery.of(context).padding.bottom + 5,
                left: 15,
                right: 20),
            child: Column(
              children: [
                buildBackIcon(),
                Expanded(child: buildImagesGuide()),
                buildNavigation()
              ],
            ),
          );
        }));
  }

  buildBackIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        splashController.currentIndex != 0
            ? SizedBox(
                height: 50,
                child: IconButton(
                    onPressed: onBack,
                    icon: Icon(Icons.arrow_back_ios_new_rounded,
                        color: Colors.black)))
            : SizedBox(height: 50)
      ],
    );
  }

  buildImagesGuide() {
    return PageView(
        controller: splashController.pageController,
        onPageChanged: (index) {
          setState(() {
            splashController.currentIndex = index;
          });
        },
        children: splashController.listImage.map((e) {
          if (e.value is String) {
            return Image.network(e.value.toString());
          } else if (e.value is List) {
            List<Widget> list = [];
            e.value.forEach((val) {
              list.add(Text(val.toString()));
            });
            return Column(
              children: list,
            );
          } else if (e.value is Map) {
            return Text("FIELD");
          }
          return SizedBox();
        }).toList());
  }

  buildNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
            "${splashController.currentIndex + 1}/${splashController.listImage.length}"),
        Row(
          children: [
            WidgetButton(
                text: "Bỏ qua".toUpperCase(),
                backgroundColor: Colors.white,
                textColor: ColorConst.primaryColor,
                onTap: onSkip),
            SizedBox(width: 10),
            WidgetButton(
              text: "Tiếp tục".toUpperCase(),
              textColor: Colors.white,
              onTap: onNext,
            )
          ],
        )
      ],
    );
  }

  Widget buildNoSplashPage(BuildContext context) {
    return FutureBuilder(
      future: _login(),
      builder: (context, snapshot) {
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<String> _login() async {
    await Future.delayed(Duration(seconds: 1)).then((value) {
      Get.offAll(LoginPage());
    });
    return "Logined";
  }

  void onBack() {
    setState(() {
      splashController.currentIndex--;
      if (splashController.currentIndex < 0) {
        splashController.currentIndex = 0;
      }
    });
    jumpPage(splashController.currentIndex);
  }

  void onNext() {
    print("xxx");
    setState(() {
      splashController.currentIndex++;
      if (splashController.currentIndex >
          splashController.listImage.length - 1) {
        Get.offAll(LoginPage());
        // splashController.currentIndex = splashController.listImage.length - 1;
      }
      jumpPage(splashController.currentIndex);
    });
  }

  void onSkip() {
    Get.offAll(LoginPage());
  }

  void jumpPage(int index) {
    setState(() {
      splashController.pageController.jumpToPage(index);
    });
  }
}
