import 'package:flutter/material.dart';

class FaceConfiguration {
  Eyebrows eyebrows;
  Eyes eyes;
  Face face;
  Mouth mouth;

  FaceConfiguration(this.eyebrows, this.eyes, this.face, this.mouth);
}

class Eyebrows {
  double leftOfEyebrowOffsetX;
  double leftOfEyebrowOffsetY;
  double middleOfEyebrowOffsetX;
  double middleOfEyebrowOffsetY;
  double rightOfEyebrowOffsetX;
  double rightOfEyebrowOffsetY;

  //All these are offsets from the eye itself.
  double offsetFromEyeX;
  double offsetFromEyeY;

  Eyebrows(this.leftOfEyebrowOffsetX, this.leftOfEyebrowOffsetY, this.middleOfEyebrowOffsetX, this.middleOfEyebrowOffsetY, this.rightOfEyebrowOffsetX, this.rightOfEyebrowOffsetY, this.offsetFromEyeX,
           this.offsetFromEyeY);
}

class Eyes {
  Eye leftEye;
  Eye rightEye;

  Eyes(this.leftEye, this.rightEye);
}

class Eye
{
  Color color;
  double offsetFromCenterX;
  double offsetFromCenterY;

  Eye(this.color,this.offsetFromCenterX,this.offsetFromCenterY);
}

class ArcEye
{
  double radiusX;
  double radiusY;
  double startAngleRadians;
  double sweepAngleRadians;

  ArcEye(this.radiusX, this.radiusY, this.startAngleRadians, this.sweepAngleRadians);
}

class Mouth {
  double xPadding;
  double yOffsetFromCenter;
  double pullDownAmount; //How much the center of the mouth is pulled down from its center.

  Mouth(this.xPadding, this.yOffsetFromCenter, this.pullDownAmount);
}

class Face {
  int minSize;
  int maxSize;
  double sizeAsPercentageOfWidth;
  Gradient color;

  Face(this.minSize, this.maxSize, this.sizeAsPercentageOfWidth, this.color);
}

class FaceDefaults {
  static Gradient defaultGradient = new RadialGradient(
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
}
