import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_registeration/http_clients/image_uploading_client.dart';
import 'package:service_registeration/http_clients/user_info_client.dart';
import 'package:service_registeration/models/user_info.dart';

class ImageUploadingViewModel extends GetxController {
  ImageUploadingClient imageUploadingClient = Get.find();
  UserInfoClient userInfoClient = Get.find();
  Rxn<XFile> image = Rxn<XFile>();
  RxInt iconIndex = (-1).obs;
RxBool showIcon = false.obs;
void onInit(){
  super.onInit();
  print("index value :${iconIndex.value}");
}
  void showDeleteIcon() {
    showIcon.value = !showIcon.value;
  }

  void galleryDeleteIcon(int index,){
    print("iconIndex: ${iconIndex.value} and index:${index}");
    iconIndex.value = index;
    print("iconIndex: ${iconIndex.value} and index:${index}");
    update();
  }
  void deleteGalleryImages(UserInfo userInfo,int indexValue){
    userInfo.galleryImages.removeAt(indexValue);
    iconIndex.value=-1;
    update();
  }


  Future<void> getCoverImage(UserInfo userInfo) async {
  if(userInfo.coverImageUrl == null){
    ImagePicker picker = ImagePicker();
    final ImagePicked = await picker.pickImage(source: ImageSource.gallery);
    if (ImagePicked != null) {
      image.value = ImagePicked;
      final coverImageUrl = await imageUploadingClient.uploadImage(
          image.value!.path);
      userInfo.coverImageUrl = coverImageUrl.url;
      userInfoClient.updateData(userInfo);
      update();
    }
  }
  else{
      Get.snackbar("", "",messageText: Text(
        "Only One Cover Image is Allowed",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color:Color.fromARGB(
              200, 255, 253, 253),
        ),
      ),colorText:Color.fromARGB(
          200, 255, 253, 253),backgroundColor:Color.fromARGB(
          200, 225, 207, 9));
    }

  }

  Future<void> deleteImage(UserInfo userInfo) async {
    userInfo.coverImageUrl = null;
    userInfoClient.updateData(userInfo);
    showIcon.value = false;
    iconIndex.value = -1;
    update();
  }

  Future<void> getGalleryImages(UserInfo userInfo) async {
    print(userInfo.galleryImages.length);
    if(userInfo.galleryImages.length <5){
    List<String> galleryImages =[];
    ImagePicker picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();
    if (pickedImages.isNotEmpty) {
      for (var galleryImage in pickedImages.take(5-userInfo.galleryImages.length)) {
        final galleryImageUrl = await imageUploadingClient.uploadImage(galleryImage.path);
        galleryImages.add(galleryImageUrl.url!);
      }
        userInfo.galleryImages.addAll(galleryImages);
        userInfoClient.updateData(userInfo);
        iconIndex.value = -1;
        update();

    }
    }

    else{
      Get.snackbar("", "",messageText: Text(
        "Only 5 Gallery Images are Allowed",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color:Color.fromARGB(
              200, 255, 253, 253),
        ),
      ),colorText:Color.fromARGB(
          200, 255, 253, 253),backgroundColor:Color.fromARGB(
          200, 243, 224, 12));;

    }
  }
}

