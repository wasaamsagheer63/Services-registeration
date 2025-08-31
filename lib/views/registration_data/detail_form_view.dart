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


  final ButtonThemes buttonsTheme = ButtonThemes();
  final TextFieldComponent textFieldComponent = TextFieldComponent();
 final  List<String> services = ["Electrician","Plumber","Carpenter","Painter","House Cleaning","Pest Control","Appliance Repair","Baby Sitter","Tutor"];
  final List<String> experienceLevels = ["Beginner","Intermediate","Expert"];
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
          controller.locationController,
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
                      buttonsTheme.dropDownComponent(experienceLevels,"Select Experience",controller.experianceLevel,(value){
                        controller.experianceLevel.value = value.toString() ?? "";
                      }),
                      textFieldComponent.textFieldGeneralComponent(
                          "Price per hour",
                          controller.priceController,
                              (){},
                          price: true
                      ),
                      InkWell(
                        onTap: (){
                          controller.showMap.value = true;
                          },
                        child: textFieldComponent.textFieldGeneralComponent(
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
                      ),
                      textFieldComponent.textFieldforDetailComponent(
                        "Service Details",
                        controller.detailController,
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
                        controller.forUpdate.value != null?"Update Service":"Next Step",
                            ()async{
                          if(await controller.uploadData(
                            controller.priceController.text,
                            controller.addressController.text,controller.detailController.text)){
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
    controller.priceController.clear();
    controller.addressController.clear();
    controller.detailController.clear();
    controller.service.value="";
    controller.experianceLevel.value="";
  }
}
