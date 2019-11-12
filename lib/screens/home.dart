import 'package:flutter/material.dart';
import 'package:my_wellbeing/widgets/fade.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/emotionface.dart';
import '../widgets/emotionlist.dart';
import '../widgets/fade.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double emotion = 50;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color gradientColor;

    MaterialColor color1 = Colors.red;
    MaterialColor color2 = Colors.yellow;
    MaterialColor color3 = Colors.green;
    backgroundColor = Color.lerp(Color.lerp(color1[200], color2[200], (emotion / 100)), Color.lerp(color2[200], color3[200], (emotion / 100)), (emotion / 100));
    gradientColor = Color.lerp(Color.lerp(color1[500], color2[500], (emotion / 100)), Color.lerp(color2[500], color3[500], (emotion / 100)), (emotion / 100));

    // if (emotion >= 0 && emotion < 30) {
    //   color1 = Colors.red;
    //   color2 = Colors.orange;
    //   backgroundColor = Color.lerp(color1[200], color2[200], emotion / 30);
    //   gradientColor = Color.lerp(color1[500], color2[500], emotion / 30);
    // } else if (emotion >= 30 && emotion < 50) {
    //   color1 = Colors.orange;
    //   color2 = Colors.yellow;
    //   backgroundColor =
    //       Color.lerp(color1[200], color2[200], (emotion * 50) / 30);
    //   gradientColor = Color.lerp(color1[500], color2[500], (emotion * 50) / 30);
    // }

    // backgroundColor = Color.lerp(
    //     Color.lerp(color1[200], color2[200], emotion / 100),
    //     Color.lerp(color2[200], color3[200], emotion / 100),
    //     emotion / 100);
    // gradientColor = Color.lerp(
    //     Color.lerp(color1[500], color2[500], emotion / 100),
    //     Color.lerp(color2[500], color3[500], emotion / 100),
    //     emotion / 100);

    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0, 1],
                colors: [Colors.blue[400], Colors.blue[700]],
              ),
            ),
            child: FutureBuilder(
                future: SharedPreferences.getInstance(),
                builder: (BuildContext context, AsyncSnapshot<SharedPreferences> prefs) {
                  if (prefs.hasData) {
                    return Stack(
//                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                          FadeOut(
                              20,
                              FadeUp(
                                  5,
                                  Padding(
                                    padding: EdgeInsets.only(top: 50, left: 20),
                                    child: Text(
                                      "Hello " + prefs.data.getString("Name"),
                                      style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.w700 /*, fontFamily: "Playfair"*/),
                                      textAlign: TextAlign.left,
                                    ),
                                  ))),
                          FadeOut(
                              20,
                              FadeUp(
                                  10,
                                  Padding(
                                    padding: EdgeInsets.only(left: 50),
                                    child: Text(
                                      "How do you feel?",
                                      style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.w700 /*, fontFamily: "Playfair"*/),
                                      textAlign: TextAlign.left,
                                    ),
                                  ))),
                        ]),
                        FadeUp(
                            21,
                            Column(
                              children: <Widget>[
                                Container(padding: EdgeInsets.only(top: 50), child: EmotionFace(emotion)),
                                Container(
                                    decoration: new BoxDecoration(color: Color.fromRGBO(200, 200, 200, 0.5), borderRadius: new BorderRadius.all(const Radius.circular(15.0))),
                                    margin: EdgeInsets.only(top: 10, bottom: 20, left: 15, right: 15),
                                    child: Slider(
                                        activeColor: Color.lerp(Color.lerp(Colors.red, Colors.yellow, emotion / 100), Color.lerp(Colors.yellow, Colors.green.shade600, emotion / 100), emotion / 100),
                                        // activeColor: Colors.white,
                                        min: 1,
                                        value: emotion,
                                        max: 100,
                                        onChanged: (newEmotionValue) {
                                          setState(() => emotion = newEmotionValue);
                                        })),
                                EmotionList(emotion),
                                Spacer(),
                                Container(
                                    margin: EdgeInsets.only(bottom: 5, left: 5, right: 5),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(color: Colors.blueGrey.withOpacity(0.6), borderRadius: BorderRadius.all(Radius.circular(10))),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                            child: Container(
                                                margin: EdgeInsets.only(right: 10),
                                                child: AutoSizeText(
                                                  "Selected emotion: Happy",
                                                  style: TextStyle(fontSize: 30, color: Colors.white70),
                                                  maxLines: 1,
                                                ))),
                                        MaterialButton(
                                            child: Text("Change", style: TextStyle(color: Colors.white)),
                                            color: /*Colors.green.shade400*/ Color.fromRGBO(backgroundColor.red - 50, backgroundColor.green - 50, backgroundColor.blue - 50, 1),
                                            onPressed: () {})
                                      ],
                                    )),
                                Container(
                                    margin: EdgeInsets.only(bottom: 5, left: 5, right: 5),
                                    padding: EdgeInsets.only(bottom: 5),
                                    decoration: BoxDecoration(color: Colors.blueGrey.withOpacity(0.7), borderRadius: BorderRadius.all(Radius.circular(10))),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.add_circle, color: Colors.white, size: 40),
                                          onPressed: () {},
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.pie_chart, color: Colors.blueGrey[200], size: 40),
                                          onPressed: () {},
                                        ),
                                      ],
                                    )),
                              ],
                            ))
                      ],
                    );
                  }
                  return Text("Loading...");
                })));
  }
}
