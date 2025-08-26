import 'package:get/get.dart';

class UserInfo {
  String id;
  String name;
  String service;
  String experienceLevel;
  num pricePerHour;
  String address;
  String detail;
  String? coverImageUrl;
 List<String> galleryImages = [];


  UserInfo(
    this.id,
    this.name,
    this.service,
    this.experienceLevel,
    this.pricePerHour,
    this.address,
    this.detail,
  );

  Map<String, dynamic> toMap() {
    return {
      "id":id,
      "name": name,
      "service": service,
      "experienceLevel": experienceLevel,
      "pricePerHour": pricePerHour,
      "address": address,
      "detail": detail,
      "coverImageUrl":coverImageUrl,
      "galleryImages":galleryImages,
    };
  }

  static UserInfo fromMap(Map<String, dynamic> map) {
    UserInfo userInfo = UserInfo(
      map["id"],
      map["name"],
      map["service"],
      map["experienceLevel"],
      map["pricePerHour"],
      map["address"],
      map["detail"],
    );
    userInfo.coverImageUrl=map["coverImageUrl"] ;
    userInfo.galleryImages.addAll(List<String>.from(map["galleryImages"]??[]));
    return userInfo;
  }
}
