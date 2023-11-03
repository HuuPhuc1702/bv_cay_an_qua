import 'package:bv_cay_an_qua/export.dart';
import 'package:bv_cay_an_qua/models/user/plant_model.dart';
import 'package:bv_cay_an_qua/page/login/controllers/auth_controller.dart';
import 'package:bv_cay_an_qua/repositories/auth_repo.dart';
import 'package:bv_cay_an_qua/repositories/userpost_repo.dart';
import 'package:bv_cay_an_qua/services/files/service_file.dart';
import 'package:bv_cay_an_qua/shared/helper/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/user_post_model/user_post_model.dart';
import '../../../shared/helper/print_log.dart';

import '../../../services/graphql/crud_repo.dart';
import '../../../services/graphql/graphql_list_load_more_provider.dart';

class UserPostProvider extends CrudRepository<UserPostModel> {
  UserPostProvider() : super(apiName: "UserPost");

  @override
  UserPostModel fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return UserPostModel.fromJson(json);
  }
}

class UserPostController extends GraphqlListLoadMoreProvider<UserPostModel> {
  UserPostModel? detail;
  List<PlantModel> listPants = [PlantModel(name: "Tất cả")];

  static UserPostProvider _provider = UserPostProvider();

  UserPostController({query})
      : super(service: _provider, query: query, fragment: """
        id
        createdAt
        type
        code
        content
        images
        commentIds
        commentCount
        viewCount
        owner{
          profile{
                  id
                  name
                  avatar
                  email
                  phone
                }
        }
          comments{ id createdAt content image replyToId issueId updatedAt
                  rateStats
                  owner{
                    id
                    name
                    phone
                    email
                    profile{
                        ${authRepository.param}
                      }
                  }
        }
         plant{ id name image }
      """);

  refreshData() {
    _provider.clearCache();
    this.loadAll();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getAllPlant();
    update();
  }

  getAllPlant() async {
    listPants = [PlantModel(name: "Tất cả")];
    listPants.addAll(await authRepository.getAllPlant());
  }

  refreshDataDetail() async {
    _provider.clearCache();
    printLog("UserPostController---refreshDataDetail: ${detail?.id}");
    detail = await _provider.getOne(id: detail?.id, fragment: this.fragment);
    update();
  }

  getOneIssue(String id) async {
    detail = null;
    detail = await _provider.getOne(id: id, fragment: this.fragment);
    update();
  }

  createUserPost(
      {String? content = "",
      required BuildContext context,
      String? plantId = "",
      List<String>? images}) async {
    WaitingDialog.show(context);
    String? doctorId;
    if (appConfig.appType == AppType.DOCTOR) {
      doctorId = Get.find<AuthController>().userCurrent.id;
    }
    List<String>? imageNetworks;

    if (images != null) {
      imageNetworks = [];
      for (int i = 0; i < images.length; i++) {
        if (!images[i].contains("http")) {
          await serviceFile.updateImageImgur(images[i], onUpdateImage: (value) {
            if (value != null) imageNetworks!.add(value);
          });
        }
      }
    }
    var data = await userPostRepository.createUserPost(
        images: imageNetworks,
        content: content,
        doctorId: doctorId,
        plantId: plantId);

    WaitingDialog.turnOff();

    if (data) {
      Get.back();
      refreshData();
      showSnackBar(title: "Thông báo", body: "Cập nhật thành công");
    } else {
      showSnackBar(
          title: "Thông báo",
          body: "Cập nhật không thành công",
          backgroundColor: Colors.red);
    }
  }

  updateUserPost(
      {String? content,
      required String userPostId,
      required BuildContext context,
      String? plantId,
      List<String>? images}) async {
    WaitingDialog.show(context);

    List<String>? imageNetworks;
    if (images != null) {
      imageNetworks = [];
      for (int i = 0; i < images.length; i++) {
        if (!images[i].contains("http")) {
          await serviceFile.updateImageImgur(images[i], onUpdateImage: (value) {
            if (value != null) imageNetworks!.add(value);
          });
        }
      }
    }
    var data = await userPostRepository.updateUserPost(
        userPostId: userPostId,
        images: imageNetworks,
        content: content,
        plantId: plantId);
    WaitingDialog.turnOff();
    if (data) {
      Get.back();
      refreshData();
      refreshDataDetail();
      showSnackBar(title: "Thông báo", body: "Cập nhật thành công");
    } else {
      showSnackBar(
          title: "Thông báo",
          body: "Cập nhật không thành công",
          backgroundColor: Colors.red);
    }
  }

  createComment(
      {required BuildContext context,
      String? content = "",
      required String userPostId,
      String? image}) async {
    String? _image;
    WaitingDialog.show(context);
    if (image != null)
      await serviceFile.updateImageImgur(image, onUpdateImage: (value) {
        if (value != null) _image = value;
      });

    var data = await userPostRepository.createComment(
        userPostId: userPostId, content: content, image: _image);
    WaitingDialog.turnOff();

    if (data) {
      refreshData();
      refreshDataDetail();
      showSnackBar(title: "Thông báo", body: "Cập nhật thành công");
    } else {
      showSnackBar(
          title: "Thông báo",
          body: "Cập nhật không thành công",
          backgroundColor: Colors.red);
    }
  }
}
