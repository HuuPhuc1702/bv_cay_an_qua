import 'package:bv_cay_an_qua/config/theme/style-constant.dart';
import 'package:bv_cay_an_qua/export.dart';
import 'package:bv_cay_an_qua/models/banner_model.dart';
import 'package:bv_cay_an_qua/page/post/post_detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

showPopup(
    {required List<BannerModel> listBanner, required BuildContext context}) {
  Size size = MediaQuery.of(context).size;

  print(listBanner.length);
  if (listBanner.length == 0) return;
  showGeneralDialog(
    context: context,
    barrierColor: Colors.black38,
    // background color
    barrierDismissible: true,
    // should dialog be dismissed when tapped outside
    barrierLabel: "Dialog",
    // label for barrier
    transitionDuration: Duration(milliseconds: 400),
    // how long it takes to popup dialog after button click
    pageBuilder: (_, __, ___) {
      return Center(
        child: Container(
          height: 400,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  CarouselSlider(
                    options: CarouselOptions(
                        height: 400.0,
                        viewportFraction: 1.0,
                        enlargeCenterPage: false,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800)),
                    items: listBanner.map((item) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Material(
                            color: Colors.transparent,
                            child: Container(
                                width: size.width - 80,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        width: size.width,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            topLeft: Radius.circular(20),
                                          ),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: CachedNetworkImageProvider(
                                                (item.image != null &&
                                                        item.image!
                                                            .contains("http"))
                                                    ? item.image.toString()
                                                    : 'https://www.how2shout.com/wp-content/uploads/2018/09/Internet-Access-Error-1200x900.jpg',
                                              )),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(
                                        10,
                                      ),
                                      child: WidgetButton(
                                        text: "Xem chi tiết".toUpperCase(),
                                        textColor: Colors.white,
                                        onTap: () async {
                                          Navigator.pop(context);
                                          if (item.action?.type == "WEBSITE" &&
                                              item.action?.link != null) {
                                            await canLaunch(
                                                    item.action!.link ?? "")
                                                ? await launch(
                                                    item.action!.link ?? "")
                                                : throw 'Could not launch ${item.action!.link ?? ""}';
                                          }
                                          if (item.action?.type == "POST") {
                                            Get.to(PostDetailPage(
                                                id: item.action?.postId ?? ""));
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                          );
                        },
                      );
                    }).toList(),
                  )
                ],
              ),
              Positioned(
                top: 3,
                right: 40,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.close,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
