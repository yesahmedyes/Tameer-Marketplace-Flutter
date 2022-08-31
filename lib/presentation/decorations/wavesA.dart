import 'package:flutter/material.dart';

class WavesA extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;

    Paint paint1 = Paint()..color = const Color.fromRGBO(255, 192, 192, 1);

    Path path1 = Path();
    path1.moveTo(0, 0.78 * h);
    path1.quadraticBezierTo(0.20 * w, 0.68 * h, 0.28 * w, 0.8 * h);
    path1.cubicTo(0.38 * w, 0.93 * h, 0.6 * w, 0.72 * h, 0.8 * w, 0.84 * h);
    path1.cubicTo(0.9 * w, 0.92 * h, 0.55 * w, 0.95 * h, 0.55 * w, h);
    path1.lineTo(0, h);
    canvas.drawPath(path1, paint1);

    Paint paint2 = Paint()..color = const Color.fromRGBO(231, 231, 239, 1);

    Path path2 = Path();
    path2.moveTo(0.6 * w, 0);
    path2.cubicTo(0.1 * w, 0.32 * h, 0.5 * w, 0.24 * h, 0.55 * w, 0.26 * h);
    path2.cubicTo(0.7 * w, 0.26 * h, 0.45 * w, 0.5 * h, 0.9 * w, 0.4 * h);
    path2.quadraticBezierTo(1 * w, 0.37 * h, w, 0.36 * h);
    path2.lineTo(w, 0);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
