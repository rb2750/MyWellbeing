import 'package:flutter/material.dart';
import 'dart:math' as Math;

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
      stops: [
        0.2,
        1,
      ],
    );
    final paint = Paint()
      ..shader = gradient.createShader(Rect.fromCircle(
        center: new Offset(0.0, 0.0),
        radius: 180.0,
      ));
    // final paint = Paint()..color = Colors.red;
    canvas.drawCircle(center, radius, paint);
    // Draw the mouth
    final smilePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    // Point 0: 0
    // Point 1: -50, 50
    // Point 2: 0

    Paint mouthPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    Path path = Path();
    double width = size.width;
    double height = size.height;

    double xPosition = 20;
    var yOffset = 15;

    var smileEffector = smileAmount / 100;
    double yPosition = (height / 2) + yOffset;

    path.moveTo(xPosition, yPosition);
    path.quadraticBezierTo(
        (width / 2),
        lerp(smileEffector, 60 /*Very Sad*/, 100 /*Very happy*/),
        (width - xPosition),
        (yPosition));
    canvas.drawPath(path, mouthPaint);
    // Draw the eyes
    canvas.drawCircle(
        Offset((center.dx - radius / 2) + 5, (center.dy - radius / 2) + 8),
        5,
        Paint());
    canvas.drawCircle(
        Offset((center.dx + radius / 2) - 5, (center.dy - radius / 2) + 8),
        5,
        Paint());
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

double lerp(double t, num min, num max) {
  return min + t * (max - min);
}
