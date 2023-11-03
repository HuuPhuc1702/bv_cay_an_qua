import 'package:bv_cay_an_qua/models/setting_model.dart';
import 'package:bv_cay_an_qua/page/home/home_page.dart';
import 'package:bv_cay_an_qua/page/login/controllers/auth_controller.dart';
import 'package:bv_cay_an_qua/repositories/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  PageController pageController = PageController();
  late int currentIndex;
  List<SettingModel> listImage = [];

  @override
  void onInit() async {
    super.onInit();
    getAllSetting();
    currentIndex = 0;
    update();
  }

  void onBack() {
    currentIndex--;
    if (currentIndex < 0) {
      currentIndex = 0;
    }
    jumpPage(currentIndex);
  }

  void onNext() {
    currentIndex++;
    if (currentIndex > listImage.length - 1) {
      currentIndex = listImage.length - 1;
    }
    jumpPage(currentIndex);
  }

  void onSkip() {
    Get.offAll(HomePage());
  }

  void jumpPage(int index) {
    pageController.jumpToPage(index);
  }

  void getAllSetting() async {
    print(
        "------------------------- Fetching setting splash ----------------------");
    var settings = await authRepository.getAllSetting();
    listImage.addAll(settings);
    listImage.retainWhere((element) {
      //print(element);
      if (element.key?.split("_")[0] == "APP") {
        if (element.key?.split("_")[1] == "HDSD") {
          return true;
        }
      }
      return false;
    });

    listImage.retainWhere((element) {
      if (element.value is String) {
        String value = element.value.toString();
        if (value.contains("http")) {
          return true;
        }
      } else if (element.value is List) {
        return true;
      } else if (element.value is Map) {
        return true;
      } else if (element.value is bool) {
        return false;
      }
      return false;
    });

    listImage.sort((a, b) {
      String? compare_1 = a.key?.split("_")[2];
      String? compare_2 = b.key?.split("_")[2];
      if (compare_1 == null || compare_2 == null) {
        return 0;
      }
      return compare_1.compareTo(compare_2);
    });
    print(
        "-------------------------------------${listImage.length}--------------------");
    update();
  }
}
