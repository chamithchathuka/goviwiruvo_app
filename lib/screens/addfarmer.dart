import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goviwiruvo_app/customwidget/multiselectdialog.dart';
import 'package:goviwiruvo_app/dto/userdto.dart';
import 'package:goviwiruvo_app/dto/vegetablerequestdto.dart';
import 'package:goviwiruvo_app/external/webservices.dart';
import 'package:goviwiruvo_app/model/VegetableModel.dart';
import 'package:goviwiruvo_app/myglobals.dart';
import 'package:goviwiruvo_app/services/vegetableservice.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:location/location.dart' as mylocation;

class AddFarmer extends StatefulWidget {

  @override
  _AddFarmerState createState() => _AddFarmerState();
}

class _AddFarmerState extends State<AddFarmer> {
  final _formKey = GlobalKey<FormState>();
  VegetableService vs = VegetableService();
  bool _autoValidate = false;
  final addressController = TextEditingController();
  final nameController = TextEditingController();
  final whatappContactNoController = TextEditingController();
  final weightController = TextEditingController();
  final contactNoController = TextEditingController();
  String selectedArea = null;
  var username = "User Name";

  final pageName = "ගොවිමහතාගේ තොරතුරු";

  mylocation.Location _locationService = new mylocation.Location();
  mylocation.PermissionStatus _permission ;
  mylocation.LocationData location;
  double lat = 0.0;
  double lon = 0.0;

  @override
  void initState() {
    super.initState();
  }


  address(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 20,left: 50,right: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "ලිපිනය",
                  style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black87),
                  textAlign: TextAlign.left,
                )),
            Container(
              child: Row(
                children: <Widget>[
//                  Icon(Icons.chat_bubble),
//                  Padding(
//                    padding: EdgeInsets.only(left: 8, right: 8),
//                  ),
                  Expanded(
                    child: TextFormField(
                      decoration:  new InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87)) ,
                      ),
                      style: new TextStyle(
                        color: Colors.black87,
                        decorationColor: Colors.black87,//Font color change
                      ),

                      validator: (value) {
                        if (value.isEmpty) {
                          return ('ලිපිනය ඇතුලත්කරන්න');
                        }
                      },
//
//              decoration: InputDecoration(
////                        fillColor: Colors.black,
////                          focusColor: Colors.black,
////                          hoverColor: Colors.black,
//
//              labelStyle:TextStyle(color: Colors.black),
//                focusedBorder:  UnderlineInputBorder(
//                    borderSide: new BorderSide(
//                        color: Colors.black
//                    )
//                ),
//
//                labelText: 'ලිපිනය'
//            ),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      controller: addressController,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  customerName(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 20,left: 50,right: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "නම",
                  style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black87),
                  textAlign: TextAlign.left,
                )),
            Container(
              child: Row(
                children: <Widget>[
//                  Icon(Icons.person),
//                  Padding(
//                    padding: EdgeInsets.only(left: 8, right: 8),
//                  ),
                  Expanded(
                    child: TextFormField(
                      decoration:  new InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87)) ,
                      ),
                      style: new TextStyle(
                        color: Colors.black87,
                        decorationColor: Colors.black87,//Font color change
                      ),
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
        padding: const EdgeInsets.only(top: 20,left: 50,right: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "දුරකථන අංකය",
                  style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black87),
                  textAlign: TextAlign.left,
                )),
            Container(
              child: Row(
                children: <Widget>[
//                  Icon(Icons.phone),
//                  Padding(
//                    padding: EdgeInsets.only(left: 8, right: 8),
//                  ),
                  Expanded(
                    child: TextFormField(
                      decoration:  new InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87)) ,
                      ),
                      style: new TextStyle(
                        color: Colors.black87,
                        decorationColor: Colors.black87,//Font color change
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return ('දුරකථන අංකය ඇතුලත්කරන්න');
                        }
                        if (value.length<10) {
                          return ('දුරකථන අංකය වැරදයි');
                        }
                      },inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      controller: contactNoController,
                      maxLength: 10,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
  );

  contactnumberWhatsApp(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 20,left: 50,right: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "වට්ස්ඇප් දුරකථන අංකය",
                  style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black87),
                  textAlign: TextAlign.left,
                )),
            Container(
              child: Row(
                children: <Widget>[
//                  Icon(Icons.verified_user),
//                  Padding(
//                    padding: EdgeInsets.only(left: 8, right: 8),
//                  ),
                  Expanded(
                    child: TextFormField(
                      decoration:  new InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87)) ,
//                        contentPadding:
//                        EdgeInsets.only(left: 15, bottom: 10, top: 20, right: 15),
                      ),

                      style: new TextStyle(
                        color: Colors.black87,
                        decorationColor: Colors.black87,//Font color change
                      ),

                      validator: (value) {
//                        if(value.isEmpty){
//                          return ('දුරකථන අංකය වැරදයි');
//                        }
                        if (!value.isEmpty && value.length<10) {
                          return ('දුරකථන අංකය වැරදයි');
                        }
                      },
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      controller: whatappContactNoController,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  saveLead(BuildContext context) => Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          width: double.infinity,
          height: 50,
          child: RaisedButton(
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            color: Color.fromRGBO(0, 102, 34,0.8),
            onPressed: () {
              bool isValid = _validateInputs(context);

              if(isValid){
                getLocationAccess(context);
              }

            },
            child: Text("ඉදිරියට",
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
                    SizedBox(height: MediaQuery.of(context).size.height/20),
                    customerName(context),
                    SizedBox(height: 20),
                    address(context),
                    SizedBox(height: 20),
                    contactnumber(context),
                    SizedBox(height: 20),
                    contactnumberWhatsApp(context),

                    SizedBox(height: MediaQuery.of(context).size.height/10),
                    saveLead(context)
                  ],
                ),
              ),
            ),
          ),
//          Column(
//            children: [
//              saveLead(context),
//            ],
//          ),
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
                  address(context),
                  customerName(context),
                  contactnumber(context),
                  contactnumberWhatsApp(context),

                ]),
          ),
          saveLead(context),
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
                  address(context),
                  customerName(context),
//                  contactnumber(context),
//                  natureOfBusiness(context),

                ]),
          ),
          saveLead(context),
        ],
      ),
    );
  }

  @override
  void dispose() {
    addressController.dispose();
    nameController.dispose();
    whatappContactNoController.dispose();
    weightController.dispose();
//    contactNoController.dispose();
//    nicController.dispose();
//    noteController.dispose();
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
        backgroundColor: MyGlobals.backgroundColor,
        title: new Text(pageName,
            style: TextStyle(color:Colors.black87,fontSize: 18, fontWeight: FontWeight.bold)),
      ),
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
//    image: DecorationImage(
//    colorFilter:
//    ColorFilter.mode(Colors.lightGreenAccent.withOpacity(0.20),
//    BlendMode.dstATop),
//    image:  new AssetImage('assets/background_a.jpg'),
//    fit: BoxFit.cover,
//    ),
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

  bool _validateInputs(BuildContext context) {
    if(_formKey.currentState.validate()){
      return true;
    }else{
      return false;
    }
  }


  getLocationAccess(BuildContext context) async{
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        print("Permission: $_permission");
        if (_permission==mylocation.PermissionStatus.granted) {
          location = await _locationService.getLocation();
          print('start lat ${location.latitude.toString()} ?');
          print('start lng  ${location.longitude.toString()} ?');

          print('lat long');
          print(location.latitude.toString());
          print(location.longitude.toString());


          UserDTO farmer = new UserDTO();
          farmer.name =nameController.text;
          farmer.address =addressController.text;
          farmer.whatsappNo =nameController.text;
          farmer.phoneNo =contactNoController.text;
          farmer.role = 1;
          farmer.lat = location.latitude;
          farmer.lon = location.longitude;


          Future<http.Response> response = addCoordinatorRequest(farmer);

          response.then((response) => response.statusCode == 200?Alert(
            context: context,
            type: AlertType.success,
            title: "Success",
            desc: "User add Success",
            buttons: [
              DialogButton(
                child: Text(
                  "close",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: ()  {
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacementNamed('/loadfarmers');

                },
                width: 120,
              )
            ],
          ).show(): Alert(
            context: context,
            type: AlertType.error,
            title: "Error",
            desc: "Failed to add user",
            buttons: [
              DialogButton(
                child: Text(
                  "close",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
              )
            ],
          ).show()).catchError((onError){

            print('${onError}');
            Alert(
              context: context,
              type: AlertType.error,
              title: "Error",
              desc: "Fail to add User.",
              buttons: [
                DialogButton(
                  child: Text(
                    "close",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => Navigator.pop(context),
                  width: 120,
                )
              ],
            ).show();
          });

          // await _goToMyLocation(location.latitude, location.longitude);
        } else {
          print('permission not available');
          Alert(
            context: context,
            type: AlertType.error,
            title: "Allow GPS Location Access",
            desc: "Please allow location access and try again.",
            buttons: [
              DialogButton(
                child: Text(
                  "Close",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
              )
            ],
          ).show();
          //_showDialog();
        }
      }else{
        Alert(
          context: context,
          type: AlertType.error,
          title: "Turn on  GPS ",
          desc: "Please turn on location and try again",
          buttons: [
            DialogButton(
              child: Text(
                "Close",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();


      }
    } on PlatformException catch (e) {

      if (e.code == 'PERMISSION_DENIED') {

        Alert(
          context: context,
          type: AlertType.error,
          title: "Allow GPS Location Access",
          desc: "Please allow location access and try again.",
          buttons: [
            DialogButton(
              child: Text(
                "Close",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
      } else if (e.code == 'SERVICE_STATUS_ERROR') {

      }

    } on Exception catch (ex) {
      print(ex);


      Alert(
        context: context,
        type: AlertType.error,
        title: "Allow GPS Location Access",
        desc: "Please allow location access and try again.",
        buttons: [
          DialogButton(
            child: Text(
              "Close",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();

    }

  }

  Future<http.Response> addCoordinatorRequest(UserDTO userDTO) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenStr  = prefs.get('token');
    print('tokenStr = ${tokenStr}' );

    Future<http.Response> response = null;

    String bodyd = "";
    bodyd = json.encode(userDTO.toJson());

    print("json map :"+bodyd);

    try {

      response = http.post('http://goviwiru.xeniqhub.xyz:8080/registerFarmer',
          headers: {'Content-type': 'application/json','Authorization':'${tokenStr}'},
          body: bodyd);



    } on Exception catch (e) {
      print(e);

    }
    return response;
  }
}
