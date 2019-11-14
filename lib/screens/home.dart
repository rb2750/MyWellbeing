import 'package:flutter/material.dart';
import 'package:my_wellbeing/main.dart';
import 'package:my_wellbeing/widgets/fade.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/emotionface.dart';
import '../widgets/emotionlist.dart';
import '../widgets/fade.dart';

class Home extends StatefulWidget {
  bool firstLaunch;

  Home({this.firstLaunch = false, Key key}) : super(key: key);

  @override
  HomeState createState() => HomeState(this.firstLaunch);
}

class HomeState extends State<Home> {
  bool firstLaunch = false;

  HomeState(this.firstLaunch);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Visibility(
            visible: firstLaunch,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              FadeOut(
                  15,
                  FadeUp(
                      2,
                      Padding(
                        padding: EdgeInsets.only(top: 50, left: 20),
                        child: Text(
                          "Hello " + MyWellbeing.name,
                          style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.w700 /*, fontFamily: "Playfair"*/),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      animate: firstLaunch),
                  animate: firstLaunch),
              FadeOut(
                  15,
                  FadeUp(
                      10,
                      Padding(
                        padding: EdgeInsets.only(left: 50),
                        child: Text(
                          "How do you feel?",
                          style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.w700 /*, fontFamily: "Playfair"*/),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      animate: firstLaunch),
                  animate: firstLaunch),
            ])),
        FadeUp(
            16,
            Column(
              children: <Widget>[
                Container(padding: EdgeInsets.only(top: 50), child: EmotionFace()),
                Container(
                    decoration: new BoxDecoration(color: Color.fromRGBO(200, 200, 200, 0.5), borderRadius: new BorderRadius.all(const Radius.circular(15.0))),
                    margin: EdgeInsets.only(top: 10, bottom: 20, left: 15, right: 15),
                    child: Slider(
                        activeColor: Color.lerp(
                            Color.lerp(Colors.red, Colors.yellow, MyWellbeing.emotion / 100), Color.lerp(Colors.yellow, Colors.green.shade600, MyWellbeing.emotion / 100), MyWellbeing.emotion / 100),
                        // activeColor: Colors.white,
                        min: 1,
                        value: MyWellbeing.emotion,
                        max: 100,
                        onChanged: (newEmotionValue) {
                          setState(() => 0);
                          context.ancestorStateOfType(const TypeMatcher<MyWellbeingState>()).setState(() => MyWellbeing.emotion = newEmotionValue);
                        })),
                EmotionList(),
              ],
            ),
            animate: firstLaunch),
      ],
    );
  }
}
