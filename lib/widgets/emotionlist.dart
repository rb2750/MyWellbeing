import 'package:flutter/material.dart';
import '../main.dart';
import 'faceconfiguration.dart';
import 'staticface.dart';
import 'dart:math' as Math;

class EmotionList extends StatelessWidget {
  Widget createEmotionWidget(FaceConfiguration configuration, String name) {
    return IntrinsicWidth(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
          decoration: new BoxDecoration(
              color: Color.fromRGBO(200, 200, 200, 0.5),
              borderRadius: new BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0))),
          child: StaticFace(configuration),
        ),
        Container(
            padding: EdgeInsets.all(5),
            decoration: new BoxDecoration(
                color: Color.fromRGBO(200, 200, 200, 0.45),
                borderRadius: new BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0))),
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, color: Colors.white),
            ))
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> emotions = new List<Widget>();

    if (MyWellbeing.emotion >=0 && MyWellbeing.emotion < 25) {
      emotions.add(createEmotionWidget(
          DefaultHappyFace(0.2)
            ..mouth = Mouth(0.2, 0.2, 0)
            ..eyebrows.left.leftOfEyebrowOffsetYPercentage += 0.08
            ..eyebrows.right.leftOfEyebrowOffsetYPercentage += 0.08
            ..eyebrows.left.rightOfEyebrowOffsetYPercentage -= 0.01
            ..eyebrows.right.rightOfEyebrowOffsetYPercentage -= 0.01
            ..face = Face.fromColor(0.2, Colors.red[300], Colors.red[400])
            ..mouth.pullDownAmountPercentage = -0.1,
          "Angry"));
      emotions.add(createEmotionWidget(
          DefaultHappyFace(0.2)
            ..mouth.pullDownAmountPercentage = -0.15
            ..mouth.yOffsetFromCenterPercentage += 0.1
            ..eyebrows.left.middleOfEyebrowOffsetYPercentage += 0.1
            ..eyebrows.left.leftOfEyebrowOffsetYPercentage += 0.02
            ..eyebrows.right.middleOfEyebrowOffsetYPercentage += 0.1
            ..eyebrows.right.leftOfEyebrowOffsetYPercentage += 0.02,
          "Sad"));
      emotions.add(createEmotionWidget(
          DefaultHappyFace(0.2)
            ..eyebrows.left.middleOfEyebrowOffsetYPercentage += 0.1
            ..eyebrows.left.leftOfEyebrowOffsetYPercentage += 0.02
            ..eyebrows.left.rightOfEyebrowOffsetYPercentage += 0.02
            ..eyebrows.right.middleOfEyebrowOffsetYPercentage += 0.1
            ..eyebrows.right.leftOfEyebrowOffsetYPercentage += 0.02
            ..eyebrows.right.rightOfEyebrowOffsetYPercentage += 0.02
            ..eyes.left.offsetFromCenterXPercentage += 0.01
            ..eyes.right.offsetFromCenterXPercentage += 0.01
            ..mouth.xPaddingPercentage = 0.25
            ..mouth.pullDownAmountPercentage = -0.1
            ..mouth.yOffsetFromCenterPercentage += 0.05,
          "Anxious"));
      emotions.add(createEmotionWidget(
          DefaultHappyFace(0.2)
            ..face = Face.fromColor(0.2, Colors.blue[300], Colors.blue[400])
            ..eyebrows.left.middleOfEyebrowOffsetYPercentage  += 0.06
            ..eyebrows.left.leftOfEyebrowOffsetYPercentage += 0.02
            ..eyebrows.right.middleOfEyebrowOffsetYPercentage += 0.06
            ..eyebrows.right.leftOfEyebrowOffsetYPercentage += 0.02
            ..eyes.left.offsetFromCenterXPercentage += 0.01
            ..eyes.right.offsetFromCenterXPercentage += 0.01
            ..mouth.xPaddingPercentage = 0.25
            ..mouth.pullDownAmountPercentage = -0.05
            ..mouth.yOffsetFromCenterPercentage += 0.05,
          "Numb"));
    }
    if (MyWellbeing.emotion >= 25 && MyWellbeing.emotion < 50) {
      emotions.add(createEmotionWidget(
          DefaultHappyFace(0.2)
            ..mouth = Mouth(0.2, 0.2, 0)
            ..eyebrows.left.offsetFromEyeXPercentage -= 0.06
            ..eyebrows.right.offsetFromEyeXPercentage += 0.08
            ..eyebrows.left.offsetFromEyeYPercentage += 0.01
            ..eyebrows.right.offsetFromEyeYPercentage += 0.01
            ..eyebrows.left.leftOfEyebrowOffsetYPercentage = 0.11
            ..eyebrows.right.leftOfEyebrowOffsetYPercentage = 0.11
            ..eyebrows.left.middleOfEyebrowOffsetYPercentage = 0.15
            ..eyebrows.right.middleOfEyebrowOffsetYPercentage = 0.15 
            ..eyes = Eyes(ArcEye(0.15,0.03, -Math.pi, Math.pi, Colors.black, -0.08, -0.1), ArcEye(0.15,0.03, Math.pi, Math.pi, Colors.black, -0.08, 0.1))
            ..mouth.xPaddingPercentage = 0.25
            ..mouth.pullDownAmountPercentage = 0,
          "Bored"));
    }

    return Wrap(spacing: 15, runSpacing: 20, children: emotions);
//    return Container(
//      width: double.maxFinite,
//      child: Column(
//        children: emotions,
//      ),
//    );
  }
}

class Emotion extends StatelessWidget {
  String text = "Emotion";
  Color background = Colors.pink;

  double minScore;
  double maxScore;
  double currentScore;

  double padding = 20;

  Emotion(this.text, {this.background = Colors.pink});

  @override
  Widget build(BuildContext context) {
//    if (currentScore >= minScore && currentScore <= maxScore) {
//      return new Container(
//          decoration: new BoxDecoration(
//              borderRadius: new BorderRadius.all(const Radius.circular(15.0)),
//              color: Colors.grey.withAlpha(120)),
//          padding: EdgeInsets.only(top: 5, bottom: 5),
//          margin: EdgeInsets.only(left: padding, right: padding, bottom: 10),
//          width: double.maxFinite,
//          // decoration: Decoration,
//          child: Center(
//            child: Text(
//              text,
//              style: TextStyle(fontSize: 50.0, color: Colors.white),
//              textAlign: TextAlign.center,
//            ),
//          ));
//    } else {
//      return new Container();
//    }
  }
}
