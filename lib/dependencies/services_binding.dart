import 'package:get/get.dart';

import '../view_models/services_viewmodel.dart';

class ServicesBinding extends Bindings{
  void dependencies(){
    Get.put(ServicesViewModel());
  }
}