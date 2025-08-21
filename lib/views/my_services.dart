import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_registeration/view_models/services_viewmodel.dart';

class MyServices extends GetView<ServicesViewModel> {
  const MyServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leadingWidth: MediaQuery.of(context).size.width,
        toolbarHeight: 90,
        leading: Obx((){
          return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("My Services",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                appChipComponent("Published", 1,isClicked: controller.checkDataofChip("Published")),
                appChipComponent("Unpublished", 0,isClicked: controller.checkDataofChip("Unpublished")),
                appChipComponent("Draft", 1,isClicked: controller.checkDataofChip("Draft")),
              ],
            )
          ],
        );}),
      ),
    );
  }
  Widget appChipComponent(String name, int count,{bool isClicked = false}){
    return SizedBox(
      height:33,
      child: InkWell(
        onTap: (){
          controller.enterDataofChip(name);
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

