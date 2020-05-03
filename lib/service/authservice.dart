import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:goviwiruvo_app/screens/cartscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

class AuthService{
  handleAuth(){
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context,snapshot){
        if(snapshot.hasData){
          return CartScreen();
        }else{
          return SplashScreen();
        }
        }
    );
  }

  signOut(){
    FirebaseAuth.instance.signOut();
  }

  signIn(AuthCredential authCreds) async {
    AuthResult authResult = null;
    try{
       authResult = await FirebaseAuth.instance.signInWithCredential(authCreds);
       print('phonenumber ${authResult.user.phoneNumber}');

       SharedPreferences _prefs = await SharedPreferences.getInstance();
       _prefs.setString('coodinatorcontactnumber', authResult.user.phoneNumber);

      // print('${authResult.additionalUserInfo.username}');
      print('${authResult.user.uid}');

    } on  PlatformException catch(e) {
      print(e.message);
      throw e;
    }

    return authResult;

  }

  signInWithOTP(smsCode,verId) async{
    AuthCredential authCredential = PhoneAuthProvider.getCredential(verificationId: verId, smsCode: smsCode);
    AuthResult authResult = await signIn(authCredential);
    return authResult;
  }
}