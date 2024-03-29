import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goviwiruvo_app/screens/cartscreen_farmer.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../myglobals.dart';
import '../dto/farmerlistdto.dart';
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
    String tokenStr = prefs.get('token');
    print('tokenStr = ${tokenStr}');

    http.Response response = await http.get(GET_URL, headers: {
      'Content-type': 'application/json',
      'Authorization': '${tokenStr}'
    });
    print('Response from server ${response.statusCode} - ${response.body} ');
    if (response.statusCode == 200) {
      if (response.body != null) {
        return FarmerListDTO.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load Farmers');
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Farmers');
    }
  }

  final pageName = "ගොවි මහතුන්";

  @override
  void initState() {
    super.initState();
    futureFarmers = fetchFarmers();
  }

  Container _buildVerticalLayout(BuildContext context) {
    double vheight = MediaQuery.of(context).size.height * 0.2;

    return Container(
      child: Center(
        child: Center(
          child: FutureBuilder<FarmerListDTO>(
            future: futureFarmers,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.farmers.length > 0) {
                  return ListView.builder(
                      itemCount: snapshot.data.farmers.length,
                      itemBuilder: (BuildContext ctxt, int Index) {
                        return Column(children: <Widget>[
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 80),
                          Row(
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height / 20,
                                width: MediaQuery.of(context).size.width - 20,
                                color: MyGlobals.backgroundColor2,
                                child: GestureDetector(
                                  onTap: () {
                                    print(
                                        '${snapshot.data.farmers[Index].name}');
                                    Farmers farmer = snapshot.data.farmers[Index] ;
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CartScreenFarmer(farmerDTO: farmer,)));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white54,
                                        borderRadius: BorderRadius.only(
                                          topLeft: const Radius.circular(10.0),
                                          topRight: const Radius.circular(10.0),
                                          bottomLeft:
                                              const Radius.circular(10.0),
                                          bottomRight:
                                              const Radius.circular(10.0),
                                        )),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: new RichText(
                                        text: new TextSpan(
                                          // Note: Styles for TextSpans must be explicitly defined.
                                          // Child text spans will inherit styles from parent
                                          style: new TextStyle(
                                            fontSize: 18,
                                            color: Colors.black87,
                                          ),
                                          children: <TextSpan>[
                                            new TextSpan(text: '        '),
                                            new TextSpan(
                                                text: (Index + 1).toString()),
                                            new TextSpan(
                                                text: '.',
                                                style: new TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            new TextSpan(text: '  '),
                                            new TextSpan(
                                                text: snapshot
                                                    .data.farmers[Index].name,
                                                style: new TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            new TextSpan(text: '  - '),
                                            new TextSpan(
                                                text: snapshot.data
                                                    .farmers[Index].phoneNo,
                                                style: new TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                      //                                      Text(
                                      //                                          "     "+(Index+1).toString() + ".     " +  snapshot.data.farmers[Index].name,
                                      //                                          style: TextStyle(
                                      //                                          color: Colors.black87,
                                      //                                          fontSize: 18,
                                      //                                          fontWeight: FontWeight.bold)
                                      //                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ]);
                      });
                } else {
                  return Text(
                      'No registered farmars found. Consider registering farmers.');
                }
              } else if (snapshot.hasError) {
                return Text("Error Occurred Unable to load farmers");
              }
              return CircularProgressIndicator();
            },
          ),
        ),
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
        appBar: AppBar(
          backgroundColor: MyGlobals.backgroundColor,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: () {
                  Alert(
                      context: context,
                      title: "Logout",
                      content: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.network(
                              '${MyGlobals.userproFileURL}',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Username',
                            ),
                          )
                        ],
                      ),
                      buttons: [
                        DialogButton(
                          color: Colors.teal,
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        DialogButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.clear();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/login', (Route<dynamic> route) => false);
                          },
                          child: Text(
                            "Logout",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ]).show();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    '${MyGlobals.userproFileURL}',
                  ),
                ),
              ),
            ),
          ],
          title: new Text(pageName,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ),
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.black87,
          onPressed: () {
            // Add your onPressed code here!
            Navigator.of(context).pushNamed('/addfarmer');
          },
          child: Icon(Icons.person_add),
          backgroundColor: MyGlobals.backgroundColor,
        ),
        body: Container(
          decoration: BoxDecoration(
            color: MyGlobals.backgroundColor2,
//            image: DecorationImage(
//              colorFilter: ColorFilter.mode(
//                  Colors.lightGreenAccent.withOpacity(0.20), BlendMode.dstATop),
//              image: new AssetImage('assets/background_a.jpg'),
//              fit: BoxFit.cover,
//            ),
          ),
          child: SafeArea(
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
        ));
  }
}
