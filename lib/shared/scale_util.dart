// import 'package:flutter/material.dart';

// class ScaleUtil {
//   static ScaleUtil instance = ScaleUtil();

// // Thiết kế sửa đổi kích thước thiết bị
//   double width;
//   double height;
//   bool allowFontScaling;

//   static MediaQueryData _mediaQueryData;
//   static double _screenWidth;
//   static double _screenHeight;
//   static double _pixelRatio;
//   static double _statusBarHeight;

//   static double _bottomBarHeight;

//   static double _textScaleFactor;

//   ScaleUtil({
//     this.width = 375,
//     this.height = 667,
//     this.allowFontScaling = false,
//   });

//   static ScaleUtil getInstance() {
//     return instance;
//   }

//   void init(BuildContext context) {
//     MediaQueryData mediaQuery = MediaQuery.of(context);
//     _mediaQueryData = mediaQuery;
//     _pixelRatio = mediaQuery.devicePixelRatio;
//     _screenWidth = mediaQuery.size.width;
//     _screenHeight = mediaQuery.size.height;
//     _statusBarHeight = mediaQuery.padding.top;
//     _bottomBarHeight = _mediaQueryData.padding.bottom;
//     _textScaleFactor = mediaQuery.textScaleFactor;
//   }

//   static MediaQueryData get mediaQueryData => _mediaQueryData;

//   /// Số lượng pixel phông chữ trên mỗi pixel logic, tỷ lệ của phông chữ
//   static double get textScaleFactory => _textScaleFactor;

//   /// Mật độ điểm ảnh của thiết bị
//   static double get pixelRatio => _pixelRatio;

//   /// chiều rộng thiết bị hiện tại dp
//   static double get screenWidthDp => _screenWidth;

//   /// chiều cao thiết bị hiện tại dp
//   static double get screenHeightDp => _screenHeight;

//   /// chiều rộng thiết bị hiện tại px
//   static double get screenWidth => _screenWidth * _pixelRatio;

//   /// chiều cao thiết bị hiện tại px
//   static double get screenHeight => _screenHeight * _pixelRatio;

//   /// Chiều cao thanh trạng thái Lưu Haiping sẽ cao hơn
//   static double get statusBarHeight => _statusBarHeight * _pixelRatio;

//   /// Khoảng cách vùng an toàn dưới cùng
//   static double get bottomBarHeight => _bottomBarHeight * _pixelRatio;

//   /// Tỷ lệ của dp thực tế với tỉ lệ px
//   get scaleWidth => _screenWidth / instance.width;
//   get scaleHeight => _screenHeight / instance.height;

//   /// Tỉ lệ với chiều rộng thiết bị của tỉ lệ
//   /// Chiều cao cũng được điều chỉnh theo điều này để đảm bảo không bị biến dạng.
//   setWidth(double width) => width * scaleWidth;

//   ///* Tỉ lệ với chiều cao của thiết bị theo tỉ lệ
//   ///* Khi nhận thấy một màn hình trong bản phác thảo thiết kế không phù hợp với hiệu ứng kiểu hiện tại,
//   ///* hoặc khi có sự khác biệt về hình dạng, nên sử dụng phương pháp này để điều chỉnh chiều cao.
//   ///* Việc điều chỉnh chiều cao chủ yếu cho cùng hiệu ứng mà bạn muốn hiển thị theo một màn hình của bản phác thảo thiết kế.
//   setHeight(double height) => height * scaleHeight;

//   ///* Phương pháp Tỉ lệ cỡ chữ /n
//   ///* @ param fontSize Truyền px của phông chữ vào bản nháp thiết kế,\/n
//   ///* @ param allowFontScaling Điều khiển xem phông chữ có được thu nhỏ theo tùy chọn trợ năng "cỡ chữ" của hệ thống hay không. Mặc định là sai./n
//   ///* @ param allowFontScaling Chỉ định xem phông chữ có nên chia tỷ lệ để tôn trọng cài đặt trợ năng Kích thước văn bản hay không. Mặc định là sai.\/n
//   setFS(double fontSize) => allowFontScaling ? setWidth(fontSize) : setWidth(fontSize) / _textScaleFactor;
// }
