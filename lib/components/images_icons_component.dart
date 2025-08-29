import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_registeration/models/user_info.dart';
import 'package:service_registeration/view_models/image_uploading_viewmodel.dart';

class ImageIconComponet{
  Widget imageComponent(UserInfo userInfo,String? image,ImageUploadingViewModel controller,Function onTap){
    return InkWell(
      onTap: (){
        controller.showDeleteIcon();
      },
      child: Stack(
          children:[
            ClipRRect(
                borderRadius:BorderRadius.circular(8),
                child: Image.network(image!,width: 40,height: 40,fit: BoxFit.cover,)),
            Obx(() => controller.showIcon.value ==true?Positioned(
                top:0,
                bottom: 0,
                left: 0,
                right: 0,
                child: InkWell(
                    onTap:()=>onTap(),
                    child: Container(
                      width: 40,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(70, 70, 70,0.3),
                        borderRadius: BorderRadius.circular(8),

                      ),
                      child: Icon(Icons.cancel_outlined,color: Colors.white,),))):SizedBox.shrink()

            )]),
    );
  }


  Widget galleryImageComponent(UserInfo userInfo,String? image,int index,ImageUploadingViewModel controller){
    return GetBuilder<ImageUploadingViewModel>(builder: (controller){
      return
      InkWell(
        onTap: (){
          print("index:$index");
          controller.galleryDeleteIcon(index);
        },
        child: Stack(
            children:[
              ClipRRect(
                  borderRadius:BorderRadius.circular(8),
                  child: Image.network(image!,width: 40,height: 40,fit: BoxFit.cover,)),
              index == controller.iconIndex.value?Positioned(
                  top:0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: InkWell(
                      onTap:(){
                        controller.deleteGalleryImages(userInfo, index);
                      },
                      child: Container(
                        width: 40,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(70, 70, 70,0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.cancel_outlined,color: Colors.white,),))):SizedBox.shrink()

            ]),
      );});
    }
  }
