import '../components/widget_detail.dart';
import 'post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PostDetailPage extends StatelessWidget {
  final String id;
   String? topicId;
  late PostController controller;

  PostDetailPage({Key? key, required this.id, this.topicId})
      : super(key: key) {
    try{
      controller = Get.find<PostController>(tag: this.topicId);
    }catch(error){
      controller=Get.put(PostController());
    }
  }

  double width = 0.0;
  double height = 0.0;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    controller.getOnePost(id);
    return GetBuilder<PostController>(
        tag: this.topicId,
        builder: (controller) {
          return WidgetDetail(
            tag: this.topicId,
            html: controller.postDetail?.content ?? "",
            urlImage: controller.postDetail?.featureImage ?? "",
            publishedAt: controller.postDetail?.publishedAt ?? "",
            title: controller.postDetail?.title ?? "",
            url: controller.postDetail?.url,
            view: controller.postDetail?.view,
            attachments: controller.postDetail?.attachments
          );
        });
  }
}
