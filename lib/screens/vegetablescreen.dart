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

class VegitableAddScreen extends StatefulWidget {
  @override
  _VegitableAddScreenState createState() => _VegitableAddScreenState();
}

class _VegitableAddScreenState extends State<VegitableAddScreen> {
  final _formKey = GlobalKey<FormState>();

  Vegset veggi = Vegset();

  bool _autoValidate = false;

  final qualityController = TextEditingController();
  final weightController = TextEditingController();
  final rateController = TextEditingController();
  final freeprecentagecontroller = TextEditingController();
  VegetableService vegservice = VegetableService();

  bool isDataLoaded = false;

  bool isErrorOccurred = false;

  List<String> qualitygrades = ['Please Select', '1', '2', '3'];

  List<VegetableLoad> _vegetable = [];

  List<String> veggiesList = ['Please Select'];

  String selectedQualityValue = null;
  String selectedVegetable = '';
  String selectedProductListStrNames = null;
  String selectedNatureOfBusiness = null;
  String selectedArea = null;

  final items = <MultiSelectDialogItem<int>>[
    MultiSelectDialogItem(1, 'Auto Loan'),
    MultiSelectDialogItem(2, 'Educational Loan'),
    MultiSelectDialogItem(3, 'Business Loan'),
    MultiSelectDialogItem(4, 'Business 1'),
    MultiSelectDialogItem(5, 'Business 2'),
    MultiSelectDialogItem(6, 'Business 3'),
    MultiSelectDialogItem(7, 'Business 4'),
    MultiSelectDialogItem(8, 'Business 5'),
    MultiSelectDialogItem(9, 'Business 6'),
    MultiSelectDialogItem(10, 'Business 7'),
    MultiSelectDialogItem(11, 'Business 8'),
    MultiSelectDialogItem(12, 'Business 9'),
    MultiSelectDialogItem(13, 'Business 10'),
    MultiSelectDialogItem(14, 'Business 11'),
    MultiSelectDialogItem(15, 'Business 12'),
  ];

  DateTime selectedDate = null;

  Set<int> selectedValues = new Set();

  var username = "User Name";

  final pageName = "Add Vegetable";

  vegetable(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Vegetable / එළවළු වර්ගය",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                )),
            Container(
              child: Row(
                children: <Widget>[
                  isDataLoaded == false
                      ? CircularProgressIndicator()
                      : Expanded(
                          child: DropdownButtonFormField(
                            validator: (value) {
                              if (selectedVegetable .isEmpty) {
                                return 'එළවළු වර්ගය තෝරන්න';
                              }
                            },
                              items: veggiesList
                                .map(
                                  (value) => DropdownMenuItem(
                                    child: Text('${value}'),
                                    value: value,
                                  ),
                                )
                                .toList(),
                            onChanged: (String value) {
                              setState(() {
                                selectedVegetable = value;
                                print("Selected Channel  - $value");


                              });
                            },
                            onSaved: (val) =>
                                setState(() => veggi.vegetableDescription = val),
//                            value: selectedVegetable == ''
//                          ? 'Selected Value'
//                          : selectedVegetable,
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      );

  rate(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Text(
              "කිලෝ 1ක්  සදහා අයකරන මුදල  රුපියල්  / Rate per 1Kg",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            )),
        Container(
          child: Row(
            children: <Widget>[
              Icon(Icons.monetization_on),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
              ),
              Expanded(
                child: TextFormField(

                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  controller: rateController,
                  maxLength: 3,
                  onSaved: (val) =>
                      setState(() => veggi.rate = double.parse(val)),
                  validator: (value) {

                    if(value.isEmpty){
                      return ('Rate invalid. 1');
                    }
                    else
                    if (int.parse(value) > 2000) {
                      return ('Rate invalid. 2');
                    }
                  },
                  textAlign: TextAlign.left,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  weight(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Text(
              "බර කිලෝග්‍රෑම් / Weight in Kilograms",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            )),
        Container(
          child: Row(
            children: <Widget>[
              Icon(Icons.add_shopping_cart),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
              ),
              Expanded(
                child: TextFormField(
                  onSaved: (val) =>
                      setState(() => veggi.quantity = int.parse(val)),
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  controller: weightController,
                  maxLength: 3,
                  validator: (value) {

                    if(value.isEmpty){
                      return ('Weight invalid.1');
                    }
                    else if (int.parse(value) > 1000) {
                      return ('Weight invalid.2');
                    }
                  },
                  textAlign: TextAlign.left,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  quality(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "ගුණාත්මකභාවය / Quality",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                )),
            Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.add_shopping_cart),
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      validator: (value) {
                        if (selectedQualityValue.contains('Select Quality')) {
                          return 'Select Quality.';
                        }
                      },
//                      isExpanded: true,
                      items: qualitygrades
                          .map((value) => DropdownMenuItem(

                                child: Text(value),
                                value: value,
                              ))
                          .toList(),
                      onChanged: (String value) {
                        setState(() {
                          selectedQualityValue = value;
                        });
                        onSaved: (val) =>
                            setState(() => veggi.grade = int.parse(val));
                      },
                      value: selectedQualityValue == ''
                          ? ''
                          : selectedQualityValue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  freeprecentage(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Text(
              "නොමිලේ දෙන ප්‍රතිශතය / Free Precentage",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            )),
        Container(
          child: Row(
            children: <Widget>[
//              Icon(Icons.pre),
//              Padding(
//                padding: EdgeInsets.only(left: 8, right: 8),
//              ),
              Expanded(
                child: TextFormField(
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  controller: freeprecentagecontroller,
                  maxLength: 2,
                  validator: (value) {
                    if(value.isEmpty){

                      return ('invalid Precentage.1');
                    }
                    if (value.length > 100) {
                      return ('invalid Precentage.2');
                    }
                  },
                  onSaved: (val) =>
                      setState(() => veggi.freePercentage = int.parse(val)),
                  textAlign: TextAlign.left,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );




  products(BuildContext context) {
    selectedProductListStrNames = "";

    if (selectedValues != null) {
      selectedValues.forEach((element) => selectedProductListStrNames =
          selectedProductListStrNames +
              items.elementAt(element - 1).label +
              ",");
    } else {
      selectedValues = Set();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Products",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              )),
          Container(
            child: Row(
              children: <Widget>[
                Icon(Icons.shopping_cart),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                ),
                Expanded(
                  child: MaterialButton(
                    child: selectedValues.length == 0
                        ? Text(
                            "Select Products",
                            style: selectedValues.length == 0
                                ? TextStyle(color: Colors.red)
                                : TextStyle(color: Colors.black),
                          )
                        : Text(
                            "${selectedProductListStrNames}",
                            textAlign: TextAlign.center,
                          ),
                    onPressed: () {
                      _showMultiSelect(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    List<VegetableLoad> vegetables = await WebServiceCall.getVegetables();

    setState(() {
      isDataLoaded = true;

      for (var i = 0; i < vegetables.length; i++) {
        veggiesList.add(vegetables[i].description);
      }
    });



//
//    try {
//      assignedJobs = await webs.WebServiceCall.loadAssignedDatawithDate(date);
//      setState(() {
//        isLoadingDone = true;
//        isErrorOccurred = false;
//      });
//    } catch (e) {
//      print(e);
////      print("Connection exception occurred. ");
//      setState(() {
//        isLoadingDone = true;
//        isErrorOccurred = true;
//      });
//    }
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate == null
            ? DateTime.now().add(
                Duration(days: 2),
              )
            : selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2022));
    if (picked != null && picked != selectedDate) print(picked.day);
//    setState(() {
//      selectedDate = picked;
//    });
  }

  targetDate(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Target Date",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                )),
            Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.calendar_today),
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                  ),
                  Expanded(
                    child: MaterialButton(
                        child: Text(selectedDate == null
                            ? "Select Date"
                            : "${selectedDate.toLocal().day} - ${selectedDate.toLocal().month} - ${selectedDate.toLocal().year}"),
                        onPressed: () => _selectDate(context)),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

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
              _validateInputs();

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
    print('${veggiesList.length}');
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    vegetable(context),
                    weight(context),
                    quality(context),
                    rate(context),
                    freeprecentage(context)
                  ],
                ),
              ),
            ),
          ),
          saveLead(context),
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
                  vegetable(context),
                  //customerNIC(context),
                  products(context),
                  targetDate(context),
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
                  vegetable(context),
                  //customerNIC(context),
                  products(context),
                  targetDate(context),
                ]),
          ),
          saveLead(context),
        ],
      ),
    );
  }

  @override
  void dispose() {
    qualityController.dispose();
    weightController.dispose();
    freeprecentagecontroller.dispose();
    rateController.dispose();
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

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      print('Validated 3');
//    If all data are correct then save data to out variables
        _formKey.currentState.save();
      vegservice.addVegSet(veggi);

      setState(){
      _formKey.currentState.reset();

      }

      Navigator.of(context).pop(
                    ); // to connect screen


    } else {
      print('invalid');
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void _showMultiSelect(BuildContext context) async {
    Set<int> selectedValuesLocal = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: items,
          initialSelectedValues:
              selectedValues.length == 0 ? [1].toSet() : selectedValues.toSet(),
        );
      },
    );

//    setState(() {
//      selectedValues = selectedValuesLocal;
//    });
  }
}
