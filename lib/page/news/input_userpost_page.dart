import 'dart:io';

import 'package:bv_cay_an_qua/models/disease_model.dart';
import 'package:bv_cay_an_qua/models/doctor_model.dart';
import 'package:bv_cay_an_qua/models/hospital_model.dart';
import 'package:bv_cay_an_qua/models/user/plant_model.dart';
import 'package:bv_cay_an_qua/models/user_post_model/user_post_model.dart';
import 'package:bv_cay_an_qua/page/components/image_picker.dart';
import 'package:bv_cay_an_qua/page/components/widget_video.dart';
import 'package:bv_cay_an_qua/page/issue/controllers/issue_controller.dart';
import 'package:bv_cay_an_qua/shared/helper/dialogs.dart';
import 'package:bv_cay_an_qua/shared/helper/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../export.dart';
import 'controllers/userpost_controller.dart';

class InputUserPostPage extends StatefulWidget {
  String? tag;
  UserPostModel? detail;

  InputUserPostPage({Key? key, this.tag, this.detail}) : super(key: key);

  @override
  _InputUserPostPageState createState() => _InputUserPostPageState();
}

class _InputUserPostPageState extends State<InputUserPostPage> {
  TextEditingController questionController = TextEditingController();
  late MediaQueryData _mediaQueryData;

  List<String> listImage = [];
  PlantModel? _currentTree;
  late UserPostController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = Get.put(UserPostController(), tag: widget.tag);
    if (widget.detail != null) {
      questionController.text = widget.detail?.content ?? "";
      listImage = widget.detail?.images ?? [];
      _controller.listPants.forEach((element) {
        if (element.id == widget.detail?.plant?.id) {
          _currentTree = element;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    // print(widget.tag);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: WillPopScope(
        onWillPop: () => showExist(context),
        child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                showExist(context);
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
                Text("Tạo bài viết",
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
            bottom: PreferredSize(
                child: Container(
                  color: ColorConst.primaryColor,
                  height: 8,
                ),
                preferredSize: Size.fromHeight(8)),
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nội dung bài viết",
                        style: StyleConst.boldStyle(
                            color: ColorConst.primaryColor),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: TextField(
                            controller: questionController,
                            maxLines: 4,
                            style: StyleConst.regularStyle(fontSize: 18.0),
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              fillColor: ColorConst.primaryColor,
                              border: OutlineInputBorder(),
                              hintText: 'Nhập nội dung bài viết',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2.0),
                              ),

                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFE2E0E0), width: 2.0),
                              ),
                              labelStyle: StyleConst.regularStyle(
                                  color: ColorConst.primaryColor),
                              // border: InputBorder.none,
                              // enabledBorder: InputBorder.none,
                              // disabledBorder: InputBorder.none,
                              // focusedBorder: InputBorder.none,
                            ),
                            onSubmitted: (String value) {},
                          )),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Hình ảnh đính kèm",
                        style: StyleConst.boldStyle(
                            color: ColorConst.primaryColor),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: <Widget>[
                            InkWell(
                              child: Container(
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                      border: Border.all(
                                          width: 3,
                                          color: ColorConst.borderInputColor)),
                                  child: Icon(
                                    Icons.add,
                                    color: ColorConst.grey,
                                  )),
                              onTap: () => _handleUploadImage.call(context),
                            ),
                            Container(
                              width: _mediaQueryData.size.width - 130,
                              height: 64,
                              child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: listImage
                                    .map(
                                      (item) => InkWell(
                                        child: Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: item.split(".").last == "mp4"
                                              ? WidgetVideo(
                                                  url: item,
                                                  size: 64,
                                                  isRemove: true,
                                                )
                                              : ImagePickerWidget(
                                                  context: context,
                                                  size: 64,
                                                  isRemove: true,
                                                  resourceUrl: item,
                                                  // onFileChanged: (fileUri, fileType) {
                                                  //   setState(() {
                                                  //     item = fileUri;
                                                  //   });
                                                  // },
                                                ),
                                        ),
                                        onTap: () => _handleRemoveImage(item),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Chọn cây trồng",
                        style: StyleConst.boldStyle(
                            color: ColorConst.primaryColor),
                      ),
                      GetBuilder<UserPostController>(
                          tag: widget.tag,
                          builder: (builder) {
                            return Container(
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  border: Border.all(
                                      width: 1,
                                      color: ColorConst.borderInputColor)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                child: DropdownButton<PlantModel>(
                                  value: _currentTree,
                                  isExpanded: true,
                                  hint: Text('Chọn loại cây trồng'),
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 30,
                                  style: StyleConst.regularStyle(),
                                  underline: Container(
                                    height: 0,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (newTree) {
                                    setState(() {
                                      _currentTree = newTree;
                                    });
                                  },
                                  items: _controller.listPants
                                      .map<DropdownMenuItem<PlantModel>>(
                                          (item) {
                                    return DropdownMenuItem<PlantModel>(
                                      value: item,
                                      child: Text(item.name ?? 'No name'),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          })
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: _mediaQueryData.padding.bottom),
                child: WidgetButton(
                  text: (widget.detail != null ? "Cập nhật" : "Gửi bài viết")
                      .toUpperCase(),
                  textColor: Colors.white,
                  onTap: () async {
                    if (questionController.text.isEmpty ||
                        _currentTree == null) {
                      showDialog<bool>(
                        context: context,
                        builder: (c) => AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                  'Vui lòng bổ sung tất cả các trường trên màn hình.'),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: 10,
                                  left: 10,
                                  top: 16,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(),
                                    WidgetButton(
                                        text: 'OK',
                                        paddingBtnWidth: 0,
                                        paddingBtnHeight: 0,
                                        textColor: ColorConst.primaryColor,
                                        backgroundColor: Colors.white,
                                        onTap: () {
                                          Navigator.pop(c, false);
                                        }),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      if (widget.detail != null) {
                        await _controller.updateUserPost(
                            context: context,
                            content: questionController.text,
                            userPostId: widget.detail!.id!,
                            plantId: _currentTree?.id,
                            images: listImage);
                      } else {
                        await _controller.createUserPost(
                            content: questionController.text,
                            context: context,
                            plantId: _currentTree?.id,
                            images: listImage);
                      }
                    }
                  },
                ),
              ),
              SizedBox(
                height: 16 + MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ),
      ),
    );
  }

  _handleRemoveImage(item) async {
    setState(() {
      listImage.remove(item);
    });
  }

  _handleUploadImage(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    showSelectMoreFile(
        context: context,
        isMultiImage: true,
        callBack: (value) {
          if (value is List<String> && value.length > 0) {
            listImage.addAll(value);
            setState(() {});
          } else {
            setState(() {
              listImage.add(value);
            });
          }
        });
  }

  Future<bool> showExist(BuildContext context) async {
    bool result = false;
    showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text('Xác nhận'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Câu hỏi chưa hoàn tất. Bạn muốn tiếp tục'),
            Padding(
              padding: const EdgeInsets.only(
                  right: 10, left: 10, top: 16, bottom: 0),
              child: Row(
                children: [
                  Expanded(
                    child: WidgetButton(
                        text: 'Hủy',
                        backgroundColor: Colors.white,
                        onTap: () {
                          result = false;
                          Navigator.pop(c, false);
                          Navigator.pop(context, false);
                        }),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: WidgetButton(
                      text: 'Tiếp tục',
                      textColor: Colors.white,
                      onTap: () {
                        result = true;
                        Navigator.pop(c, false);
                        // return Platform.isIOS ? exit(0) : SystemNavigator.pop();
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
    return result;
  }
}
