import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_registeration/components/title_chip_component.dart';
import 'package:service_registeration/view_models/services_viewmodel.dart';

class MyServices extends GetView<ServicesViewModel> {
  final TitleChipComponent titleChipComponent = TitleChipComponent();
   MyServices({super.key});

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
                titleChipComponent.appChipComponent("Published", 1,controller,isClicked: controller.checkDataofChip("Published")),
                titleChipComponent.appChipComponent("Unpublished", 0,controller,isClicked: controller.checkDataofChip("Unpublished")),
                titleChipComponent.appChipComponent("Draft", 1,controller,isClicked: controller.checkDataofChip("Draft")),
              ],
            )
          ],
        );}),
      ),
    );
  }

}

