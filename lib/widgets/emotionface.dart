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
          width: 120,
          height: 120,
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
    // Draw the body
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
    // final paint = Paint()..color = Colors.red;
    canvas.drawCircle(center, radius, paint);
    // Draw the mouth
    final smilePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    // Point 0: 0
    // Point 1: -50, 50
    // Point 2: 0

    Paint tearPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..strokeWidth = 4.0;

    double width = size.width;
    double height = size.height;
    double eyeXOffset = 10;
    double teareyex = (center.dx + radius / 2) - eyeXOffset;
    double teareyey = (center.dy - radius / 2) + 8;
    if (smileAmount < 20 && false /*TODO TEMP*/) {
      Path tearpath = Path();

      var tearyOffset = 15;

      tearpath.moveTo(teareyex, teareyey);
      tearpath.quadraticBezierTo(teareyex + 35, teareyey + 5, (teareyex + 20 - smileAmount), teareyey + 5 + (20 - smileAmount));
      canvas.drawPath(tearpath, tearPaint);
    }

    Paint mouthPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    Path path = Path();

    double xPosition = 20;

    var smileEffector = smileAmount / 100;
    var yOffset = 15 + lerp(smileEffector, 10 /*Very Sad*/, 0 /*Very happy*/);
    double yPosition = (height / 2) + yOffset;

    path.moveTo(xPosition, yPosition);
    path.quadraticBezierTo((width / 2), lerp(smileEffector, 60 /*Very Sad*/, 100 /*Very happy*/), (width - xPosition), (yPosition));
    canvas.drawPath(path, mouthPaint);

    bool eyeSmile = smileAmount > 80;
    bool eyeCry = smileAmount <= 20;

    // Draw the eyes
//    canvas.drawCircle(Offset((center.dx - radius / 2) + eyeXOffset, (center.dy - radius / 2) + 8), 12, Paint()..color = Colors.white);

    drawEye(canvas, (center.dx) - 22, center.dy - 20, eyeSmile, eyeCry, true);
    drawEye(canvas, (center.dx) + 22, center.dy - 20, eyeSmile, eyeCry, false);

//    if (smileAmount < 20) {
//    } else {
//      canvas.drawCircle(Offset((center.dx - radius / 2) + eyeXOffset, (center.dy - radius / 2) + 8), 8, Paint());
//    }
//    canvas.drawCircle(
//        Offset((center.dx - radius / 2) + eyeXOffset, (center.dy - radius / 2) + 8),
//        15,
//        Paint()
//          ..color = Colors.black
//          ..style = PaintingStyle.stroke
//          ..strokeWidth = 0.5);
//    canvas.drawCircle(Offset(teareyex, teareyey), 12, Paint()..color = Colors.white);
//    canvas.drawCircle(Offset(teareyex, teareyey), 8, Paint());
//    canvas.drawArc(
//        new Rect.fromLTWH(teareyex - 10, teareyey - 8 + (eyeSmile ? 7 : 0), eyeSmile ? 20 : 17, eyeSmile ? 20 : 17),
//        Math.pi,
//        eyeSmile ? Math.pi : Math.pi * 2,
//        false,
//        new Paint()
//          ..isAntiAlias = true
//          ..strokeWidth = 4.0
//          ..color = Colors.black
//          ..style = eyeSmile ? PaintingStyle.stroke : PaintingStyle.fill);
//    canvas.drawCircle(
//        Offset(teareyex, teareyey),
//        15,
//        Paint()
//          ..color = Colors.black
//          ..style = PaintingStyle.stroke
//          ..strokeWidth = 0.5);
//    arc(size, canvas);
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
            ..strokeWidth =5);
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
//      x -= 10;
//      y += 10;
//      double width = 30;
//      double height = 20;
//      x -= width / 2;
//      Path eyePath = Path()
//        ..moveTo(x, y)
//        ..quadraticBezierTo(x + (width / 2), y - height, x + width, y)
//        ..quadraticBezierTo(x + width, y+10, x + (width / 2), y)
//        ..quadraticBezierTo(x + (width / 2), y, x,y+5)
//        ..quadraticBezierTo(x,y+6, x,y);
////        ..quadraticBezierTo(x + (width / 2), y - (height / 4), x, y);
////        ..quadraticBezierTo(x + (width / 2), y - (height / 4), x, y);
//      canvas.drawPath(eyePath, Paint()..style = PaintingStyle.fill);
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

  void arc(size, canvas) {
    Paint paint = new Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..strokeWidth = 2
      ..color = Colors.purple[700];

    Path path = Path()..quadraticBezierTo(20, -30, 30, 0)..quadraticBezierTo(20, -10, 0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

double lerp(double t, num min, num max) {
  return min + t * (max - min);
}
