import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvailabilityChipComponent{
  Widget availabilityChipComponent(String day, {bool isSelected = false}){
    return  Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1,color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
          color: Colors.white
      ),
      child: Padding(padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(day,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            Switch(
                inactiveTrackColor:Color.fromRGBO(
                  160, 163, 160, 0.4,),
                inactiveThumbColor: Colors.white,
                trackOutlineColor: WidgetStatePropertyAll(Colors.white),
                activeTrackColor:Color.fromRGBO(
                  1, 138, 1, 0.6,),
                value:false , onChanged:(value){

            })
          ],
        ),),
    );
  }
}