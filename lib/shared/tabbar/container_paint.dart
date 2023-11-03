import 'package:flutter/material.dart';

class ContainerPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size s) {
    // print(s.width);
    // print(s.height);
    final w = s.width;
    final h = s.height;
    final r = 40;
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 1);
    final path = Path();
    path.moveTo(0, h - 79);
    path.lineTo(w / 2 - r + 2, h - 79);
    path.arcToPoint(
      Offset(w / 2 + r - 2, h - 79),
      radius: Radius.circular(10),
      clockwise: false,
    );
    path.lineTo(w, h - 79);
    path.lineTo(w, h);
    path.lineTo(0, h);
    path.close();
    // canvas.drawShadow(path, Colors.grey.shade200, 1.0, true);
    canvas.drawShadow(path, Colors.blue.withOpacity(.5), -1.5, true);
    canvas.drawPath(path, paint);
  }

  static double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
