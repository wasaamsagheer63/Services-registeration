import 'package:get/get.dart';

import '../repositories/user_info_repo.dart';
import '../view_models/detail_form_viewmodel.dart';
import '../view_models/services_viewmodel.dart';

class ServicesDetailBinding extends Bindings{
  void dependencies(){
    Get.put(UserInfoRepo());
    Get.put(ServiceDetailViewModel());
  }
}