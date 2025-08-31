import 'package:get/get.dart';
import 'package:service_registeration/http_clients/user_info_client.dart';

import '../view_models/services_viewmodel.dart';

class ServicesBinding extends Bindings{
  @override
  void dependencies(){
    Get.put(UserInfoClient());
    Get.put(ServicesViewModel());
  }
}