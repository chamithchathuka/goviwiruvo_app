import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goviwiruvo_app/customwidget/multiselectdialog.dart';
import 'package:goviwiruvo_app/model/VegetableModel.dart';
import 'package:provider/provider.dart';
import 'package:international_phone_input/international_phone_input.dart';


class LeadCaptureScreen extends StatelessWidget {
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

  String selectedVegetable = null;
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
  final pageName = "ගොවි මහතාගේ තොරතුරු";

  String phoneNumber;
  String phoneIsoCode;


  vegetable(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "එළවළු වර්ගය",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                )),
            Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.restaurant_menu),
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  area(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(
          "ලිපිනය",
          style: TextStyle(fontWeight: FontWeight.bold),
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
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      controller: areaController,
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
                  style: TextStyle(fontWeight: FontWeight.bold),
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
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
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
                    child:InternationalPhoneInput(
                     // onPhoneNumberChange: onPhoneNumberChange,
                        hintText: "777363287",
                      initialPhoneNumber: phoneNumber,
                      initialSelection: phoneIsoCode,
                      enabledCountries: ['+94']
                    //  labelText: "Phone Number",
                    ),

                 /*   child: TextFormField(
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      controller: contactNoController,
                      maxLength: 10,
                      validator: (value) {
                        if (value.length != 10) {
                          return ('Contact Number invalid.');
                        }
                      },
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.number,
                    ),*/
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  contactnumberWhatsApp(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "වට්ස්අප්‍ දුරකථන අංකය",
                  style: TextStyle(fontWeight: FontWeight.bold),
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
                    child:InternationalPhoneInput(
                      // onPhoneNumberChange: onPhoneNumberChange,
                        hintText: "777363287",
                        initialPhoneNumber: phoneNumber,
                        initialSelection: phoneIsoCode,
                        enabledCountries: ['+94']
                      //  labelText: "Phone Number",
                    ),
//                    child: TextFormField(
//                      inputFormatters: [
//                        WhitelistingTextInputFormatter.digitsOnly
//                      ],
//                      controller: whatappContactNoController,
//                      maxLength: 10,
//                      validator: (value) {
//                        if (value.length != 10) {
//                          return ('Contact Number invalid.');
//                        }
//                      },
//                      textAlign: TextAlign.left,
//                      keyboardType: TextInputType.number,
//                    ),
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
                  Icon(Icons.add_shopping_cart),
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                  ),
                  Expanded(
                    child: TextFormField(

                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
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

  coordinationOfficerNumber(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "සම්බන්ධිකරණ මහතාගේ දුරකථන අංකය",
                  style: TextStyle(fontWeight: FontWeight.bold),
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
                    child:InternationalPhoneInput(
                      // onPhoneNumberChange: onPhoneNumberChange,
                        hintText: "777363287",
                        initialPhoneNumber: phoneNumber,
                        initialSelection: phoneIsoCode,
                        enabledCountries: ['+94']
                      //  labelText: "Phone Number",
                    ),
//                    child: TextFormField(
//                      inputFormatters: [
//                        WhitelistingTextInputFormatter.digitsOnly
//                      ],
//                      controller: coordinationOfficerTextController,
//                      maxLength: 10,
//                      validator: (value) {
//                        if (value.length != 10) {
//                          return ('Contact Number invalid.');
//                        }
//                      },
//                      textAlign: TextAlign.left,
//                      keyboardType: TextInputType.number,
//                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

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
//                  print(todo.vegList.length);
//                  return
//                    ListView.builder(
//                        itemCount: todo.vegList.length,
//                        itemBuilder: (context, index){
//                          return Container(
//                            child: ListTile(
//                              contentPadding: EdgeInsets.only(left: 32, right: 32, top: 8, bottom: 8),
//                              title: Text(todo.vegList[index].vegetableId.toString(),
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

  listViewNew(BuildContext context) =>
      Container(
        height: MediaQuery.of(context).size.height * 0.1,
        child: Consumer<VegetableModel>(
                builder: (context, todo, child){
          Container(
            height: 0,
            width: 0,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: todo.vegList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
//                    onTap: () =>
//                        Navigatoar.of(context).pushNamed(todo.vegList[index]),
                      child: Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.07,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.3,
                        child: Center(
                          child: Text(
                            todo.vegList[index].description.toString(),
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.rectangle,
                          borderRadius: new BorderRadius.circular(8.0),
//                      image: DecorationImage(
//                        fit: BoxFit.cover,
//                        colorFilter: ColorFilter.mode(
//                            Colors.black.withOpacity(0.4), BlendMode.dstATop),
//                      image: AssetImage(MyGlobals.MENU_IMAGES[index]),
//                      ),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10.0,
                              offset: Offset(0.0, 10.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          );}
        ),
      );

  listviewscroll(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [

        Container(
          child: Container(
              height: MediaQuery.of(context).size.height*0.2,
              child:  Consumer<VegetableModel>(
                builder: (context, todo, child){
                  print(todo.vegList.length);
                  return
                    ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: todo.vegList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
//                    onTap: () =>
//                        Navigatoar.of(context).pushNamed(todo.vegList[index]),
//                                Stack(
//                                  children: <Widget>[
//                                    Card(
//                                      color: Colors.blueAccent,
//                                      child: Container(
//                                        height: 100,
//                                        width: 350,
//                                        child: Column(
//                                          children: <Widget>[
//                                            Text(
//                                              'Day ${widget._dayNumber}',
//                                              style: TextStyle(
//                                                color: Colors.white,
//                                              ),
//                                            ),
//                                          ],
//                                        ),
//                                      ),
//                                    ),
//                                    Positioned(
//                                      top: 0,
//                                      right: 0,
//                                      child: IconButton(
//                                        onPressed: () {},
//                                        icon: Icon(Icons.more_vert),
//                                      ),
//                                    ),
//                                  ],
//                                );
                              child: Stack(
                                children: <Widget>[

                                  Container(
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.15,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.3,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            todo.vegList[index].description.toString(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),

//                                      GestureDetector(
//                                        onTap: () =>null,
//                                        child: Icon(Icons.remove),
//                                      ),
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.rectangle,
                                      borderRadius: new BorderRadius.circular(8.0),
//                      image: DecorationImage(
//                        fit: BoxFit.cover,
//                        colorFilter: ColorFilter.mode(
//                            Colors.black.withOpacity(0.4), BlendMode.dstATop),
//                      image: AssetImage(MyGlobals.MENU_IMAGES[index]),
//                      ),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 10.0,
                                          offset: Offset(0.0, 10.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: IconButton(
                                      onPressed: () {
                                        Provider.of<VegetableModel>(context).removeVegToList(todo.vegList[index]);
                                      },
                                      icon: Icon(Icons.clear,color: Colors.white70,),

                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                    );
                },
              )
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
            color: Color.fromRGBO(0, 0, 0, 0.9),
//            shape:
//                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: () {
              _validateInputs();
            },
            child: Text("ඉදිරියට",
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ),
      );

  _buildVerticalLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          customerName(context),
          SizedBox(height: 25),
          area(context),
          SizedBox(height: 25),
          contactnumber(context),
          SizedBox(height: 25),
          contactnumberWhatsApp(context),
          SizedBox(height: 25),
          coordinationOfficerNumber(context),
//        listViewNew(context ),
          listviewscroll(context),
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
                  area(context),
                  customerName(context),
                  contactnumber(context),
                  contactnumberWhatsApp(context),
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
                  area(context),
                  customerName(context),
                  contactnumber(context),
//                  natureOfBusiness(context),
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
//    super.initState();
//    if (listDrop.isEmpty) loadData();
//  }
//
//  void loadData() async {
//    var list = await service.loadwifiscaninfo();
//
//    listDrop = [];
//
//    if (list != null) {
//      list.forEach((n) {
//        print(n.ssid);
//        listDrop.add(new DropdownMenuItem(child: Text(n.ssid), value: n.ssid));
//      });
//      setState(() {
//        //_obscureText = !_obscureText;
//        _inprogress = false;
//      });
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        actions: <Widget>[
//            IconButton(
//                icon: Icon(Icons.search),
//                onPressed: () {
//                  Navigator.of(context).pushReplacementNamed(
//                      '/leadcapturesearch'); // to connect screen
//                }),
        ],
        title: new Text(pageName,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.of(context).pushNamed('/vegadd'); // to connect screen
        },
        child: Icon(Icons.add_shopping_cart),
        backgroundColor: Colors.redAccent,
      ),*/
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
