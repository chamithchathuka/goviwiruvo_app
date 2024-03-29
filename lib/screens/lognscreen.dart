import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goviwiruvo_app/customwidget/multiselectdialog.dart';
import 'package:goviwiruvo_app/dto/vegetablerequestdto.dart';
import 'package:goviwiruvo_app/external/webservices.dart';
import 'package:goviwiruvo_app/model/VegetableModel.dart';
import 'package:goviwiruvo_app/myglobals.dart';
import 'package:goviwiruvo_app/service/authservice.dart';
import 'package:goviwiruvo_app/services/vegetableservice.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;



  VegetableService vs = VegetableService();

  bool _isVerficationCode = false;

  final contactNoController = TextEditingController();
  final verificationCodeController = TextEditingController();
  final nameController = TextEditingController();

  String selectedVegetable = null;
  String selectedProductListStrNames = null;

  bool codeSent = false;

  String verificationId;

  final pageName = "ගොවිමහතාගේ තොරතුරු";

  @override
  void initState() {
    super.initState();
  }


  password(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Password",
              style: TextStyle(
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,

            ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return ('නම ඇතුලත්කරන්න');
                    }
                  },
                  controller: nameController,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );



  contactnumber(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 20,left: 60,right: 60),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          child: Image.asset('assets/trs_logo.png'),
          width: MediaQuery.of(context).size.width / 2,
        ),
        SizedBox(height: 50),
        Align(
            alignment: Alignment.center,
            child: Text(
              "දුරකථන අංකය",
              style: TextStyle(
                  color:Colors.black87,fontSize: 18,fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            )),
        Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  decoration:  new InputDecoration(
//                    border: OutlineInputBorder(
//
//                        borderSide: BorderSide(color: Colors.white)
//
//                    )
//                    ,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87)) ,
              contentPadding:
              EdgeInsets.only(left: 15, bottom: 10, top: 20, right: 15),
              ),

                  style: new TextStyle(
                      color: Colors.black87,
                      decorationColor: Colors.black87,//Font color change
                   ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return ('දුරකථන අංකය ඇතුලත්කරන්න');
                    }
                    if (value.length!=10) {
                      return ('දුරකථන අංකය වැරදයි');
                    }
                  },inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                  keyboardType: TextInputType.number,
                  controller: contactNoController,
                  maxLength: 10,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Align(
            alignment: Alignment.center,
            child: Text(
              "ඔබගේ දුරකථන අංකය ඇතුලත් කර පිවිසෙන්න",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color:Colors.black87
              ),
              textAlign: TextAlign.center,
            )),
      ],
    ),
  );

  circularprogressbar(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF14753a)))),
        ),
      ],
    ),
  );

  verificationCode(BuildContext context) => Padding(
    padding: EdgeInsets.only(top: 20,left: 60,right: 60),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [

        Container(
          child: Image.asset('assets/trs_logo.png'),
          width: MediaQuery.of(context).size.width / 2,
        ),
        SizedBox(height: 50),
        Align(
            alignment: Alignment.center,
            child: Text(
              "තහවුරු කිරීමේ කේතය",
              style: TextStyle(color:Colors.black87,fontSize: 18,fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            )),
        Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
              decoration:  new InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black87)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black87)) ,
                              contentPadding:
                              EdgeInsets.only(left: 15, bottom: 10, top: 10, right: 15),
                      ),
                  style: new TextStyle(
                    color: Colors.black87,
                    decorationColor: Colors.black87,//Font color change
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return ('කේතය  ඇතුලත් කරන්න');
                    }
                    if (value.length!=6) {
                      return ('කේතය වැරදයි');
                    }
                  },inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                  keyboardType: TextInputType.number,
                  controller: verificationCodeController,
                  maxLength: 6,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Align(
            alignment: Alignment.center,
            child: Text(
              "ඔබගේ දුරකථන අංකය ඇතුලත් කර පිවිසෙන්න",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color:Colors.black87
              ),
              textAlign: TextAlign.center,
            )),
      ],
    ),
  );


  submitRequest(BuildContext context) => Padding(
    padding: EdgeInsets.only(right: 60,left: 60,bottom: 120),
    child: Container(
      width: double.infinity,
      height: 60,
      child: RaisedButton(
        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),

        color: Colors.white,
        onPressed: () async {
          _validateInputs(context);



//              Navigator.of(context).pushNamed('/cart'); // to connect screen
        },
        child: Text("ඉදිරියට",
            style: TextStyle(color: Colors.black87, fontSize: 20,fontWeight: FontWeight.bold)),
      ),
    ),
  );

  submitVerificationCodeRequest(BuildContext context) => Padding(
    padding: EdgeInsets.only(right: 60,left: 60,bottom: 120),
    child: Container(
      width: double.infinity,
      height: 50,
      child:
             RaisedButton(
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.white,
                    onPressed: () async {
                      print('verificationCode continue pressed ${verificationCodeController.text}  --- ${verificationId} ');

                        Future<AuthResult> authResult =   AuthService().signInWithOTP(verificationCodeController.text, verificationId);

                      authResult.then((authResult){
                        if(authResult.user!=null){

                  //Todo

                          vs.saveContactNumber(contactNoController.text);
                          WebServiceCall.getToken(authResult.user.uid);
                          Navigator.of(context).pushReplacementNamed('/roleselect'); // to connect screen

                        }else{
                          print('error occurred block 1');
                        }
                      }).catchError((error){
                        showDialogAlert(BuildContext context) {
                          // flutter defined function

                          // return object of type Dialog
                          return AlertDialog(
                            title: new Text("Error"),
                            content: new Text("${error}"),
                            actions: <Widget>[
                              // usually buttons at the bottom of the dialog
                              new FlatButton(
                                child: new Text("Close"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );

                        }
                        print('error occurred ${error}');
                      });

//            if(authResult!=null){
//              if(authResult.user!=null){
//
//                vs.saveContactNumber(contactNoController.text);
//                WebServiceCall.getToken(authResult.user.uid);
//                Navigator.of(context).pushReplacementNamed('/roleselect'); // to connect screen
//
//              }else{
//                print('error occurred');
//              }
//            }else{
//
//
//              print('error occurred');
//            }

        },
        child: Text("පිවිසෙන්න",
            style: TextStyle(color: Colors.black87, fontSize: 18,fontWeight: FontWeight.bold)),
      ),
    ),
  );

  _buildVerticalLayout(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    _isVerficationCode?verificationCode(context):contactnumber(context),
                    SizedBox(height: 20),
                    _isVerficationCode?circularprogressbar(context):Container(),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              _isVerficationCode?(codeSent?submitVerificationCodeRequest(context):Text("Sending Verification Code..")):submitRequest(context),
            ],
          ),
        ],
      ),
    );
  }

  Padding _buildVerticallTabLayout(BuildContext context) {
    double horizontalheight = MediaQuery.of(context).size.width * 0.2;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: GridView.count(
                childAspectRatio: MediaQuery.of(context).size.height *
                    0.3 /
                    (horizontalheight),
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                children: <Widget>[
//                  password(context),
                  contactnumber(context),

                ]),
          ),
          submitRequest(context),
        ],
      ),
    );
  }

  Padding _buildHorizontalLayout(BuildContext context) {
    double horizontalheight = MediaQuery.of(context).size.height * 0.2;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: GridView.count(
                childAspectRatio: MediaQuery.of(context).size.width > 1200
                    ? (MediaQuery.of(context).size.width *
                    0.6 /
                    (horizontalheight))
                    : MediaQuery.of(context).size.width *
                    0.3 /
                    (horizontalheight),
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                children: <Widget>[
                  password(context),
                  contactnumber(context),
//                  natureOfBusiness(context),

                ]),
          ),
          submitRequest(context),
        ],
      ),
    );
  }

  @override
  void dispose() {
    contactNoController.dispose();
    verificationCodeController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: new AppBar(
//        actions: <Widget>[
////            IconButton(
////                icon: Icon(Icons.search),
////                onPressed: () {
////                  Navigator.of(context).pushReplacementNamed(
////                      '/leadcapturesearch'); // to connect screen
////                }),
//        ],
//        backgroundColor: Color.fromRGBO(0, 102, 34,0.8),
//
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {
//          // Add your onPressed code here!
//          Navigator.of(context).pushNamed('/vegadd'); // to connect screen
//        },
//        child: Icon(Icons.add_shopping_cart),
//        backgroundColor: Colors.redAccent,
//      ),
      body:
      Container(
        decoration: BoxDecoration(
          color: MyGlobals.backgroundColor2,
//          image: DecorationImage(
//            colorFilter:
//            ColorFilter.mode(Colors.lightGreenAccent.withOpacity(0.20),
//                BlendMode.dstATop),
//            image: new AssetImage('assets/background_a.jpg'),
//            fit: BoxFit.cover,
//          ),
        ),

        child:

        SafeArea(
          minimum: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: OrientationBuilder(builder: (context, orientation) {
              return orientation == Orientation.portrait
                  ? LayoutBuilder(builder: (context, constraints) {
                if (constraints.maxWidth < 600) {
                  return _buildVerticalLayout(context);
                } else {
                  return _buildVerticalLayout(context);
                }
              })
                  : LayoutBuilder(builder: (context, constraints) {
                if (constraints.maxWidth < 600) {
                  return _buildVerticalLayout(context);
                } else {
                  //Todo Change this
                  return _buildVerticalLayout(context);
                }
              });
            }),
          ),
        ),

    )
    );
  }

  void _validateInputs(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _formKey.currentState.reset();

      setState(() {
        _isVerficationCode = true;
      });

      _register(context);

//      Navigator.of(context).pushReplacementNamed('/cart'); // to connect screen

    } else {
      print('invalid');

    }
  }



  void _register(BuildContext context) async {

    final PhoneVerificationCompleted verified = (AuthCredential authCredential){
//      try{
      Future<AuthResult> authResult = AuthService().signIn(authCredential);

      authResult.then((authResult){
        print('auth ID found ');
        Navigator.of(context).pushNamed('/lead'); // to connect screen
      }).catchError((onError)
      {
        showDialogAlert(BuildContext context) {
          // flutter defined function

          // return object of type Dialog
          return AlertDialog(
            title: new Text("Error"),
            content: new Text("Error"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );

        }
        print(onError.message);
      }
      );


//
//      if(authResult.user!=null){
//        Navigator.of(context).pushNamed('/lead'); // to connect screen
//      }
//      } on  PlatformException catch(e) {
//        print(e.message);
//      }

    };

    final PhoneVerificationFailed verificationfailed = (AuthException authException){
      print('verificationfailed');
      print('${authException.message}');

    };

//    final PhoneCodeAutoRetrievalTimeout tomeout = (String verId){
//      print('verid ${verId}' );
//    };

    final PhoneCodeSent smsSent =
        (String verId,[int forceresend]){
          print('sms sent called ');
      setState(() {
        this.verificationId = verId;
        this.codeSent = true;
      });
    };

    print('submit verification');
    print(contactNoController.text.substring(1,contactNoController.text.length));
//
    await _auth.verifyPhoneNumber(

        phoneNumber: '+94${contactNoController.text.substring(1,contactNoController.text.length)}',
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        timeout: Duration(seconds: 5),
    );
  }
}

