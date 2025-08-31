import 'package:get/get.dart';
import 'package:service_registeration/http_clients/user_info_client.dart';

import '../http_clients/image_uploading_client.dart';
import '../view_models/availability_viewmodel.dart';
import '../view_models/image_uploading_viewmodel.dart';
import '../view_models/services_viewmodel.dart';

class AvailabilityBinding extends Bindings{
  void dependencies(){
    Get.put(UserInfoClient());
    Get.put(AvailabilityViewModel());
  }
}