import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../myglobals.dart';
import 'farmerlistdto.dart';
import 'package:http/http.dart' as http;


class LoadFarmerScreen extends StatefulWidget {
  @override
  _LoadFarmerScreenState createState() => _LoadFarmerScreenState();
}

 final String GET_URL = "http://goviwiru.xeniqhub.xyz:8080/getFarmersList";

class _LoadFarmerScreenState extends State<LoadFarmerScreen> {
  Future<FarmerListDTO> futureFarmers;

  Future<FarmerListDTO> fetchFarmers() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenStr  = prefs.get('token');
    print('tokenStr = ${tokenStr}' );

    http.Response response = await http.get(GET_URL, headers: {'Content-type': 'application/json','Authorization':'${tokenStr}'});


    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return FarmerListDTO.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  final pageName = "Farmers";

  @override
  void initState() {
    super.initState();
    futureFarmers = fetchFarmers();
  }


  Container _buildVerticalLayout(BuildContext context) {
    double vheight = MediaQuery
        .of(context)
        .size
        .height * 0.2;

    return Container(
      child:
      Center(
        child:
        Center(
          child: FutureBuilder<FarmerListDTO>(
            future: futureFarmers,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.farmers.length > 0) {
                  return Expanded(
                    child: new ListView.builder
                      (
                        itemCount: snapshot.data.farmers.length,
                        itemBuilder: (BuildContext ctxt, int Index) {
                          return Text(snapshot.data.farmers[Index].name);
                        }
                    ),
                  );
                } else {
                  return Text('Not avaiable registered List');
                }
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

//    ListView.builder(
//
//            itemCount: MyGlobals.USER_ROLES.length,
//            itemBuilder: (BuildContext context, int index) {
//              return Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: GestureDetector(
//                  onTap: () =>
//                      Navigator.of(context).pushNamed(MyGlobals.MENU_PATHS[index]),
//                  child: Container(
//                    height: vheight,
//                    child: Center(
//                      child: Text(
//                        MyGlobals.USER_ROLES[index],
//                        style: TextStyle(
//                            fontSize: 20,
//                            color: Colors.white,
//                            fontWeight: FontWeight.bold),
//                      ),
//                    ),
//                    decoration: BoxDecoration(
//                      color: Color.fromRGBO(0, 102, 34,0.8),
//                      shape: BoxShape.rectangle,
//                      borderRadius: new BorderRadius.circular(8.0),
//                      boxShadow: <BoxShadow>[
//                        BoxShadow(
//                          color: Colors.black12,
//                          blurRadius: 10.0,
//                          offset: Offset(0.0, 10.0),
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//              );
          //  }),
//      ),
//    );
//  }

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

