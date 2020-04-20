import 'package:goviwiruvo_app/dto/vegetableload.dart';
import 'package:goviwiruvo_app/dto/vegetablerequestdto.dart';
import 'package:goviwiruvo_app/external/webservices.dart';
import 'package:http/http.dart' as http;

class VegetableService {
  static VegetableRequest vegetableRequest = VegetableRequest();

  //WebServiceCall webServiceCall = WebServiceCall();

  static final List<VegetableLoad> vegloadedList = [];
  static final List<Vegset> vegitablesToBeSaved = [];

  void addVegSet(Vegset vegset) {
    print('tem add 1 ${vegset.vegetableDescription}');
    vegitablesToBeSaved.add(vegset);
    print('tem size ${vegitablesToBeSaved.length}');
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
  }

  saveRequestInfo(String name, String address, String contactNo,
      String whatsappContact, String coodinationContact) {
    vegetableRequest.name = name;
    vegetableRequest.address = address;
    vegetableRequest.phone = contactNo;
    vegetableRequest.whatsapp = whatsappContact;

    Connector connector = new Connector();
    connector.phone = coodinationContact;
    vegetableRequest.connector = connector;
    print('name in service - ${vegetableRequest.name}');


  }

  Future<bool> callWebServicePostRequest() async {
    vegetableRequest.vegset = vegitablesToBeSaved;
    http.Response response =
        await WebServiceCall.createVegRequestPOST(vegetableRequest);

    if (response.statusCode == 200) {
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
}
