

import 'package:goviwiruvo_app/dto/vegetableload.dart';
import 'package:goviwiruvo_app/dto/vegetablerequestdto.dart';

class VegetableService{


  static final List<VegetableLoad> vegloadedList =  [];
  static final List<Vegset> vegitablesToBeSaved=  [];

  void addVegSet(Vegset vegset){



     vegitablesToBeSaved.add(vegset);

    print('tem size ${vegitablesToBeSaved.length}');
  }

  List<Vegset> getVegstobeSaved(){

    return vegitablesToBeSaved;
  }




}