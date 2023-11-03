import 'package:bv_cay_an_qua/export.dart';
import 'package:bv_cay_an_qua/shared/helper/print_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../shared/helper/dialogs.dart';

enum TypeAlbum { video, image }

showSelectMoreFile(
    {required BuildContext context,
    bool isMultiImage = false,
    TypeAlbum typeAlbum = TypeAlbum.image,
    required Function(dynamic) callBack}) {
  final _picker = ImagePicker();

  Get.bottomSheet(
      IntrinsicHeight(
        child: Column(
          children: [
            Visibility(
              visible: typeAlbum == TypeAlbum.image,
              child: InkWell(
                onTap: () async {
                  Get.back();
                  WaitingDialog.show(context);
                  try {
                    final XFile? pickedFile = await _picker.pickImage(
                        imageQuality: 50, source: ImageSource.camera);
                    printLog(" path - ${pickedFile?.path}");
                    callBack.call(pickedFile?.path);
                    // await serviceFile.updateImageImgur(pickedFile?.path ?? "",
                    //     onUpdateImage: (value) {
                    //   printLog("gallery - $value");
                    //   if (value != null) callBack.call(value);
                    // }, catchError: (error) {});
                  } catch (error) {
                    printLog("showSelectImage---- error: $error");
                  }
                  WaitingDialog.turnOff();
                },
                child: Padding(
                  padding: EdgeInsets.all(kConstantPadding),
                  child: Row(
                    children: [
                      Icon(Icons.photo_camera,
                          size: 30, color: ColorConst.grey),
                      SizedBox(width: kConstantPadding),
                      Text(
                        'Máy ảnh',
                        style: StyleConst.mediumStyle(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: typeAlbum == TypeAlbum.video,
              child: InkWell(
                onTap: () async {
                  Get.back();
                  WaitingDialog.show(context);
                  try {
                    final XFile? pickedFile = await _picker.pickVideo(
                        source: ImageSource.camera,
                        maxDuration: Duration(seconds: 60));
                    printLog(" path - ${pickedFile?.path}");
                    printLog(" path - ${await pickedFile?.length()}");
                    callBack.call(pickedFile?.path);
                    // var dataVideoResult = jsonDecode(await serviceFile
                    //         .uploadFile(pathFile: pickedFile!.path) ??
                    //     "");
                    // print("dataVideoResult");
                    // await serviceFile.updateImageImgur(pickedFile?.path ?? "",
                    //     onUpdateImage: (value) {
                    //   printLog("gallery - $value");
                    //   if (value != null) callBack.call(value);
                    // }, catchError: (error) {});
                  } catch (error) {
                    printLog("showSelectImage---- error: $error");
                  }
                  WaitingDialog.turnOff();
                },
                child: Padding(
                  padding: EdgeInsets.all(kConstantPadding),
                  child: Row(
                    children: [
                      Icon(Icons.photo_camera,
                          size: 30, color: ColorConst.grey),
                      SizedBox(width: kConstantPadding),
                      Text(
                        'Quay video',
                        style: StyleConst.mediumStyle(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                Get.back();
                WaitingDialog.show(context);
                try {
                  if (isMultiImage && typeAlbum != TypeAlbum.video) {
                    List<String> listLinks = [];
                    List<XFile>? pickedFiles =
                        await _picker.pickMultiImage(imageQuality: 50);

                    if (pickedFiles != null) {
                      if (pickedFiles.length > 5) {
                        WaitingDialog.turnOff();
                        showSnackBar(
                            title: "Cảnh báo",
                            body:
                                "Xin lỗi, hiện chỉ có thể lấy được tối đa 5 hình.",
                            backgroundColor: Colors.yellow,
                            seconds: 4,
                            color: Colors.black);
                      } else {
                        if (pickedFiles.length > 0) {
                          listLinks = pickedFiles.map((e) => e.path).toList();
                          callBack.call(listLinks);
                        }
                      }
                    }
                  } else {
                    XFile? pickedFile;
                    if (typeAlbum == TypeAlbum.image) {
                      pickedFile = await _picker.pickImage(
                          imageQuality: 50, source: ImageSource.gallery);
                    } else {
                      pickedFile = await _picker.pickVideo(
                          source: ImageSource.gallery,
                          maxDuration: Duration(seconds: 60));
                    }
                    if (pickedFile != null) {
                      if ((await pickedFile.length()) <= 25000000) {
                        callBack.call(pickedFile.path);
                      } else {
                        WaitingDialog.turnOff();
                        showSnackBar(
                            title: "Cảnh báo",
                            body:
                                "Dung lượng tập tin không được quá 25MB, vui lòng chọn tập tin khác.",
                            backgroundColor: Colors.yellow.shade300,
                            seconds: 4,
                            color: Colors.black87);
                      }
                    }
                  }
                } catch (error) {
                  printLog(error.toString());
                }
                WaitingDialog.turnOff();
              },
              child: Padding(
                padding: EdgeInsets.all(kConstantPadding),
                child: Row(
                  children: [
                    Icon(Icons.photo_library, size: 30, color: ColorConst.grey),
                    SizedBox(width: kConstantPadding),
                    Text(
                      'Thư viện ${typeAlbum == TypeAlbum.video ? "video" : "ảnh"}',
                      style: StyleConst.mediumStyle(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16 + MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
      backgroundColor: Colors.white);
}
