import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goviwiruvo_app/customwidget/multiselectdialog.dart';
import 'package:goviwiruvo_app/dto/userdto.dart';
import 'package:goviwiruvo_app/dto/vegetablerequestdto.dart';
import 'package:goviwiruvo_app/model/VegetableModel.dart';
import 'package:goviwiruvo_app/services/vegetableservice.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';


class LeadFarmerCaptureScreen extends StatefulWidget {
  @override
  _LeadFarmerCaptureScreenState createState() => _LeadFarmerCaptureScreenState();
}

class _LeadFarmerCaptureScreenState extends State<LeadFarmerCaptureScreen> {
  final _formKey = GlobalKey<FormState>();
  VegetableService vs = VegetableService();
  bool _autoValidate = false;

  final addressController = TextEditingController();

  final nameController = TextEditingController();

  final whatappContactNoController = TextEditingController();

  final weightController = TextEditingController();

  final coordinationOfficerTextController = TextEditingController();

  final contactNoController = TextEditingController();

  final nicController = TextEditingController();

  final noteController = TextEditingController();

  List<String> _channels = ['Please Select', 'Walk-in', 'B', 'C', 'D'];

  String selectedVegetable = null;

  String selectedProductListStrNames = null;

  String selectedNatureOfBusiness = null;

  String selectedArea = null;

  var username = "User Name";

  String contactNumber = '';

  final pageName = "ගොවිමහතාගේ තොරතුරු";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
//    List<VegetableLoad> vegetables = await WebServiceCall.getVegetables();
    VegetableRequest vegRequest = await vs.loadVegRequestFromState();
    SharedPreferences _prefs = await SharedPreferences.getInstance();
     contactNumber =_prefs.getString("user_contactnumber");
    if(vegRequest!=null){

      addressController.text = vegRequest.address;
      nameController.text = vegRequest.name;
      whatappContactNoController.text = vegRequest.whatsapp;
      coordinationOfficerTextController.text = vegRequest.connector.phone;

    }

  }

  address(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "ලිපිනය",
                  style: TextStyle(fontWeight: FontWeight.bold,color:Color.fromRGBO(0, 102, 34,0.8)),
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
                            borderSide: BorderSide(color: Color.fromRGBO(0, 102, 34,0.8))),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(0, 102, 34,0.8))) ,
                        contentPadding:
                        EdgeInsets.only(left: 15, bottom: 10, top: 20, right: 15),
                      ),
                      style: new TextStyle(
                        color: Color.fromRGBO(0, 102, 34,0.8),
                        decorationColor: Color.fromRGBO(0, 102, 34,0.8),//Font color change
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
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "නම",
                  style: TextStyle(fontWeight: FontWeight.bold,color:Color.fromRGBO(0, 102, 34,0.8)),
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
                            borderSide: BorderSide(color: Color.fromRGBO(0, 102, 34,0.8))),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(0, 102, 34,0.8))) ,
                        contentPadding:
                        EdgeInsets.only(left: 15, bottom: 10, top: 20, right: 15),
                      ),
                      style: new TextStyle(
                        color: Color.fromRGBO(0, 102, 34,0.8),
                        decorationColor: Color.fromRGBO(0, 102, 34,0.8),//Font color change
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

//  contactnumber(BuildContext context) => Padding(
//        padding: const EdgeInsets.only(top: 8),
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          children: [
//            Align(
//                alignment: Alignment.topLeft,
//                child: Text(
//                  "දුරකථන අංකය",
//                  style: TextStyle(fontWeight: FontWeight.bold),
//                  textAlign: TextAlign.left,
//                )),
//            Container(
//              child: Row(
//                children: <Widget>[
////                  Icon(Icons.phone),
////                  Padding(
////                    padding: EdgeInsets.only(left: 8, right: 8),
////                  ),
//                  Expanded(
//                    child: TextFormField(
//                      validator: (value) {
//                        if (value.isEmpty) {
//                          return ('දුරකථන අංකය ඇතුලත්කරන්න');
//                        }
//                        if (value.length<10) {
//                          return ('දුරකථන අංකය වැරදයි');
//                        }
//                      },inputFormatters: [
//                      WhitelistingTextInputFormatter.digitsOnly
//                      ],
//                      keyboardType: TextInputType.number,
//                      controller: contactNoController,
//                      maxLength: 10,
//                      textAlign: TextAlign.left,
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ],
//        ),
//  );

  contactnumberWhatsApp(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "වට්ස්ඇප් දුරකථන අංකය",
                  style: TextStyle(fontWeight: FontWeight.bold,color:Color.fromRGBO(0, 102, 34,0.8)),
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
                            borderSide: BorderSide(color: Color.fromRGBO(0, 102, 34,0.8))),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(0, 102, 34,0.8))) ,
                        contentPadding:
                        EdgeInsets.only(left: 15, bottom: 10, top: 20, right: 15),
                      ),
                      style: new TextStyle(
                        color: Color.fromRGBO(0, 102, 34,0.8),
                        decorationColor: Color.fromRGBO(0, 102, 34,0.8),//Font color change
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

//  coordinationOfficerNumber(BuildContext context) => Padding(
//        padding: const EdgeInsets.only(top: 8),
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          children: [
//            Align(
//                alignment: Alignment.topLeft,
//                child: Text(
//                  "සම්බන්ධිකරණ නිලධාරී දුරකථන අංකය",
//                  style: TextStyle(fontWeight: FontWeight.bold),
//                  textAlign: TextAlign.left,
//                )),
//            Container(
//              child: Row(
//                children: <Widget>[
////                  Icon(Icons.verified_user),
////                  Padding(
////                    padding: EdgeInsets.only(left: 8, right: 8),
////                  ),
//                  Expanded(
//                    child: TextFormField(
//                        validator: (value) {
//                          if(value.isEmpty){
//                           // return ('Coordinator number Invalid.');
//                          }
//                          if (!value.isEmpty && value.length<10) {
//                            return ('දුරකථන අංකය වැරදයි');
//                          }
//
//                        },
//                        maxLength: 10,
//                        controller: coordinationOfficerTextController,
//                        textAlign: TextAlign.left,
//                      inputFormatters: [
//                        WhitelistingTextInputFormatter.digitsOnly
//                      ],
//                      keyboardType: TextInputType.number,
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ],
//        ),
//      );


  saveLead(BuildContext context) => Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          width: double.infinity,
          height: 50,
          child: RaisedButton(
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            color: Color.fromRGBO(0, 102, 34,0.8),
            onPressed: () {
              _validateInputs();

//              Navigator.of(context).pushNamed('/cart'); // to connect screen
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
                    SizedBox(height: 15),
                    customerName(context),
                    SizedBox(height: 20),
                    address(context),
//                    SizedBox(height: 20),
//                    contactnumber(context),
                    SizedBox(height: 20),
                    contactnumberWhatsApp(context),
//                    SizedBox(height: 20),
//                    coordinationOfficerNumber(context),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              saveLead(context),
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
                  address(context),
                  customerName(context),
//                  contactnumber(context),
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
    nicController.dispose();
    noteController.dispose();
    coordinationOfficerTextController.dispose();
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color.fromRGBO(0, 102, 34,0.8),
        title: new Text(pageName,
            style: TextStyle(color:Colors.white,fontSize: 20, fontWeight: FontWeight.bold)),
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
                    color: Colors.white,
                    image: DecorationImage(
                    colorFilter:
                    ColorFilter.mode(Colors.lightGreenAccent.withOpacity(0.20),
                    BlendMode.dstATop),
                    image: new AssetImage('assets/background_a.jpg'),
                    fit: BoxFit.cover,
                    ),
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


  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      vs.saveRequestInfo( nameController.text, addressController.text,
         whatappContactNoController.text,coordinationOfficerTextController.text);

      UserDTO farmer = new UserDTO();
      farmer.name =nameController.text;
      farmer.address =addressController.text;
      farmer.whatsappNo =nameController.text;
      farmer.role = 1;
      addFarmerRequest(farmer);

      _formKey.currentState.reset();

      Navigator.of(context).pushReplacementNamed('/cart'); // to connect screen

    } else {
      print('invalid');
//    If all data are not valid then start auto validation.
//      setState(() {
//        _autoValidate = true;
//      });
    }



  }

  Future<http.Response> addFarmerRequest(UserDTO farmerDTO) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenStr  = prefs.get('token');
    print('tokenStr = ${tokenStr}' );

    farmerDTO.phoneNo = prefs.get('user_contactnumber');

    Future<http.Response> response = null;

    String bodyd = "";
    bodyd = json.encode(farmerDTO.toJson());

    print("json map :"+bodyd);

    try {

      response = http.post('http://goviwiru.xeniqhub.xyz:8080/register',
          headers: {'Content-type': 'application/json','Authorization':'${tokenStr}'},
          body: bodyd);

    } on Exception catch (e) {
      print(e);

    }
    return response;
  }
}
