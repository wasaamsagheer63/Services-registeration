import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_registeration/models/availability.dart';
import 'package:service_registeration/models/user_info.dart';
import 'package:service_registeration/view_models/availability_viewmodel.dart';

import '../../models/timings.dart';

class TimeSelectionChip{
  AvailabilityViewModel availabilityViewModel = AvailabilityViewModel();
  Widget timeChip(String timeType,Function onChanged,String timeHint){
    return Column(
      spacing: 2,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(timeType,style: TextStyle(fontWeight:FontWeight.bold,fontSize:14,color: Colors.grey),),
        Container(
          width:115,
          height: 50,
          child: DropdownButtonFormField2(
              hint:Text(timeHint),
              style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),

              decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal:1),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide(width: 1,color: Colors.grey)

                ),
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: 200,
                padding: EdgeInsets.zero
              ),
              value: timeHint,
              items:availabilityViewModel.timeValues.map((time) => DropdownMenuItem(
                  value: time,

                  child: Text(time,style: TextStyle(color: Colors.black),))).toList()
              , onChanged:(value)=>onChanged(value)


          ),
        )
      ],);
  }
}
