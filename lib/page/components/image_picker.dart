import 'dart:async';
import 'dart:io';

import 'package:bv_cay_an_qua/config/theme/color-constant.dart';
import 'package:bv_cay_an_qua/config/theme/size-constant.dart';
import 'package:bv_cay_an_qua/config/theme/style-constant.dart';
import 'package:bv_cay_an_qua/export.dart';
import 'package:bv_cay_an_qua/services/files/service_file.dart';
import 'package:bv_cay_an_qua/shared/helper/dialogs.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_image_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'pic_swiper.dart';

class ImagePickerWidget extends StatefulWidget {
  final double size;
  final int quality;
  String? resourceUrl;
  String? positionUser;
  final BuildContext context;
  final bool circle;
  final bool isEdit;
  final bool isRemove;
  final bool avatar;
  Function? onClick;
  List? listImage;

  ImagePickerWidget({
    Key? key,
    required this.context,
    this.size = 50,
    this.quality = 50,
    this.resourceUrl,
    this.positionUser,
    this.circle = false,
    this.isEdit = false,
    this.isRemove = false,
    this.avatar = false,
    this.onFileChanged,
    this.listImage,
    this.onClick,
  }) : super(
          key: key,
        );
  Function(String, String)? onFileChanged;

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.resourceUrl == "null")
      widget.resourceUrl = widget.resourceUrl?.replaceAll("null", "");
    if (widget.resourceUrl != null &&
        !widget.resourceUrl!.contains("http") &&
        widget.resourceUrl!.isNotEmpty) {
      image = File(widget.resourceUrl!);
    }
  }

  popupAlert() {
    FocusScope.of(context).requestFocus(FocusNode());
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text(
                  'Máy ảnh',
                  style: StyleConst.boldStyle(fontSize: titleSize),
                ),
                onTap: imageSelectorCamera,
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text(
                  'Thư viện ảnh',
                  style: StyleConst.boldStyle(fontSize: titleSize),
                ),
                onTap: imageSelectorGallery,
              )
            ],
          );
        });
  }

  openZoomListImage(List url) {
    int indexImage = widget.listImage != null && widget.listImage!.length > 1
        ? widget.listImage!.indexOf(url[0])
        : 0; // 1
    // Routing().navigate2(context, PicSwiper(indexImage, widget.listImage ?? url));
    Get.to(PicSwiper(indexImage, widget.listImage ?? url));
  }

  Widget uploadExtraInfo() {
    return ClipRRect(
      borderRadius: BorderRadius.all(
          Radius.circular(widget.circle ? widget.size / 2 : 5.0)),
      child: GestureDetector(
        onTap: () {
          widget.resourceUrl != null &&
                  widget.resourceUrl != '' &&
                  widget.resourceUrl!.contains("http")
              ? openZoomListImage([widget.resourceUrl])
              : {};
        },
        child: widget.resourceUrl != null &&
                widget.resourceUrl != '' &&
                widget.resourceUrl!.contains("http")
            ? WidgetImageNetWork(
                url:
                    "https://aelaaawjoo.cloudimg.io/crop/${widget.quality}x${widget.quality}/x/${widget.resourceUrl}",
                fit: BoxFit.cover,
                width: widget.size,
              )
            // ? CachedNetworkImage(
            //     fit: BoxFit.cover,
            //     width: widget.size,
            //     // height: widget.size,
            //     imageUrl:
            //         "https://aelaaawjoo.cloudimg.io/crop/${widget.quality}x${widget.quality}/x/${widget.resourceUrl}",
            //     placeholder: (context, url) => Center(
            //       child: Container(
            //         width: widget.size / 2,
            //         height: widget.size / 2,
            //         child: CircularProgressIndicator(
            //             backgroundColor:
            //                 ColorConst.primaryColor.withOpacity(0.1),
            //             valueColor: AlwaysStoppedAnimation<Color>(
            //                 ColorConst.primaryColor.withOpacity(0.3))),
            //       ),
            //     ),
            //     errorWidget: (context, url, error) => Icon(Icons.error),
            //   )
            : image == null
                ? Image.asset(
                    widget.positionUser == 'doctor'
                        ? "assets/images/avatar_doctor.jpg"
                        : widget.positionUser == 'client'
                            ? "assets/images/avatar_client.jpg"
                            : "assets/images/app_logo.png",
                    fit: BoxFit.cover,
                    width: widget.size,
                    height: widget.size,
                  )
                // Center(
                //     child: Container(
                //       width: widget.size / 2,
                //       height: widget.size / 2,
                //       child: CircularProgressIndicator(
                //           backgroundColor: ptPrimaryColor(context).withOpacity(0.1),
                //           valueColor: AlwaysStoppedAnimation<Color>(ptPrimaryColor(context).withOpacity(0.3))),
                //     ),
                //   )
                : Image.file(
                    image ?? File(""),
                    fit: BoxFit.cover,
                    width: widget.size,
                    height: widget.size,
                  ),
      ),
    );
  }

  _handleUploadImage(localImage) async {
    WaitingDialog.show(context, message: "Đang tải ảnh lên...");
    serviceFile.updateImageImgur(localImage?.path ?? "",
        onUpdateImage: (value) {
      print("gallery - $value");
      WaitingDialog.turnOff();
      if (widget.onFileChanged != null) {
        widget.onFileChanged!.call(value ?? "", 'image');
      }
      if (localImage != null) {
        print("You selected gallery image : " + localImage.path);
        setState(() {
          image = File(localImage?.path ?? "");
        });
      }
    }, catchError: (error) {
      // WaitingDialog.turnOff();
      showSnackBar(
          title: "Thông báo", body: "$error", backgroundColor: Colors.red);
    });

    // var image0 = image;
    // showWaitingDialog(context, message: "Đang tải ảnh lên...");
    // String link = await ImageService().uploadImageToImgur(localImage).then((onValue) {
    //   if (widget.onFileChanged != null) {
    //     widget.onFileChanged(onValue, 'image');
    //   }
    //   if (localImage != null) {
    //     print("You selected gallery image : " + localImage.path);
    //     setState(() {
    //       image = localImage;
    //     });
    //   }
    //   Navigator.pop(context);
    // }).catchError((onError) {
    //   Navigator.pop(context);
    //   setState(() {
    //     image = image0;
    //   });
    //   Alert(context: context, title: "", desc: "Cập nhật ảnh thất bại").show();
    // });
    // print('phat update link ảnh nè: $link');
  }

  //display image selected from camera
  Future imageSelectorCamera() async {
    Navigator.pop(context);
    final XFile? cameraFile = await ImagePicker().pickImage(
        imageQuality: 50,
        source: ImageSource.camera,
        maxHeight: 500,
        maxWidth: 500);
    // var cameraFile = await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 500.0, maxHeight: 500.0);
    _handleUploadImage(cameraFile);
  }

  //display image selected from gallery
  Future imageSelectorGallery() async {
    Navigator.pop(context);
    final XFile? galleryFile = await ImagePicker().pickImage(
        imageQuality: 90,
        source: ImageSource.gallery,
        maxHeight: 1000,
        maxWidth: 800);
    // var galleryFile =
    //     await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 800, maxHeight: 1000, imageQuality: 90);
    _handleUploadImage(galleryFile);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.avatar) {
      return ClipOval(
        child: GestureDetector(
          onTap: () {
            widget.resourceUrl != null &&
                    widget.resourceUrl != '' &&
                    widget.resourceUrl!.contains("http")
                ? openZoomListImage([widget.resourceUrl])
                : {};
          },
          child:
              widget.resourceUrl != null && widget.resourceUrl!.contains("http")
                  ? CachedNetworkImage(
                      fit: BoxFit.cover,
                      width: widget.size,
                      height: widget.size,
                      imageUrl:
                          "https://aelaaawjoo.cloudimg.io/crop/${widget.quality}x${widget.quality}/x/${widget.resourceUrl}",
                      placeholder: (context, url) => Center(
                        child: Container(
                          width: widget.size / 2,
                          height: widget.size / 2,
                          child: CircularProgressIndicator(
                              backgroundColor:
                                  ColorConst.primaryColor.withOpacity(0.1),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  ColorConst.primaryColor.withOpacity(0.3))),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    )
                  : image == null
                      ? Image.asset(
                          widget.positionUser == 'doctor'
                              ? "assets/images/avatar_doctor.jpg"
                              : widget.positionUser == 'client'
                                  ? "assets/images/avatar_client.jpg"
                                  : "assets/images/app_logo.png",
                          fit: BoxFit.cover,
                          width: widget.size,
                          height: widget.size,
                        )
                      : Image.file(
                          image ?? File(""),
                          fit: BoxFit.cover,
                          width: widget.size,
                          height: widget.size,
                        ),
        ),
      );
    } else {
      return Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: ColorConst.primaryColor.withOpacity(0.5),
          borderRadius: BorderRadius.all(
            Radius.circular(widget.circle ? widget.size : 5.0),
          ),
          border: Border.all(
              color: ColorConst.borderInputColor), /*HexColor('#fafafa')*/
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          // overflow: Overflow.clip,
          fit: StackFit.expand,
          children: <Widget>[
            uploadExtraInfo(),
            widget.isEdit
                ? GestureDetector(
                    onTap: popupAlert,
                    child: Container(
                      width: widget.size,
                      height: widget.size,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.all(
                          Radius.circular(widget.circle ? widget.size : 5.0),
                        ),
                        border: Border.all(
                            color: ColorConst
                                .borderInputColor), /*HexColor('#fafafa')*/
                      ),
                      child: Center(
                        child: Icon(
                          Icons.camera_alt,
                          size: widget.size * 0.3,
                          color: Color(0xFFE5E5E5),
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
            widget.isRemove
                ? Container(
                    width: widget.size,
                    height: widget.size,
                    decoration: BoxDecoration(
                      color: Colors.white30,
                      borderRadius: BorderRadius.all(
                        Radius.circular(widget.circle ? widget.size : 5.0),
                      ),
                      border: Border.all(
                          color: ColorConst
                              .borderInputColor), /*HexColor('#fafafa')*/
                    ),
                    child: Center(
                      child: Icon(
                        Icons.remove_circle,
                        size: widget.size * 0.3,
                        color: Colors.redAccent,
                      ),
                    ),
                  )
                : SizedBox()
          ],
        ),
      );
    }
  }
}
