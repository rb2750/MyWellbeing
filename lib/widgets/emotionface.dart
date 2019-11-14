import 'package:flutter/material.dart';
import 'dart:math' as Math;

import 'package:flutter/widgets.dart';
import '../main.dart';

class EmotionFace extends StatefulWidget {
  @override
  EmotionFaceState createState() => EmotionFaceState();
}

class EmotionFaceState extends State<EmotionFace> with SingleTickerProviderStateMixin {
  double tearOffset=0;

  Animation<double> _animation;
  AnimationController controller;

  EmotionFaceState();

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
    _animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        double emotionLevel = MyWellbeing.emotion;
        if (emotionLevel < 10) {
          setState(() {
            tearOffset = _animation.value;
          });
        }
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double emotionLevel = MyWellbeing.emotion;
    var painter = SmileyPainter(emotionLevel, tearOffset);

    var size = Math.min(140.0, MediaQuery.of(context).size.width / 2.6);

    return Center(
      child: Container(
          width: size,
          height: size,
          child: CustomPaint(
            painter: painter,
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
    drawMouth(canvas, center, radius, size);
    drawEyes(canvas, center, size);
    if (smileAmount < 6) {
      drawTear(canvas, center, radius);
    }
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

    double paddingX = lerp(smileAmount / 100, 25 /*Very Sad*/, lerp(smileAmount / 100, 30/*Middle*/, 20 /*Very happy*/)); //20;
    double paddingY = 18;

    double width = size.width;
    double height = size.width;
    double x = paddingX;
    double y = (height / 2) + paddingY + lerp(smileAmount / 100, 10 /*Very Sad*/, 0 /*Very happy*/);

    Path path = Path()
      ..moveTo(x + 5, y)
      ..quadraticBezierTo((width / 2), y + lerp(smileAmount / 100, -20, lerp(smileAmount / 100, 0, 30)), (width - paddingX), (y));

    canvas.drawPath(path, mouthPaint);
  }

  void drawTear(Canvas canvas, center, radius) {
    Paint tearPaint = Paint()
      ..color = Colors.blue.withAlpha((255 * lerp(tearOffset, 1, lerp(tearOffset, 0.98, 0))).floor())
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..strokeWidth = 4.0;

    double maxXOffset = 40;

    double x = (center.dx + radius / 2) - 5 + maxXOffset + lerp(tearOffset, -maxXOffset, lerp(tearOffset, 0, -maxXOffset)); //lerp(tearOffset, 0, -20);
    double y = (center.dy - radius / 2) + 23 + (tearOffset * 30) * 2;

    double degrees = lerp(tearOffset, -25, 55);

    double rotation = degrees * Math.pi / 180; //-Math.pi*0.4 * distance;

    double width = 15;
    double height = 20;

    canvas.translate(x, y);
    canvas.rotate(rotation);
    canvas.drawPath(
        Path()
//          ..moveTo(x, y)
          ..quadraticBezierTo(width, height, 0, height * 1.25)
          ..quadraticBezierTo(-width, height, 0, 0)
//          ..transform(Matrix4.rotationY(Math.pi).storage)
        ,
        tearPaint);
    canvas.rotate(-rotation);
    canvas.translate(-x, -y);
  }

  void drawFace(canvas, center, radius, size) {
    final Gradient gradient = new RadialGradient(
      colors: <Color>[
        Colors.yellow[400],
        Colors.yellow[600],
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
    double overallYOffset = -lerp(smileAmount / 100, 3, lerp(smileAmount / 100, 20, 5)) + 5;

    double offsetx1 = 15; //Left of eyebrow x offset
    double offsety1 = -16 + overallYOffset; //Left of eyebrow y offset
    double offsetx2 = 0; //Middle of eyebrow x offset
    double offsety2 = -lerp(smileAmount / 100, 0, 15) - 15 + overallYOffset; //Middle of eyebrow y offset
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
      y += 10;
      canvas.drawArc(
          new Rect.fromLTWH(x - 10, y - 15, 20, 17),
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
          new Rect.fromLTWH(x - 10, y - 15, 20, 18),
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
  bool shouldRepaint(SmileyPainter oldDelegate) => smileAmount <= 10 || smileAmount != oldDelegate.smileAmount; //Only if crying
}

double lerp(double t, num min, num max) {
  return min + t * (max - min);
}
