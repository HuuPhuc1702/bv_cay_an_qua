import 'package:flutter/material.dart';
import 'dart:math' as math;
class TabBarLeftPainter extends CustomPainter {
  TabBarLeftPainter({
    this.textColor,
    this.text, 
    this.fillColor = Colors.red,
    required this.topWidth,
    required this.bottomWidth,
    required this.height});

  final String ?text;
  final Color ?textColor;
  final Color ?fillColor;
  final double topWidth;
  final double bottomWidth;
  final double height;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = fillColor!
      ..strokeWidth = 0
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;
    
    final Path path = Path();

    Offset top1Point = Offset(0, 0);
    Offset top2Point = Offset(topWidth , 0);
    Offset bottom1Point = Offset(0, height );
    Offset bottom2Point = Offset(bottomWidth, height );

    path.moveTo(top1Point.dx, top1Point.dy);
    path.lineTo(top2Point.dx, top2Point.dy);
    path.lineTo(bottom2Point.dx, bottom2Point.dy);
    path.lineTo(bottom1Point.dx, bottom1Point.dy);
    path.close();

    canvas.drawPath(path, paint);

    final textStyle = TextStyle(color: textColor, fontSize: 20);
    final textSpan = TextSpan(
      text: text?.toUpperCase(),
      style: textStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final xCenter = (topWidth - textPainter.width) / 2;
    final yCenter = (height - textPainter.height) / 2;
    final offset = Offset(xCenter, yCenter);
    textPainter.paint(canvas, offset);
  
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class TabBarRightPainter extends CustomPainter {
  TabBarRightPainter({
    this.textColor,
    this.text, 
    this.fillColor = Colors.red,
    required this.topWidth,
    required this.bottomWidth,
    required this.height});

  final String? text;
  final Color ?textColor;
  final Color ?fillColor;
  final double topWidth;
  final double bottomWidth;
  final double height;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = fillColor!
      ..strokeWidth = 0
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;
    
    final Path path = Path();

    Offset top1Point = Offset(size.width - topWidth , 0);
    Offset top2Point = Offset(size.width, 0);
    Offset bottom1Point = Offset(size.width - bottomWidth, height );
    Offset bottom2Point = Offset(size.width , height );

    path.moveTo(top1Point.dx, top1Point.dy);
    path.lineTo(top2Point.dx, top2Point.dy);
    path.lineTo(bottom2Point.dx, bottom2Point.dy);
    path.lineTo(bottom1Point.dx, bottom1Point.dy);
    path.close();

    canvas.drawPath(path, paint);

    final textStyle = TextStyle(color: textColor, fontSize: 20);
    final textSpan = TextSpan(
      text: text?.toUpperCase(),
      style: textStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final xCenter = (topWidth - textPainter.width) / 2 + (size.width - topWidth);
    final yCenter = (height - textPainter.height) / 2;
    final offset = Offset(xCenter, yCenter);
    textPainter.paint(canvas, offset);
  
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}