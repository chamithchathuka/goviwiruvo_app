import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    String tokenStr  = prefs.get('token');
    print('tokenStr = ${tokenStr}' );

    http.Response response = await http.get(GET_URL, headers: {'Content-type': 'application/json','Authorization':'${tokenStr}'});
    print('Response from server ${response.statusCode} - ${response.body} ');
    if (response.statusCode == 200) {
      if(response.body != null){
          return FarmerListDTO.fromJson(json.decode(response.body));
      }else{
        throw Exception('Failed to load Farmers');
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Farmers');
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
                  return Text('No registered farmars found. Consider registering farmers.');
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
            Navigator.of(context).pushNamed('/addfarmer');

          },
          child: Icon(Icons.person_add),
          backgroundColor: Colors.green,
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

