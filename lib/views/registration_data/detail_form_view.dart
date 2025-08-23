import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:service_registeration/components/map_view.dart';
import '../../components/button_component.dart';
import '../../components/textfield_component.dart';
import '../../view_models/detail_form_viewmodel.dart';

class CreateService extends GetView<ServiceDetailViewModel> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  ButtonThemes buttonsTheme = ButtonThemes();
  TextFieldComponent textFieldComponent = TextFieldComponent();
  List<String> services = ["Electrician","Plumber","Carpenter"];
  List<String> experianceLevels = ["Biggner","Intermediate","Expert"];
  MapView mapView = MapView();


  CreateService({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Scaffold(
      appBar: !controller.showMap.value?AppBar(
        title: Text(
          "Create Service",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
        ),
        backgroundColor: Color.fromRGBO(250, 250, 250, 1.0),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_new_sharp, size: 22),
        ),
      ):AppBar( title: Column(
        spacing: 16,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 55,
            children:[
              IconButton(
                onPressed: () {
                  controller.showMap.value = false;
                },
                icon: Icon(Icons.arrow_back_ios_new_sharp,color:Colors.white, size: 22),
              ),
              Text(
              "Create Service",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900,color: Colors.white),
            ),
           ],
          ),
          textFieldComponent.textFieldSearchComponent("Search Location", locationController,controller)
        ],
      ),
        centerTitle: true,
        toolbarHeight: 140,
        backgroundColor: Color.fromRGBO(40, 168, 11, 1.0),
      ),
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
                      textFieldComponent.textFieldGeneralComponent(
                          "Enter Name",
                          nameController,
                              (){}

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
                          controller.getCurrentPosition().then((_){
                          if(controller.currentLocation.value != null){
                            controller.showMap.value = true;
                          }
                            else{
                                 print("Problem in fetching current location");
                            }
                          });},
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
                    top: MediaQuery.of(context).size.height * 0.77,
                    left: 10,
                    right: 10,
                    child: buttonsTheme.buttonThemeComponent(
                        "Next Step",
                            (){
                          controller.uploadData( nameController.text,
                            priceController.text,
                            controller.addressController.text,
                            detailController.text,);
                          nameController.clear();
                          priceController.clear();
                          controller.addressController.clear();
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
        )
      :mapView.flutterMapView(controller.currentLocation.value??LatLng(0.0, 0.0),(){
        controller.showMap.value=false;
      },controller,controller.addressData)));
  }
}
