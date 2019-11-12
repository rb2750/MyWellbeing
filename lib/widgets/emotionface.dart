import 'package:flutter/material.dart';
import 'dart:math' as Math;

import 'package:flutter/widgets.dart';

class EmotionFace extends StatelessWidget {
  double emotionLevel;

  EmotionFace(this.emotionLevel);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 140,
          height: 140,
          child: CustomPaint(
            painter: SmileyPainter(this.emotionLevel),
          )),
    );
  }
}

class SmileyPainter extends CustomPainter {
  double smileAmount;

  SmileyPainter(this.smileAmount);

  @override
  void paint(Canvas canvas, Size size) {
    final radius = Math.min(size.width, size.height) / 2;
    final center = Offset(size.width / 2, size.height / 2);

    drawFace(canvas, center, radius, size);
    if(smileAmount<6)
    {
      drawTear(canvas, center, radius);
    }
    drawMouth(canvas, center, radius, size);
    drawEyes(canvas, center, size);
  }

  void drawEyes(canvas, center, size) {
    bool smiling = smileAmount > 80;
    bool frowning = smileAmount <= 20;

    drawEye(canvas, (center.dx) - size.width / 7.5, center.dy - size.height / 7.5, smiling, frowning, true);
    drawEye(canvas, (center.dx) + size.width / 7.5, center.dy - size.height / 7.5, smiling, frowning, false);
  }

  void drawMouth(canvas, center, radius, size) {
    Paint mouthPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    Path path = Path();

    double xPosition = size.width / 7.5;

    var smileEffector = smileAmount / 100;
    var yOffset = 15 + lerp(smileEffector, 10 /*Very Sad*/, 0 /*Very happy*/);
    double yPosition = (size.height / 2) + yOffset;

    path.moveTo(xPosition + 5, yPosition);
    path.quadraticBezierTo((size.width / 2), lerp(smileEffector, size.width / 1.8 /*Very Sad*/, size.width / 1.3 /*Very happy*/), (size.width - xPosition), (yPosition));
    canvas.drawPath(path, mouthPaint);
  }

  void drawTear(canvas, center, radius) {
    Paint tearPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..strokeWidth = 4.0;
    double x = (center.dx + radius / 2) - 5;
    double y = (center.dy - radius / 2) + 23;
    canvas.drawPath(
        Path()
          ..moveTo(x, y)
          ..quadraticBezierTo(x + 15, y + 20, x, y + 24)
          ..quadraticBezierTo(x - 15, y + 20, x, y),
        tearPaint);
  }

  void drawFace(canvas, center, radius, size) {
    final Gradient gradient = new RadialGradient(
      colors: <Color>[
        Colors.yellow[300],
        Colors.yellow[800],
      ],
      center: Alignment(0.2, 0.2),
      radius: 0.2,
      tileMode: TileMode.clamp,
      stops: [
        0,
        0.7,
      ],
    );
    final paint = Paint()..shader = gradient.createShader(Rect.fromCircle(center: new Offset(0.0, 0.0), radius: size.width * 2));
    canvas.drawCircle(center, radius, paint);
  }

  void drawEye(canvas, x, y, happy, sad, left) {
    if (left) {
      canvas.drawPath(
          Path()
            ..moveTo(x - 15, y - 10)
            ..quadraticBezierTo(x, y - 10 - (lerp(smileAmount / 100, 0, 20)), x + 5, y - 25),
          Paint()
            ..isAntiAlias = true
            ..style = PaintingStyle.stroke
            ..strokeWidth = 5);
    } else {
      canvas.drawPath(
          Path()
            ..moveTo(x + 15, y - 10)
            ..quadraticBezierTo(x, y - 10 - (lerp(smileAmount / 100, 0, 20)), x - 5, y - 25),
          Paint()
            ..isAntiAlias = true
            ..style = PaintingStyle.stroke
            ..strokeWidth = 5);
    }
    if (sad) {
      y += 5;
      canvas.drawArc(
          new Rect.fromLTWH(x - 10, y - 15, 20, 20),
          Math.pi * 2 + 0.2,
          Math.pi - 0.4,
          false,
          new Paint()
            ..isAntiAlias = true
            ..strokeWidth = 4.0
            ..color = Colors.black
            ..style = PaintingStyle.stroke);
    } else if (happy) {
      y += 10;
      canvas.drawArc(
          new Rect.fromLTWH(x - 10, y - 15, 20, 20),
          Math.pi,
          Math.pi,
          false,
          new Paint()
            ..isAntiAlias = true
            ..strokeWidth = 4.0
            ..color = Colors.black
            ..style = PaintingStyle.stroke);
    } else {
      canvas.drawCircle(Offset(x, y), 8.0, Paint());
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

double lerp(double t, num min, num max) {
  return min + t * (max - min);
}
