import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_registeration/components/appbar_components.dart';
import 'package:service_registeration/components/availability_chip_component.dart';
import 'package:service_registeration/components/button_component.dart';
import 'package:service_registeration/view_models/availability_viewmodel.dart';

class Availabilty extends GetView<AvailabilityViewModel> {
  AppBarComponent appBarComponent = AppBarComponent();
  ButtonThemes buttonThemes = ButtonThemes();
  AvailabilityChipComponent availabilityChipComponent = AvailabilityChipComponent();


  Availabilty({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBarComponent.normalAppBar("Service Availability",back: true),
    body: Stack(
       children: [SingleChildScrollView(

         child: Padding(
           padding: EdgeInsets.all(16),
           child: Column(
             spacing: 7,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
           Text("Availability",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900),),
               Text("Set your working hours for your service.",
                 style: TextStyle(
                     fontSize: 16,fontWeight: FontWeight.bold,
                     color: Colors.grey),),
               SizedBox(height: 3,),
               availabilityChipComponent.availabilityChipComponent("Monday"),
               availabilityChipComponent.availabilityChipComponent("Tuesday"),
               availabilityChipComponent.availabilityChipComponent("Wednesday"),
               availabilityChipComponent.availabilityChipComponent("Thursday"),
               availabilityChipComponent.availabilityChipComponent("Friday"),
               availabilityChipComponent.availabilityChipComponent("Saturday"),
               availabilityChipComponent.availabilityChipComponent("Sunday"),
               SizedBox(height: 180,)

             ],

           ),
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
