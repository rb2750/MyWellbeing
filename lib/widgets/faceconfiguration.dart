import 'package:flutter/material.dart';

class FaceConfiguration {
  Eyebrows eyebrows;
  Eyes eyes;
  Face face;
  Mouth mouth;

  FaceConfiguration(this.face, this.eyes, this.eyebrows, this.mouth);
}

class Eyebrows {
  Eyebrow left;
  Eyebrow right;

  Eyebrows(this.left, this.right);
}

class Eyebrow {
  double leftOfEyebrowOffsetXPercentage;
  double leftOfEyebrowOffsetYPercentage;
  double middleOfEyebrowOffsetXPercentage;
  double middleOfEyebrowOffsetYPercentage;
  double rightOfEyebrowOffsetXPercentage;
  double rightOfEyebrowOffsetYPercentage;

  //All these are offsets from the eye itself.
  double offsetFromEyeXPercentage;
  double offsetFromEyeYPercentage;

  Eyebrow(this.leftOfEyebrowOffsetXPercentage, this.leftOfEyebrowOffsetYPercentage, this.middleOfEyebrowOffsetXPercentage, this.middleOfEyebrowOffsetYPercentage, this.rightOfEyebrowOffsetXPercentage,
      this.rightOfEyebrowOffsetYPercentage, this.offsetFromEyeXPercentage, this.offsetFromEyeYPercentage);
}

class Eyes {
  Eye left;
  Eye right;

  Eyes(this.left, this.right);
}

class Eye {
  Color color;
  double offsetFromCenterXPercentage;
  double offsetFromCenterYPercentage;
  double radiusPercentage;

  Eye(this.color, this.offsetFromCenterXPercentage, this.offsetFromCenterYPercentage, this.radiusPercentage);
}

class ArcEye extends Eye {
  double radiusXPercentage;
  double radiusYPercentage;
  double startAngleRadians;
  double sweepAngleRadians;

  ArcEye(this.radiusXPercentage, this.radiusYPercentage, this.startAngleRadians, this.sweepAngleRadians, Color color, double offsetFromCenterX, double offsetFromCenterY, double radius)
      : super(color, offsetFromCenterX, offsetFromCenterY, radius);
}

class Mouth {
  double xPaddingPercentage;
  double yOffsetFromCenterPercentage;
  double pullDownAmountPercentage; //How much the center of the mouth is pulled down from its center.

  Mouth(this.xPaddingPercentage, this.yOffsetFromCenterPercentage, this.pullDownAmountPercentage);
}

class Face {
  double sizeAsPercentageOfWidth;
  Gradient gradient;

  Face(this.sizeAsPercentageOfWidth, this.gradient);

  Face.fromColor(double sizeAsPercentageOfWidth, Color from,Color to)
  {
    this.sizeAsPercentageOfWidth=sizeAsPercentageOfWidth;
    this.gradient=new RadialGradient(
      colors: <Color>[
        from,
        to,
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
}

class DefaultHappyFace extends FaceConfiguration {
  DefaultHappyFace(sizeAsPercentageOfWidth)
      : super(
            new Face.fromColor(
                sizeAsPercentageOfWidth,
                Colors.yellow[400],Colors.yellow[600]),
            new Eyes(new Eye(Colors.black, -0.13, -0.13, 8.0 / 140.0), new Eye(Colors.black, -0.13, 0.13, 8.0 / 140.0)),
            new Eyebrows(new Eyebrow(15.0 / 140.0, 16.0 / 140.0, 0.0, 15.0 / 140.0, -5.0 / 140.0, 25.0 / 140.0, -10 / 140.0, -40 / 140.0),
                new Eyebrow(-15.0 / 140.0, 16.0 / 140.0, 0.0, 15.0 / 140.0, 5.0 / 140.0, 25.0 / 140.0, 10 / 140.0, -40 / 140.0)),
            new Mouth(25.0 / 140.0, 18.0 / 140.0, 25.0 / 140.0));
}
