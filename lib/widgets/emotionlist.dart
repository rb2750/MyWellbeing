import 'package:flutter/material.dart';

class EmotionList extends StatelessWidget {
  List<Widget> emotions;
  double emotionLevel;

  EmotionList(this.emotionLevel) {
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
    return Container(
      width: double.maxFinite,
      child: Column(
        children: emotions,
      ),
    );
  }
}

class Emotion extends StatelessWidget {
  String text = "Emotion";
  Color background = Colors.pink;

  double minScore;
  double maxScore;
  double currentScore;

  double padding = 20;

  Emotion(this.minScore, this.maxScore, this.currentScore,
      [this.text = "", this.background = Colors.pink]);

  @override
  Widget build(BuildContext context) {
    if (currentScore >= minScore && currentScore <= maxScore) {
      return new Container(
          decoration: new BoxDecoration(
              borderRadius: new BorderRadius.all(const Radius.circular(15.0)),
              color: Colors.grey.withAlpha(150)),
          padding: EdgeInsets.only(top: 5, bottom: 5),
          margin: EdgeInsets.only(left: padding, right: padding, bottom: 10),
          width: double.maxFinite,
          // decoration: Decoration,
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 50.0, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ));
    } else {
      return new Container();
    }
  }
}
