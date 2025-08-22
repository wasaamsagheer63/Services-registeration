import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:service_registeration/models/user_info.dart';
import 'package:service_registeration/repositories/user_info_repo.dart';

class ServiceDetailViewModel extends GetxController {
  final UserInfoRepo userInfoRepo = Get.find();
  RxString service = "".obs;
  RxBool showMap = false.obs;
  RxString experianceLevel = "".obs;
  bool emptyData = false;
  bool correctPrice = true;
  LatLng? currentLocation ;
  late Position position;


  void onInit(){
    super.onInit();
    getCurrentPosition();
    currentLocation = LatLng(position.latitude, position.longitude);
  }
  Future<void> getCurrentPosition()async{
    Position position = await Geolocator.getCurrentPosition();
  }

void dispose(){
  super.dispose();

}
  Future<void> uploadData(
    String name,
    String price,
    String address,
    String detail,
  ) async {
emptyData = false;
correctPrice = true;
    try{
if(name.isEmpty || price.toString().isEmpty || address.isEmpty || detail.isEmpty || service.value.isEmpty || experianceLevel.value.isEmpty){
  emptyData = true;
}
if(num.tryParse(price) == null){
  correctPrice = false;
  Get.snackbar("Error", "",messageText: Text(
    "Your price per hour data is not correct",
    style: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color:Color.fromARGB(
          200, 255, 253, 253),
    ),
  ));
}
      UserInfo userInfo = UserInfo(name, service.value, experianceLevel.value, num.tryParse(price)??0.0, address, detail);
     if(!emptyData && !correctPrice){
      userInfoRepo.uploadData(userInfo);
     }
     else{
       Get.snackbar("Error", "",messageText: Text(
         "Fill all the fields with correct data",
         style: TextStyle(
           fontWeight: FontWeight.w600,
           fontSize: 16,
           color:Color.fromARGB(
               200, 255, 253, 253),
         ),
       ),colorText:Color.fromARGB(
           200, 255, 253, 253),backgroundColor:Color.fromARGB(
           200, 243, 12, 12));
     }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }
}
