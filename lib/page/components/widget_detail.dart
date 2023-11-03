import 'package:bv_cay_an_qua/models/issue/attachment_model.dart';
import 'package:bv_cay_an_qua/shared/helper/print_log.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_image_network.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../../export.dart';
import 'image_picker.dart';
import 'zoom_webview.dart';

class WidgetDetail extends StatelessWidget {
  ScrollController? scrollController;
  String? tag;
  final String title;
  final String html;
  final String urlImage;
  final String publishedAt;
  final String? url;
  final num? view;
  final List<AttachmentModel>? attachments;

  WidgetDetail(
      {Key? key,
      this.tag,
      this.scrollController,
      required this.urlImage,
      required this.title,
      required this.publishedAt,
      this.url,
      this.view,
      this.attachments,
      required this.html})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverPersistentHeader(
              delegate: MySliverAppBar(
                  expandedHeight: 300,
                  title: title,
                  url: url,
                  publishedAt: publishedAt,
                  view: view,
                  urlImage: urlImage),
              pinned: true,
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: ZoomWebView(html: "$html", tag: tag, attachments: attachments),
        ),
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  String? urlImage;
  String? title;
  String? publishedAt;
  String? url;
  num? view;

  MySliverAppBar(
      {required this.expandedHeight,
      this.urlImage,
      this.title,
      this.url,
      this.view,
      this.publishedAt});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.passthrough,
      clipBehavior: Clip.none,
      children: [
        (urlImage != null && urlImage!.isNotEmpty)
            ? ImagePickerWidget(
                context: context,
                size: expandedHeight -
                    50 -
                    (shrinkOffset >= 250 ? shrinkOffset - 50 : shrinkOffset),
                resourceUrl: urlImage ?? "",
                quality: 1080,
              )
            : Container(
                child: Image.asset(
                  AssetsConst.errorPlaceHolder,
                  fit: BoxFit.cover,
                ),
              ),
        Opacity(
            opacity: shrinkOffset / expandedHeight,
            child: Container(
              padding: EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: ColorConst.primaryColor,
                    width: 8,
                  ),
                ),
              ),
              height: expandedHeight + 8,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 8.0, bottom: 8, left: 16, right: 8),
                      child: Image.asset(
                        "assets/images/ic_back.png",
                        fit: BoxFit.cover,
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  title ?? "",
                                  style: StyleConst.boldStyle(
                                      fontSize: supTitleSize),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  publishedAt ?? '',
                                  style: StyleConst.regularStyle(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (url != null) {
                                Share.share(url ?? "");
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(
                                Icons.ios_share,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
        Positioned(
          top: kToolbarHeight - 14,
          left: 0,
          child: Opacity(
            opacity: 1 - shrinkOffset / expandedHeight > 0.2
                ? 1 - shrinkOffset / expandedHeight
                : 0,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding:
                    EdgeInsets.only(top: 0.0, bottom: 8, left: 16, right: 8),
                child: Image.asset(
                  "assets/images/ic_back.png",
                  fit: BoxFit.cover,
                  width: 30,
                  height: 30,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: expandedHeight - 50 - shrinkOffset - 60,
          // left: MediaQuery.of(context).size.width / 4,
          child: Opacity(
              opacity: 1 - shrinkOffset / expandedHeight > 0.3
                  ? 1 - shrinkOffset / expandedHeight
                  : 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Material(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    animationDuration: Duration(milliseconds: 500),
                    elevation: 2.0,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            title ?? "",
                            style: StyleConst.boldStyle(fontSize: titleSize),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              children: [
                                Text(
                                  publishedAt ?? '',
                                  style: StyleConst.regularStyle(
                                      fontSize: miniSize),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: Text(
                                    view != null ? "Số lượt xem: $view" : "",
                                    style: StyleConst.regularStyle(
                                        fontSize: miniSize),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (url != null) {
                                      Share.share(url ?? "");
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Icon(
                                      Icons.ios_share,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 40;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
