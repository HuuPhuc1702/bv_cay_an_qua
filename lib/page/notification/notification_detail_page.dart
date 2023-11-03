import 'package:bv_cay_an_qua/config/theme/color-constant.dart';
import 'package:bv_cay_an_qua/config/theme/size-constant.dart';
import 'package:bv_cay_an_qua/config/theme/style-constant.dart';
import 'package:bv_cay_an_qua/page/components/image_picker.dart';
import 'package:bv_cay_an_qua/page/components/widget_detail.dart';
import 'package:bv_cay_an_qua/page/components/zoom_webview.dart';
import 'package:bv_cay_an_qua/page/notification/notification_controller.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_image_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationDetailPage extends StatelessWidget {
  final String id;

  NotificationDetailPage({Key? key, required this.id}) : super(key: key);

  double width = 0.0;
  double height = 0.0;

  ScrollController scrollController = ScrollController();

  NotificationController notificationController =
      Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    notificationController.getOneNotification(id, context);

    return GetBuilder<NotificationController>(builder: (controller) {
      return WidgetDetail(
        html: controller.notificationDetail?.body ?? "",
        urlImage: controller.notificationDetail?.image ?? "",
        publishedAt: controller.notificationDetail?.createdAt ?? "",
        title: controller.notificationDetail?.title ?? "",
        scrollController: scrollController,
      );
    });
  }
}
