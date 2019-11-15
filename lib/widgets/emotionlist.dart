import 'package:flutter/material.dart';
import '../main.dart';
import 'faceconfiguration.dart';
import 'staticface.dart';

class EmotionList extends StatelessWidget {
  List<Widget> emotions;

  EmotionList() {
    double emotionLevel = MyWellbeing.emotion;
    emotions = [
      new Emotion(0, 30, emotionLevel, "Very sad", Colors.red[700]),
      new Emotion(20, 50, emotionLevel, "Quite sad", Colors.red[400]),
      new Emotion(40, 60, emotionLevel, "Sad", Colors.orange),
      new Emotion(50, 70, emotionLevel, "Kind of happy", Colors.green[300]),
      new Emotion(60, 90, emotionLevel, "Happy", Colors.green[600]),
      new Emotion(80, 100, emotionLevel, "Very Happy", Colors.green[800])
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 15,
      runSpacing: 20,
      children: <Widget>[
        IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
                  decoration: new BoxDecoration(color: Color.fromRGBO(200, 200, 200, 0.5), borderRadius: new BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
                  child: StaticFace(DefaultHappyFace(0.2)
                    ..mouth = Mouth(0.2, 0.2, 0)
                    ..eyebrows.left.leftOfEyebrowOffsetYPercentage += 0.08
                    ..eyebrows.right.leftOfEyebrowOffsetYPercentage += 0.08
                    ..eyebrows.left.rightOfEyebrowOffsetYPercentage -= 0.01
                    ..eyebrows.right.rightOfEyebrowOffsetYPercentage -= 0.01
                    ..face = Face.fromColor(0.2, Colors.red[300], Colors.red[400])
                    ..mouth.pullDownAmountPercentage = -0.1),
                ),
                Container(
                    padding: EdgeInsets.all(5),
                    decoration: new BoxDecoration(color: Color.fromRGBO(200, 200, 200, 0.45), borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0))),
                    child: Text(
                      "Angry",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ))
              ],
            )),
        IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
                  decoration: new BoxDecoration(color: Color.fromRGBO(200, 200, 200, 0.5), borderRadius: new BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
                  child: StaticFace(DefaultHappyFace(0.2)
                    ..mouth.pullDownAmountPercentage = -0.15
                    ..mouth.yOffsetFromCenterPercentage += 0.1
                    ..eyebrows.left.middleOfEyebrowOffsetYPercentage += 0.1
                    ..eyebrows.left.leftOfEyebrowOffsetYPercentage += 0.02
                    ..eyebrows.right.middleOfEyebrowOffsetYPercentage += 0.1
                    ..eyebrows.right.leftOfEyebrowOffsetYPercentage += 0.02),
                ),
                Container(
                    padding: EdgeInsets.all(5),
                    decoration: new BoxDecoration(color: Color.fromRGBO(200, 200, 200, 0.45), borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0))),
                    child: Text(
                      "Sad",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ))
              ],
            )),
        IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
                  decoration: new BoxDecoration(color: Color.fromRGBO(200, 200, 200, 0.5), borderRadius: new BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
                  child: StaticFace(DefaultHappyFace(0.2)
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
                    ..mouth.yOffsetFromCenterPercentage += 0.05),
                ),
                Container(
                    padding: EdgeInsets.all(5),
                    decoration: new BoxDecoration(color: Color.fromRGBO(200, 200, 200, 0.45), borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0))),
                    child: Text(
                      "Anxious",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ))
              ],
            )),
        IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
                  decoration: new BoxDecoration(color: Color.fromRGBO(200, 200, 200, 0.5), borderRadius: new BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
                  child: StaticFace(DefaultHappyFace(0.2)
                    ..mouth = Mouth(0.2, 0.2, 0)
                    ..eyebrows.left.leftOfEyebrowOffsetYPercentage += 0.08
                    ..eyebrows.right.leftOfEyebrowOffsetYPercentage += 0.08
                    ..eyebrows.left.rightOfEyebrowOffsetYPercentage -= 0.01
                    ..eyebrows.right.rightOfEyebrowOffsetYPercentage -= 0.01
                    ..face = Face.fromColor(0.2, Colors.red[300], Colors.red[400])
                    ..mouth.pullDownAmountPercentage = -0.1),
                ),
                Container(
                    padding: EdgeInsets.all(5),
                    decoration: new BoxDecoration(color: Color.fromRGBO(200, 200, 200, 0.45), borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0))),
                    child: Text(
                      "Angry",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ))
              ],
            )),
        IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
                  decoration: new BoxDecoration(color: Color.fromRGBO(200, 200, 200, 0.5), borderRadius: new BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
                  child: StaticFace(DefaultHappyFace(0.2)
                    ..mouth.pullDownAmountPercentage = -0.15
                    ..mouth.yOffsetFromCenterPercentage += 0.1
                    ..eyebrows.left.middleOfEyebrowOffsetYPercentage += 0.1
                    ..eyebrows.left.leftOfEyebrowOffsetYPercentage += 0.02
                    ..eyebrows.right.middleOfEyebrowOffsetYPercentage += 0.1
                    ..eyebrows.right.leftOfEyebrowOffsetYPercentage += 0.02),
                ),
                Container(
                    padding: EdgeInsets.all(5),
                    decoration: new BoxDecoration(color: Color.fromRGBO(200, 200, 200, 0.45), borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0))),
                    child: Text(
                      "Sad",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ))
              ],
            )),
        IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
                  decoration: new BoxDecoration(color: Color.fromRGBO(200, 200, 200, 0.5), borderRadius: new BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
                  child: StaticFace(DefaultHappyFace(0.2)
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
                    ..mouth.yOffsetFromCenterPercentage += 0.05),
                ),
                Container(
                    padding: EdgeInsets.all(5),
                    decoration: new BoxDecoration(color: Color.fromRGBO(200, 200, 200, 0.45), borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0))),
                    child: Text(
                      "Anxious",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ))
              ],
            )),
        IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
                  decoration: new BoxDecoration(color: Color.fromRGBO(200, 200, 200, 0.5), borderRadius: new BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
                  child: StaticFace(DefaultHappyFace(0.2)
                    ..mouth = Mouth(0.2, 0.2, 0)
                    ..eyebrows.left.leftOfEyebrowOffsetYPercentage += 0.08
                    ..eyebrows.right.leftOfEyebrowOffsetYPercentage += 0.08
                    ..eyebrows.left.rightOfEyebrowOffsetYPercentage -= 0.01
                    ..eyebrows.right.rightOfEyebrowOffsetYPercentage -= 0.01
                    ..face = Face.fromColor(0.2, Colors.red[300], Colors.red[400])
                    ..mouth.pullDownAmountPercentage = -0.1),
                ),
                Container(
                    padding: EdgeInsets.all(5),
                    decoration: new BoxDecoration(color: Color.fromRGBO(200, 200, 200, 0.45), borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0))),
                    child: Text(
                      "Angry",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ))
              ],
            )),
        IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
                  decoration: new BoxDecoration(color: Color.fromRGBO(200, 200, 200, 0.5), borderRadius: new BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
                  child: StaticFace(DefaultHappyFace(0.2)
                    ..mouth.pullDownAmountPercentage = -0.15
                    ..mouth.yOffsetFromCenterPercentage += 0.1
                    ..eyebrows.left.middleOfEyebrowOffsetYPercentage += 0.1
                    ..eyebrows.left.leftOfEyebrowOffsetYPercentage += 0.02
                    ..eyebrows.right.middleOfEyebrowOffsetYPercentage += 0.1
                    ..eyebrows.right.leftOfEyebrowOffsetYPercentage += 0.02),
                ),
                Container(
                    padding: EdgeInsets.all(5),
                    decoration: new BoxDecoration(color: Color.fromRGBO(200, 200, 200, 0.45), borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0))),
                    child: Text(
                      "Sad",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ))
              ],
            )),
        IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
                  decoration: new BoxDecoration(color: Color.fromRGBO(200, 200, 200, 0.5), borderRadius: new BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
                  child: StaticFace(DefaultHappyFace(0.2)
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
                    ..mouth.yOffsetFromCenterPercentage += 0.05),
                ),
                Container(
                    padding: EdgeInsets.all(5),
                    decoration: new BoxDecoration(color: Color.fromRGBO(200, 200, 200, 0.45), borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0))),
                    child: Text(
                      "Anxious",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ))
              ],
            ))
      ],
    );
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

  Emotion(this.minScore, this.maxScore, this.currentScore, [this.text = "", this.background = Colors.pink]);

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
