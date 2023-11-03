// yyyy-MM-dd'T'HH:mm:ss.SSS'Z'

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

String dateTimeConvertString(
    {required DateTime dateTime, required String dateType}) {
  var local = initializeDateFormatting("vi_VN");
  return DateFormat(dateType, "vi_VN").format(dateTime.toLocal());
}

String formatTime(String? time) {
  var local = initializeDateFormatting("vi_VN");
  timeago.setLocaleMessages('vi', timeago.ViMessages());
  String result="";
  if(time!=null){
    result = timeago.format(DateTime.parse(time).toLocal(), locale: 'vi');
  }
  if (result == "một thoáng trước") {
    return "khoảng một phút trước";
  }
  return result;
}

DateTime stringConvertDateTime(
    {required String dateTime, required String dateType}) {
  var local = initializeDateFormatting("vi_VN");
  return DateFormat(dateType, "vi_VN").parse(dateTime);
}
