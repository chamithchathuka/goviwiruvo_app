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
import 'package:intl/intl.dart';

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


  List<DropdownMenuItem<VegetableLoad>> _vegLoadItems;
  VegetableLoad _selectedVegetable;

  bool isDataLoaded = false;
  bool isErrorOccurred = false;

  List<String> qualitygrades = ['තරමක් හොදයි', 'හොදයි', 'ඉතා හොදයි'];

  List<VegetableLoad> _vegetableList = [];

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

  String selectedDate = null;

  Set<int> selectedValues = new Set();

  var username = "User Name";

  final pageName = "බෝග එකතු කරන්න";

  onChangeDropDownItem(VegetableLoad vegetableLoad){
    setState(() {
      _selectedVegetable = vegetableLoad;
    });
  }

  vegetable(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "බෝග වර්ගය",
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
                            value: _selectedVegetable,
                            items: _vegLoadItems,
                            onChanged: onChangeDropDownItem,
                            validator: (value) {
                              if (_selectedVegetable == null) {
                                return 'Select Veg.';
                              }
                            },

//                            },
//                              items:veggiesList.map((String ){
//                                return DropdownMenuItem<String>(
//                                  value: val.description,
//                                  child: new Text(val.description),
//                                );
//                              }).toList(),
//                              hint:Text(_SelectdType),
//                              onChanged:(String val){
//                                _SelectdType= val;
//                                setState(() {});
//                              }

//                            validator: (value) {
//                              if (selectedVegetable .isEmpty) {
//                                return 'බෝග වර්ගය තෝරන්න';
//                              }
//                            },
//                              items: veggiesList
//                                .map(
//                                  (value) => DropdownMenuItem(
//                                    child: Text('${value}'),
//                                    value: value,
//                                  ),
//                                )
//                                .toList(),
//                            onChanged: (String value) {
//                              setState(() {
//                                selectedVegetable = value;
//                                print("Selected Channel  - $value");
//
//
//                              });
//                            },
//                            onSaved: (val) =>
//                                setState(() { veggi.vegetableDescription = val;}),
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
              "ඒකකයක මිල (කිලෝ 1ක් සදහා)",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            )),
        Container(
          child: Row(
            children: <Widget>[
         //     Icon(Icons.monetization_on),
//              Padding(
//                padding: EdgeInsets.only(left: 8, right: 8),
//              ),
              Expanded(
                child: TextFormField(

                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  controller: rateController,
                  maxLength: 7,
                  onSaved: (val) =>
                      setState(() => veggi.rate = double.parse(val)),
                  validator: (value) {
                    if(value.isEmpty){
                      return ('මිල ඇතුලත් කරන්න');
                    }
//                    else
//                    if (int.parse(value) > 2000) {
//                      return ('මිල වැරදයි');
//                    }
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
              "බර කිලෝග්‍රෑම්",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            )),
        Container(
          child: Row(
            children: <Widget>[
         //     Icon(Icons.add_shopping_cart),
//              Padding(
//                padding: EdgeInsets.only(left: 8, right: 8),
//              ),
              Expanded(
                child: TextFormField(
                  onSaved: (val) =>
                      setState(() => veggi.quantity = int.parse(val)),
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  controller: weightController,
                  maxLength: 6,
                  validator: (value) {

                    if(value.isEmpty){
                      return ('බර ඇතුලත් කරන්න');
                    }
//                    else if (int.parse(value) > 1000) {
//                      return ('බර වැරදයි');
//                    }
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

  datepicker(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Text(
              "අස්වනු නෙලාගත් දිනය",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            )),
        Container(
          child:
          FlatButton(
            child: Text('$selectedDate'),
            color: Colors.amberAccent,
            textColor: Colors.black,
            onPressed: () {
           //   print('meek meek');

              DateTime today = new DateTime.now();
              DateTime before = today.subtract(new Duration(days: 30));
              DateTime after = today.add(new Duration(days: 30));


              showDatePicker(
                  context: context,
                  initialDate: today,
                  firstDate: before,
                  lastDate: after)
                  .then((date) {
                setState(() {
                  print('date ${date}');
                  if (date != null) {
                    var formatter = new DateFormat('dd-MM-yyyy');
                    String formatted = formatter.format(date);
                    print(formatted);
                    selectedDate = formatted;
                  }
                });
              });
            },
          ),

//          GestureDetector(
//            onTap: (){
//              print('tapped');
//
//            showDatePicker(
//                context: context,
//                initialDate: DateTime.now(),
//                firstDate: DateTime(DateTime.now().year),
//                lastDate: DateTime(DateTime.now().year))
//                .then((date) {
//              setState(() {
//                print('date ${date}');
//                if (date != null) {
//                  var formatter = new DateFormat('dd-MM-yyyy');
//                  String formatted = formatter.format(date);
//                  print(formatted);
//                  selectedDate = formatted;
//                }
//              });
//            });
//
//            },
//            child: Row(
//              children: <Widget>[
//                Expanded(
//                  child: Text(selectedDate),
//                ),
//              ],
//            ),
//          ),
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
                  "තත්වය",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                )),
            Container(
              child: Row(
                children: <Widget>[
//                  Icon(Icons.add_shopping_cart),
//                  Padding(
//                    padding: EdgeInsets.only(left: 8, right: 8),
//                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      validator: (value) {
                        if (selectedQualityValue == null) {
                          return 'තත්වය ඇතුලත් කරන්න';
                        }else if(selectedQualityValue.isEmpty ) {
                          return 'තත්වය ඇතුලත් කරන්න';
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
                            setState(() => veggi.grade = val);
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
              "නොමිලේ දෙන ප්‍රමානය (කිලෝ)",
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
                  keyboardType: TextInputType.number,
                  controller: freeprecentagecontroller,
                  maxLength: 7,

                  validator: (value) {
                    if(value.isEmpty){

                      return ('ප්‍රමානය ඇතුලත් කරන්න');
                    }
//                    if (value.length > 100) {
//                      return ('invalid වැරදයි');
//                    }
                  },
                  onSaved: (val) =>
                      setState(() => veggi.freePercentage = int.parse(val)),
                  textAlign: TextAlign.left,
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
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formatted = formatter.format(now);
    selectedDate = formatted;
    loadData();
  }

  void loadData() async {
//    List<VegetableLoad> vegetables = await WebServiceCall.getVegetables();
    _vegetableList = await WebServiceCall.getVegetables();
    _vegLoadItems = buildDropDownMenuItems(_vegetableList);
    _selectedVegetable = _vegLoadItems[0].value;

    setState(() {
      isDataLoaded = true;
    });
  }

  List<DropdownMenuItem<VegetableLoad>> buildDropDownMenuItems(List vegebleLoads){
    List<DropdownMenuItem<VegetableLoad>> items = List();

    for (VegetableLoad vegetable in vegebleLoads){
      items.add(DropdownMenuItem(
          value:vegetable ,
          child:Text(vegetable.description)
      ));
    }

    return items;
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



  saveLead(BuildContext context) => Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          width: double.infinity,
          height: 50,
          child: RaisedButton(
            color: Color.fromRGBO(0, 0, 0, 0.9),
//            shape:
//                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: () {
              _validateInputs();

//              Navigator.of(context).pop(
//              );
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
            child: Text("එකතුකරන්න",
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
                    SizedBox(height: 5),
                    vegetable(context),
                    SizedBox(height: 20),
                    weight(context),
                    SizedBox(height: 20),
                    quality(context),
                    SizedBox(height: 20),
                    rate(context),
                    SizedBox(height: 20),
                    freeprecentage(context),
                    SizedBox(height: 20),
                    datepicker(context),
                    SizedBox(height: 5)
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
                  vegetable(context),
                  //customerNIC(context),
                  products(context),
//                  targetDate(context),
                ]),
          ),
          saveLead(context),
        ],
      ),
    );
  }
//
//  @override
//  void dispose() {
////    qualityController.dispose();
////    weightController.dispose();
////    freeprecentagecontroller.dispose();
////    rateController.dispose();
////    super.dispose;
//  }

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

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      print('Validated 3');
        _formKey.currentState.save();
        Vegset v2 = Vegset();
        v2.vegetableDescription = _selectedVegetable.description;
        v2.vegId = _selectedVegetable.id;
        v2.freePercentage = int.parse(freeprecentagecontroller.text);
        v2.grade = selectedQualityValue;
        v2.rate= double.parse(rateController.text);
        v2.quantity= int.parse(weightController.text);
        v2.date = selectedDate;
      vegservice.addVegSet(v2);



      _formKey.currentState.reset();
      Navigator.of(context)
          .pushReplacementNamed(
          '/cart'); // to connect screen


    } else {
      print('invalid');
    //If all data are not valid then start auto validation.
//      setState(() {
//        _autoValidate = true;
//      });
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
