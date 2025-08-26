import 'package:get/get.dart';

import '../http_clients/image_uploading_client.dart';
import '../view_models/image_uploading_viewmodel.dart';
import '../view_models/services_viewmodel.dart';

class ImageUploadingBinding extends Bindings{
  void dependencies(){
    Get.put(ImageUploadingClient());
    Get.put(ImageUploadingViewModel());
  }
}