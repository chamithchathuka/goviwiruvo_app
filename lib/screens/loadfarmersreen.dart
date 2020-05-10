import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goviwiruvo_app/service/authservice.dart';
import 'package:goviwiruvo_app/services/vegetableservice.dart';

import '../myglobals.dart';



class LoadFarmerScreen extends StatefulWidget {
  @override
  _LoadFarmerScreenState createState() => _LoadFarmerScreenState();
}

class _LoadFarmerScreenState extends State<LoadFarmerScreen> {


  final pageName = "Farmers";

  @override
  void initState() {
    super.initState();
  }


  Container _buildVerticalLayout(BuildContext context) {
    double vheight = MediaQuery.of(context).size.height * 0.2;

    return Container(
      child:
      Center(
        child:
        Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.title);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
    ListView.builder(

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
                      color: Color.fromRGBO(0, 102, 34,0.8),
                      shape: BoxShape.rectangle,
                      borderRadius: new BorderRadius.circular(8.0),
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
          backgroundColor: Color.fromRGBO(0, 102, 34,0.8),
        title: new Text(pageName,
            style: TextStyle(color:Colors.white,fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body:

    Container(
    decoration: BoxDecoration(
    color: Colors.white,
    image: DecorationImage(
    colorFilter:
    ColorFilter.mode(Colors.lightGreenAccent.withOpacity(0.20),
    BlendMode.dstATop),
    image:  new AssetImage('assets/background_a.jpg'),
    fit: BoxFit.cover,
    ),
    ),
     child:
      SafeArea(
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
    )
    );
  }


}

