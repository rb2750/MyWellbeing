import 'package:flutter/material.dart';
import 'dart:math' as Math;

import 'package:flutter/widgets.dart';

class EmotionFace extends StatefulWidget {
  var sliderValue;

  EmotionFace(this.sliderValue);

  @override
  EmotionFaceState createState() => EmotionFaceState(this.sliderValue);
}

class EmotionFaceState extends State<EmotionFace> with SingleTickerProviderStateMixin {
  var sliderValue;
  double tearOffset;

  Animation<double> _animation;
  AnimationController controller;

  EmotionFaceState(this.sliderValue);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: Duration(milliseconds: 2500), vsync: this);

    controller.forward();

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reset();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double emotionLevel = sliderValue();
    _animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        if (emotionLevel < 10) {
          setState(() {
            tearOffset = _animation.value;
          });
        }
      });

    return Center(
      child: Container(
          width: 140,
          height: 140,
          child: CustomPaint(
            painter: SmileyPainter(emotionLevel, tearOffset),
          )),
    );
  }
}

class SmileyPainter extends CustomPainter {
  double smileAmount;
  double tearOffset;

  SmileyPainter(this.smileAmount, this.tearOffset);

  @override
  void paint(Canvas canvas, Size size) {
    final radius = Math.min(size.width, size.height) / 2;
    final center = Offset(size.width / 2, size.height / 2);

    drawFace(canvas, center, radius, size);
    if (smileAmount < 6) {
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

  void drawMouth(Canvas canvas, Offset center, double radius, Size size) {
    Paint mouthPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    double paddingX = lerp(smileAmount / 100, 25 /*Very Sad*/, 20 /*Very happy*/); //20;
    double paddingY = 20;

    double width = size.width;
    double height = size.width;
    double x = paddingX;
    double y = (height / 2) + paddingY + lerp(smileAmount / 100, 10 /*Very Sad*/, 0 /*Very happy*/);

    Path path = Path()
      ..moveTo(x + 5, y)
      ..quadraticBezierTo((width / 2), y + lerp(smileAmount / 100, -20 /*Very Sad*/, 30 /*Very happy*/), (width - paddingX), (y));

    canvas.drawPath(path, mouthPaint);
  }

  void drawTear(Canvas canvas, center, radius) {
    Paint tearPaint = Paint()
      ..color = Colors.blue.withAlpha((255 * (1 - tearOffset)).floor())
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..strokeWidth = 4.0;
    double x = (center.dx + radius / 2) - 5 + lerp(tearOffset, 0, -20);
    double y = (center.dy - radius / 2) + 23 + (tearOffset * 30)*3;
    canvas.rotate(-0.5*tearOffset);
    canvas.drawPath(
        Path()
          ..moveTo(x, y)
          ..quadraticBezierTo(x + 15, y + 20, x, y + 24)
          ..quadraticBezierTo(x - 15, y + 20, x, y)
//          ..transform(Matrix4.rotationY(Math.pi).storage)
        ,
        tearPaint);
    canvas.rotate(0.5*tearOffset);
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

  void drawEyebrows(canvas, x, y, left) {
    double overallYOffset = -lerp(smileAmount / 100, 0, 5);

    double offsetx1 = 15; //Left of eyebrow x offset
    double offsety1 = -10 + overallYOffset; //Left of eyebrow y offset
    double offsetx2 = 0; //Middle of eyebrow x offset
    double offsety2 = -lerp(smileAmount / 100, 0, 20) - 10 + overallYOffset; //Middle of eyebrow y offset
    double offsetx3 = -5; //Right of eyebrow x offset
    double offsety3 = -25 + overallYOffset; //Right of eyebrow x offset

    if (left) {
      offsetx1 *= -1;
      offsetx2 *= -1;
      offsetx3 *= -1;
    }

    canvas.drawPath(
        Path()
          ..moveTo(x + offsetx1, y + offsety1)
          ..quadraticBezierTo(x + offsetx2, y + offsety2, x + offsetx3, y + offsety3),
        Paint()
          ..isAntiAlias = true
          ..color = Colors.black54
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4);
  }

  void drawEye(canvas, x, y, happy, sad, left) {
    drawEyebrows(canvas, x, y, left);
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
          Math.pi + 0.2,
          Math.pi - 0.4,
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
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

double lerp(double t, num min, num max) {
  return min + t * (max - min);
}
