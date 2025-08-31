import 'package:get/get.dart';
import 'package:service_registeration/http_clients/user_info_client.dart';
import 'package:service_registeration/models/user_info.dart';

class ServicesViewModel extends GetxController{
final UserInfoClient userInfoClient = Get.find();
RxList<UserInfo> serviceData = RxList<UserInfo>();
RxList<UserInfo> publishedData = RxList<UserInfo>();
RxList<UserInfo> unpublishedData = RxList<UserInfo>();
RxList<UserInfo> draftData = RxList<UserInfo>();
RxBool isLoading = false.obs;
String category = "published";
RxString chipData = "published".obs;
@override
void onInit(){
  super.onInit();
  category = Get.arguments ?? "published";
  chipData.value = category;
  getData();
}



  void enterDataOfChip(String data){
      chipData.value=data;
  }
  bool checkDataOfChip(String data){
    if(chipData.value == data){
      return true;
    }
    else{
      return false;
    }
  }
  Future<void> getData()async{
    try {
      serviceData.clear();
      publishedData.clear();
      unpublishedData.clear();
      draftData.clear();
      isLoading.value = true;
      serviceData.assignAll(await userInfoClient.getData());
      serviceData.map((map){

        if(map.category == "published"){
          publishedData.add(map);
        }
         if(map.category == "unpublished"){
          unpublishedData.add(map);
        }if(map.category == "draft"){
          draftData.add(map);
        }
      }).toList();
    }
    catch(e){
      throw Exception("Error in getting Data${e.toString()}");
    }
    finally{
      isLoading.value = false;
    }
  }
}