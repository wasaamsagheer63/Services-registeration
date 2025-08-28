import 'package:service_registeration/models/timings.dart';

class Availability{
  String day;
  bool isAvailable = false;
  List<Timings> timingSlots =[];

  Availability(
      this.day,
      this.isAvailable);
  Map<String, dynamic> toMap() {
    return {
     "day":day,
      "isAvailable":isAvailable,
      "timingSlots":timingSlots.map((item) => item.toMap()).toList(),
    };
  }

  static Availability fromMap(Map<String, dynamic> map) {
    Availability availability =Availability(map["day"], map["isAvailable"]);
    availability.timingSlots.addAll(List<Timings>.from(map["timingSlots"]??[]));
    return availability;
  }

}