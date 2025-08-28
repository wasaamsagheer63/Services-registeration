import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_registeration/components/availability_components/time_selection_row.dart';
import 'package:service_registeration/models/availability.dart';
import 'package:service_registeration/models/timings.dart';
import 'package:service_registeration/models/user_info.dart';
import 'package:service_registeration/view_models/availability_viewmodel.dart';

class AvailabilityChipComponent{
  TimeSelectionRow timeSelectionRow = TimeSelectionRow();
  Widget availabilityChip(String day,int dayIndex,UserInfo userInfo,AvailabilityViewModel controller){
    Availability availability = Availability(day, controller.isAvailable.value);
    Timings timings = Timings("00:00", "01:00");
    return  GetBuilder<AvailabilityViewModel>(builder: (controller){
      return InkWell(
        onTap: () {
          if(availability.isAvailable == false){
            availability.isAvailable = true;
            controller.uploadData(0, dayIndex, userInfo, timings, availability);
          }
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(15),
              color: Colors.white
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(12,0, 8, 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(day,
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                    Switch(
                        inactiveTrackColor: Color.fromRGBO(
                          160, 163, 160, 0.4,),
                        inactiveThumbColor: Colors.white,
                        trackOutlineColor: WidgetStatePropertyAll(Colors.white),
                        activeTrackColor: Color.fromRGBO(
                          1, 138, 1, 0.6,),
                        value:availability.isAvailable,
                        onChanged: (value) {
                          print(value);
                          availability.isAvailable = !availability.isAvailable;
                          print("after click");
                          print(availability.isAvailable);
                          availability.isAvailable ==true?
                          controller.uploadData(0, dayIndex, userInfo, timings, availability)
                              :null;
                        })
                  ],
                ),
                availability.isAvailable == true?Column(

                  children: [
                    timeSelectionRow.timeRow( availability.timingSlots[0].startTime,
                            (value){
                          availability.timingSlots[0].endTime = controller.valueSelected(value, availability.timingSlots[0], 0, dayIndex, userInfo, availability);
                        },availability.timingSlots[0].endTime,(value){
                          availability.timingSlots[0].endTime = value;
                          print("first end time${availability.timingSlots[0].endTime}");
                          controller.uploadData(0,dayIndex,userInfo,availability.timingSlots[0], availability);
                        }),
                    availability.timingSlots.length == 1?
                    Center(child: InkWell(
                        onTap: (){
                          Timings timings = Timings("02:00", "03:00");
                          timings.startTime = controller.nextTimeValue(availability.timingSlots[0].endTime)!;
                          timings.endTime= controller.nextTimeValue(timings.startTime)!;
                          controller.uploadData(1, dayIndex, userInfo,timings, availability);
                        },
                        child: Icon(Icons.add)),)

                        :timeSelectionRow.timeRow(availability.timingSlots[1].startTime,(value){
                      availability.timingSlots[1].endTime = controller.valueSelected(value,availability.timingSlots[1] , 1, dayIndex, userInfo, availability);
                    },availability.timingSlots[1].endTime,(value){
                      availability.timingSlots[1].endTime = value;
                      controller.uploadData(1,dayIndex,userInfo, availability.timingSlots[1], availability);
                    }),

                    availability.timingSlots.length==2 ?
                    Center(child: InkWell(
                        onTap: (){
                          Timings timings = Timings("04:00","05:00");
                          timings.startTime = controller.nextTimeValue(availability.timingSlots[1].endTime)!;
                          timings.endTime= controller.nextTimeValue(timings.startTime)!;
                          controller.uploadData(2, dayIndex, userInfo, timings, availability);
                        },
                        child: Icon(Icons.add)),)
                        :availability.timingSlots.length ==3 ? timeSelectionRow.timeRow(availability.timingSlots[2].startTime,
                            (value){
                              availability.timingSlots[2].endTime = controller.valueSelected(value, availability.timingSlots[2], 2, dayIndex, userInfo, availability);
                    },availability.timingSlots[2].endTime,(value){
                          availability.timingSlots[2].endTime = value;
                      controller.uploadData(2,dayIndex,userInfo, availability.timingSlots[2], availability);
                    }):SizedBox.shrink()
                  ],
                ):SizedBox.shrink(),

              ],
            ),
          ),
        ),

      );});
    }
  }

