import 'package:flutter/material.dart';
import 'package:goviwiruvo_app/screens/cartscreen.dart';
import 'package:goviwiruvo_app/screens/leadcapture.dart';
import 'package:goviwiruvo_app/screens/lognscreen.dart';
import 'package:goviwiruvo_app/screens/vegetablescreen.dart';
import 'package:provider/provider.dart';

import 'package:goviwiruvo_app/screens/leadcapture.dart';
import 'external/webservices.dart';
import 'model/VegetablLoadModel.dart';
import 'model/VegetableModel.dart';
import 'myglobals.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  WebServiceCall webserive = new WebServiceCall();
  @override
  Widget build(BuildContext context) {
    return   MaterialApp(

      routes: <String, WidgetBuilder>{
        '/lead': (BuildContext context) => LeadCaptureScreen(),
        '/vegadd': (BuildContext context) => VegitableAddScreen(),
        '/cart': (BuildContext context) => CartScreen(),
      },
      title: MyGlobals.AppName,
      theme: ThemeData(
        primaryColor: Colors.lightBlue[50],
        fontFamily: 'Montserrat',
      ),
      home:
       SplashScreen(
          seconds: 3,
          navigateAfterSeconds: LoginScreen(),
          title: new Text('ගොවි විරුවන් රැකගනිමු'),
          image: new Image.asset('assets/pnglogo.png'),
          backgroundColor: Colors.white,
          styleTextUnderTheLoader: new TextStyle(),
          photoSize: 100.0,
          loaderColor: Colors.red
      ),

    );


//      MyHomePage(title: MyGlobals.AppName),

  }
}
