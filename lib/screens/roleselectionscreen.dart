import 'package:auto_size_text/auto_size_text.dart';
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
  final pageName = "ගොවි විරු";

  @override
  void initState() {
    super.initState();
  }

  Container _buildVerticalLayout(BuildContext context) {
    double vheight = MediaQuery.of(context).size.height * 0.2;

    return Container(
      child: Column(
        children: <Widget>[

          Container(
            height: MediaQuery.of(context).size.height / 4,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/image_bg.png'),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.rectangle,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width ,
            color: MyGlobals.backgroundColor,
            child: Center(child: Text('ඔබේ වුර්තිය තෝරන්න',
                style: TextStyle(color:Colors.black87,fontSize: 18, fontWeight: FontWeight.bold)
            )),
            height: MediaQuery.of(context).size.height / 10,
          ),
          Expanded(
            child: Center(
              child: ListView(

                children: <Widget>[

                  SizedBox(height: MediaQuery.of(context).size.height/20),

//                  Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: GestureDetector(
//                      onTap: () => Navigator.of(context)
//                          .pushNamed(MyGlobals.MENU_PATHS[0]),
//                      child: Container(
////    decoration: BoxDecoration(
////    shape: BoxShape.circle,
////    color: Color(0xFFe0f2f1),),
//                        height: vheight,
//
//                        child: Column(
//                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                          children: <Widget>[
//                            Container(
//                              child: Image.asset('assets/icon1.png'),
//                              width: MediaQuery.of(context).size.width / 10,
//                            ),
//                            AutoSizeText(
//                              MyGlobals.USER_ROLES[0],
//                              maxFontSize: 32,
//                              maxLines: 2,
//                              style: TextStyle(
//                                  fontSize: 20,
////                                  color: Colors.white,
//                                  fontWeight: FontWeight.bold),
//                            ),
//                          ],
//                        ),
//                        decoration: BoxDecoration(
////                          color: Color.fromRGBO(0, 102, 34, 0.8),
//                          shape: BoxShape.rectangle,
//                          borderRadius: BorderRadius.circular(90.0),
////                      image: DecorationImage(
////                        fit: BoxFit.cover,
////                        colorFilter: ColorFilter.mode(
////                            Colors.black.withOpacity(0.4), BlendMode.dstATop),
////                        image: AssetImage('assets/coordination.png'),
////                      ),
//                          //Todo Comment below to remove shadow
//                          boxShadow: <BoxShadow>[
//                            BoxShadow(
//                              color: Colors.black12,
//                              blurRadius: 10.0,
//                              offset: Offset(0.0, 10.0),
//                            ),
//                          ],
//                        ),
//                      ),
//                    ),
//                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:

                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RawMaterialButton(
                          onPressed: () {
                            Navigator.of(context)
                                      .pushNamed(MyGlobals.MENU_PATHS[0]);
                          },
                          elevation: 2.0,
                          fillColor: MyGlobals.backgroundColor,
                          child: Container(
                            child: Image.asset('assets/icon1.png'),
                            width: MediaQuery.of(context).size.width / 10,
                          ),
                          padding: EdgeInsets.all(15.0),
                          shape: CircleBorder(),
                        )
                        ,
                        SizedBox(height: MediaQuery.of(context).size.height/80),
                        AutoSizeText(
                          MyGlobals.USER_ROLES[0],
                          maxFontSize: 32,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 16,
//                                  color: Colors.white,
                                fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),

                  ),

                  SizedBox(height: MediaQuery.of(context).size.height/20),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:

                     Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RawMaterialButton(
                              onPressed: () {

                                Navigator.of(context)
                                    .pushNamed(MyGlobals.MENU_PATHS[1]);

                              },
                              elevation: 2.0,
                              fillColor: MyGlobals.backgroundColor,
                              child: Container(
                                child: Image.asset('assets/icon2.png'),
                                width: MediaQuery.of(context).size.width / 10,
                              ),
                              padding: EdgeInsets.all(15.0),
                              shape: CircleBorder(),
                            )
                            ,

                            SizedBox(height: MediaQuery.of(context).size.height/80),

                            AutoSizeText(
                              MyGlobals.USER_ROLES[1],
                              maxFontSize: 32,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 16,
//                                  color: Colors.white,
                                 fontWeight: FontWeight.bold
                              ),
                            ),

//                            SizedBox(height: MediaQuery.of(context).size.height/20),
//                            AutoSizeText(
//                              "Powered by Shraddha Media Network",
//                              maxFontSize: 14,
//                              maxLines: 2,
//                              style: TextStyle(
//                                  fontSize: 16,
////                                  color: Colors.white,
//                                  fontWeight: FontWeight.bold
//                              ),
//                            ),

                          ],
                        ),

                  ),

//                    GestureDetector(
//                      onTap: () => Navigator.of(context)
//                          .pushNamed(MyGlobals.MENU_PATHS[0]),
//                      child: Container(
//                        height: vheight,
//                        child: Column(
//                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                          children: <Widget>[
//                            Container(
//                              child: Image.asset('assets/icon2.png'),
//                              width: MediaQuery.of(context).size.width / 10,
//                            ),
//                            AutoSizeText(
//                              MyGlobals.USER_ROLES[1],
//                              maxFontSize: 32,
//                              maxLines: 2,
//                              style: TextStyle(
//                                  fontSize: 20,
////                                  color: Colors.white,
//                                  fontWeight: FontWeight.bold),
//                            ),
//                          ],
//                        ),
//                        decoration: BoxDecoration(
////                          color: Color.fromRGBO(0, 102, 34, 0.8),
//                          shape: BoxShape.rectangle,
//                         // shape: BoxShape.rectangle,
//                          borderRadius: new BorderRadius.circular(90.0),
////                      image: DecorationImage(
////                        fit: BoxFit.cover,
////                        colorFilter: ColorFilter.mode(
////                            Colors.black.withOpacity(0.4), BlendMode.dstATop),
////                        image: AssetImage('assets/coordination.png'),
////                      ),
//                        //Todo Comment below to remove shadow
//                          boxShadow: <BoxShadow>[
//                            BoxShadow(
//                              color: Colors.black12,
//                              blurRadius: 10.0,
//                              offset: Offset(0.0, 10.0),
//                            ),
//                          ],
//                        ),
//                      ),
//                    ),
                //  ),




                ],
              ),
            ),
          ),
        ],
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
          backgroundColor: MyGlobals.backgroundColor,
          title: new Text(pageName,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: MyGlobals.backgroundColor2
//            image: DecorationImage(
//              colorFilter: ColorFilter.mode(
//                  Colors.lightGreenAccent.withOpacity(0.20), BlendMode.dstATop),
//              image: new AssetImage('assets/background_a.jpg'),
//              fit: BoxFit.cover,
//            ),
          ),
          child: SafeArea(
//            minimum: const EdgeInsets.all(8.0),
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
        ));
  }
}
