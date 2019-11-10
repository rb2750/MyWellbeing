import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/emotionface.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0, 1],
                colors: [
                  Colors.blue[200],
                  Colors.blue[500],
                ],
              ),
            ),
            child: FutureBuilder(
                future: SharedPreferences.getInstance(),
                builder: (BuildContext context, AsyncSnapshot<SharedPreferences> prefs) {
                  if (prefs.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 50, left: 20),
                          child: Text(
                            "Hi " + prefs.data.getString("Name") + ",",
                            style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.w700, fontFamily: "Playfair"),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 50),
                          child: Text(
                            "How do you feel?",
                            style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.w700, fontFamily: "Playfair"),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 20),
                          child: EmotionFace(0.75)
                        ),
                      ],
                    );
                  }
                  return Text("Loading...");
                })));
  }
}
