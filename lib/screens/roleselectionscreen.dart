import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goviwiruvo_app/service/authservice.dart';
import 'package:goviwiruvo_app/services/vegetableservice.dart';

import '../myglobals.dart';



class RoleSelectionScreen extends StatefulWidget {
  @override
  _RoleSelectionScreenState createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {


  final pageName = "User Role Select";

  @override
  void initState() {
    super.initState();
  }



  Container _buildVerticalLayout(BuildContext context) {
    double vheight = MediaQuery.of(context).size.height * 0.2;

    return Container(
      child:
      Center(
        child: ListView.builder(
            itemCount: MyGlobals.USER_ROLES.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushNamed(MyGlobals.MENU_PATHS[index]),
                  child: Container(
                    height: vheight,
                    child: Center(
                      child: Text(
                        MyGlobals.USER_ROLES[index],
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
//                        image: AssetImage(MyGlobals.MENU_IMAGES[index]),
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
      ),
    );
  }



  @override
  void dispose() {
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
        backgroundColor: Color(0xFFFFFFFF),
        title: new Text(pageName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(8.0),
        child: Form(
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


}

