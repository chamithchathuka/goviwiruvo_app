import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:goviwiruvo_app/external/webservices.dart';
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

  Future<AuthResult> signIn(AuthCredential authCreds)  {

    Future<AuthResult> authResult =  FirebaseAuth.instance.signInWithCredential(authCreds);
    return authResult;

  }

  Future<AuthResult> signInWithOTP(smsCode,verId) {
    AuthCredential authCredential = PhoneAuthProvider.getCredential(verificationId: verId, smsCode: smsCode);
    Future<AuthResult> authResult = signIn(authCredential);

    return authResult;
  }
}