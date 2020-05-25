import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class Splash extends StatefulWidget {
  Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final Duration animationDuration = Duration(milliseconds: 200);
  GlobalKey rectGetterKey = RectGetter.createGlobalKey();
  final nameController = TextEditingController();
  Rect rect;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Scaffold(
          body: SingleChildScrollView(
              padding: EdgeInsets.zero,
//              autoScroll: true,
              child: Container(
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
                child: Center(
                    child: Container(
                        child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 70)),
                    Text(
                      "Welcome to MyWellbeing",
                      style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.w700, fontFamily: "Playfair"),
                      textAlign: TextAlign.center,
                    ),
                    Padding(padding: EdgeInsets.only(top: 40)),
                    Text(
                      "Your personal wellbeing tracker",
                      style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w500, fontFamily: "Playfair"),
                      textAlign: TextAlign.center,
                    ),
                    Spacer(flex: 2),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: new TextFormField(
                              controller: nameController,
                              textCapitalization: TextCapitalization.words,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Playfair",
                              ),
                              cursorColor: Colors.white,
                              decoration: new InputDecoration(
//                    resizeToAvoidBottomPadding: false,
                                labelText: "Enter Name",
                                hintStyle: TextStyle(color: Colors.white),
                                labelStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700, fontFamily: "Playfair"),
                                fillColor: Colors.white,
                                focusColor: Colors.orangeAccent,
                                enabledBorder: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(color: Colors.white.withAlpha(170)),
                                ),
                                focusedBorder: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(color: Colors.white),
                                ),
                                errorBorder: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(color: Colors.red),
                                ),
                              ),
                              validator: (val) {
                                if (val.length == 0) {
                                  return "Name cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          RectGetter(
                              key: rectGetterKey,
                              child: SizedBox(
                                  width: double.infinity,
                                  height: 90,
                                  child: Container(
                                      padding: EdgeInsets.all(20),
                                      child: RaisedButton(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                          color: Colors.blue.shade500,
                                          onPressed: () async {
                                            if (_formKey.currentState.validate()) {
                                              final prefs = await SharedPreferences.getInstance();
                                              prefs.setString("Name", nameController.text);
                                              setState(() => rect = RectGetter.getRectFromKey(rectGetterKey));
                                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                                setState(() => rect = rect.inflate(1.3 * MediaQuery.of(context).size.longestSide));
                                                Future.delayed(animationDuration, () => Navigator.of(context).push(FadeRouteBuilder(page: MyWellbeing())).then((_) => setState(() => rect = null)));
                                              });
                                            }
                                          },
                                          elevation: 5,
                                          child: Text(
                                            "Let's Go!",
                                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700, fontFamily: "Playfair"),
                                          )))))
                        ],
                      ),
                    ),
                  ],
                ))),
              ))),
      _ripple()
    ]);
  }

  Widget _ripple() {
    if (rect == null) {
      return Container();
    }
    return AnimatedPositioned(
      duration: animationDuration,
      left: rect.left,
      right: MediaQuery.of(context).size.width - rect.right,
      top: rect.top,
      bottom: MediaQuery.of(context).size.height - rect.bottom,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
      ),
    );
  }
}

class FadeRouteBuilder<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeRouteBuilder({@required this.page})
      : super(
          pageBuilder: (context, animation1, animation2) => page,
          transitionsBuilder: (context, animation1, animation2, child) {
            return FadeTransition(opacity: animation1, child: child);
          },
        );
}
