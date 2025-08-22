import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:service_registeration/theme/button_component.dart';
import 'package:service_registeration/theme/map_view.dart';
import 'package:service_registeration/theme/textfield_component.dart';

import '../../view_models/service_detail_filing_form_viewmodel.dart';

class CreateService extends GetView<ServiceDetailViewModel> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  ButtonThemes buttonsTheme = ButtonThemes();
  TextFieldComponent textFieldComponent = TextFieldComponent();
  List<String> services = ["Electrician","Plumber","Carpenter"];
  List<String> experianceLevels = ["Biggner","Intermediate","Expert"];
  MapView mapView = MapView();

  CreateService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Service",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(236, 237, 236, 0.5),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_new_sharp, size: 22),
        ),
      ),
      body:!controller.showMap.value ? Container(
        color: Color.fromRGBO(236, 237, 236, 0.5),
        child: Obx(()=>SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Stack(
              children: [
                Column(
                  spacing: 19,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Service Details",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    textFieldComponent.textFieldGeneralComponent(
                      "Enter Name",
                      nameController,
                    ),
                    buttonsTheme.dropDownComponent(services,"Select Service",controller.service,(value){
                      controller.service.value = value.toString() ?? "";

                    },service: true),
                    buttonsTheme.dropDownComponent(experianceLevels,"Select Experiance",controller.experianceLevel,(value){
                      controller.experianceLevel.value = value.toString() ?? "";
                    }),
                    textFieldComponent.textFieldGeneralComponent(
                      "Price per hour",
                      priceController,
                      price: true
                    ),
                    InkWell(
                      onLongPress: (){
                        controller.showMap.value = true;
                      },
                      child: textFieldComponent.textFieldGeneralComponent(
                        "Address",
                        addressController,
                        address: true
                      ),
                    ),
                    textFieldComponent.textFieldforDetailComponent(
                      "Service Details",
                      detailController,
                    ),
                    SizedBox(height: 60),
                  ],
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.77,
                  left: 10,
                  right: 10,
                  child: buttonsTheme.buttonThemeComponent(
                    "Next Step",
                          (){
                      controller.uploadData( nameController.text,
                            priceController.text,
                            addressController.text,
                            detailController.text,);
                      nameController.clear();
                      priceController.clear();
                      addressController.clear();
                      detailController.clear();
                      controller.service.value="";
                      controller.experianceLevel.value="";
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      ):mapView.flutterMapView(controller.currentLocation??LatLng(0.0, 0.0)));
  }
}
