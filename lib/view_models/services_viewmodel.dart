import 'package:get/get.dart';

class ServicesViewModel extends GetxController{


  RxList chipData = ["Published"].obs;
  void enterDataofChip(String data){
    chipData.clear();
      chipData.add(data);
  }
  bool checkDataofChip(String data){
    if(chipData.contains(data)){
      return true;
    }
    else{
      return false;
    }
  }
}