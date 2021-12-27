import 'dart:math';

import 'package:flutter/material.dart';

class SignaturePainter extends CustomPainter {
  final List<Offset?> points;

  SignaturePainter(this.points);

  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      final prevPoint = points[i];
      final nextPoint = points[i + 1];
      if (prevPoint != null && nextPoint != null) {
        var x1 = nextPoint.dx;
        var x2 = prevPoint.dx;
        var y1 = nextPoint.dy;
        var y2 = prevPoint.dy;
        draw(canvas, x1, x2, y1, y2);
      }
    }
  }

  bool shouldRepaint(SignaturePainter other) => true;

  void draw(
    Canvas canvas,
    double x1,
    double x2,
    double y1,
    double y2,
  ) {
    Paint paint = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    var steep = ((y2 - y1).abs() > (x2 - x1).abs());
    if (steep) {
      var x = x1;
      x1 = y1;
      y1 = x;

      var y = y2;
      y2 = x2;
      x2 = y;
    }
    if (x1 > x2) {
      var x = x1;
      x1 = x2;
      x2 = x;

      var y = y1;
      y1 = y2;
      y2 = y;
    }

    var dx = x2 - x1;
    var dy = (y2 - y1).abs();
    double error = 0;
    double de = dy / dx;
    var yStep = -1;
    var y = y1;

    if (y1 < y2) {
      yStep = 1;
    }

    var lineThickness =
        5 - sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1)) / 10;
    if (lineThickness < 2) {
      lineThickness = 2;
    }

    for (var x = x1; x < x2; x++) {
      if (steep) {
        canvas.drawCircle(
          Offset(y, x),
          lineThickness / 2,
          paint,
        );
      } else {
        canvas.drawCircle(
          Offset(x, y),
          lineThickness / 2,
          paint,
        );
      }

      error += de;
      if (error >= 0.5) {
        y += yStep;
        error -= 1.0;
      }
    }
  }
}
