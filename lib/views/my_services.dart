import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_registeration/components/button_component.dart';
import 'package:service_registeration/components/title_chip_component.dart';
import 'package:service_registeration/models/user_info.dart';
import 'package:service_registeration/view_models/services_viewmodel.dart';
import 'package:service_registeration/views/service_category_views/published_view.dart';

class MyServices extends GetView<ServicesViewModel> {
  final TitleChipComponent titleChipComponent = TitleChipComponent();
  final ButtonThemes buttonThemes = ButtonThemes();
  final CategoryView categoryView = CategoryView();
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
                titleChipComponent.appChipComponent("Published", controller.publishedData.length,controller,isClicked: controller.checkDataOfChip("published")),
                titleChipComponent.appChipComponent("Unpublished", controller.unpublishedData.length,controller,isClicked: controller.checkDataOfChip("unpublished")),
                titleChipComponent.appChipComponent("Draft", controller.draftData.length,controller,isClicked: controller.checkDataOfChip("draft")),
              ],
            )
          ],
        );}),
      ),
      body:SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Obx(() =>Stack(
          children: [
            controller.isLoading.value?Center(
              child: CircularProgressIndicator(strokeWidth: 3,color: Colors.green,),
            ):controller.chipData.value =="published"?
            categoryView.publishedViewList(controller,context)
                :controller.chipData.value =="unpublished"
                ?categoryView.unpublishedViewList(controller, context):
            categoryView.draftViewList(controller, context),
           controller.serviceData.length < 3? Positioned(
              bottom: 50,
              left: 90,
              right: 90,
              child: buttonThemes.buttonThemeComponent(
                  "+ Create",
                      (){
                    Get.offAllNamed("/create_services");
                      }
              ),
            ):SizedBox.shrink(),
          ],
        ),
      )
    ));
  }

}

