import 'dart:math';

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

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _formKey = GlobalKey<FormState>();

//  Vegset veggi = Vegset();

  bool _autoValidate = false;

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
  List<Vegset> vegitablesToBeSaved=  [];

  var username = "User Name";

  final pageName = "Vegetable List";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    vegitablesToBeSaved = vegservice.getVegstobeSaved();

    print('cart size ${vegitablesToBeSaved.length}');
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
        Container(
          child: Row(
            children: <Widget>[

            ],
          ),
        ),
      ],
    ),
  );


  Widget buildBody(BuildContext ctxt, int index) {
    return  Text(vegitablesToBeSaved[index].vegetableDescription);
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
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              listViewVegs(context)
            ],
          ),
        ),
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
  void dispose() {
    super.dispose;
//    qualityController.dispose();
//    weightController.dispose();
//    freeprecentagecontroller.dispose();
//    rateController.dispose();
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
        title: new Text(pageName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),

    floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.of(context).pushNamed('/vegadd'); // to connect screen
        },
        child: Icon(Icons.add_shopping_cart),
        backgroundColor: Colors.redAccent,
      ),
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
