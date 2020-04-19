import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goviwiruvo_app/customwidget/multiselectdialog.dart';
import 'package:goviwiruvo_app/dto/vegetableload.dart';
import 'package:goviwiruvo_app/dto/vegitablerequestdto.dart';
import 'package:goviwiruvo_app/external/webservices.dart';
import 'package:goviwiruvo_app/model/VegetablLoadModel.dart';
import 'package:goviwiruvo_app/model/VegetableModel.dart';
import 'package:provider/provider.dart';

class VegitableAddScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  final areaController = TextEditingController();
  final nameController = TextEditingController();
  final whatappContactNoController = TextEditingController();
  final weightController = TextEditingController();
  final coordinationOfficerTextController = TextEditingController();
  final contactNoController = TextEditingController();
  final nicController = TextEditingController();
  final noteController = TextEditingController();

  List<String> _channels = ['Please Select', 'Walk-in', 'B', 'C', 'D'];
  List<VegetableLoad> _vegetable = [];
  List<VegetableLoad> veggiesList = [];

  String selectedVegitable = null;
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

              "Vegetable/එළවළු වර්ගය",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            )),
        Container(
          child:  Row(
            children: <Widget>[
              Icon(Icons.restaurant_menu),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
              ),
              Expanded(
                child: veggiesList==null?Center(child:CircularProgressIndicator()):
                DropdownButtonFormField(
                  validator: (value) {

                    if (selectedVegitable == null) {
                      return 'එළවළු වර්ගය තෝරන්න';
                    }
                  },
//                      isExpanded: true,
                  items: veggiesList
                      .map((value) {
                    print('${value.description}');
                    return DropdownMenuItem(
                      child: Text('1'),
                      value: value,
                    );
                  }
                     )
                      .toList(),
//                    onChanged: (VegetableLoad value) {
//                    },
                  value:
//                  selectedVegitable == null
//                      ? _vegetable.first
//                      :
                  selectedVegitable,
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
              "Weight in Kilograms/බර කිලෝග්‍රෑම්",
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

                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  controller: weightController,
                  maxLength: 10,
                  validator: (value) {
                    if (value.length < 1000) {
                      return ('Weight invalid.');
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


//  listviewscroll(BuildContext context) => Padding(
//    padding: const EdgeInsets.only(top: 8),
//    child: Column(
//      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//      children: [
//
//        Container(
//          child: Container(
//              height: MediaQuery.of(context).size.height*0.3,
//              child:  Consumer<VegetableModel>(
//                builder: (context, todo, child){
//                  print(todo.vegMap.length);
//                  return
//                    ListView.builder(
//                        itemCount: todo.vegMap.length,
//                        itemBuilder: (context, index){
//                          return Container(
//                            child: ListTile(
//                              contentPadding: EdgeInsets.only(left: 32, right: 32, top: 8, bottom: 8),
//                              title: Text(todo.vegMap[index].vegetableId.toString(),
//                                style : TextStyle(color: Colors.black87,
//                                    fontWeight: FontWeight.bold),
//                              ),
////                            subtitle: Text(todo.vegList[index].grade.toString(), style: TextStyle(color: Colors.black45,
////                                fontWeight: FontWeight.bold),),
//
//                              trailing: Icon(Icons.check_circle, color: Colors.greenAccent,),
//                            ),
//                            margin: EdgeInsets.only(bottom: 8, left: 16, right: 16),
//                          );
//                        }
//                    );
//                },
//              )
//          ),
//        ),
//      ],
//    ),
//  );

  customerNIC(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Customer NIC",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            )),
        Container(
          child: Row(
            children: <Widget>[
              Icon(Icons.perm_identity),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
              ),
              Expanded(
                child: TextFormField(
                  controller: nicController,
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
                      style: selectedValues.length==0
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
          //_validateInputs();

          var rng = new Random(3);

//          Vegset v1 = Vegset();
//          v1.vegetableId = rng.nextInt(3);
//          v1.grade=2;
//          v1.rate=3;
//          v1.quantity=100;
//          v1.date="2013-02-01";
//          v1.freePercentage = 10;
          Provider.of<VegetableModel>(context).addVegToList(veggiesList[rng.nextInt(3)]);

        },
        child: Text("Save Lead",
            style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
    ),
  );

  _buildVerticalLayout(BuildContext context) {
    print('${veggiesList.length}');
    return SingleChildScrollView(
      child: Column(
        children: [
          vegetable(context),
          weight(context),

//          listviewscroll(context),
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
                  customerNIC(context),
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
                  customerNIC(context),
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
    areaController.dispose();
    nameController.dispose();
    whatappContactNoController.dispose();
    weightController.dispose();
    contactNoController.dispose();
    nicController.dispose();
    noteController.dispose();
    coordinationOfficerTextController.dispose();
//    super.dispose();
  }
//
//  @override
//  void initState() {
//   // super.initState();
//    if (_vegetable.isEmpty) loadData();
//  }
////
//  void loadData() async {
//    var list = await WebServiceCall.getVegetables();
//
//    var listDrop = [];
//
//    if (list != null) {
//      list.forEach((n) {
//        listDrop.add(new DropdownMenuItem(child: Text(n.id.toString()), value: n.description));
//      });
////      setState(() {
////        //_obscureText = !_obscureText;
////        _inprogress = false;
////      });
//    }
//  }

  @override
  Widget build(BuildContext context) {

veggiesList = Provider.of<List<VegetableLoad>>(context);

    return

      Scaffold(

        appBar: new AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(
                      '/leadcapturesearch'); // to connect screen
                }),
          ],
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
      print('Validated');
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
      _formKey.currentState.reset();
    } else {
      print('invalid');
//    If all data are not valid then start auto validation.
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
