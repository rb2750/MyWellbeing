import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:my_wellbeing/screens/charts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/home.dart';
import 'widgets/fade.dart';
import 'screens/charts.dart';
import 'screens/splash.dart';
import 'package:auto_size_text/auto_size_text.dart';

void main() => runApp(MyWellbeing());

class MyWellbeing extends StatefulWidget {
  static double emotion = 50;
  static String name;

  MyWellbeing({Key key}) : super(key: key);

  @override
  MyWellbeingState createState() => MyWellbeingState();
}

class MyWellbeingState extends State<MyWellbeing> {
  int currentPage = 0;
  bool firstLaunch = false;
  PageController _controller;

  MyWellbeingState() {
    firstLaunch = true;
    _controller = PageController(initialPage: currentPage, keepPage: false)
      ..addListener(() {
        setState(() {
          currentPage = _controller.page.round();
        });
      });
  }

  void goToPage(int index) {
    _controller.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    bool fl = firstLaunch;
    firstLaunch = false;

    MaterialColor color1 = Colors.red;
    MaterialColor color2 = Colors.yellow;
    MaterialColor color3 = Colors.green;
    Color backgroundColor =
        Color.lerp(Color.lerp(color1[200], color2[200], (MyWellbeing.emotion / 100)), Color.lerp(color2[200], color3[200], (MyWellbeing.emotion / 100)), (MyWellbeing.emotion / 100));

    return MaterialApp(
        title: 'MyWellbeing',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: (BuildContext context, AsyncSnapshot<SharedPreferences> prefs) {
              Widget widget = Container();

              if (prefs.hasData) {
                if (prefs.data.containsKey("Name")) {
                  MyWellbeing.name = prefs.data.getString("Name");
                  widget = Scaffold(
                      body: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              stops: [0, 1],
                              colors: [Colors.blue[500], Colors.blue[900]],
                            ),
                          ),
                          child: Stack(children: <Widget>[
                            PageView(
                              physics: new NeverScrollableScrollPhysics(),
                              controller: _controller,
                              children: <Widget>[Home(firstLaunch: fl), Charts()],
                            ),
                            FadeUp(
                                22,
                                Column(
                                  children: <Widget>[
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
                                                color: Color.fromRGBO(backgroundColor.red - 50, backgroundColor.green - 50, backgroundColor.blue - 50, 1),
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
                                              icon: Icon(Icons.add_circle, color: currentPage == 0 ? Colors.white : Colors.blueGrey[200], size: 40),
                                              onPressed: () {
                                                goToPage(0);
                                              },
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.pie_chart, color: currentPage == 1 ? Colors.white : Colors.blueGrey[200], size: 40),
                                              onPressed: () {
                                                goToPage(1);
                                              },
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                                animate: fl)
                          ])));
                } else {
                  widget = Splash();
                }
              }

              return widget;
            }));
  }
}
