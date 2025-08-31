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


  RxBool secondSlot = false.obs;
  RxBool thirdSlot = false.obs;

  void chooseAvailability(){
    isAvailable.value = !isAvailable.value;
  }

  Future<bool> addSlot( UserInfo   userInfo)async {
    try{
    if(await userInfoClient.updateData(userInfo)) {
      update();
      print("Data is uploaded");
      return true;
    }
    else{
      return false;
    }
    }
  catch(e){
      throw Exception(e.toString());
  }
  }

  String? nextTimeValue(String startTime) {
    print("previous value ${startTime}");
    if(startTime == "23:00"){
      return "00:00";
    }else{
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
  }

  void  uploadData(int timingIndex,int dayIndex, UserInfo   userInfo, Timings timings,Availability availability){
    while (availability.timingSlots.length <= timingIndex) {
      availability.timingSlots.add(Timings("00:00", "01:00"));
    }
    Timings newTimings = Timings(timings.startTime, timings.endTime);
    print("new timings: ${newTimings.toMap()}");
    availability.timingSlots[timingIndex] = newTimings;
    print(availability.timingSlots[timingIndex].startTime);

    while (  userInfo.availabilityOfDays.length <= dayIndex) {
        userInfo.availabilityOfDays.add(Availability("", false));
    }

    print("before uploadation: ${  userInfo.availabilityOfDays[dayIndex].toMap()}");
      userInfo.availabilityOfDays[dayIndex] = availability;
    addSlot(  userInfo);
    update();
  }

  String valueSelected(String value,Timings timings,int timeIndex,int dayIndex, UserInfo   userInfo,Availability availability){
    {
      timings.startTime=value;
      String? nextValue =nextTimeValue(timings.startTime);
      timings.endTime = nextValue!;
      uploadData(timeIndex,dayIndex,  userInfo,timings, availability);
      return timings.endTime;
    }
  }

  List<String> getDisabledStartValues(Availability availability, int slotIndex) {
    List<String> disabled = [];

    if(slotIndex == 0){
      if(availability.timingSlots.length > 0) {
        String endTime = availability.timingSlots[0].endTime;
        int endHour = int.tryParse(endTime.substring(0,2)) ?? 0;
        for(var time in timeValues){
          int hour = int.tryParse(time.substring(0,2)) ?? 0;
          if(hour >= endHour){
            disabled.add(time);
          }
        }
      }
    }
    else if(slotIndex == 1){
      if(availability.timingSlots.length > 0) {
        String prevEndTime = availability.timingSlots[0].endTime;
        int prevEndHour = int.tryParse(prevEndTime.substring(0,2)) ?? 0;

        for(var time in timeValues){
          int hour = int.tryParse(time.substring(0,2)) ?? 0;
          if(hour < prevEndHour){
            disabled.add(time);
          }
        }

        if(availability.timingSlots.length > 1) {
          String endTime = availability.timingSlots[1].endTime;
          int endHour = int.tryParse(endTime.substring(0,2)) ?? 0;
          for(var time in timeValues){
            int hour = int.tryParse(time.substring(0,2)) ?? 0;
            if(hour >= endHour && !disabled.contains(time)){
              disabled.add(time);
            }
          }
        }
      }
    }
    else if(slotIndex == 2){
      if(availability.timingSlots.length > 1) {
        String prevEndTime = availability.timingSlots[1].endTime;
        int prevEndHour = int.tryParse(prevEndTime.substring(0,2)) ?? 0;

        for(var time in timeValues){
          int hour = int.tryParse(time.substring(0,2)) ?? 0;
          if(hour < prevEndHour){
            disabled.add(time);
          }
        }

        if(availability.timingSlots.length > 2) {
          String endTime = availability.timingSlots[2].endTime;
          int endHour = int.tryParse(endTime.substring(0,2)) ?? 0;
          for(var time in timeValues){
            int hour = int.tryParse(time.substring(0,2)) ?? 0;
            if(hour >= endHour && !disabled.contains(time)){
              disabled.add(time);
            }
          }
        }
      }
    }

    return disabled;
  }

  List<String> getDisabledEndValues(Availability availability, int slotIndex) {
    List<String> disabled = [];

    if(slotIndex == 0){
      if(availability.timingSlots.length > 0) {
        String startTime = availability.timingSlots[0].startTime;
        int startHour = int.tryParse(startTime.substring(0,2)) ?? 0;

        for(var time in timeValues){
          int hour = int.tryParse(time.substring(0,2)) ?? 0;
          if(hour <= startHour){
            disabled.add(time);
          }
        }

        if(availability.timingSlots.length > 1) {
          String nextStartTime = availability.timingSlots[1].startTime;
          int nextStartHour = int.tryParse(nextStartTime.substring(0,2)) ?? 0;
          for(var time in timeValues){
            int hour = int.tryParse(time.substring(0,2)) ?? 0;
            if(hour > nextStartHour && !disabled.contains(time)){
              disabled.add(time);
            }
          }
        }
      }
    }
    else if(slotIndex == 1){
      if(availability.timingSlots.length > 1) {
        String startTime = availability.timingSlots[1].startTime;
        int startHour = int.tryParse(startTime.substring(0,2)) ?? 0;

        for(var time in timeValues){
          int hour = int.tryParse(time.substring(0,2)) ?? 0;
          if(hour <= startHour){
            disabled.add(time);
          }
        }

        if(availability.timingSlots.length > 2) {
          String nextStartTime = availability.timingSlots[2].startTime;
          int nextStartHour = int.tryParse(nextStartTime.substring(0,2)) ?? 0;
          for(var time in timeValues){
            int hour = int.tryParse(time.substring(0,2)) ?? 0;
            if(hour > nextStartHour && !disabled.contains(time)){
              disabled.add(time);
            }
          }
        }
      }
    }
    else if(slotIndex == 2){
      if(availability.timingSlots.length > 2) {
        String startTime = availability.timingSlots[2].startTime;
        int startHour = int.tryParse(startTime.substring(0,2)) ?? 0;

        for(var time in timeValues){
          int hour = int.tryParse(time.substring(0,2)) ?? 0;
          if(hour <= startHour){
            disabled.add(time);
          }
        }
      }
    }

    return disabled;
  }

}