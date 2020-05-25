import 'package:flutter/material.dart';
import 'dart:math' as Math;

import 'package:flutter/widgets.dart';
import '../widgets/faceconfiguration.dart';

class StaticFace extends StatelessWidget {
  FaceConfiguration configuration;

  StaticFace(this.configuration);

  @override
  Widget build(BuildContext context) {
    var painter = SmileyPainter(configuration);

    var size = MediaQuery.of(context).size.width *
        configuration.face.sizeAsPercentageOfWidth;

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

  void drawEyes(Canvas canvas, Offset center, Size size) {
    double eye1XOffset = center.dx +
        size.width * configuration.eyes.left.offsetFromCenterXPercentage;
    double eye1YOffset = center.dy +
        size.height * configuration.eyes.left.offsetFromCenterYPercentage;
    double eye2XOffset = center.dx -
        size.width * configuration.eyes.right.offsetFromCenterXPercentage;
    double eye2YOffset = center.dy -
        size.height * configuration.eyes.right.offsetFromCenterYPercentage;

    drawEye(
        canvas,
        eye1XOffset -
            (configuration.eyes.left is ArcEye
                ? ((size.width * configuration.eyes.left.radiusPercentage))
                : 0),
        eye1YOffset,
        configuration.eyes.left,
        size);
    drawEye(canvas, eye2XOffset, eye2YOffset, configuration.eyes.right, size);
    drawEyebrow(
        canvas, eye1XOffset, eye1YOffset, size, configuration.eyebrows.left);
    drawEyebrow(
        canvas, eye2XOffset, eye2YOffset, size, configuration.eyebrows.right);
  }

  void drawMouth(Canvas canvas, Offset center, double radius, Size size) {
    Paint mouthPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * (4.0 / 140.0);

    double paddingX = configuration.mouth.xPaddingPercentage * size.width;
    double yOffset =
        configuration.mouth.yOffsetFromCenterPercentage * size.height;

    double x = paddingX;
    double y = center.dy + yOffset;

    Path path = Path()
      ..moveTo(x, y)
      ..quadraticBezierTo(
          center.dx,
          y + configuration.mouth.pullDownAmountPercentage * size.height,
          (size.width - paddingX),
          (y));

    canvas.drawPath(path, mouthPaint);
  }

  void drawFace(canvas, center, radius, size) {
    final paint = Paint()
      ..shader = configuration.face.gradient.createShader(Rect.fromCircle(
          center: new Offset(0.0, 0.0), radius: size.width * 2));
    canvas.drawCircle(center, radius, paint);
  }

  void drawEyebrow(canvas, x, y, Size size, Eyebrow eyebrow) {
    double overallXOffset = eyebrow.offsetFromEyeXPercentage * size.width;
    double overallYOffset = eyebrow.offsetFromEyeYPercentage * size.height;

    double offsetx1 = eyebrow.leftOfEyebrowOffsetXPercentage * size.width +
        overallXOffset; //Left of eyebrow x offset
    double offsety1 = eyebrow.leftOfEyebrowOffsetYPercentage * size.height +
        overallYOffset; //Left of eyebrow y offset
    double offsetx2 = eyebrow.middleOfEyebrowOffsetXPercentage * size.width +
        overallXOffset; //Middle of eyebrow x offset
    double offsety2 = eyebrow.middleOfEyebrowOffsetYPercentage * size.height +
        overallYOffset; //Middle of eyebrow y offset
    double offsetx3 = eyebrow.rightOfEyebrowOffsetXPercentage * size.width +
        overallXOffset; //Right of eyebrow x offset
    double offsety3 = eyebrow.rightOfEyebrowOffsetYPercentage * size.height +
        overallYOffset; //Right of eyebrow x offset

    canvas.drawPath(
        Path()
          ..moveTo(x + offsetx1, y + offsety1)
          ..quadraticBezierTo(
              x + offsetx2, y + offsety2, x + offsetx3, y + offsety3),
        Paint()
          ..isAntiAlias = true
          ..color = Colors.black54
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * (4 / 140));
  }

  void drawEye(
      Canvas canvas, double xOffset, double yOffset, Eye eye, Size size) {
    if (eye is ArcEye) {
      canvas.drawArc(
          new Rect.fromLTWH(
              xOffset,
              yOffset,
              size.width * eye.radiusXPercentage,
              size.height * eye.radiusYPercentage),
          eye.startAngleRadians,
          eye.sweepAngleRadians,
          false,
          new Paint()
            ..isAntiAlias = true
            ..strokeWidth = size.width * (4 / 140)
            ..color = eye.color
            ..style = PaintingStyle.stroke);
    } else {
      canvas.drawCircle(Offset(xOffset, yOffset),
          eye.radiusPercentage * size.width, Paint()..color = eye.color);
    }
  }

  @override
  bool shouldRepaint(SmileyPainter oldDelegate) => false;
}

double lerp(double t, num min, num max) {
  return min + t * (max - min);
}
