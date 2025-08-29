import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_registeration/components/availability_components/time_selection_chip.dart';
import 'package:service_registeration/view_models/availability_viewmodel.dart';
import 'package:service_registeration/models/availability.dart';


class TimeSelectionRow{
  TimeSelectionChip timeSelectionChip = TimeSelectionChip();

  Widget timeRow(String startTimeHint, Function onChangedStart, String endTimeHint,
      Function onChangedEnd, AvailabilityViewModel controller, Function onDelete,
      Availability availability, int slotIndex){
    return Row(
      children: [
        timeSelectionChip.timeChip("Start Time ", onChangedStart, startTimeHint,
            true, controller, availability, slotIndex),
        SizedBox(width: 12,),
        timeSelectionChip.timeChip("End Time", onChangedEnd, endTimeHint,
            false, controller, availability, slotIndex),
        IconButton(onPressed: ()=>onDelete(), icon: Icon(Icons.delete_outline_outlined,size: 30,))
      ],
    );
  }
}