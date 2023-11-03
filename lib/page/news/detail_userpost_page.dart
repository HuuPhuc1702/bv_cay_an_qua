import 'package:bv_cay_an_qua/models/issue/comment_model.dart';
import 'package:bv_cay_an_qua/page/components/dialog.dart';
import 'package:bv_cay_an_qua/page/components/image_picker.dart';
import 'package:bv_cay_an_qua/page/components/widget_video.dart';
import 'package:bv_cay_an_qua/page/issue/components/item_comment.dart';
import 'package:bv_cay_an_qua/page/login/controllers/auth_controller.dart';
import 'package:bv_cay_an_qua/page/news/controllers/userpost_controller.dart';
import 'package:bv_cay_an_qua/repositories/issue_repo.dart';
import 'package:bv_cay_an_qua/shared/helper/dialogs.dart';
import 'package:bv_cay_an_qua/shared/helper/image_helper.dart';
import 'package:bv_cay_an_qua/shared/helper/print_log.dart';
import 'package:bv_cay_an_qua/shared/util_convert/datetime_convert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../export.dart';
import 'input_userpost_page.dart';

class DetailUserPostPage extends StatefulWidget {
  final String id;
  final String tag;

  DetailUserPostPage({Key? key, required this.id, required this.tag})
      : super(key: key);

  @override
  _DetailUserPostPageState createState() => _DetailUserPostPageState();
}

class _DetailUserPostPageState extends State<DetailUserPostPage> {
  AuthController authController = Get.find<AuthController>();
  TextEditingController _commentController = TextEditingController();
  TextEditingController editController = TextEditingController();
  List<String> imageComment = [];
  late UserPostController _controller;

  // double _initialRating = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      _controller = Get.find<UserPostController>(tag: widget.tag);
    } catch (error) {
      _controller = Get.put(UserPostController());
    }
    _controller.getOneIssue(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    // printLog("authController.userCurrent.id--${authController.userCurrent.id}");
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.all(14.0),
              child: Image.asset(
                AssetsConst.iconBack,
                fit: BoxFit.cover,
                width: 24,
                height: 24,
              ),
            ),
          ),
          brightness: Brightness.light,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Chi tiết câu hỏi",
                  style: StyleConst.boldStyle(
                          color: ColorConst.red, fontSize: titleSize)
                      .copyWith(
                          color: Colors.red, fontWeight: FontWeight.bold)),
              Text('www.benhviencayanqua.vn',
                  style:
                      StyleConst.mediumStyle(color: ColorConst.primaryColor)),
            ],
          ),
          elevation: 2,
          backgroundColor: Colors.white,
          actions: <Widget>[
            GetBuilder<UserPostController>(
              tag: widget.tag,
              builder: (controller) {
                return Visibility(
                  visible: appConfig.appType == AppType.DOCTOR &&
                      _controller.detail?.owner?.id ==
                          authController.userCurrent.id,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(InputUserPostPage(
                        tag: widget.tag,
                        detail: _controller.detail,
                      ));
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Icon(
                        Icons.edit_outlined,
                        color: ColorConst.primaryColor,
                        size: 30,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
          bottom: PreferredSize(
              child: Container(
                color: ColorConst.primaryColor,
                height: 8,
              ),
              preferredSize: Size.fromHeight(8)),
        ),
        body: RefreshIndicator(
          color: ColorConst.primaryColor,
          onRefresh: () async {
            _controller.refreshDataDetail();
          },
          child: Column(
            children: <Widget>[
              Expanded(
                  child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      child: Container(
                        color: Color(0xFFF6F8F9),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 30),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          color: Colors.white,
                          child: GetBuilder<UserPostController>(
                            tag: widget.tag,
                            builder: (controller) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Người đăng",
                                          style: StyleConst.regularStyle(
                                              color: ColorConst.primaryColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0),
                                          child: Text(
                                            _controller.detail?.owner?.name ??
                                                'Rỗng',
                                            style: StyleConst.regularStyle(),
                                            textAlign: TextAlign.justify,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Divider(),
                                        ),
                                        Text(
                                          "Nội dung",
                                          style: StyleConst.regularStyle(
                                              color: ColorConst.primaryColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0),
                                          child: Text(
                                            _controller.detail?.content ??
                                                'Rỗng',
                                            style: StyleConst.regularStyle(),
                                            textAlign: TextAlign.justify,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Divider(),
                                        ),
                                        Text(
                                          "Loại cây trồng",
                                          style: StyleConst.regularStyle(
                                              color: ColorConst.primaryColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0),
                                          child: Text(
                                            _controller.detail?.plant?.name ??
                                                'Chưa cập nhật',
                                            style: StyleConst.regularStyle(),
                                            textAlign: TextAlign.justify,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Divider(),
                                        ),
                                        Text(
                                          "Hình ảnh đính kèm",
                                          style: StyleConst.boldStyle(
                                              color: ColorConst.primaryColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        (_controller.detail?.images?.length ??
                                                    0) >
                                                0
                                            ? Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 76,
                                                padding:
                                                    EdgeInsets.only(top: 12.0),
                                                child: ListView(
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  children: _controller
                                                      .detail!.images!
                                                      .map<Widget>(
                                                        (item) => item
                                                                    .split(".")
                                                                    .last ==
                                                                "mp4"
                                                            ? WidgetVideo(
                                                                url: item,
                                                                size: 65,
                                                              )
                                                            : Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            5),
                                                                child:
                                                                    ImagePickerWidget(
                                                                  context:
                                                                      context,
                                                                  size: 65,
                                                                  listImage:
                                                                      _controller
                                                                          .detail!
                                                                          .images,
                                                                  resourceUrl:
                                                                      item,
                                                                  onFileChanged:
                                                                      (fileUri,
                                                                          fileType) {
                                                                    setState(
                                                                        () {
                                                                      item =
                                                                          fileUri;
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                      )
                                                      .toList(),
                                                ),
                                              )
                                            : Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 12.0),
                                                child: Text(
                                                    'Không có ảnh đính kèm',
                                                    style: TextStyle(
                                                        color:
                                                            Colors.grey[500]))),
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  // rating

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            _controller.detail == null
                                                ? "Đang tải bình luận..."
                                                : 'Có ${_controller.detail?.commentCount} bình luận',
                                            style: StyleConst.regularStyle(
                                                color: ColorConst.primaryColor),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.0),
                                    child: Divider(),
                                  ),

                                  _buildComments(),
                                  (_controller.detail?.comments?.length ?? 0) >
                                          0
                                      ? Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.0),
                                        )
                                      : Container(),
                                ],
                              );
                            },
                          ),
                        ),
                      ))),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    imageComment.length > 0
                        ? Container(
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.18,
                                bottom: 10),
                            height: 100,
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: imageComment
                                  .map(
                                    (item) => InkWell(
                                      child: Container(
                                        child: ImagePickerWidget(
                                          context: context,
                                          size: 150,
                                          quality: 150,
                                          isRemove: true,
                                          resourceUrl: item,
                                        ),
                                      ),
                                      onTap: () => _handleRemoveImage(item),
                                    ),
                                  )
                                  .toList(),
                            ),
                          )
                        : Container(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ImagePickerWidget(
                          context: context,
                          size: MediaQuery.of(context).size.width * 0.12,
                          avatar: true,
                          resourceUrl: authController.userCurrent.avatar ?? '',
                          quality: 100,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          width: MediaQuery.of(context).size.width * 0.85 - 20,
                          child: TextField(
                            controller: _commentController,
                            onSubmitted: (str) =>
                                _handleSendDoctorComment.call(context, str),
                            onChanged: (text) {
                              setState(() {
                                // this.text = text;
                              });
                            },
                            style: StyleConst.regularStyle(),
                            textInputAction: TextInputAction.newline,
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 8,
                            decoration: InputDecoration(
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  GestureDetector(
                                    child: Icon(
                                      Icons.image,
                                      size: 20,
                                      color: this.imageComment.length > 0
                                          ? Color(0xFFBBB7B7)
                                          : ColorConst.primaryColor,
                                    ),
                                    onTap: this.imageComment.length > 0
                                        ? () {}
                                        : () =>
                                            _handleUploadImage.call(context),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.send,
                                      size: 20,
                                      color: _commentController.text.isEmpty &&
                                              _commentController.text.length ==
                                                  0
                                          ? Color(0xFFBBB7B7)
                                          : ColorConst.primaryColor,
                                    ),
                                    onPressed: () {
                                      _handleSendDoctorComment(
                                          context, _commentController.text);
                                    },
                                  ),
                                ],
                              ),

                              // labelText: "Tìm kiếm... ",
                              hintText: "Viết bình luận",
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 20),
                              hintStyle: StyleConst.regularStyle(),
                              fillColor: Theme.of(context).primaryColor,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorConst.borderInputColor,
                                    width: 2.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildComments() {
    if ((_controller.detail?.comments?.length ?? 0) > 0) {
      return Column(
          children:
              _controller.detail!.comments!.map<Widget>((CommentModel item) {
        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black12,
                width: 1,
              ),
            ),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 10.0, left: 0, right: 0, bottom: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 5, right: 8.0),
                  child: ImagePickerWidget(
                    context: context,
                    size: 60,
                    avatar: true,
                    resourceUrl: item.owner?.profile?.avatar ?? '',
                    quality: 80,
                  ),
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  item.owner?.name ?? 'Chưa cập nhật',
                                  maxLines: 1,
                                  textAlign: TextAlign.justify,
                                  overflow: TextOverflow.ellipsis,
                                  style: StyleConst.mediumStyle(),
                                ),
                              ),
                              Text(
                                formatTime(item.updatedAt),
                                style: StyleConst.regularStyle(
                                    color: ColorConst.grey, fontSize: 12.0),
                                maxLines: 3,
                                textAlign: TextAlign.justify,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: canEdit(item),
                          child: InkWell(
                            onTap: item.editing
                                ? () => updateComment(
                                    item, editController.text.toString())
                                : () {
                                    _controller.detail!.comments!
                                        .where((c) => c.id != item.id)
                                        .forEach((c) => c.editing = false);
                                    editController = TextEditingController(
                                        text: item.content);
                                    setState(() {
                                      item.editing = !item.editing;
                                    });
                                  },
                            child: Card(
                              child: Icon(
                                  item.editing ? Icons.save : Icons.edit,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        )
                      ],
                    ),
                    item.image != '' && item.image != null
                        ? Container(
                            margin: EdgeInsets.only(top: 8),
                            height: 100,
                            child: item.image.split(".").last == "mp4"
                                ? WidgetVideo(
                                    url: item.image,
                                    size: 150,
                                  )
                                : ImagePickerWidget(
                                    context: context,
                                    size: 150,
                                    quality: 150,
                                    resourceUrl: item.image,
                                  ),
                          )
                        : SizedBox(),
                    itemComment(context: context, content: item.content ?? ""),
                    item.editing
                        ? TextField(
                            controller: editController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                          )
                        : Container(),
                    item.editing
                        ? Padding(
                            padding: EdgeInsets.only(top: 12.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  ElevatedButton(
                                      child: Text('Cập nhật',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                      onPressed: () => updateComment(
                                          item, editController.text.toString()))
                                ]),
                          )
                        : Container()
                  ],
                )),
              ],
            ),
          ),
        );
      }).toList());
    }
    return SizedBox();
  }

  canEdit(CommentModel comment) {
    if (comment.owner == null ||
        comment.owner?.id == authController.userCurrent.id) return true;
    return false;
  }

  updateComment(CommentModel comment, String content) async {
    try {
      print("updateComment---${comment.id}");
      print("updateComment---$content");
      final value = await issueRepository.updateComment(
          id: comment.id!, content: content);
      if (value) {
        _controller.getOneIssue(widget.id);
      }
    } catch (e) {
      showAlertDialog(
          context, 'Sửa bình luận thất bại\n Mã lỗi: ${e.toString()}');
    }
    setState(() {
      comment.editing = false;
    });
  }

  _handleSendDoctorComment(BuildContext context, String comment) async {
    try {
      if (imageComment.length == 0) {
        await _controller.createComment(
            context: context, userPostId: widget.id, content: comment);
      } else {
        await _controller.createComment(
            context: context,
            userPostId: widget.id,
            content: comment,
            image: imageComment[0]);
      }
      _commentController.text = '';
      setState(() {
        imageComment = [];
      });
      showSnackBar(title: "Thông báo", body: "Bình luận đã được tạo");
      _controller.refreshData();
      _controller.getOneIssue(widget.id);
    } catch (error) {
      printLog(error.toString());
    }
  }

  _handleRemoveImage(item) async {
    setState(() {
      imageComment.remove(item);
    });
  }

  _handleUploadImage(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    showSelectMoreFile(
        context: context,
        callBack: (value) {
          if (value is List<String> && value.length > 0) {
            imageComment.addAll(value);
            setState(() {});
          } else {
            setState(() {
              imageComment.add(value);
            });
          }
        });
  }
}
