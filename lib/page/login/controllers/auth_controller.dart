import 'package:bv_cay_an_qua/config/app_key.dart';
import 'package:bv_cay_an_qua/models/topic_model.dart';
import 'package:bv_cay_an_qua/models/user/user_model.dart';
import 'package:bv_cay_an_qua/page/home/home_page.dart';
import 'package:bv_cay_an_qua/page/profile/update_profile_page.dart';
import 'package:bv_cay_an_qua/repositories/auth_repo.dart';
import 'package:bv_cay_an_qua/repositories/category_repo.dart';
import 'package:bv_cay_an_qua/services/firebase/firebase_auth.dart';
import 'package:bv_cay_an_qua/services/spref.dart';
import 'package:bv_cay_an_qua/shared/helper/dialogs.dart';
import 'package:bv_cay_an_qua/shared/helper/information_device.dart';
import 'package:bv_cay_an_qua/shared/helper/print_log.dart';
import 'package:bv_cay_an_qua/shared/widget/widget-combobox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';

import '../../../export.dart';
import '../login_otp_page.dart';
import '../change_pin_page.dart';

class AuthController extends GetxController {
  Position? position;

  List<TopicModel> listTopic = [];
  List<FormComboBox> listDataProvince = [];
  List<FormComboBox> listDataDistrict = [];
  List<FormComboBox> listDataWard = [];

  FormComboBox? provinceModel;
  FormComboBox? districtModel;
  FormComboBox? wardModel;

  User userCurrent = User();

  AuthController() {
    init();
  }

  init() async {
    String? xToken = SPref.instance.get(AppKey.xToken);
    //if (xToken != null && xToken.isNotEmpty) {
    print("-------------------Check if fetching topic or not----------------");
    userGetMe();
    listTopic = await authRepository.getAllTopic();
    //}
    getInfoDevice();
  }

  userUpdateMe(
      {required String name,
      required String address,
      required String area,
      String? provinceId,
      String? province,
      String? districtId,
      String? district,
      String? ward,
      String? wardId,
      String? street,
      bool firstPage = false}) async {
    if (provinceId == null || districtId == null || wardId == null) {
      showSnackBar(
          title: "Thông báo",
          body: "Vui lòng nhập đầy đủ thông tin địa chỉ",
          backgroundColor: Colors.red);
    } else if (name.isEmpty) {
      showSnackBar(
          title: "Thông báo",
          body: "Vui lòng nhập họ và tên.",
          backgroundColor: Colors.red);
    } else {
      var data = await authRepository.userUpdateMe(
          name: name,
          address: address,
          area: area,
          avatar: userCurrent.avatar,
          provinceId: provinceId,
          province: province,
          districtId: districtId,
          district: district,
          ward: ward,
          wardId: wardId,
          street: street);
      if (data.name!.isNotEmpty) {
        await SPref.instance.set(AppKey.staffId, data.id ?? "");
        userCurrent = data;
        if (firstPage) {
          // if (appConfig.appType == AppType.DOCTOR) {
          //   Get.offAll(HomeDoctorPage());
          // } else {
          Get.offAll(HomePage());
          // }
        } else {
          Get.back();
        }
        showSnackBar(title: "Thông báo", body: "Cập nhật thành công");
        update();
      }
    }
  }

  Future<User> userGetMe() async {
    userCurrent = await authRepository.userGetMe();
    await SPref.instance.set(AppKey.staffId, userCurrent.id ?? "");
    await SPref.instance.set(AppKey.staffArea, userCurrent.area.toString());
    await SPref.instance.set(AppKey.staffName, userCurrent.name.toString());
    // print("userGetMe--- ${userCurrent.id}");
    // print("userGetMe--- ${userCurrent.area}");
    printLog("x-token api- ${SPref.instance.get(AppKey.xToken)}");

    update();
    return userCurrent;
  }

  loginByPhonePin(
      {required BuildContext context,
      required String phoneNumber,
      required String pin}) async {
    UserModel data =
        await authRepository.loginByPhonePin(phone: phoneNumber, pin: pin);
    if (data.token != null && data.token!.isNotEmpty) {
      await SPref.instance.set(AppKey.xToken, data.token ?? "");
      printLog("x-token api- ${data.token}");
      try {
        WaitingDialog.turnOff();
        await userGetMe().then((value) {
          if (value.name!.isEmpty) {
            Get.to(UpdateProfilePage(
              firstPage: true,
            ));
          } else {
            // Get.offAll(HomeDoctorPage());
            Get.offAll(HomePage());
          }
        });
      } catch (error) {
        WaitingDialog.turnOff();
      }
    } else {
      WaitingDialog.turnOff();
      showSnackBar(title: "Thông báo", body: "Đăng nhập không thành công.");
    }
  }

  userLoginWithOTP(
      {required BuildContext context,
      required String phoneNumber,
      required String otp}) async {
    UserModel data =
        await authRepository.userLoginWithOTP(phone: phoneNumber, otp: otp);
    if (data.token != null && data.token!.isNotEmpty) {
      await SPref.instance.set(AppKey.xToken, data.token ?? "");
      printLog("x-token api- ${data.token}");
      try {
        WaitingDialog.turnOff();
        await userGetMe().then((value) {
          Get.offAll(ChangePinPage());
        });
      } catch (error) {
        WaitingDialog.turnOff();
      }
    } else {
      WaitingDialog.turnOff();
      showSnackBar(title: "Thông báo", body: "Đăng nhập không thành công.");
    }
  }

  loginSendOTP(
      {required BuildContext context, required String phoneNumber}) async {
    if (phoneNumber.isNotEmpty) {
      WaitingDialog.show(context);
      await ConfigFirebaseAuth.intent.verifyPhoneNumber(phoneNumber,
          (result) async {
        if (result.status == AuthStatus.CodeSent) {
          WaitingDialog.turnOff();
          Get.to(LoginOTPPage(
            phoneNumber: phoneNumber,
            isFb: true,
          ));
        } else {
          try {
            var res = await authRepository.requestOTP(phone: phoneNumber);
            WaitingDialog.turnOff();
            showSnackBar(title: "Thông báo", body: res);
            Get.to(LoginOTPPage(
              phoneNumber: phoneNumber,
              isFb: false,
            ));
          } catch (e) {
            WaitingDialog.turnOff();
            showSnackBar(title: "Thông báo", body: e.toString());
          }
        }
      });
    }
  }

  requestOTP(
      {required BuildContext context, required String phoneNumber}) async {
    if (phoneNumber.isNotEmpty) {
      //WaitingDialog.show(context);
      try {
        var res = await authRepository.requestOTP(phone: phoneNumber);
        if (res != null) {
          WaitingDialog.turnOff();
          showSnackBar(title: "Thông báo", body: res);
          Get.to(LoginOTPPage(
            phoneNumber: phoneNumber,
            isFb: true,
          ));
        }

        WaitingDialog.turnOff();
      } catch (e) {
        WaitingDialog.turnOff();
        showSnackBar(title: "Thông báo", body: e.toString());
      }
    }
  }

  loginEmail(
      {required BuildContext context,
      required String email,
      required String password}) async {
    print("email: $email");
    if (email.isNotEmpty) {
      WaitingDialog.show(context);
      await ConfigFirebaseAuth.intent.verifyEmailVsPassword(email, password,
          (result) async {
        WaitingDialog.turnOff();
        if (result.status == AuthStatus.Verified) {
          printLog("result.token--- ${result.token}");
          UserModel data =
              await authRepository.loginRepo(idToken: result.token ?? "");
          if (data.token != null && data.token!.isNotEmpty) {
            await SPref.instance.set(AppKey.xToken, data.token ?? "");
            await SPref.instance.set(AppKey.email, result.user?.email ?? "");
            printLog("x-token api- ${data.token}");
            try {
              WaitingDialog.turnOff();
              await userGetMe().then((value) {
                if (value.name!.isEmpty) {
                  Get.to(UpdateProfilePage(
                    firstPage: true,
                  ));
                } else {
                  // Get.offAll(HomeDoctorPage());
                  Get.offAll(HomePage());
                }
              });
            } catch (error) {
              WaitingDialog.turnOff();
            }
          } else {
            WaitingDialog.turnOff();
            showSnackBar(
                title: "Thông báo", body: "Đăng nhập không thành công.");
          }
        } else {
          showSnackBar(title: "Thông báo", body: "Đăng nhập không thành công.");
        }
      });
    }
  }

  changePin({required BuildContext context, required String pin}) async {
    var result = await authRepository.updatePin(pin: pin);
    WaitingDialog.turnOff();
    try {
      WaitingDialog.turnOff();
      try {
        await userGetMe().then((value) {
          if (value.name!.isEmpty ||
              value.place?.provinceId == null ||
              value.place?.districtId == null ||
              value.place?.wardId == null ||
              (value.area ?? 0) == 0) {
            Get.to(UpdateProfilePage(
              firstPage: true,
            ));
          } else {
            print("INTO HOMEEEEEEEEE");
            Get.offAll(HomePage());
          }
        });
      } catch (error) {
        WaitingDialog.turnOff();
      }
      showSnackBar(title: "Thông báo", body: "Cập nhật mật khẩu thành công.");
    } catch (e) {
      WaitingDialog.turnOff();
      showSnackBar(title: "Thông báo", body: e.toString());
    }
  }

  changePassword(
      {required BuildContext context,
      required String passwordOld,
      required String passwordNew1,
      required String passwordNew2}) async {
    WaitingDialog.show(context);
    if (passwordNew1 != passwordNew2) {
      WaitingDialog.turnOff();
      showSnackBar(
          title: "Thông báo", body: "Nhập lại mật khẩu mới chưa chính xác.");
    }
    await ConfigFirebaseAuth.intent.changePassword(
        userCurrent.email!, passwordOld, passwordNew1, (result) async {
      WaitingDialog.turnOff();
      if (result.status == AuthStatus.Verified) {
        WaitingDialog.turnOff();
        Get.back();
        showSnackBar(title: "Thông báo", body: "Cập nhật thành thành công.");
      } else {
        WaitingDialog.turnOff();
        showSnackBar(title: "Thông báo", body: "Mật khẩu không chính xác.");
      }
    });
  }

  loginConform({
    required String phone,
    required String code,
    required BuildContext context,
  }) async {
    WaitingDialog.show(context);
    ConfigFirebaseAuth.intent.validateCode(code, (result) async {
      print(result.status);
      if (result.status == AuthStatus.Verified) {
        UserModel data =
            await authRepository.loginRepo(idToken: result.token ?? "");
        if (data.token != null && data.token!.isNotEmpty) {
          await SPref.instance.set(AppKey.xToken, data.token ?? "");
          await SPref.instance.set(AppKey.phoneNumber, phone);
          WaitingDialog.turnOff();
          Get.to(ChangePinPage());
        } else {
          WaitingDialog.turnOff();
          showSnackBar(
              title: "Thông báo",
              body: "Xác thực không thành công vui lòng thử lại sau.");
        }
      } else {
        WaitingDialog.turnOff();
        showSnackBar(title: "Thông báo", body: "Mã OTP không chính xác");
      }
    });
  }

  logout() {
    SPref.instance.clear();
    userCurrent = User();
  }

  //region quận huyện, phường, đường

  getProvince({String? provinceId}) async {
    listDataProvince = [];
    var data = await categoryRepository.getProvince();
    if (data.length > 0) {
      data.forEach((element) {
        listDataProvince.add(FormComboBox(
            key: element.id,
            title: element.province ?? "",
            id: element.id ?? ""));
      });
      if (provinceId != null) {
        provinceModel = listDataProvince
            .firstWhereOrNull((element) => element.id == provinceId);
        print("provinceModel---- ${provinceModel?.title}");
        print("provinceModel---- ${provinceId}");
      }
      update();
    }
  }

  getDistrict(String provinceId, {String? districtId}) async {
    listDataDistrict = [];
    var data = await categoryRepository.getDistrict(provinceId: provinceId);
    if (data.length > 0) {
      data.forEach((element) {
        listDataDistrict.add(FormComboBox(
            key: element.id,
            title: element.district ?? "",
            id: element.id ?? ""));
      });
      if (districtId != null) {
        districtModel = listDataDistrict
            .firstWhereOrNull((element) => element.id == districtId);
      }
      update();
    }
  }

  getWard(String districtId, {String? wardId}) async {
    listDataWard = [];
    var data = await categoryRepository.getWard(districtId: districtId);
    if (data.length > 0) {
      data.forEach((element) {
        listDataWard.add(FormComboBox(
            key: element.id, title: element.ward ?? "", id: element.id ?? ""));
      });
      if (wardId != null) {
        wardModel =
            listDataWard.firstWhereOrNull((element) => element.id == wardId);
      }
      update();
    }
  }
//endregion
}
