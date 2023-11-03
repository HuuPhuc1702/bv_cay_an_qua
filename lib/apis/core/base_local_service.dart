// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:path_provider/path_provider.dart';

// abstract class BaseLocalService {
//   static const LOCAL_DB = 'colleaguesdb';

//   BaseLocalService();

//   Future<String> get _localPath async {
//     final directory = await getApplicationDocumentsDirectory();
//     return directory.path;
//   }

//   dynamic loadJsonDB(String name) async {
//     final path = await _localPath;
//     try {
//       final file = File('$path/$LOCAL_DB/$name');
//       String contents = await file.readAsString();
//       return contents == null ? null : json.decode(contents);
//     } catch (e) {
//       return null;
//     }
//   }

//   void saveJsonDB(String name, String raw) async {
//     final path = await _localPath;
//     try {
//       final file = File('$path/$LOCAL_DB/$name');
//       await file.writeAsString(raw);
//     } catch (e) {
//       print('saveJsonDB' + '$e');
//     }
//   }
// }
