import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/home.dart';
import 'screens/splash.dart';

void main() => runApp(MyWellbeing());

class MyWellbeing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MyWellbeing',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: (BuildContext context, AsyncSnapshot<SharedPreferences> prefs) {
              if (prefs.hasData && prefs.data.containsKey("Name")) {
                return Home();
              } else {
                return Splash();
              }
            }));
  }
}
