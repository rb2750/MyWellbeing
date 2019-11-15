import 'package:flutter/material.dart';
import 'dart:math' as Math;

import 'package:flutter/widgets.dart';
import 'package:my_wellbeing/widgets/faceconfiguration.dart';
import '../main.dart';

class EmotionFaceState extends StatelessWidget {
  FaceConfiguration configuration;

  EmotionFaceState(this.configuration);

  @override
  Widget build(BuildContext context) {
    var painter = SmileyPainter(configuration);

    var size = Math.max(
        configuration.face.minSize,
        Math.min(
            configuration.face.maxSize,
            MediaQuery.of(context).size.width *
                configuration.face.sizeAsPercentageOfWidth));

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
  FaceConfiguration configuration;

  SmileyPainter(this.configuration);

  @override
  void paint(Canvas canvas, Size size) {
    final radius = Math.min(size.width, size.height) / 2;
    final center = Offset(size.width / 2, size.height / 2);

    drawFace(canvas, center, radius, size);
    drawMouth(canvas, center, radius, size);
    drawEyes(canvas, center, size);
  }

  void drawEyes(canvas, center, size) {
    drawEye(canvas, center, configuration.eyes.left);
    drawEye(canvas, center, configuration.eyes.right);
    drawEyebrow(canvas, center.dx, center.dy, configuration.eyebrows.left);
    drawEyebrow(canvas, center.dx, center.dy, configuration.eyebrows.right);
  }

  void drawMouth(Canvas canvas, Offset center, double radius, Size size) {
    Paint mouthPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    double paddingX = configuration.mouth.xPadding;
    double yOffset = configuration.mouth.yOffsetFromCenter;

    double x = paddingX;
    double y = center.dy + yOffset;

    Path path = Path()
      ..moveTo(x + 5, y)
      ..quadraticBezierTo(center.dx, y + configuration.mouth.pullDownAmount,
          (size.width - paddingX), (y));

    canvas.drawPath(path, mouthPaint);
  }

  void drawFace(canvas, center, radius, size) {
    final paint = Paint()
      ..shader = configuration.face.color.createShader(Rect.fromCircle(
          center: new Offset(0.0, 0.0), radius: size.width * 2));
    canvas.drawCircle(center, radius, paint);
  }

  void drawEyebrow(canvas, x, y, Eyebrow eyebrow) {
    double overallXOffset = eyebrow.offsetFromEyeX;
    double overallYOffset = eyebrow.offsetFromEyeY;

    double offsetx1 = eyebrow.leftOfEyebrowOffsetX +
        overallXOffset; //Left of eyebrow x offset
    double offsety1 = eyebrow.leftOfEyebrowOffsetY +
        overallYOffset; //Left of eyebrow y offset
    double offsetx2 = eyebrow.middleOfEyebrowOffsetX +
        overallXOffset; //Middle of eyebrow x offset
    double offsety2 = eyebrow.middleOfEyebrowOffsetY +
        overallYOffset; //Middle of eyebrow y offset
    double offsetx3 = eyebrow.rightOfEyebrowOffsetX +
        overallXOffset; //Right of eyebrow x offset
    double offsety3 = eyebrow.rightOfEyebrowOffsetY +
        overallYOffset; //Right of eyebrow x offset

//    if (left) {
//      offsetx1 *= -1;
//      offsetx2 *= -1;
//      offsetx3 *= -1;
//    }

    canvas.drawPath(
        Path()
          ..moveTo(x + offsetx1, y + offsety1)
          ..quadraticBezierTo(
              x + offsetx2, y + offsety2, x + offsetx3, y + offsety3),
        Paint()
          ..isAntiAlias = true
          ..color = Colors.black54
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4);
  }

  void drawEye(Canvas canvas, Offset center, Eye eye) {
    if (eye is ArcEye) {
      canvas.drawArc(
          new Rect.fromLTWH(center.dx + eye.offsetFromCenterX,
              center.dy + eye.offsetFromCenterY, eye.radiusX, eye.radiusY),
          eye.startAngleRadians,
          eye.sweepAngleRadians,
          false,
          new Paint()
            ..isAntiAlias = true
            ..strokeWidth = 4.0
            ..color = eye.color
            ..style = PaintingStyle.stroke);
    } else {
      canvas.drawCircle(Offset(eye.offsetFromCenterX, eye.offsetFromCenterY),
          8.0, Paint()..color = eye.color);
    }
  }

  @override
  bool shouldRepaint(SmileyPainter oldDelegate) => false;
}

double lerp(double t, num min, num max) {
  return min + t * (max - min);
}
