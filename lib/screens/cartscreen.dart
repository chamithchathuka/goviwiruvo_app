import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goviwiruvo_app/customwidget/multiselectdialog.dart';
import 'package:goviwiruvo_app/dto/vegetableload.dart';
import 'package:goviwiruvo_app/dto/vegetablerequestdto.dart';
import 'package:goviwiruvo_app/external/webservices.dart';
import 'package:goviwiruvo_app/model/VegetablLoadModel.dart';
import 'package:goviwiruvo_app/model/VegetableModel.dart';
import 'package:goviwiruvo_app/services/vegetableservice.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:location/location.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
//  final _formKey = GlobalKey<FormState>();

//  Vegset veggi = Vegset();

//  bool _autoValidate = false;

//  final qualityController = TextEditingController();
//  final weightController = TextEditingController();
//  final rateController = TextEditingController();
//  final freeprecentagecontroller = TextEditingController();
  VegetableService vegservice = VegetableService();

//  bool isDataLoaded = false;
//
//  bool isErrorOccurred = false;
//
//  String selectedQualityValue = null;
//  String selectedVegetable = '';
//  String selectedProductListStrNames = null;
//  String selectedNatureOfBusiness = null;
//  String selectedArea = null;
//
//  DateTime selectedDate = null;
//
//  Set<int> selectedValues = new Set();
  List<Vegset> vegitablesToBeSaved = [];

  var username = "User Name";

  final pageName = "මිලදීගත් බෝග";

  @override
  void initState() {
    super.initState();
    print('cart size ${vegitablesToBeSaved.length}');
    loadData();
  }

  void loadData() async {
    vegitablesToBeSaved = vegservice.getVegstobeSaved();
    print('cart size 2 ${vegitablesToBeSaved.length}');
  }

  listViewVegs(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Cart Vegetable List",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                )),

            new Divider(
              color: Colors.red,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              //  color: Colors.white,
              //  padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 15),
                  Expanded(child: createTable()),
                ],
              ),

//          ListView.builder
//            (
//              itemCount: vegitablesToBeSaved.length,
//              itemBuilder: (BuildContext ctxt, int index) {
//                return new Text('${vegitablesToBeSaved[index].vegetableDescription}');
//              }
//          )
            ),
          ],
        ),
      );

  Widget createTable() {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
//                SizedBox(height: 15),//SizeBox Widget
      AutoSizeText(
        'Name',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
        maxLines: 2,
      ),
      AutoSizeText(
        'Weight',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
        maxLines: 2,
      ),
      AutoSizeText(
        'Quality',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
        maxLines: 2,
      ),
      AutoSizeText(
        'Rate',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
        maxLines: 2,
      ),
      AutoSizeText(
        'Free Precentage',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
        maxLines: 2,
      ),
      AutoSizeText(
        '',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
        maxLines: 2,
      ),
    ]));
    rows.add(TableRow(children: [
//                SizedBox(height: 15),//SizeBox Widget
      SizedBox(height: 15),
      SizedBox(height: 15),
      SizedBox(height: 15),
      SizedBox(height: 15),
      SizedBox(height: 15),
      SizedBox(height: 15)
    ]));
    for (int i = 0; i < vegitablesToBeSaved.length; ++i) {
      rows.add(TableRow(children: [
//                SizedBox(height: 15),//SizeBox Widget
        SizedBox(height: 15),
        SizedBox(height: 15),
        SizedBox(height: 15),
        SizedBox(height: 15),
        SizedBox(height: 15),
        SizedBox(height: 15)
      ]));

      rows.add(TableRow(children: [
//        Text(i.toString()),
        Text('${vegitablesToBeSaved[i].vegetableDescription}'),
        Text(
          '${vegitablesToBeSaved[i].quantity} KG',
          textAlign: TextAlign.right,
        ),
        Text(
          '${vegitablesToBeSaved[i].grade}',
          textAlign: TextAlign.center,
        ),
        Text('Rs.  ${vegitablesToBeSaved[i].rate}',
          textAlign: TextAlign.right,),
        Text('${vegitablesToBeSaved[i].freePercentage} %',
          textAlign: TextAlign.right,),
        GestureDetector(
          child: Icon(Icons.clear),
          onTap: () {
            setState(() {
              vegservice.removeVegSet(vegitablesToBeSaved[i]);
//              vegitablesToBeSaved.removeAt(i);
            });
          },
        ),
      ]));
    }
    return Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: new TableBorder(
//            horizontalInside:   new BorderSide(color: Colors.black),
            //    horizontalInside: new BorderSide(color: Colors.black)
            ),
        children: rows);
  }


  submitRequestButton(BuildContext context) => Padding(
    padding: const EdgeInsets.all(0),
    child: Container(
      width: double.infinity,
      height: 50,
      child: RaisedButton(
        color: Color.fromRGBO(0, 0, 0, 0.9),
        onPressed: () async {


          if(vegservice.getVegstobeSaved().length>0){

            Location location = new Location();

            bool _serviceEnabled;
            PermissionStatus _permissionGranted;
            LocationData _locationData;

            _serviceEnabled = await location.serviceEnabled();
            if (!_serviceEnabled) {
              _serviceEnabled = await location.requestService();
              if (!_serviceEnabled) {
                return;
              }
            }

            _permissionGranted = await location.hasPermission();
            if (_permissionGranted == PermissionStatus.denied) {
              _permissionGranted = await location.requestPermission();
              if (_permissionGranted != PermissionStatus.granted) {
                return;
              }
            }

            _locationData = await location.getLocation();

            print(' lat ${_locationData.latitude}. long  - ${_locationData.longitude}');

            Alert(
                context: context,
                title: "Submit Confirmation",
                content: Column(
                  children: <Widget>[
//                  Padding(
//                    padding: const EdgeInsets.all(10.0),
//                    child: Image.network(
//                      'https://avatars2.githubusercontent.com/u/17052727?s=400&v=4',
//                    ),
//                  ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Are you sure you want to submit?',
                      ),
                    )
                  ],
                ),
                buttons: [
                  DialogButton(
                    color: Colors.teal,
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  DialogButton(
                    onPressed: () async {

                      bool issuccess  = await vegservice.callWebServicePostRequest();

                      print( issuccess);

                      Navigator.pop(context);


                      if(issuccess){
                        Alert(
                          context: context,
                          type: AlertType.success,
                          title: "Result Message",
                          desc: "Success.",
                          buttons: [
                            DialogButton(
                              child: Text(
                                "COOL",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              width: 120,
                            )
                          ],
                        ).show();
                      }else{
                        Alert(
                          context: context,
                          type: AlertType.error,
                          title: "Result Message",
                          desc: "Failed.",
                          buttons: [
                            DialogButton(
                              child: Text(
                                "Error Occurred. Please try again. ",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              width: 120,
                            )
                          ],
                        ).show();
                      }
                      //Navigator.pop(context);
//                    await storage.deleteAll();
//                    Navigator.of(context).pushNamedAndRemoveUntil(
//                        '/login', (Route<dynamic> route) => false);
////                          Navigator.of(context).popAndPushNamed(
////                              '/login'); // to connect screen
                    },
                    child: Text(
                      "Confirm",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ]).show();
          }else{
            Alert(
              context: context,
              type: AlertType.error,
              title: "Cannot Submit",
              desc: "Cart is Empty.",
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
          }


        },
        child: Text("Submit",
            style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
    ),
  );



  Widget buildBody(BuildContext ctxt, int index) {
    return Text(vegitablesToBeSaved[index].vegetableDescription);
  }

  saveLead(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          height: 50,
          child: RaisedButton(
            color: Color.fromRGBO(2, 119, 189, 0.9),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: () {
//          _validateInputs();

//              var rng = new Random(3);

//          Vegset v1 = Vegset();
//          v1.vegetableId = rng.nextInt(3);
//          v1.grade=2;
//          v1.rate=3;
//          v1.quantity=100;
//          v1.date="2013-02-01";
//          v1.freePercentage = 10;
//          Provider.of<VegetableModel>(context).addVegToList(veggiesList[rng.nextInt(3)]);
            },
            child: Text("Save",
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
                  children: [
                    listViewVegs(context),


                  ],

                ),
              ),
            ),
          ),
          submitRequestButton(context),
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
//                  targetDate(context),
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
//                  targetDate(context),
                ]),
          ),
          saveLead(context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
//        actions: <Widget>[
//          IconButton(
//              icon: Icon(Icons.search),
//              onPressed: () {
//                Navigator.of(context).pushReplacementNamed(
//                    '/leadcapturesearch'); // to connect screen
//              }),
//        ],
        backgroundColor: Color(0xFFFFFFFF),
        title: new Text(pageName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.of(context)
              .pushReplacementNamed('/vegadd'); // to connect screen
//          Navigator.of(context).pushNamed('/vegadd'); // to connect screen
        },
        child: Icon(Icons.add_shopping_cart),
        backgroundColor: Colors.redAccent,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(8.0),
        child: OrientationBuilder(builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? LayoutBuilder(builder: (context, constraints) {
                  if (constraints.maxWidth < 600) {
                    return _buildVerticalLayout(context);
                  } else {
                    return _buildVerticallTabLayout(context);
                  }
                })
              : LayoutBuilder(builder: (context, constraints) {
                  if (constraints.maxWidth < 600) {
                    return _buildHorizontalLayout(context);
                  } else {
                    //Todo Change this
                    return _buildHorizontalLayout(context);
                  }
                });
        }),
      ),
    );
  }

//  void _validateInputs() {
//    if (_formKey.currentState.validate()) {
//      print('Validated 3');
////    If all data are correct then save data to out variables
//      _formKey.currentState.save();
//
//      setState(){
//        _formKey.currentState.reset();
//
//      }
//
//    } else {
//      print('invalid');
////    If all data are not valid then start auto validation.
//      setState(() {
//        _autoValidate = true;
//      });
//    }
//  }

////  void _showMultiSelect(BuildContext context) async {
////    Set<int> selectedValuesLocal = await showDialog<Set<int>>(
////      context: context,
////      builder: (BuildContext context) {
////        return MultiSelectDialog(
////          items: items,
////          initialSelectedValues:
////          selectedValues.length == 0 ? [1].toSet() : selectedValues.toSet(),
////        );
////      },
////    );
//
////    setState(() {
////      selectedValues = selectedValuesLocal;
////    });
//  }
}
