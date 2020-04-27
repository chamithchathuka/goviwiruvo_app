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
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:location/location.dart' as mylocation;

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  bool _serviceEnabled;
  mylocation.Location _locationService = new mylocation.Location();
  mylocation.PermissionStatus _permission ;
  String error;

  double lat = 0.0;
  double lon = 0.0;



  mylocation.LocationData location;


  VegetableService vegservice = VegetableService();

  List<Vegset> vegitablesToBeSaved = [];

  var username = "User Name";

  final pageName = "මිලදීගත් බෝග";

  bool keepWaiting = false;

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
                  "",
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

            ),
          ],
        ),
      );

  Widget createTable() {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
//                SizedBox(height: 15),//SizeBox Widget
      AutoSizeText(
        'බෝග වර්ගය',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
        maxLines: 2,
      ),
      AutoSizeText(
        'බර kg',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
        maxLines: 2,
      ),
      AutoSizeText(
        'නොමිලේ ප්‍රමානය kg',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
        maxLines: 2,
      ),
      AutoSizeText(
        'ඒකක මිල',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
        maxLines: 2,
      ),
      AutoSizeText(
          'මුලු මුදල',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
        maxLines: 2,
      ),
      AutoSizeText(
        'දිනය',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
        maxLines: 2,
      ),
      AutoSizeText(
        '',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
        maxLines: 1,
      ),
    ]));
    rows.add(TableRow(children: [
//                SizedBox(height: 15),//SizeBox Widget
      SizedBox(height: 15),
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
        SizedBox(height: 15),
        SizedBox(height: 15)
      ]));

      double price =  (vegitablesToBeSaved[i].quantity- vegitablesToBeSaved[i].freePercentage)* vegitablesToBeSaved[i].rate;

      rows.add(TableRow(children: [
//        Text(i.toString()),
        Text('${vegitablesToBeSaved[i].vegetableDescription}'),
        Text(
          '${vegitablesToBeSaved[i].quantity}',
          textAlign: TextAlign.center,
        ),
        Text(
          '${vegitablesToBeSaved[i].freePercentage}',
          textAlign: TextAlign.center,
        ),
        Text('${vegitablesToBeSaved[i].rate}',
          textAlign: TextAlign.center,),
        Text('${price}',
          textAlign: TextAlign.center,),
        Text('${vegitablesToBeSaved[i].date}',
          textAlign: TextAlign.center,),
        GestureDetector(
          child: Icon(Icons.clear),
          onTap: () {
            setState(() {
              vegservice.removeVegSet(vegitablesToBeSaved[i]);
//              vegitablesToBeSaved.removeAt(i);
            });
          },
        )
      ]));
    }
    rows.add(TableRow(children: [
//                SizedBox(height: 15),//SizeBox Widget
      SizedBox(height: 15),
      SizedBox(height: 15),
      SizedBox(height: 15),
      SizedBox(height: 15),
      SizedBox(height: 15),
      SizedBox(height: 15),
      SizedBox(height: 15)
    ]));
    rows.add(TableRow(children: [
//                SizedBox(height: 15),//SizeBox Widget

      SizedBox(height: 15),
      SizedBox(height: 15),
      SizedBox(height: 15),
      SizedBox(height: 15),
      SizedBox(height: 15),
      SizedBox(height: 15),
      GestureDetector(
        child: new IconTheme(
          data: new IconThemeData(
              color: Colors.redAccent),
          child: new Icon(Icons.add_circle,size:48),
        ),
        onTap: () {
          setState(() {
            Navigator.of(context)
                .pushReplacementNamed('/vegadd');
//              vegitablesToBeSaved.removeAt(i);
          });
        },
      )
    ]));





    return Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: new TableBorder(
//            horizontalInside:   new BorderSide(color: Colors.black),
            //    horizontalInside: new BorderSide(color: Colors.black)
            ),
        children: rows);
  }

//  locationButton(BuildContext context) => Padding(
//    padding: const EdgeInsets.all(0),
//    child: Container(
//      width: double.infinity,
//      height: 50,
//      child: RaisedButton(
//        color: Color.fromRGBO(0, 0, 0, 0.9),
//        onPressed: () async {
//          if(vegservice.getVegstobeSaved().length>0){
//
//            var currentLocation = null;
//            mylocation.PermissionStatus _permission ;
//
//            mylocation.LocationData location;
//
//
//            try {
//              bool serviceStatus = await _locationService.serviceEnabled();
//              print("Service status: $serviceStatus");
//              if (serviceStatus) {
//                _permission = await _locationService.requestPermission();
//                print("Permission: $_permission");
//                if (_permission==mylocation.PermissionStatus.granted) {
//                  location = await _locationService.getLocation();
//                  print('start lat ${location.latitude.toString()} ?');
//                  print('start lng  ${location.longitude.toString()} ?');
//
//                  print('lat long');
//                  print(location.latitude.toString());
//                  print(location.longitude.toString());
//
//                  lat = location.latitude;
//                  lon = location.longitude;
//
//                  vegservice.saveLatLon( lat, lon);
//
//
//                  Alert(
//                    context: context,
//                    type: AlertType.success,
//                    title: "Location",
//                    desc: "permission ${location.latitude.toString()} Longitude ${location.longitude.toString()} ",
//                    buttons: [
//                      DialogButton(
//                        child: Text(
//                          "close",
//                          style: TextStyle(color: Colors.white, fontSize: 20),
//                        ),
//                        onPressed: () => Navigator.pop(context),
//                        width: 120,
//                      )
//                    ],
//                  ).show();
//
//
//                  // await _goToMyLocation(location.latitude, location.longitude);
//                } else {
//                  print('permission not available');
//                  Alert(
//                    context: context,
//                    type: AlertType.error,
//                    title: "Unable to Retrieve Location",
//                    desc: "permission ${location.latitude.toString()} Longitude ${location.longitude.toString()} ",
//                    buttons: [
//                      DialogButton(
//                        child: Text(
//                          "close",
//                          style: TextStyle(color: Colors.white, fontSize: 20),
//                        ),
//                        onPressed: () => Navigator.pop(context),
//                        width: 120,
//                      )
//                    ],
//                  ).show();
//                  //_showDialog();
//                }
//              }
//            } on PlatformException catch (e) {
//              if (e.code == 'PERMISSION_DENIED') {
//                error = e.message;
//                print('permission denied');
//              } else if (e.code == 'SERVICE_STATUS_ERROR') {
//                error = e.message;
//              }
//              location = null;
//            } on Exception catch (ex) {
//              print(ex);
//
//              error = ex.toString();
//            }
//
//
//          }else{
//
//          }
//
//
//        },
//        child: Text("Location",
//            style: TextStyle(color: Colors.white, fontSize: 20)),
//      ),
//    ),
//  );


  submitRequestButton(BuildContext context) => Padding(
    padding: const EdgeInsets.all(0),
    child: Container(
      width: double.infinity,
      height: 50,
      child: RaisedButton(
        color: Color.fromRGBO(0, 0, 0, 0.9),
        onPressed: () async {
          if(vegservice.getVegstobeSaved().length>0){

//            var currentLocation = null;

            Alert(
                context: context,
                title: "තහවුරු කරන්න",
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
                        "ඔබ දත්ත ඇතුලත් කිරීම ස්තිර කරන්න",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      )
                      ,
                    )
                  ],
                ),
                buttons: [
                  DialogButton(
                    color: Colors.redAccent,
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "පෙර මෙනුවට",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  keepWaiting?CircularProgressIndicator():DialogButton(
                    color: Colors.green,
                    onPressed: () async {
//                      ModalProgressHUD(child: _buildWidget(), inAsyncCall: _saving),

                      setState(() {
                        keepWaiting = true;
                      });


                      getLocationAccess(context);


                      //Navigator.pop(context);
//                    await storage.deleteAll();
//                    Navigator.of(context).pushNamedAndRemoveUntil(
//                        '/login', (Route<dynamic> route) => false);
////                          Navigator.of(context).popAndPushNamed(
////                              '/login'); // to connect screen
                    },
                    child: Text(
          "ස්තිරයි",
          style: TextStyle(color: Colors.black, fontSize: 20),
          ),
                  ),
                ]).show();







          }else{
            Alert(
              context: context,
              type: AlertType.error,
              title: "ඇතුලත්කල නොහැක",
              desc: "බෝග වර්ග ඇතුලත්කර උත්සහ කරන්න",
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
        child: Text("පුරවන්න",
            style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
    ),
  );


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

          lat = location.latitude;
          lon = location.longitude;
          
          vegservice.saveLatLon(lat, lon);

    bool issuccess  = await vegservice.callWebServicePostRequest();

    print( issuccess);

    Navigator.pop(context);


    if(issuccess){
      setState(() {

        keepWaiting = false;
      });


      Alert(
        context: context,
        type: AlertType.success,
        title: "දත්ත ඇතුලත් කිරීම",
        desc: "සාර්තකයි.",
        buttons: [
          DialogButton(
            child: Text(
              "",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {

              Navigator.pop(context);
              setState(() {
                vegitablesToBeSaved.clear();
                vegservice.setNewVegRequest();

              });
            } ,
            width: 120,
          )
        ],
      ).show();
    }else{
      setState(() {

        keepWaiting = false;
      });

      Alert(
        context: context,
        type: AlertType.error,
        title: "දත්ත ඇතුලත් කිරීම",
        desc: "අසාර්තකයි",
        buttons: [
          DialogButton(
            child: Text(
              "දෝෂයකි, නැවත උත්සහ කරන්න",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }




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
        error = e.message;
        print('permission denied');
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
        error = e.message;
      }
      location = null;

      setState(() {

        keepWaiting = false;
      });



    } on Exception catch (ex) {
      print(ex);

      setState(() {

        keepWaiting = false;
      });

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


      error = ex.toString();
    }

   }

  Widget buildBody(BuildContext ctxt, int index) {
    return Text(vegitablesToBeSaved[index].vegetableDescription);
  }

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
      //    locationButton(context),
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
//          saveLead(context),
          submitRequestButton(context),
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
          submitRequestButton(context),
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
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {
//          // Add your onPressed code here!
//          Navigator.of(context)
//              .pushReplacementNamed('/vegadd'); // to connect screen
////          Navigator.of(context).pushNamed('/vegadd'); // to connect screen
//        },
//        child: Icon(Icons.add_shopping_cart),
//        backgroundColor: Colors.redAccent,
//      ),
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
