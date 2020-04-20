

import 'package:goviwiruvo_app/dto/vegetableload.dart';
import 'package:goviwiruvo_app/dto/vegetablerequestdto.dart';

class VegetableService{


  static final List<VegetableLoad> vegloadedList =  [];
  static final List<Vegset> vegitablesToBeSaved=  [];

  void addVegSet(Vegset vegset){


    print('tem add 1 ${vegset.vegetableDescription}');
     vegitablesToBeSaved.add(vegset);

    print('tem size ${vegitablesToBeSaved.length}');
  }

  List<Vegset> getVegstobeSaved(){
    print('tem return size ${vegitablesToBeSaved.length}');
    print('tem return 1 ${vegitablesToBeSaved[0].vegetableDescription}');
    return vegitablesToBeSaved;
  }




}