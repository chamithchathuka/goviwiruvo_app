import 'package:flutter/material.dart';
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
    return   MultiProvider(
        providers: [
          ChangeNotifierProvider<VegetableModel>(create: (_) => VegetableModel()),
          ChangeNotifierProvider<VegetableLoadModel>(create: (_) => VegetableLoadModel()),
          FutureProvider(create: (_) => webserive.getVegetables()
          ,
          catchError: (context,error){
            print(error);
          },),
        ],
//      builder:(context) => VegetableModel(),
      child: MaterialApp(

        routes: <String, WidgetBuilder>{
          '/lead': (BuildContext context) => LeadCaptureScreen(),
          '/vegadd': (BuildContext context) => VegitableAddScreen(),
        },
        title: MyGlobals.AppName,
        theme: ThemeData(
          primaryColor: Colors.lightBlue[50],
//          accentColor: Colors.lightBlue[800],
          fontFamily: 'Montserrat',
//        textTheme: TextTheme(
//          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
//          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
//          body1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
//        ),
        ),
        home:LeadCaptureScreen(),



      ),
    );


//      MyHomePage(title: MyGlobals.AppName),

  }
}
