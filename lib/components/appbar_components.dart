
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_registeration/components/textfield_component.dart';

import '../view_models/detail_form_viewmodel.dart';

class AppBarComponent{
   PreferredSizeWidget normalAppBar(String text,{bool back = false}){
    return AppBar(
      title: Text(
        text,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
      ),
      centerTitle: true,
      backgroundColor: Color.fromRGBO(250, 250, 250, 1.0),
      leading: back?IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.arrow_back_ios_new_sharp, size: 22),
      ):Icon(Icons.add,color:Colors.transparent),
    );
  }

  static PreferredSizeWidget mapAppBar(ServiceDetailViewModel controller,TextEditingController locationController,TextFieldComponent textFieldComponent){
    return AppBar( title: Column(
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
    );
  }
}