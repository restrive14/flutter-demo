import 'dart:ui';

import 'package:demo/model/Line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 画板绘画区域
class PaperPainter extends CustomPainter {
  late Paint _paint;
  final List<Line> lines;

  PaperPainter({
    required this.lines,
  }) {
    _paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < lines.length; i++) {
      drawLine(canvas, lines[i]);
    }
  }

  void drawLine(Canvas canvas, Line line) {
    _paint.color = line.color!;
    _paint.strokeWidth = line.strokeWidth!;
    canvas.drawPoints(PointMode.polygon, line.points, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
