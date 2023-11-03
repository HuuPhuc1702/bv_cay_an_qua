//This import the package
import 'dart:io';

import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

//...
//Here comes code of Flutter
//...

//Now I define the async function to make the request
class HtmlUtil {
  static Future<String> getHtml(String url) async {
    var response = await http.get(Uri.parse(url));
    //If the http request is successful the st*atusCode will be 200
    if (response.statusCode == 200) {
      String htmlToParse = response.body;
      print(htmlToParse);
      return htmlToParse;
    }
    return '';
  }

  static Future<File> createFileOfPdfUrl(String url) async {
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future<File?> downloadFileFromUrl(String url) async {
    try {
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      Directory? downloadsDirectory = await DownloadsPathProvider.downloadsDirectory;
      String? dir = downloadsDirectory?.path;
      File file = new File('$dir/$filename');
      await file.writeAsBytes(bytes);
      return file;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static String? convertUrlToId(String url, {bool trimWhitespaces = true}) {
  assert(url.isNotEmpty , 'Url cannot be empty');
  if (!url.contains("http") && (url.length == 11)) return url;
  if (trimWhitespaces) url = url.trim();

  for (var exp in [
    RegExp(
        r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
    RegExp(
        r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
    RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$"),
        RegExp(
        r"^http:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
    RegExp(
        r"^http:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
    RegExp(r"^http:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
  ]) {
    RegExpMatch? match = exp.firstMatch(url);
    if (match != null && match.groupCount >= 1) return match.group(1);
  }

  return null;
}

 static position(String initialUrl, {String start = '<figure class=\"media\"><oembed url=', String end = '</oembed></figure>'}){
  List urls = [];
  
  String init = initialUrl;
  init = init.replaceAll("<p style=\"text-align:justify;\">&nbsp;</p>", "<p style=\"margin-left:0px;text-align:justify;\"><br></p>");
  init = init.replaceAll("<p style=\"margin-left:0px;text-align:justify;\">&nbsp;</p>", "<p style=\"margin-left:0px;text-align:justify;\"><br></p>");
  String a = init;

  print(init);
  
  int index_start = a.indexOf(start);
  int index_end = a.indexOf(end);

   
   if (index_start != -1 && index_end != -1) {
        urls.add([index_start, index_end]);
        a = a.substring(index_end + end.length, a.length);

        while (index_start != -1 && index_end != -1) {
        index_start = a.indexOf(start);
        index_end = a.indexOf(end);
        
        if (index_start != -1 && index_end != -1) {
              urls.add([index_start + urls.last[1] + end.length, index_end + urls.last[1]+ end.length]);
              print("=================--------------------");
              print(init.substring(index_start, index_end));
              a = a.substring(index_end + end.length, a.length );
        }
          }
        String returnString = init;
        for (int i = urls.length - 1 ; i >= 0; i--) {
          //print(init.substring(urls[i][0] + start.length + 1, urls[i][1] - 2));
          String? videoId = convertUrlToId(init.substring(urls[i][0] + start.length + 1, urls[i][1] - 2));
          videoId = '<iframe width="560" src="https://www.youtube.com/embed/$videoId" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"></iframe>';
          print(videoId);
          print(returnString.substring(urls[i][0] , urls[i][1] + end.length));
          returnString = returnString.replaceRange(urls[i][0] , urls[i][1] + end.length, videoId);
        }
        return returnString;
      } else {
          return init;
      }

 }
}
