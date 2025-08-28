import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_registeration/dependencies/image_uploading_binding.dart';
import 'package:service_registeration/dependencies/services_binding.dart';
import 'package:service_registeration/views/my_services.dart';
import 'package:service_registeration/views/registration_data/availability_view.dart';
import 'package:service_registeration/views/registration_data/detail_form_view.dart';
import 'package:service_registeration/views/registration_data/upload_images_view.dart';

import 'dependencies/availability_binding.dart';
import 'dependencies/service_detail_bindings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: "/services",
          page: () => MyServices(),
          binding: ServicesBinding(),
        ),
        GetPage(
          name: "/create_services",
          page: () => CreateService(),
          binding: ServicesDetailBinding(),
        ),
        GetPage(
          name: "/upload_image",
          page: () => ImageUploadingView(),
          binding: ImageUploadingBinding(),
        ),
        GetPage(
          name: "/availability",
          page: () => AvailabiltyView(),
          binding: AvailabilityBinding(),
        )
      ],
      initialRoute: "/create_services",
    );
  }
}
