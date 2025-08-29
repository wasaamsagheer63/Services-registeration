import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:service_registeration/components/appbar_components.dart';
import 'package:service_registeration/components/map_view.dart';
import '../../components/button_component.dart';
import '../../components/textfield_component.dart';
import '../../view_models/detail_form_viewmodel.dart';

class CreateService extends GetView<ServiceDetailViewModel> {
  TextEditingController priceController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  ButtonThemes buttonsTheme = ButtonThemes();
  TextFieldComponent textFieldComponent = TextFieldComponent();
  List<String> services = ["Electrician","Plumber","Carpenter"];
  List<String> experianceLevels = ["Beginner","Intermediate","Expert"];
  MapView mapView = MapView();
  AppBarComponent appBarComponent = AppBarComponent();


  CreateService({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Scaffold(
      appBar: !controller.showMap.value
          ?appBarComponent.normalAppBar("Create Service",back: true)
          :AppBarComponent.mapAppBar(
          controller,
          locationController,
          textFieldComponent),

      body:!controller.showMap.value ? Container(
          color: Color.fromRGBO(250, 250, 250, 1.0),
          child:SingleChildScrollView(
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
                      buttonsTheme.dropDownComponent(services,"Select Service",controller.service,(value){
                        controller.service.value = value.toString() ?? "";

                      },service: true),
                      buttonsTheme.dropDownComponent(experianceLevels,"Select Experiance",controller.experianceLevel,(value){
                        controller.experianceLevel.value = value.toString() ?? "";
                      }),
                      textFieldComponent.textFieldGeneralComponent(
                          "Price per hour",
                          priceController,
                              (){},
                          price: true
                      ),
                      textFieldComponent.textFieldGeneralComponent(
                        "Address",
                        controller.addressController,
                            (){
                          // controller.getCurrentPosition().then((_){
                          // if(controller.currentLocation.value != null){
                            controller.showMap.value = true;
                          // }
                          //   else{
                          //        print("Problem in fetching current location");
                          //   }
                          },
                        address: true,
                        isLoading: controller.isMapLoading.value

                      ),
                      textFieldComponent.textFieldforDetailComponent(
                        "Service Details",
                        detailController,
                      ),
                      SizedBox(height: 60),
                    ],
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.68,
                    bottom: 2,
                    left: 10,
                    right: 10,
                    child: buttonsTheme.buttonThemeComponent(
                        "Next Step",
                            ()async{
                          if(await controller.uploadData(
                            priceController.text,
                            controller.addressController.text,detailController.text)){
                            clearControllers();
                          }
                        }
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      :mapView.flutterMapView(controller.currentLocation.value??LatLng(0.0, 0.0),(){
        controller.showMap.value=false;
      },controller,controller.addressData)));
  }
  void clearControllers(){
    priceController.clear();
    controller.addressController.clear();
    detailController.clear();
    controller.service.value="";
    controller.experianceLevel.value="";
  }
}
