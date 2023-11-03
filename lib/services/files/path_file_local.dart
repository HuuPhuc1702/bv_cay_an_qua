import 'dart:io';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

enum EPathType { Cache, Storage, Download , Pictures}

class PathFileLocals {
  Future<Directory?> getPathLocal({required EPathType ePathType}) async {
    Directory? pathDir;
    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      switch (ePathType) {
        case EPathType.Download:
        // if (Platform.isAndroid) {
          pathDir = await DownloadsPathProvider.downloadsDirectory;
          // } else if (Platform.isIOS) {
          //   pathDir = await getApplicationDocumentsDirectory();
          // }
          // pathDir = (await getExternalStorageDirectories(
          //         type: StorageDirectory.downloads))
          //     ?.first;
          break;
        case EPathType.Pictures:
        // if (Platform.isAndroid) {
          pathDir = await DownloadsPathProvider.downloadsDirectory;
          // } else if (Platform.isIOS) {
          //   pathDir = await getApplicationDocumentsDirectory();
          // }
          // pathDir = (await getExternalStorageDirectories(
          //         type: StorageDirectory.downloads))
          //     ?.first;
          break;
        case EPathType.Storage:
        // if (Platform.isAndroid) {
        //   pathDir = (await getExternalStorageDirectories())?.first;
        // } else if (Platform.isIOS) {
          pathDir = await getApplicationDocumentsDirectory();
          // }
          break;
        default:
          if (Platform.isAndroid) {
            pathDir = (await getExternalCacheDirectories())?.first;
          } else if (Platform.isIOS) {
            pathDir = await getTemporaryDirectory();
          }
          break;
      }

      // if (ePathType == EPathType.Download ) {
      //   // pathDir = await DownloadsPathProvider.downloadsDirectory;
      //   pathDir =( await getExternalStorageDirectories(type: StorageDirectory.downloads))?.first;
      // }
      // else if (ePathType == EPathType.Storage) {
      //   if (Platform.isAndroid) {
      //     pathDir = (await getExternalStorageDirectories())?.first;
      //   } else if (Platform.isIOS) {
      //     pathDir = await getApplicationDocumentsDirectory();
      //   }
      // } else {
      //   if (Platform.isAndroid) {
      //     pathDir = (await getExternalCacheDirectories())?.first;
      //   } else if (Platform.isIOS) {
      //     pathDir = await getTemporaryDirectory();
      //   }
      // }
      if (pathDir != null) return pathDir;
      return null;
    } catch (error) {
      throw ("PathFileLocals---- $error");
      return null;
    }
  }

  Future<bool> checkExistFile({String? path}) async {
    if (path == null) return false;
    if (!(await File(path).exists())) {
      await File(path).create(recursive: false);
    }
    return true;
  }
}
