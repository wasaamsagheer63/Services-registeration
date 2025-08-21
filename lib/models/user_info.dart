class UserInfo {
  int id;
  String name;
  String service;
  String experienceLevel;
  num pricePerHour;
  String address;
  String detail;

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
      "id": id,
      "name": name,
      "service": service,
      "experienceLevel": experienceLevel,
      "pricePerHour": pricePerHour,
      "address": address,
      "detail": detail,
    };
  }

  static UserInfo fromMap(Map<String, dynamic> map) {
    return UserInfo(
      map["id"],
      map["name"],
      map["service"],
      map["experienceLevel"],
      map["pricePerHour"],
      map["address"],
      map["detail"],
    );
  }
}
