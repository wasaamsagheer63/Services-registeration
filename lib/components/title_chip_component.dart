import 'package:flutter/material.dart';
import 'package:service_registeration/view_models/detail_form_viewmodel.dart';

import '../view_models/services_viewmodel.dart';

class TitleChipComponent{
  Widget appChipComponent(String name, int count,ServicesViewModel controller,{bool isClicked = false}){
    return SizedBox(
      height:33,
      child: InkWell(
        onTap: (){
          controller.enterDataOfChip(name.toLowerCase());
          controller.getData();
        },
        child: Chip(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            backgroundColor :isClicked ?Color.fromRGBO(
              32,
              170,
              6,
              1.0,
            ):Color.fromRGBO(
              211,
              213,
              210,
              0.2,
            ),
            label: Row(
              spacing: 6,
              children: [
                Text(name,style: TextStyle(color:isClicked ? Colors.white: Colors.black,fontSize: 11.5),),

                CircleAvatar(
                  radius: 8,
                  child: Text(count.toString(),style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold),),
                )
              ],
            )),
      ),
    );
  }
}