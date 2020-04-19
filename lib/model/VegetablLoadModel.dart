import 'package:flutter/cupertino.dart';
import 'package:goviwiruvo_app/dto/vegetableload.dart';
import 'package:goviwiruvo_app/external/webservices.dart';

class VegetableLoadModel extends ChangeNotifier{
//
//  List<VegetableLoad> vegetableLoadedList = [];
//
//  loadVeggies() async {
//
//    List<VegetableLoad> veggies = await WebServiceCall.getVegetables();
//
//    vegetableLoadedList = veggies;
//
//    notifyListeners();
//  }

    String selectedVegetable = '';


    setSelectedVegetable(String selected){

      selectedVegetable = selected;

      notifyListeners();
    }

}