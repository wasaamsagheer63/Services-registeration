import 'package:get/get.dart';
import '../http_clients/user_info_client.dart';
import '../view_models/detail_form_viewmodel.dart';

class ServicesDetailBinding extends Bindings{
  void dependencies(){
    Get.put(UserInfoClient());
    Get.put(ServiceDetailViewModel());
  }
}
