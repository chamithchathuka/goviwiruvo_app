import 'dart:convert';

import 'package:goviwiruvo_app/dto/vegetableload.dart';
import 'package:goviwiruvo_app/dto/vegetablerequestdto.dart';
import 'package:goviwiruvo_app/external/webservices.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class VegetableService {
  static VegetableRequest vegetableRequest = VegetableRequest();

  //WebServiceCall webServiceCall = WebServiceCall();

  static final List<VegetableLoad> vegloadedList = [];
  static final List<Vegset> vegitablesToBeSaved = [];

  void addVegSet(Vegset vegset) {
    print('tem add 1 ${vegset.vegetableDescription}');
    vegitablesToBeSaved.add(vegset);
    print('tem size ${vegitablesToBeSaved.length}');

    saveinSharedPreferencesVegitablesToBeSaved();

  }

  List<Vegset> getVegstobeSaved() {
    print('tem return size ${vegitablesToBeSaved.length}');
//    print('tem return 1 ${vegitablesToBeSaved[0].vegetableDescription}');
    return vegitablesToBeSaved;
  }

  List<Vegset> removeVegSet(Vegset vegset) {
    vegitablesToBeSaved.remove(vegset);
  }

  setNewVegRequest() {
    vegetableRequest = VegetableRequest();
    vegitablesToBeSaved.clear();
  }

  saveRequestInfo(String name, String address,
      String whatsappContact, String coodinationContact) {
    vegetableRequest.name = name;
    vegetableRequest.address = address;
    vegetableRequest.whatsapp = whatsappContact;

    Connector connector = new Connector();
    connector.phone = coodinationContact;
    vegetableRequest.connector = connector;
    print('name in service - ${vegetableRequest.name}');
    saveinSharedPreferencesVegitablesToBeSaved();
  }

  saveContactNumber( String contactNo) {
    vegetableRequest.phone = contactNo;
  }


  saveLatLon(double lat,double long) {
    vegetableRequest.lat = lat;
    vegetableRequest.lon = long;
    print('name in service lat lon - ${vegetableRequest.lat} ${vegetableRequest.lon}');
  }

  Future<bool> callWebServicePostRequest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    vegetableRequest.vegset = vegitablesToBeSaved;
    http.Response response =
        await WebServiceCall.createVegRequestPOST(vegetableRequest);
    print('response code ${response.statusCode}');

    if (response.statusCode == 200) {
        prefs.clear();
      return true;
    } else {
      if (response != null) {
        print(response.statusCode);
      } else {
        print('response null');
      }
      return false;
    }
  }

  Future<bool> saveinSharedPreferencesVegitablesToBeSaved() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print('saveinSharedPreferencesVegitablesToBeSaved() ${vegitablesToBeSaved.length}');
   vegetableRequest.vegset = vegitablesToBeSaved;
    String vegRequestString = jsonEncode(vegetableRequest);
    print(vegRequestString);
    prefs.setString('vegRequest', vegRequestString);


  }


  Future<VegetableRequest> loadVegRequestFromState()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String str = prefs.getString('vegRequest');

    if(str==null){
      return null;
    }else{
      Map userMap = jsonDecode(str);

      VegetableRequest vegRequest = VegetableRequest.fromJson(userMap);

      print('VegRequest Loaded ${vegRequest.vegset.length}' );

        if(vegRequest.vegset.length>0){
          for(Vegset veg in vegRequest.vegset){
            print(veg.toJson().toString());
            vegitablesToBeSaved.add(veg);
          }
        }else{
          print('no veglist items found');
        }

      return vegRequest;
    }

  }
}
