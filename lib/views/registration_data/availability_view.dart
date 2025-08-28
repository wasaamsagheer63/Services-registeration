import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_registeration/components/appbar_components.dart';
import 'package:service_registeration/components/button_component.dart';
import 'package:service_registeration/view_models/availability_viewmodel.dart';

import '../../components/availability_components/availability_chip_component.dart';
import '../../models/user_info.dart';

class AvailabiltyView extends GetView<AvailabilityViewModel> {
  AppBarComponent appBarComponent = AppBarComponent();
  ButtonThemes buttonThemes = ButtonThemes();
  AvailabilityChipComponent availabilityChipComponent = AvailabilityChipComponent();
  UserInfo userInfo = Get.arguments;


  AvailabiltyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBarComponent.normalAppBar("Service Availability",back: true),
    body: Stack(
       children: [
         SingleChildScrollView(
           child: Padding(
           padding: EdgeInsets.all(16),
           child: Obx(() => Column(
             spacing: 10,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
           Text("Availability",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900),),
               Text("Set your working hours for your service.",
                 style: TextStyle(
                     fontSize: 16,fontWeight: FontWeight.bold,
                     color: Colors.grey),),
               SizedBox(height: 2,),
              availabilityChipComponent.availabilityChip("Monday",0,userInfo ,controller),
              availabilityChipComponent.availabilityChip("Tuesday",1,userInfo ,controller),
              availabilityChipComponent.availabilityChip("Wednesday",2,userInfo ,controller),
              availabilityChipComponent.availabilityChip("Thursday",3,userInfo ,controller),
              availabilityChipComponent.availabilityChip("Friday",4,userInfo ,controller),
              availabilityChipComponent.availabilityChip("Saturday",5,userInfo ,controller),
              availabilityChipComponent.availabilityChip("Sunday",6,userInfo ,controller),

               SizedBox(height: 180,),

             ],

           )),
         ),
       ),
      Positioned(
          bottom:0,
          left:0,
          right:0,
          top:485,
          child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: BoxBorder.fromLTRB(top: BorderSide(width:0.2,color: Colors.grey))
        ),
      )),
        Positioned(
            bottom: 110,
            left: 10,
            right: 10,
            top: 500,
            child:buttonThemes.simpleButtonThemeComponent("Save darft",(){}) ),
        Positioned(
            bottom: 35,
            left: 10,
            right: 10,
            top: 570,
            child:buttonThemes.buttonThemeComponent("Next Step",(){}) )
      ],
    ),
    );
  }

}
