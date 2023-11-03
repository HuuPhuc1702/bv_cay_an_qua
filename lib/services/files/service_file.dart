import 'dart:io';

import '../../config/app_key.dart';
import '../../config/backend.dart';
import '../../shared/helper/print_log.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../export.dart';
import '../spref.dart';
import 'path_file_local.dart';
import 'package:http/http.dart' as http;
import 'package:imgur/imgur.dart' as ig;

_ServiceFile serviceFile = _ServiceFile();

class _ServiceFile {

  Future<File?> downloadFile(String link,
      {Function(double)? onReceiveProgress, String? nameFile}) async {
    try {
      // print("$link");
      final fileName = nameFile ?? (link.split('/').last);
      // print("fileName----- ${fileName}");
      final tempDir =
      await PathFileLocals().getPathLocal(ePathType: EPathType.Download);
      File file = new File("${tempDir?.path}/$fileName");
      print("file----- ${file.path}");

      if (await PathFileLocals().checkExistFile(path: file.path) == true &&
          file.lengthSync() > 0) {
        // await file.create();
        print("file--2--- ${file.path}");
        onReceiveProgress?.call(1);
        return file;
        // File file = new File("${tempPath}/${fileName}");
      }
      var dataResult = await Dio().get(link,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              receiveTimeout: 0), onReceiveProgress: (received, total) {
            double dataProgress = (received / total * 100);
            onReceiveProgress?.call(dataProgress / 100);
            print(dataProgress/100);
          });
      print(dataResult.data);
      var status = await Permission.storage.status;
      print("status-----------${status.isGranted}");
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      await file.writeAsBytes(dataResult.data);
      // }
      print("file-------${file.path}");

      return file;
    } catch (error) {
      print(error);
      // showSnackBar(title: "Thông báo", body: "Tải không thành công.",backgroundColor: Colors.red);
      return null;
    }
  }

 Future<String?> uploadFile(
      {required String pathFile,
      Function(String?)? onUpdateImage,
      Function(String)? catchError}) async {
    try {
      var headers = {'x-token': '${SPref.instance.get(AppKey.xToken)}'};
      var request = http.MultipartRequest(
          'POST', Uri.parse('${BackendHost.BACKEND_API}/file/upload'));
      request.files.add(await http.MultipartFile.fromPath('file', pathFile));
      request.headers.addAll(headers);
      var response = await request.send();
      if (response.statusCode == 200) {
        String result = await response.stream.bytesToString();
        onUpdateImage?.call(result);
        return result;
      } else {
        print("xxx: ${response.statusCode}");
        print("xxx: ${await response.stream.bytesToString()}");
        printLog(response.reasonPhrase!);
        catchError?.call(response.reasonPhrase!);
        return null;
      }
    } catch (error) {
      print("upload file - $error");
      catchError?.call(error.toString());
      return null;
    }
  }

  Future updateImageImgur(String path,
      {Function(String?)? onUpdateImage, Function(String)? catchError}) async {
    try {
      final imgurService =
          ig.Imgur(ig.Authentication.fromClientId('317d13ba79b0825')).image;
      if (path.isNotEmpty) {
        return imgurService.uploadImage(imageFile: File(path)).then((value) {
          if (value.link != null && onUpdateImage != null) {
            onUpdateImage.call(value.link);
          }
        }).catchError((error) {
          printLog("updateImage---- ${error.toString()}");
          catchError?.call(error.toString());
        });
      }
    } catch (error) {
      catchError?.call(error.toString());
    }
  }
}
