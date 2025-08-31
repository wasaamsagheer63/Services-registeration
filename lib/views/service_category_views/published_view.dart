import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_registeration/components/service_card.dart';
import 'package:service_registeration/view_models/services_viewmodel.dart';

class CategoryView{
  ServiceCard serviceCard = ServiceCard();
  Widget publishedViewList(ServicesViewModel controller,BuildContext context){
    return controller.publishedData.isEmpty?
    Center(
      child: SizedBox(
        height: 500,
        child: Column(
          spacing: 5,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icons/service-person.PNG",width: 50,),
            Text("You don't have any published Service",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
            Text("Your published services will appear here",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.grey))
          ],
        ),
      ),
    )
        :SingleChildScrollView(
      child:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          spacing: 5,
          children:controller.publishedData.map((service){
            return serviceCard.serviceCardView(service,controller,context,"Unpublish",()async{
              service.category="unpublished";
              print(controller.publishedData.length);
              if(await controller.userInfoClient.updateData(service)){
                Get.back();
                controller.getData();
                print(controller.publishedData.length);
              }
              controller.update();
            },"",(){});
          }).toList(),
        ),
      ),
    );
  }

  Widget unpublishedViewList(ServicesViewModel controller,BuildContext context){
    return controller.unpublishedData.isEmpty?
    Center(
      child: SizedBox(
        child: Column(
          spacing: 5,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icons/service-person.PNG",width: 50,),
            Text("You don't have any Unpublished Service",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
            Text("Your Unpublished services will appear here",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.grey))
          ],
        ),
      ),
    )
        :SingleChildScrollView(
      child:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children:controller.unpublishedData.map((service){
            return serviceCard.serviceCardView(service,controller,context,"Publish",()async{
              service.category="published";
              print(controller.publishedData.length);
              if(await controller.userInfoClient.updateData(service)){
                Get.back();

                controller.getData();
                print(controller.publishedData.length);
              }
              controller.update();
            },"Delete",()async{
              if(await controller.userInfoClient.deleteData(service)){
                Get.back();

                controller.getData();
                controller.update();
                print(controller.unpublishedData.length);
              }},unpublish: true);
          }).toList(),
        ),
      ),
    );
  }

  Widget draftViewList(ServicesViewModel controller,BuildContext context){
    return controller.draftData.isEmpty?
        Center(
          child: SizedBox(
            child: Column(
              spacing: 5,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/icons/service-person.PNG",width: 50,),
                Text("You don't have any Draft Service",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                Text("Your Draft services will appear here",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.grey))
              ],
            ),
          ),
        )
        :SingleChildScrollView(
      child:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          spacing: 5,
          children:controller.draftData.map((service){
            return serviceCard.serviceCardView(service,controller,context,"Update",()async{
              Get.offAllNamed("/upload_image",arguments: service);
            },"",(){});
          }).toList(),
        ),
      ),
    );
  }
}