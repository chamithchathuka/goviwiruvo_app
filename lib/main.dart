import 'package:flutter/material.dart';
import 'package:goviwiruvo_app/screens/cartscreen.dart';
import 'package:goviwiruvo_app/screens/leadcoordinator.dart';
import 'package:goviwiruvo_app/screens/addfarmer.dart';
import 'package:goviwiruvo_app/screens/leadcaptureFarmer.dart';
import 'package:goviwiruvo_app/screens/loadfarmersreen.dart';
import 'package:goviwiruvo_app/screens/lognscreen.dart';
import 'package:goviwiruvo_app/screens/roleselectionscreen.dart';
import 'package:goviwiruvo_app/screens/vegetablescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

import 'external/webservices.dart';
import 'model/VegetablLoadModel.dart';
import 'model/VegetableModel.dart';
import 'myglobals.dart';

void main() async{
 WidgetsFlutterBinding.ensureInitialized();

 Widget _defaultHome =LoginScreen();
 bool checkAccessTokenBool =  await  checkAccessToken();

   if (checkAccessTokenBool) {
     //Todo change this to a common screen or recheck weather the user is a farmer or a coordinator
   int user =       await getUserRole();
      if(user==1){
        SingleChildScrollView(child: _defaultHome = CartScreen());
      }else{
        SingleChildScrollView(child: _defaultHome = LoadFarmerScreen());
      }

   }else{
     SingleChildScrollView(child: _defaultHome = LoginScreen());
   }



 await runApp(MaterialApp(
    routes: <String, WidgetBuilder>{
      '/leadCoordinator': (BuildContext context) => LeadCoordinator(),
      '/login': (BuildContext context) => LoginScreen(),
      '/vegadd': (BuildContext context) => VegitableAddScreen(),
      '/cart': (BuildContext context) => CartScreen(),
      '/roleselect': (BuildContext context) => RoleSelectionScreen(),
      '/addfarmer': (BuildContext context) => AddFarmer(),
      '/leadFarmer': (BuildContext context) => LeadFarmerCaptureScreen(), // register farmer to coordinator
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
        loadingText: new Text(
          'Powered by Shraddha Media Network',
          style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black87),
          textAlign: TextAlign.center,
        ) ,
        navigateAfterSeconds:_defaultHome,
        title: new Text(
          '\n\n\nලක්පොළොවෙන් උපන් සාරය ලක් දූ පුතුන් පෝෂණය නොකොට \n නිකරුනේ දිරායෑමට ඉඩ නොතබමු',
          style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey,fontStyle: FontStyle.italic),
          textAlign: TextAlign.center,
        ),
        image: new Image.asset('assets/trs_logo.png',
//          height: MediaQuery.of(context).size.width / 2.5,
//          width: MediaQuery.of(context).size.width / 2.5,
        ),
        backgroundColor: MyGlobals.backgroundColor2,
        styleTextUnderTheLoader: new TextStyle(
            color: Colors.grey,
            fontStyle: FontStyle.italic
        ),
        photoSize: 100.0,
        loaderColor: MyGlobals.backgroundColor
    ),
  ));
}

Future<bool> checkAccessToken() async{

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.get('token');

  if(accessToken==null){
    return false;
  }else{
    return  true;
  }

}

Future<int> getUserRole() async{

  SharedPreferences prefs = await SharedPreferences.getInstance();
  int userRole = prefs.get('userRole');
  return userRole;



}

