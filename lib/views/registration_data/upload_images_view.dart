import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_registeration/components/appbar_components.dart';
import 'package:service_registeration/components/button_component.dart';
import 'package:service_registeration/components/images_icons_component.dart';
import 'package:service_registeration/components/uploading_card.dart';
import 'package:service_registeration/models/user_info.dart';
import 'package:service_registeration/view_models/image_uploading_viewmodel.dart';

class ImageUploadingView extends GetView<ImageUploadingViewModel> {
  ImageUploadingView({super.key});
 final  AppBarComponent appBarComponent =AppBarComponent();
ButtonThemes buttonThemes = ButtonThemes();
UploadingCard uploadingCard = UploadingCard();
UserInfo userInfo = Get.arguments;
ImageIconComponet imageIconComponet = ImageIconComponet();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarComponent.normalAppBar("Create Service"),
      body: Stack(
         children: [Container(
           decoration: BoxDecoration(
             color:Color.fromRGBO(250, 250, 250, 1.0)
           ),
           child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Work Gallery",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w900),),
                  SizedBox(height: 8,),
                  Text("Add images to highlight your work",
                    style: TextStyle(
                        fontSize: 16,fontWeight: FontWeight.w700,
                        color: Colors.grey),),
                  SizedBox(height:35),
                  Text("Upload cover image",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900,color:Color.fromRGBO(
                      12, 12, 12, 0.6) ),),
                  SizedBox(height: 8),
                  InkWell(
                      onTap: (){
                        controller.getCoverImage(userInfo);
                      },
                      child: uploadingCard.uploadingCard("File")),
                  SizedBox(height: 8),
                  GetBuilder<ImageUploadingViewModel>(
                    builder: (controller){
                      return userInfo.coverImageUrl == null?
                  Text("No Files added yet",
                    style: TextStyle(
                        fontSize: 16,fontWeight: FontWeight.w700,
                        color: Colors.grey),):
                    imageIconComponet.imageComponent(userInfo,userInfo.coverImageUrl,controller,(){ controller.deleteImage(userInfo);});},),
                  SizedBox(height: 30,),
                  Text("Upload gallery image",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900,color:Color.fromRGBO(
                      12, 12, 12, 0.6) ),),
                  SizedBox(height: 8),

                  InkWell(
                      onTap: (){
                        controller.getGalleryImages(userInfo);
                      },
                      child: uploadingCard.uploadingCard("File(s) upto 5 gallery images")),
                  SizedBox(height: 8),

                  GetBuilder<ImageUploadingViewModel>(builder: (controller){
                    return userInfo.galleryImages.isEmpty? Text("No Files added yet",
    style: TextStyle(
    fontSize: 16,fontWeight: FontWeight.w700,
    color: Colors.grey),):SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
      child: Row(
                        spacing: 10,
                        children:userInfo.galleryImages.asMap().entries.map(
                                (image) {
                                  return imageIconComponet.galleryImageComponent(
                                    userInfo,image.value,image.key,controller);}).toList(),
                      ),
    );}),

    SizedBox(height: MediaQuery.of(context).size.height-600)
    ],
    ),
    ),
    ),
    ),
           Positioned(
               bottom: 35,
               left: 10,
               right: 10,
               top: 570,
               child:buttonThemes.buttonThemeComponent("Next Step",(){}) ),
      ]),
    );
  }
}
