import 'package:flutter/material.dart';
import 'package:goviwiruvo_app/screens/cartscreen.dart';
import 'package:goviwiruvo_app/screens/leadcapture.dart';
import 'package:goviwiruvo_app/screens/addfarmer.dart';
import 'package:goviwiruvo_app/screens/leadcaptureFarmer.dart';
import 'package:goviwiruvo_app/screens/loadfarmersreen.dart';
import 'package:goviwiruvo_app/screens/lognscreen.dart';
import 'package:goviwiruvo_app/screens/roleselectionscreen.dart';
import 'package:goviwiruvo_app/screens/vegetablescreen.dart';
import 'package:splashscreen/splashscreen.dart';

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
        '/roleselect': (BuildContext context) => RoleSelectionScreen(),
        '/addfarmer': (BuildContext context) => AddFarmer(),
        '/leadFarmer': (BuildContext context) => LeadFarmerCaptureScreen(),
        '/loadfarmers':(BuildContext context) => LoadFarmerScreen()
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
          title: new Text(
                    '\n\n\n\n\n\n\n\n\n\n\n\nලක්පොළොවෙන් උපන් සාරය ලක් දූ පුතුන් පෝෂණය නොකොට \n නිකරුනේ දිරායෑමට ඉඩ නොතබමු',
                     style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey,fontStyle: FontStyle.italic),
                     textAlign: TextAlign.center,
                  ),
          image: new Image.asset('assets/pnglogo.png'),
          backgroundColor: Colors.white,
          styleTextUnderTheLoader: new TextStyle(
            color: Colors.grey,
              fontStyle: FontStyle.italic
          ),
          photoSize: 100.0,
          loaderColor: Color.fromRGBO(0, 102, 34,0.8)
      ),
    );
  }
}
