// import 'dart:async';
// import 'dart:io';

// import 'package:path_provider/path_provider.dart';

// class FileStorage {
//   final String _photosFolder = '/cards'; // folder store name cards not yet uploaded.
//   final String _correctPhotosFolder = '/correctCards';

//   static final FileStorage _instance = new FileStorage._internal();

//   factory FileStorage() {
//     return _instance;
//   }

//   FileStorage._internal();

//   Future<File> _getLocalFile(String name) async {
//     final dir = await getApplicationDocumentsDirectory();
//     return new File('${dir.path}/$name.json');
//   }

//   Future<FileSystemEntity> clean(String name) async {
//     final file = await _getLocalFile(name);
//     return file.delete();
//   }

//   Future<void> clearPhotoFolder() async {
//     final dir = await getApplicationDocumentsDirectory();
//     Directory photoDir = new Directory(dir.path + _photosFolder);
//     if (photoDir.existsSync()) photoDir.delete(recursive: true);
//   }

//   Future<Directory> getPhotoFolder() async {
//     final dir = await getApplicationDocumentsDirectory();
//     return createFolder(dir.path + _photosFolder);
//   }

//   Future<void> clearCorrectPhotoFolder() async {
//     final dir = await getApplicationDocumentsDirectory();
//     Directory photoDir = new Directory(dir.path + _correctPhotosFolder);
//     if (photoDir.existsSync()) photoDir.delete(recursive: true);
//   }

//   Future<Directory> getCorrectPhotoFolder() async {
//     final dir = await getApplicationDocumentsDirectory();
//     return createFolder(dir.path + _correctPhotosFolder);
//   }

//   Future<Directory> createCardFolder(String folderName) async {
//     final dir = await getApplicationDocumentsDirectory();
//     return createFolder(dir.path + _photosFolder + "/" + folderName);
//   }

//   Future<Directory> createFolder(String path) async {
//     final dir = new Directory(path);
//     var exists = await dir.exists();
//     if (!exists) {
//       dir.create(recursive: true);
//     }
//     return dir;
//   }

//   Future<FileSystemEntity> delete(File file) {
//     return file.delete(recursive: false);
//   }
// }
