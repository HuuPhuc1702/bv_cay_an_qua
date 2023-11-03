import 'package:bv_cay_an_qua/export.dart';
import 'package:bv_cay_an_qua/models/issue/attachment_model.dart';
import 'package:bv_cay_an_qua/page/post/post_controller.dart';
import 'package:bv_cay_an_qua/services/files/service_file.dart';
import 'package:bv_cay_an_qua/shared/helper/dialogs.dart';
import 'package:bv_cay_an_qua/shared/helper/print_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:rxdart/subjects.dart';

import 'zoom_image_asset.dart';

class ZoomWebView extends StatefulWidget {
  String? html;
  String? tag;
  List<AttachmentModel>? attachments;
  double paddingBottom;

  ZoomWebView(
      {Key? key,
      this.html = '',
      this.tag,
      this.paddingBottom = 10,
      this.attachments})
      : super(key: key);

  _ZoomWebViewState createState() => _ZoomWebViewState();
}

class _ZoomWebViewState extends State<ZoomWebView> {
  // ignore: close_sinks
  final _htmlFontBehavior = BehaviorSubject<double>.seeded(22);
  double fontSlider = defaultSize;
  // static final double MIN_FONT = 22;
  // static final double MAX_FONT = 41;

  late ScrollController scrollController;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() => setState(() {}));
  }

  Widget build(BuildContext context) {
    String? htmlContent = widget.html ?? '';
    htmlContent = htmlContent.replaceAll(
        "<p style=\"text-align:justify;\">&nbsp;</p>",
        "<p style=\"margin-left:0px;text-align:justify;\"><br></p>");
    htmlContent = htmlContent.replaceAll(
        "<p style=\"margin-left:0px;text-align:justify;\">&nbsp;</p>",
        "<p style=\"margin-left:0px;text-align:justify;\"><br></p>");
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder<double>(
                  stream: _htmlFontBehavior.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData == false) return Container();
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 0, bottom: 30),
                      child: Html(
                        onLinkTap: (url, attributes, element) {
                          print(url);
                          Get.to(ZoomImageAsset(
                            imageProvider: NetworkImage(url ?? ""),
                          ));
                        },
                        style: {
                          "body": Style(
                            fontSize: FontSize(fontSlider),
                          ),
                        },
                        data: htmlContent ??
                            """ <center>Bài viết chưa sẳn sàng<br/>Vui lòng đợi trong giây lát...</center>""",
                      ),
                    );
                  }),
              widget.attachments != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.attachments!.map((e) {
                        return GestureDetector(
                          onTap: () => onDownloadFile(e),
                          child: Container(
                              padding: EdgeInsets.only(
                                  bottom: 5, left: 16, right: 16),
                              child: Row(children: [
                                Icon(Icons.attach_file,
                                    color: ColorConst.primaryColor),
                                Expanded(
                                    child: Text("File đính kèm ${e.name}",
                                        style: StyleConst.regularStyle(
                                            color: ColorConst.primaryColor)))
                              ])),
                        );
                      }).toList())
                  : SizedBox(),
              SizedBox(height: 70),
            ],
          ),
        ),
        Positioned(
            bottom: widget.paddingBottom,
            left: 50.0,
            right: 50.0,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Row(children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      if (fontSlider >= defaultSize + 2) {
                        setState(() {
                          fontSlider = fontSlider - 2;
                        });
                        _htmlFontBehavior.sink.add(fontSlider - 2);
                      }
                    },
                    child: Icon(Icons.zoom_out,
                        size: 30, color: Theme.of(context).primaryColor),
                  ),
                  Expanded(
                    child: Slider(
                        divisions: ((supTitleSize - defaultSize) ~/ 2).toInt(),
                        min: defaultSize,
                        max: supTitleSize,
                        value: fontSlider,
                        onChanged: (v) {
                          setState(() {
                            fontSlider = v;
                          });
                          _htmlFontBehavior.sink.add(fontSlider);
                        }),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (fontSlider <= supTitleSize - 2) {
                        setState(() {
                          fontSlider = fontSlider + 2;
                        });
                        _htmlFontBehavior.sink.add(fontSlider + 2);
                      }
                    },
                    child: Icon(Icons.zoom_in,
                        size: 30, color: Theme.of(context).primaryColor),
                  ),
                ])))
      ],
    );
  }

  onDownloadFile(AttachmentModel e) async {
    WaitingDialog.show(context);
    PostController _postController = Get.find<PostController>(tag: widget.tag);
    await _postController.refreshGetOnePost();
    if (_postController.postDetail != null) {
      var itemAttachment = _postController.postDetail!.attachments
          ?.firstWhere((element) => element.id == e.id);
      if (itemAttachment != null) {
        printLog("Starting downloading--${itemAttachment.downloadUrl}");
        var file = await serviceFile.downloadFile(
          itemAttachment.downloadUrl.toString(),
          nameFile: itemAttachment.name,
        );
        WaitingDialog.turnOff();
        if (file != null) {
          showSnackBar(
              title: "Thông báo",
              body: "Tải thành công.",
              backgroundColor: ColorConst.primaryColor);
          // await OpenFile.open(file.path);
        } else {
          showSnackBar(
              title: "Thông báo",
              body: "Tải không thành công.",
              backgroundColor: Colors.red);
        }
        print("data.attachments?.first.file?.path---- ${file?.path}");
      }
    }
  }
}
