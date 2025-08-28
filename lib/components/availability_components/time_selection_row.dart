import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_registeration/components/availability_components/time_selection_chip.dart';


import '../../models/timings.dart';

class TimeSelectionRow{
  TimeSelectionChip timeSelectionChip = TimeSelectionChip();
  Widget timeRow(String startTimeHint,Function onChangedStart,String endTimeHint,Function onChangedEnd){
 return Row(
      children: [
        timeSelectionChip.timeChip("Start Time ",onChangedStart,startTimeHint),
        SizedBox(width: 12,),
        timeSelectionChip.timeChip("End Time",onChangedEnd,endTimeHint),
        IconButton(onPressed: (){}, icon: Icon(Icons.delete_outline_outlined,size: 30,))
      ],
    );
  }
}