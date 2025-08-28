import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_registeration/http_clients/user_info_client.dart';
import 'package:service_registeration/models/user_info.dart';

import '../models/availability.dart';
import '../models/timings.dart';

class AvailabilityViewModel extends GetxController{
  final UserInfoClient userInfoClient = Get.find();
RxBool isAvailable = false.obs;
RxList<String> timeValues = ["00:00","01:00","02:00","03:00","04:00","05:00",
  "06:00","07:00","08:00","09:00","10:00","11:00","12:00","13:00","14:00",
  "15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00"].obs;

  RxList<String> selectedTimeValues =<String>[].obs;


  RxBool secondSlot = false.obs;
  RxBool thirdSlot = false.obs;




void chooseAvailability(){
  isAvailable.value = !isAvailable.value;
}

  Future<void> addSlot(UserInfo userInfo)async {
  await userInfoClient.updateData(userInfo);
  print("Data is uploaded");
  }

  String? nextTimeValue(String startTime) {
  print("previus value ${startTime}");
    int startingHour = int.tryParse(startTime.substring(0,2))??0;
    for(var value in timeValues) {
      int endingHour = int.tryParse(value.substring(0, 2)) ?? 0;
      if (endingHour > startingHour) {
        print("next value ${value}");

        return value;
      }
    }
    return null;
}


  void uploadData(int timingIndex,int dayIndex,UserInfo userInfo, Timings timings,Availability availability){
    while (availability.timingSlots.length <= timingIndex) {
      availability.timingSlots.add(Timings("00:00", "01:00"));
    }
    Timings newTimings = Timings(timings.startTime, timings.endTime);
    print("new timings: ${newTimings.toMap()}");
    availability.timingSlots[timingIndex] = newTimings;
    print(availability.timingSlots[timingIndex].startTime);

    while (userInfo.availabilityOfDays.length <= dayIndex) {
      userInfo.availabilityOfDays.add(Availability("", false));
    }


    print("before uploadation: ${userInfo.availabilityOfDays[dayIndex].toMap()}");

    userInfo.availabilityOfDays[dayIndex] = availability;
    selectedTimeSlots(availability);
    addSlot(userInfo);
    update();
  }


  String valueSelected(String value,Timings timings,int timeIndex,int dayIndex,UserInfo userInfo,Availability availability){
    {
      timings.startTime=value;
      String? nextValue =nextTimeValue(timings.startTime);
      timings.endTime = nextValue!;
      uploadData(timeIndex,dayIndex,userInfo,timings, availability);
      return timings.endTime;

    }
  }

  void selectedTimeSlots(Availability availability){
  availability.timingSlots.map((slot){
    int startRange = int.tryParse(slot.startTime.substring(0,2))!;
    int endRange = int.tryParse(slot.endTime.substring(0,2))!;
    for(var value in timeValues){
      int data =int.tryParse(value.substring(0,2))!;
      if(data >= startRange && data <= endRange){
        selectedTimeValues.add(value);
      }
    }
  } ).toList();
  }


}