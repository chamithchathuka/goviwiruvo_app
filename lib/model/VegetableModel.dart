import 'package:flutter/cupertino.dart';
import 'package:goviwiruvo_app/dto/vegetableload.dart';
import 'package:goviwiruvo_app/dto/vegetablerequestdto.dart';

class VegetableModel extends ChangeNotifier{

  List<VegetableLoad> vegList = [];//


//  Map vegMap = Map<int, Vegset>();

//  getList(){
//    List<Vegset> vegList  =   vegMap.entries.map
//      ( (entry) => Vegset(entry.key, entry.value)).toList();
//
//
//  }



   addVegToList(VegetableLoad vegset){

    vegList.add(vegset);

//    vegMap[vegset.vegetableId]=vegset;

    print('add called ${vegList.length}');

    notifyListeners();
  }

  removeVegToList(VegetableLoad vegset){

     vegList.remove(vegset);

    print('remove ${vegset.id} called ${vegList.length}');

    notifyListeners();
  }

}