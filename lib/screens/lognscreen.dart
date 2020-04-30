import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goviwiruvo_app/customwidget/multiselectdialog.dart';
import 'package:goviwiruvo_app/dto/vegetablerequestdto.dart';
import 'package:goviwiruvo_app/model/VegetableModel.dart';
import 'package:goviwiruvo_app/service/authservice.dart';
import 'package:goviwiruvo_app/services/vegetableservice.dart';



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

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
    padding: const EdgeInsets.only(top: 8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Text(
              "දුරකථන අංකය",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )),
        Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
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
      ],
    ),
  );

  circularprogressbar(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          child: Center(child: CircularProgressIndicator()),
        ),
      ],
    ),
  );

  verificationCode(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Verification Code",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            )),
        Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return ('දුරකථන අංකය ඇතුලත්කරන්න');
                    }
                    if (value.length!=6) {
                      return ('දුරකථන අංකය වැරදයි');
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
      ],
    ),
  );


  submitRequest(BuildContext context) => Padding(
    padding: const EdgeInsets.all(0),
    child: Container(
      width: double.infinity,
      height: 50,
      child: RaisedButton(
        color: Color.fromRGBO(0, 0, 0, 0.9),
        onPressed: () async {
          _validateInputs(context);



//              Navigator.of(context).pushNamed('/cart'); // to connect screen
        },
        child: Text("ඉදිරියට",
            style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
    ),
  );

  submitVerificationCodeRequest(BuildContext context) => Padding(
    padding: const EdgeInsets.all(0),
    child: Container(
      width: double.infinity,
      height: 50,
      child: RaisedButton(
        color: Color.fromRGBO(0, 0, 0, 0.9),
        onPressed: () async {
          print('verificationCode continue pressed');
            AuthResult authResult = await  AuthService().signInWithOTP(verificationCodeController.text, verificationId);
          if(authResult.user!=null){
            Navigator.of(context).pushReplacementNamed('/lead'); // to connect screen
          }else{
            print('error occurred');
          }

        },
        child: Text("Submit Verification Code",
            style: TextStyle(color: Colors.white, fontSize: 20)),
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
              _isVerficationCode?submitVerificationCodeRequest(context):submitRequest(context),
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
      appBar: new AppBar(
        actions: <Widget>[
//            IconButton(
//                icon: Icon(Icons.search),
//                onPressed: () {
//                  Navigator.of(context).pushReplacementNamed(
//                      '/leadcapturesearch'); // to connect screen
//                }),
        ],
        backgroundColor: Color(0xFFFFFFFF),
        title: new Text(pageName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {
//          // Add your onPressed code here!
//          Navigator.of(context).pushNamed('/vegadd'); // to connect screen
//        },
//        child: Icon(Icons.add_shopping_cart),
//        backgroundColor: Colors.redAccent,
//      ),
      body: SafeArea(
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
      AuthResult authResult = AuthService().signIn(authCredential);
      print('auth ID found ');

      if(authResult.user!=null){
        Navigator.of(context).pushNamed('/lead'); // to connect screen
      }

    };

    final PhoneVerificationFailed verificationfailed = (AuthException authException){
      print('${authException.message}');
    };

//    final PhoneCodeAutoRetrievalTimeout tomeout = (String verId){
//      print('verid ${verId}' );
//    };

    final PhoneCodeSent smsSent =
        (String verId,[int forceresend]){
      this.verificationId = verId;
      setState(() {
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

