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
import 'package:goviwiruvo_app/myglobals.dart';
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

  List<String> qualitygrades = ['තරමක් හොඳයි', 'හොඳයි', 'ඉතා හොඳයි'];

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
                  style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black87),
                  textAlign: TextAlign.left,
                )),
            Container(
              child: Row(
                children: <Widget>[
                  isDataLoaded == false
                      ? CircularProgressIndicator()
                      : Expanded(
                          child: DropdownButtonFormField(
                            decoration:  new InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: MyGlobals.backgroundColor2)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: MyGlobals.backgroundColor2)) ,
//                        contentPadding:
//                        EdgeInsets.only(left: 15, bottom: 10,  right: 15),
                            ),
                            style: new TextStyle(
                              color: Colors.black87,
                              decorationColor: Colors.black87,//Font color change
                            ),
                            value: _selectedVegetable,
                            items: _vegLoadItems,
                            onChanged: onChangeDropDownItem,
                            validator: (value) {
                              if (_selectedVegetable == null) {
                                return 'Select Veg.';
                              }
                            },

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
              style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black87),
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
//                        contentPadding:
//                        EdgeInsets.only(left: 15, bottom: 10,  right: 15),
                  ),
                  style: new TextStyle(
                    color: Colors.black87,
                    decorationColor: Colors.black87,//Font color change
                  ),
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
              style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black87),
              textAlign: TextAlign.left,
            )),
        Container(
          child: Row(
            children: <Widget>[
         //     Icon(Icons.add_shopping_cart),
////              Padding(
////                padding: EdgeInsets.only(left: 8, right: 8),
////              ),
              Expanded(
                child: TextFormField(
                  decoration:  new InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87)) ,
//                        contentPadding:
//                        EdgeInsets.only(left: 15, bottom: 10,  right: 15),
                  ),
                  style: new TextStyle(
                    color: Colors.black87,
                    decorationColor: Colors.black87,//Font color change
                  ),
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
              style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black87),
              textAlign: TextAlign.left,
            )),
        Container(
          child:
          FlatButton(
            child: Text('$selectedDate'),
            color: MyGlobals.backgroundColor,
            textColor: Colors.black87,
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
                  style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black87),
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

                      decoration:  new InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyGlobals.backgroundColor2)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyGlobals.backgroundColor2)) ,
                      ),
                      style: new TextStyle(
                        color: Colors.black87,
                        decorationColor: Colors.black87,//Font color change
                      ),

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
              "නොමිලේ දෙන ප්‍රමාණය (කිලෝ)",
              style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black87),
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
                  decoration:  new InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87)) ,
//                        contentPadding:
//                        EdgeInsets.only(left: 15, bottom: 10,  right: 15),
                  ),
                  style: new TextStyle(
                    color: Colors.black87,
                    decorationColor: Colors.black87,//Font color change
                  ),
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
                    if (int.parse(weightController.text)< int.parse(value)) {
                      return ('වැරදයි');
                    }
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
  }



  saveLead(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 60,left: 60),
        child: Container(
          width: double.infinity,
          height: 50,
          child: RaisedButton(
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.white,
            onPressed: () {
              _validateInputs();
            },
            child: Text("එකතුකරන්න",
                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold,  fontSize: 18)),
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: MyGlobals.backgroundColor,
        title: new Text(pageName, style: TextStyle(color:Colors.black87,fontSize: 18, fontWeight: FontWeight.bold)),

      ),
      body:
      Container(
              decoration: BoxDecoration(
              color: MyGlobals.backgroundColor2,
//              image: DecorationImage(
//              colorFilter:
//              ColorFilter.mode(Colors.lightGreenAccent.withOpacity(0.20),
//              BlendMode.dstATop),
//              image: new AssetImage('assets/background_a.jpg'),
//              fit: BoxFit.cover,
//              ),
              ),
         child: SafeArea(
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
          .pushNamed(
          '/cart'); // to connect screen


    } else {
      print('invalid');

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

  }
}
