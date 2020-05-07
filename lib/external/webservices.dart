import 'package:goviwiruvo_app/dto/farmer.dto.dart';
import 'package:goviwiruvo_app/dto/tokenDTO.dart';
import 'package:goviwiruvo_app/dto/usertokenid.dart';
import 'package:goviwiruvo_app/dto/vegetableload.dart';
import 'package:goviwiruvo_app/dto/vegetablerequestdto.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WebServiceCall {


  static final String GET_URL = "http://goviwiru.xeniqhub.xyz:8080/vegetable";
  static final String POST_URL = "http://goviwiru.xeniqhub.xyz:8080/createVegetableList";
  static final String POST_ADD_FARMER_URL = "http://goviwiru.xeniqhub.xyz:8080/registerFarmer";
  static final String TOKEN_URL = "https://us-central1-goviwiru.cloudfunctions.net/getToken";

//  Map<String, String> get headers => {
//    "Content-Type": "application/json",
//    "Accept": "application/json",
//    "Authorization": "Bearer $_token",
//  };
//  var response = await http.get(url, headers: headers);
//  if (response.statusCode != 200) {
//  throw Exception(
//  "Request to $url failed with status ${response.statusCode}: ${response.body}");
//  }
  static Future<List<VegetableLoad>> getVegetables() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenStr  = prefs.get('token');
    print('tokenStr = ${tokenStr}' );

    Response res = await http.get(GET_URL, headers: {'Content-type': 'application/json','Authorization':'${tokenStr}'});

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<VegetableLoad> vegetables = body
          .map(
            (dynamic item) => VegetableLoad.fromJson(item),
      )
          .toList();

      print('200');

      return vegetables;
    } else {
      print('else');
      throw "Can't get veggies list.";
    }
  }

  static Future<http.Response> getToken(String uuid) async {

    http.Response response = null;

    UseridDTO userToken = UseridDTO();
    userToken.uid = uuid;

    String bodyd = "";
    bodyd = json.encode(userToken.toJson());

    print("json map :"+bodyd);

    try {
      response = await http.post(TOKEN_URL,
          headers: {"Content-Type": "application/json"}, body: bodyd);
          print('gettoken response ${response.body}');

      if(response !=null ){
      if(response.statusCode == 200)
        if(response.body.isNotEmpty){

              TokenDTO tokenDTO = new TokenDTO.fromJson(json.decode(response.body));
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('token',tokenDTO.token);
        }else{
          print('body  empty');
        }
      }

    } on Exception catch (e) {
      print(e);
    }
    return response;
  }

  static Future<http.Response> addFarmerRequest(FarmerDTO farmerDTO) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenStr  = prefs.get('token');
    print('tokenStr = ${tokenStr}' );

    Future<http.Response> response = null;

    String bodyd = "";
    bodyd = json.encode(farmerDTO.toJson());

    print("json map :"+bodyd);

    try {

      response = http.post(POST_ADD_FARMER_URL,
          headers: {'Content-type': 'application/json','Authorization':'${tokenStr}'},
          body: bodyd);

    } on Exception catch (e) {
      print(e);

    }
    return response;
  }

  static Future<http.Response> createVegRequestPOST(VegetableRequest vegetableRequest) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenStr  = prefs.get('token');
    print('tokenStr = ${tokenStr}' );

    Future<http.Response> response = null;

    String bodyd = "";
    bodyd = json.encode(vegetableRequest.toJson());

    print("json map :"+bodyd);

    try {
     
      response = http.post(POST_URL,
          headers: {'Content-type': 'application/json','Authorization':'${tokenStr}'},
          body: bodyd);
    } on Exception catch (e) {
      print(e);

    }
    return response;
  }




  static Future<http.Response> getUserRoleData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenStr  = prefs.get('token');
    print('tokenStr = ${tokenStr}' );

    Future<http.Response> response = null;

//    String bodyd = "";
//    bodyd = json.encode(vegetableRequest.toJson());
//
//    print("json map :"+bodyd);
//
//    try {
//      response = http.post(POST_URL,
//          headers: {"Content-Type": "application/json"}, body: bodyd);
//    } on Exception catch (e) {
//      print(e);
//
//    }
    return response;
  }



//
//  static Future<http.Response> changeJobStatus(ResetPasswordDTO resetPasswordDTO) async {
//    String _changeResponse = '${MyGlobals.hostURL}/login/reset';
//
//    Future<http.Response> response = null;
//
//    String token = "";
//    token = json.encode(resetPasswordDTO.toJson());
//
//    print("json map :"+token);
//
//    try {
//      response = http.post(_changeResponse,
//          headers: {"Content-Type": "application/json"}, body: token);
//    } on Exception catch (e) {
//      print(e);
//
//    }
//    return response;
//  }

//  static Future<http.Response> resetUserPasswordPOST(ResetPasswordDTO resetPasswordDTO) async {
//    String _validateurl = '${MyGlobals.hostURL}/login/reset';
//
//    Future<http.Response> response = null;
//
//    String token = "";
//    token = json.encode(resetPasswordDTO.toJson());
//
//    print("json map :"+token);
//
//    try {
//      response = http.post(_validateurl,
//          headers: {"Content-Type": "application/json"}, body: token);
//    } on Exception catch (e) {
//      print(e);
//
//    }
//    return response;
//  }



//  static Future<LeadcaptureDTO> fetchLead()  async  {
//    print('fetch lead called. ');
//    final storage = new FlutterSecureStorage();
//    String valuejson = await storage.read(
//        key: "TEMP_TOKEN");
//    print("Value temptoken: ${json.decode(valuejson).toString()}");
//
//    LeadcaptureDTO leadcaptureDTO = null;
//
//    TokenDTO tokenDTO = new TokenDTO();
//    tokenDTO.token = valuejson;
//
//    const url = '${MyGlobals.hostURL}/leadcapture/getlead';
//
//    // AwaValue :it the http get response, then decode the json-formatted responce.
//    Response response = await http.post(url,
//        headers: {"Content-Type": "application/json"},
//        body: json.encode(tokenDTO.toJson()),
//    );
//
//    int statusCode = response.statusCode;
//
//    if (statusCode == 200) {
//      print("success");
//      leadcaptureDTO = LeadcaptureDTO.fromJson(json.decode(response.body));
//    } else {
//      print("failed ${statusCode}");
//      throw("Network connection failed with code :${statusCode} "); // error thrown
//    }
//
//    print('leadvature data on receive  ${leadcaptureDTO.toString()}');
//    return leadcaptureDTO;
//  }

//  static Future<String> getjobByRefIdAndJobType(JobType jobType,String refId)  async  {
//    print('refid in web service class');
//    print(refId);
//    final storage = new FlutterSecureStorage();
//    String valuejson = await storage.read(
//        key: "TEMP_TOKEN");
//    print("Value temptoken: ${json.decode(valuejson).toString()}");
//
//    String jobstatusStr = EnumToString.parse(jobType);
//    print(jobstatusStr);
//
//
//    TokenDTO tokenDTO = new TokenDTO();
//    tokenDTO.token = valuejson;
//
//    var url = '${MyGlobals.hostURL}/hello/job/${jobstatusStr}/${refId}';
//
//    // AwaValue :it the http get response, then decode the json-formatted responce.
//    Response response = await http.post(url,
//      headers: {"Content-Type": "application/json"},
//      body: json.encode(tokenDTO.toJson()),
//    );
//
//    int statusCode = response.statusCode;
//
//    if (statusCode == 200) {
//      print("success");
//      return response.body;
//    } else {
//      print("failed ${statusCode}");
//      throw("Network connection failed with code :${statusCode} "); // error thrown
//    }
//
//  }
//

//  static Future<CommonJobDTO> getjobByRefId(String refId)  async  {
//    final storage = new FlutterSecureStorage();
//    String valuejson = await storage.read(
//        key: "AUTH_TOKEN");
//    print("Value temptoken: ${json.decode(valuejson).toString()}");
//
//    CommonJobDTO commonJobDTO = null;
//
//    AuthTokenDTO tokenDTO = AuthTokenDTO.fromJson(json.decode(valuejson));
//
//    var url = '${MyGlobals.hostURL}/job/byid/${refId}';
//    Response response =null;
//    try {
//      // AwaValue :it the http get response, then decode the json-formatted responce.
//      response = await http.post(url,
//        headers: {"Content-Type": "application/json"},
//        body: json.encode(tokenDTO.toJson()),
//      );
//      int statusCode = response.statusCode;
//
//      if (statusCode == 200) {
//        print("updatejobByRefId success");
//        print(response.body);
//        commonJobDTO = new CommonJobDTO.fromJson(json.decode(response.body));
//
//        print('obj Print : ${commonJobDTO.toString()}');
//      } else {
//        print("failed ${statusCode}");
//        throw("Network connection failed with code :${statusCode} "); // error thrown
//      }
//
//      return commonJobDTO;
//    } catch (e) {
//      print(e);
//      throw("Network connection failed ${e}"); // error thrown
//    }
//  }

//  static Future<List<LeadCapture>> loadMyLeads()  async  {
//    print('fetch lead called.');
//    final storage = new FlutterSecureStorage();
//    String valuejson = await storage.read(
//        key: "TEMP_TOKEN");
//    print("Value temptoken: ${json.decode(valuejson).toString()}");
//
//    LeadcaptureDTO leadcaptureDTO = null;
//
//    TokenDTO tokenDTO = new TokenDTO();
//    tokenDTO.token = valuejson;
//
//    const url = '${MyGlobals.hostURL}/leadcapture/getmyleads';
//
//    // AwaValue :it the http get response, then decode the json-formatted responce.
//    Response response = await http.post(url,
//      headers: {"Content-Type": "application/json"},
//      body: json.encode(tokenDTO.toJson()),
//    );
//
//    int statusCode = response.statusCode;
//    List<LeadCapture> leadsList = null;
//
//    if (statusCode == 200) {
//      print("success");
//      MyLeadsDTO leadsDTO = new MyLeadsDTO.fromJson(json.decode(response.body));
//      leadsList = leadsDTO.leads;
//      print('length : ${leadsList.length}');
//    } else {
//      print("failed ${statusCode}");
//      throw("Network connection failed with code :${statusCode} "); // error thrown
//    }
//
//    return leadsList;
//  }

//  static Future<CommonJobDTO> updatejobByRefId(String refNumber)  async {
//    print('updatejobByRefId called.');
//    final storage = new FlutterSecureStorage();
//    String valuejson = await storage.read(
//        key: "AUTH_TOKEN");
//    print("Value temptoken: ${json.decode(valuejson).toString()}");
//
//    CommonJobDTO commonJobDTO = null;
//
//    AuthTokenDTO tokenDTO = AuthTokenDTO.fromJson(json.decode(valuejson));
//
//
//    var url = '${MyGlobals.hostURL}/job/byid/${refNumber}';
//    Response response =null;
//    try {
//      // AwaValue :it the http get response, then decode the json-formatted responce.
//      response = await http.post(url,
//        headers: {"Content-Type": "application/json"},
//        body: json.encode(tokenDTO.toJson()),
//      );
//      int statusCode = response.statusCode;
//
//      if (statusCode == 200) {
//        print("updatejobByRefId success");
//        print(response.body);
//        commonJobDTO = new CommonJobDTO.fromJson(json.decode(response.body));
//
//        // print('length : ${assignedJobsList.length}');
//      } else {
//        print("failed ${statusCode}");
//        throw("Network connection failed with code :${statusCode} "); // error thrown
//      }
//
//      return commonJobDTO;
//    } catch (e) {
//      print(e);
//      throw("Network connection failed ${e}"); // error thrown
//    }
//
//  }

//  static Future<AssignedJob> loadAssignedData()  async {
//    print('fetch lead called.');
//    final storage = new FlutterSecureStorage();
//    String valuejson = await storage.read(
//        key: "TEMP_TOKEN");
//    print("Value temptoken: ${json.decode(valuejson).toString()}");
//
//    AssignedJob assignedJobs = null;
//
//    TokenDTO tokenDTO = new TokenDTO();
//    tokenDTO.token = valuejson;
//
//
//
//    const url = '${MyGlobals.hostURL}/hello';
//    Response response =null;
//    try {
//      // AwaValue :it the http get response, then decode the json-formatted responce.
//        response = await http.post(url,
//        headers: {"Content-Type": "application/json"},
//        body: json.encode(tokenDTO.toJson()),
//      );
//        int statusCode = response.statusCode;
//
//        if (statusCode == 200) {
//          print("success");
//
//          assignedJobs = new AssignedJob.fromJson(json.decode(response.body));
//
//          // print('length : ${assignedJobsList.length}');
//        } else {
//          print("failed ${statusCode}");
//          throw("Network connection failed with code :${statusCode} "); // error thrown
//        }
//
//        return assignedJobs;
//    } catch (e) {
//      print(e);
//      throw("Network connection failed ${e}"); // error thrown
//    }
//  }

//  static Future<AssignedJob> loadAssignedDatawithDate(String date)  async {
//    print('loadAssignedDatawithDate called.');
//    final storage = new FlutterSecureStorage();
//    String valuejson = await storage.read(
//        key: "AUTH_TOKEN");
//    print("Value temptoken: ${json.decode(valuejson).toString()}");
//
//    AssignedJob assignedJobs = null;
//
//    AuthTokenDTO tokenDTO = AuthTokenDTO.fromJson(json.decode(valuejson));
//
//    date = "01-01-2015";
//
//    var url = '${MyGlobals.hostURL}/job/bydate/${date}';
//    Response response =null;
//    try {
//      // AwaValue :it the http get response, then decode the json-formatted responce.
//      response = await http.post(url,
//        headers: {"Content-Type": "application/json"},
//        body: json.encode(tokenDTO.toJson()),
//      );
//      int statusCode = response.statusCode;
//
//      if (statusCode == 200) {
//        print("loadAssignedDatawithDate success");
//        print(response.body);
//        assignedJobs = new AssignedJob.fromJson(json.decode(response.body));
//
//        // print('length : ${assignedJobsList.length}');
//      } else {
//        print("failed ${statusCode}");
//        throw("Network connection failed with code :${statusCode} "); // error thrown
//      }
//
//      return assignedJobs;
//    } catch (e) {
//      print(e);
//      throw("Network connection failed ${e}"); // error thrown
//    }
//
//  }


//  static Future<List<LeadCapture>> searchLead(String customerName,String customerNumber,String customerNIC,String targetDate)  async  {
//    print('search Lead lead called.');
//    final storage = new FlutterSecureStorage();
//    String valuejson = await storage.read(
//        key: "TEMP_TOKEN");
//    print("Value temptoken: ${json.decode(valuejson).toString()}");
//
//    LeadCapture leadcaptureDTO = new LeadCapture();
//    leadcaptureDTO.customerName = customerName;
//    leadcaptureDTO.contactNumber = customerNumber;
//    leadcaptureDTO.customerNIC = customerNIC;
//
//    TokenDTO tokenDTO = new TokenDTO();
//    tokenDTO.token = valuejson;
//
//    const url = '${MyGlobals.hostURL}/leadcapture/search';
//
//    // AwaValue :it the http get response, then decode the json-formatted responce.
//    Response response = await http.post(url,
//      headers: {"Content-Type": "application/json"},
//      body: json.encode(tokenDTO.toJson()),
//    );
//
//    int statusCode = response.statusCode;
//    List<LeadCapture> leadsList = null;
//
//    if (statusCode == 200) {
//      print("success");
//      MyLeadsDTO leadsDTO = new MyLeadsDTO.fromJson(json.decode(response.body));
//      leadsList = leadsDTO.leads;
//      print('length : ${leadsList.length}');
//    } else {
//      print("failed ${statusCode}");
//      throw("Network connection failed with code :${statusCode} "); // error thrown
//    }
//
//    return leadsList;
//  }

//  static Future<bool> updateLead(LeadCapture leadCapture)  async  {
//
//    final storage = new FlutterSecureStorage();
//    String valuejson = await storage.read(
//        key: "TEMP_TOKEN");
//    print("Value temptoken: ${json.decode(valuejson).toString()}");
//    leadCapture.token = json.decode(valuejson).toString();
//
//    const url = '${MyGlobals.hostURL}/leadcapture';
//
//    // AwaValue :it the http get response, then decode the json-formatted responce.
//    Response response = await http.put(url,
//        headers: {"Content-Type": "application/json"}, body: json.encode(leadCapture.toJson()));
//
//    int statusCode = response.statusCode;
//
//    if (statusCode == 200) {
//      print("success");
//      return true;
//    } else {
//      print("failed ${statusCode}");
//      return false;
//    }
//
//
//  }

//  static Future<bool> saveLead(LeadCapture leadCapture)  async  {
//    print('save lead called.');
//    final storage = new FlutterSecureStorage();
//    String valuejson = await storage.read(
//        key: "TEMP_TOKEN");
//    print("Value temptoken: ${json.decode(valuejson).toString()}");
//    leadCapture.token = json.decode(valuejson).toString();
//
////    TokenDTO tokenDTO = new TokenDTO();
////    tokenDTO.token = valuejson;
//
//    const url = '${MyGlobals.hostURL}/leadcapture';
//
//
//
//    // AwaValue :it the http get response, then decode the json-formatted responce.
//    Response response = await http.post(url,
//        headers: {"Content-Type": "application/json"}, body: json.encode(leadCapture.toJson()));
//
//    int statusCode = response.statusCode;
//
//    if (statusCode == 200) {
//      print("success");
//      return true;
//    } else {
//      print("failed ${statusCode}");
//      return false;
//    }
//
//
//    //print('leadvature data on receive  ${leadcaptureDTO.toString()}');
//    //return leadcaptureDTO;
//  }

//    futureResponse.then((response) {
//      if (response.statusCode == 200) {
//        // If the call to the server was successful, parse the JSON.
//        leadcaptureDTO = LeadcaptureDTO.fromJson(json.decode(response.body));
//        return  leadcaptureDTO;
//      } else {
//        print("fetchLead ${ response.statusCode }");
//        // If that call was not successful, throw an error.re;
//        return null;
//      }
//    }).catchError((onError){
//      print("Error Called -  ${onError.toString()}");
//
//      return null;
//
//    });





}
