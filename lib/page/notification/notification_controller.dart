import 'package:bv_cay_an_qua/models/notification_model.dart';
import 'package:bv_cay_an_qua/page/home/controllers/home_controller.dart';
import 'package:bv_cay_an_qua/page/issue/issue_detail_page.dart';
import 'package:bv_cay_an_qua/page/login/controllers/auth_controller.dart';
import 'package:bv_cay_an_qua/page/post/post_detail_page.dart';
import 'package:bv_cay_an_qua/repositories/notification_repo.dart';
import 'package:bv_cay_an_qua/services/graphql/crud_repo.dart';
import 'package:bv_cay_an_qua/services/graphql/graphql_list_load_more_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'notification_detail_page.dart';

class NotificationController
    extends GraphqlListLoadMoreProvider<NotificationModel> {
  static NotificationProvider _notificationProvider = NotificationProvider();
  static QueryInput _queryInput = QueryInput(order: {"_id": -1});

  NotificationController({query})
      : super(
            service: _notificationProvider,
            query: query ?? _queryInput,
            fragment: """
      id
      createdAt
      title
      body
      image
      seen
      action{
        type
        link
        postId
        issueId
      }
  """);

  NotificationModel? notificationDetail;

  getOneNotification(String id, BuildContext context) async {
    notificationDetail = null;
    readNotification(id);
    try {
      notificationDetail =
          await _notificationProvider.getOne(id: id, fragment: this.fragment);
    } catch (error) {
      print("getOneNotification-----$error");
    }
    update();
  }

  readAllNotification() async {
    var data = await notificationRepository.readAllNotification();
    if (data == true) {
      refreshData();
      update();
    }
  }

  readNotification(String id) async {
    var data = await notificationRepository.readNotification(id);
    if (data.id != null && data.id!.isNotEmpty) {
      refreshData();
      try {
        Get.find<AuthController>().userGetMe();
      } catch (error) {
        print("readNotification---$error");
      }
    }
    update();
  }

  refreshData() async {
    await _notificationProvider.clearCache();
    this.loadAll(query: QueryInput(limit: 10, page: 1, order: {"_id": -1}));
  }

  search(String value) async {
    _notificationProvider.clearCache();
    this.loadAll(
        query: QueryInput(
            limit: 10, page: 1, order: {"_id": -1}, search: "$value"));
  }

  itemClick({NotificationModel? notify}) async {
    readNotification(notify?.id ?? "");
    print("xxx");
    if (notify?.action != null) {
      if (notify?.action?.type == "ISSUE") {
        Get.to(IssueDetailPage(
          id: notify?.action?.issueId ?? "",
          tag: "",
        ));
        return;
      }
      if (notify?.action?.type == "POST") {
        Get.to(PostDetailPage(id: notify?.action?.postId ?? ""));
        return;
      }
    }
    Get.to(NotificationDetailPage(
      id: notify?.id ?? "",
    ));
  }
}

class NotificationProvider extends CrudRepository<NotificationModel> {
  NotificationProvider() : super(apiName: "Notification");

  @override
  NotificationModel fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return NotificationModel.fromJson(json);
  }
}
