import 'package:get/get.dart';
import 'package:service_registeration/models/availability.dart';

class UserInfo {
  String id;
  String service;
  String experienceLevel;
  num pricePerHour;
  String address;
  String detail;
  String category = "draft";
  String? coverImageUrl;
 List<String> galleryImages = [];
 List<Availability> availabilityOfDays = [];


  UserInfo(
    this.id,
    this.service,
    this.experienceLevel,
    this.pricePerHour,
    this.address,
    this.detail,
    this.category,
  );

  Map<String, dynamic> toMap() {
    return {
      "id":id,
      "service": service,
      "experienceLevel": experienceLevel,
      "pricePerHour": pricePerHour,
      "address": address,
      "detail": detail,
      "category": category,
      "coverImageUrl":coverImageUrl,
      "galleryImages":galleryImages,
      "availabilityOfDays":availabilityOfDays.map((item) => item.toMap()).toList(),
    };
  }

  static UserInfo fromMap(Map<String, dynamic> map) {
    UserInfo userInfo = UserInfo(
      map["id"],
      map["service"],
      map["experienceLevel"],
      map["pricePerHour"],
      map["address"],
      map["detail"],
      map["category"]
    );
    userInfo.coverImageUrl=map["coverImageUrl"] ;
    userInfo.galleryImages.addAll(List<String>.from(map["galleryImages"]??[]));
    userInfo.availabilityOfDays.addAll((
        map["availabilityOfDays"]??[])
        .map<Availability>((day) => Availability.fromMap(day)).toList());
    return userInfo;
  }
}
