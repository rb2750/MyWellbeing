import 'package:flutter/material.dart';

class EmotionFace extends StatelessWidget {
  double emotionLevel;

  EmotionFace(this.emotionLevel);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("FACE ${emotionLevel}")
      );
  }
}
