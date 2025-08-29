import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:service_registeration/models/user_info.dart';

import '../http_clients/user_info_client.dart';

class ServiceDetailViewModel extends GetxController {
  final UserInfoClient userInfoClient = Get.find();
  late TextEditingController addressController ;

  RxString service = "".obs;
  RxBool showMap = false.obs;
  RxString experianceLevel = "".obs;
  bool emptyData = false;
  bool correctPrice = true;
  Rx<LatLng?> currentLocation = Rx<LatLng?>(null);
  RxBool isMapLoading = false.obs;

  MapController mapController = MapController();
  RxString addressData ="".obs;
  late Position position;

@override
  void onInit(){
    super.onInit();
    addressController =TextEditingController();
    getCurrentPosition();

}
  Future<void> getCurrentPosition()async{
  try {
    isMapLoading.value = true;

    LocationPermission permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.denied) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      currentLocation.value = LatLng(position.latitude, position.longitude);
    getAddress(currentLocation.value!);

    }
  }
  catch (e){
    print("Error in current position getting ${e.toString()}");
  }
  finally{
    isMapLoading.value = false;
  }

  }
  Future<void> getAddress(LatLng centerPoint)async{
List<Placemark> placemark = await placemarkFromCoordinates(
    centerPoint.latitude,
    centerPoint.longitude);
if(placemark.isNotEmpty){
  Placemark place = placemark[0];
  addressData.value = "${place.street}, ${place.locality},${place.country}";
  addressController.text= addressData.value;

}
else{
  addressData.value ="Location is not selected";
  addressController.text ="";

}
  }

  Future<void> findLocation(String query)async{
  if(query.isEmpty){
    return;
  }
List<Location> location = await locationFromAddress(query);
  if(location.isNotEmpty){
      currentLocation.value = LatLng(location[0].latitude, location[0].longitude);
      mapController.move(currentLocation.value!, 15);
      getAddress(currentLocation.value!);
    }
  }




  Future<bool> uploadData(
    String price,
    String address,
    String detail,
  ) async {
emptyData = false;
correctPrice = true;
    try{
if(price.toString().isEmpty || address.isEmpty || detail.isEmpty || service.value.isEmpty || experianceLevel.value.isEmpty){
  emptyData = true;
}
if(num.tryParse(price) == null && price.length != 0){
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
      UserInfo userInfo = UserInfo("", service.value, experianceLevel.value, num.tryParse(price)??0.0, address, detail);
     if(!emptyData && correctPrice){
      userInfoClient.uploadData(userInfo);
      Get.toNamed("/upload_image",arguments: userInfo);
      return true;
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
       return false;
     }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }
}
