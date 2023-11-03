import 'dart:async';

import 'package:bv_cay_an_qua/app_config.dart';
import 'package:bv_cay_an_qua/models/banner_model.dart';
import 'package:bv_cay_an_qua/page/components/banner_widget.dart';
import 'package:bv_cay_an_qua/page/home/components/contact/conntac_page.dart';
import 'package:bv_cay_an_qua/page/home/components/hospital_system/hospital_system_page.dart';
import 'package:bv_cay_an_qua/page/home/components/introduce/introduce_page.dart';
import 'package:bv_cay_an_qua/page/home/history_activity_page.dart';
import 'package:bv_cay_an_qua/page/issue/issue_doctor_page.dart';
import 'package:bv_cay_an_qua/page/issue/issue_page.dart';
import 'package:bv_cay_an_qua/page/library/library_page.dart';
import 'package:bv_cay_an_qua/page/login/controllers/auth_controller.dart';
import 'package:bv_cay_an_qua/page/news/news_share_page.dart';
import 'package:bv_cay_an_qua/page/post/post_page.dart';
import 'package:bv_cay_an_qua/page/technical_document/technical_document_page.dart';
import 'package:bv_cay_an_qua/page/video/video_group_page.dart';
import 'package:bv_cay_an_qua/page/vxmm/vxmm_page.dart';
import 'package:bv_cay_an_qua/repositories/auth_repo.dart';
import 'package:bv_cay_an_qua/shared/helper/permission.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ItemHome {
  final String title;
  final String assetsIcon;
  final Function onTap;
  final bool? isHot;

  ItemHome(
      {required this.title,
      required this.assetsIcon,
      required this.onTap,
      this.isHot});
}

class HomeController extends GetxController {
  List<BannerModel> listBanner = [];
  List<ItemHome> listItemHome = [];

  AuthController authController = Get.find<AuthController>();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    initItemHome();
    await authController.userGetMe();
    update();
    permissionInit();
  }

  getBanner(BuildContext context) {
    Timer.run(() async {
      await authRepository.getAllBanner(type: "POPUP").then((_) {
        listBanner = _;
        print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
        print(listBanner.length);
        if (listBanner.length >= 1)
          showPopup(context: context, listBanner: listBanner);
      });
    });
  }

  void initItemHome() {
    if (appConfig.appType == AppType.FARMER) {
      listItemHome.add(ItemHome(
          title: "Giới thiệu",
          assetsIcon: "assets/icons/dashboard/1.png",
          onTap: () {
            Get.to(IntroducePage());
          }));
      listItemHome.add(ItemHome(
          title: "Hệ thống bệnh viện",
          assetsIcon: "assets/icons/dashboard/2.png",
          onTap: () {
            Get.to(HospitalSystemPage());
          }));
      listItemHome.add(ItemHome(
          title: "Tin tức - góc chia sẻ",
          assetsIcon: "assets/icons/dashboard/3.png",
          onTap: () {
            Get.to(NewsSharePage(
              title: "Tin tức - góc chia sẻ",
            ));
          }));
      listItemHome.add(ItemHome(
          title: "Dự báo nông nghiệp",
          assetsIcon: "assets/icons/dashboard/20.png",
          onTap: () {
            Get.to(TechnicalDocumentPage(
              tags: ["du-bao-nong-nghiep"],
              title: "Dự báo nông nghiệp",
            ));
          }));
      listItemHome.add(ItemHome(
          title: "Thư viện",
          assetsIcon: "assets/icons/dashboard/18.png",
          onTap: () {
            Get.to(LibraryPage());
          }));
      listItemHome.add(ItemHome(
          title: "Video",
          assetsIcon: "assets/icons/dashboard/5.png",
          onTap: () {
            Get.to(VideoGroupPage());
          }));
      listItemHome.add(ItemHome(
          title: "Phác đồ điều trị",
          assetsIcon: "assets/icons/dashboard/6.png",
          onTap: () {
            Get.to(PostPage(
              topicID: (authController.listTopic.firstWhere(
                  (element) => element.slug == "phac-do-dieu-tri")).id,
              title: "Phác đồ điều trị",
            ));
          }));
      listItemHome.add(ItemHome(
          title: "Hỏi đáp",
          assetsIcon: "assets/icons/dashboard/7.png",
          onTap: () {
            Get.to(IssuePage());
          }));
      listItemHome.add(ItemHome(
          title: "Liên hệ",
          assetsIcon: "assets/icons/dashboard/8.png",
          onTap: () {
            Get.to(ContactPage());
          }));
      listItemHome.add(ItemHome(
          title: "Câu hỏi thường gặp",
          assetsIcon: "assets/icons/dashboard/12.png",
          onTap: () {
            Get.to(TechnicalDocumentPage(
              tags: ["cau-hoi-thuong-gap"],
              title: "Câu hỏi thường gặp",
            ));
          }));
      listItemHome.add(ItemHome(
          title: "Chương trình khuyến mãi",
          assetsIcon: "assets/icons/icon_khuyen_mai.png",
          isHot: true,
          onTap: () {
            Get.to(VXMMPage(
              tags: ["chuong-trinh-khuyen-mai"],
              title: "Chương trình khuyến mãi",
            ));
          }));
    } else {
      listItemHome.add(ItemHome(
          title: "Hỏi và đáp",
          assetsIcon: "assets/icons/dashboard/7.png",
          onTap: () {
            Get.to(IssueDoctorPage());
          }));
      listItemHome.add(ItemHome(
          title: "Thư viện",
          assetsIcon: "assets/icons/dashboard/18.png",
          onTap: () {
            Get.to(LibraryPage());
          }));
      listItemHome.add(ItemHome(
          title: "Lịch sử hoạt động",
          assetsIcon: "assets/icons/dashboard/6.png",
          onTap: () {
            Get.to(HistoryActivity());
            // Get.to(IssueDoctorPage(tag: "lich-su-hoat-dong",queryInput: QueryInput(
            //   filter: {
            //     "prescription.status":"assigning"
            //   }
            // ),));
          }));

      listItemHome.add(ItemHome(
          title: "Tin tức & góc chia sẻ",
          assetsIcon: "assets/icons/dashboard/3.png",
          onTap: () {
            Get.to(NewsSharePage(
              title: "Tin tức - góc chia sẻ",
            ));

            // Get.to(PostPage(
            //   topicID: (authController.listTopic
            //       .firstWhere((element) => element.slug == "tin-tuc")).id,
            //   title: "Tin tức - kinh nghiệm nhà nông",
            // ));
          }));
      listItemHome.add(ItemHome(
          title: "Video",
          assetsIcon: "assets/icons/dashboard/5.png",
          onTap: () {
            Get.to(VideoGroupPage());
          }));
      listItemHome.add(ItemHome(
          title: "Câu hỏi thường gặp",
          assetsIcon: "assets/icons/dashboard/12.png",
          onTap: () {
            Get.to(TechnicalDocumentPage(
              tags: ["cau-hoi-thuong-gap"],
              title: "Câu hỏi thường gặp",
            ));
          }));
    }
    update();
  }
}
