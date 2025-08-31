import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/availability.dart';
import '../models/timings.dart';
import '../models/user_info.dart';
import '../view_models/services_viewmodel.dart';
import 'button_component.dart';

class BottomSheetView{
  Future<void> bottomSheetView(UserInfo service,ServicesViewModel controller,BuildContext context,String categoryText,Function onPressedCategory,String forDelete,Function onDelete,{bool unpublish = false}){
  ButtonThemes buttonThemes = ButtonThemes();
    return showModalBottomSheet(context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),),
        builder: (BuildContext context){
          List<Availability> availability = [];
          service.availabilityOfDays.map((map){
            if(map.timingSlots.isNotEmpty){
              availability.add(map);
            }
          }).toList();


          return SizedBox(
            height: 400,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Container(
                          width: 80,
                          height: 6,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey
                          ),
                        ),

                        const SizedBox(height: 20,),
                        Container(
                          width: 400,
                          height: 1,
                          decoration: BoxDecoration(
                              shape:BoxShape.rectangle,
                              color: Colors.grey
                          ),
                        ),
                        const SizedBox(height: 15,),
                        Row(
                            spacing: 40,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Service details",style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                              InkWell(
                                onTap: (){
                                  Get.offAllNamed("/create_services",arguments: service);
                                },
                                child: Row(
                                  spacing: 5,
                                  children: [
                                    Icon(Icons.edit_note,color: Colors.green,size: 20,),
                                    Text("Edit",style:TextStyle(color: Colors.green,fontWeight: FontWeight.bold),)
                                  ],
                                ),
                              ),]),
                        const SizedBox(width: 1,),
                        const SizedBox(height: 20,),
                        Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Column(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  spacing: 7,
                                  children: [
                                    Icon(Icons.shopping_bag_outlined),
                                    Text("Service :",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                    Text(service.service,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.green),),
                                    Text("(${service.experienceLevel})",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 9),),
                                  ],
                                ),
                                Row(
                                  spacing: 7,
                                  children: [
                                    Icon(Icons.price_change_outlined),
                                    Text("Price/hr :",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                    Text(service.pricePerHour.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                  ],
                                ),
                                Row(
                                  spacing: 7,

                                  children: [
                                    Icon(Icons.location_on_outlined),
                                    Text("Location :",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                    SizedBox(
                                        width: 170,
                                        child: Text(service.address,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.grey),)),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Text(service.detail,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: Colors.grey),)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Column(
                                spacing: 10,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                                  Row(
                                    spacing: 7,

                                    children: [
                                      Icon(Icons.calendar_today_rounded),
                                      Text("Availability",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                    ],
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:availability.length,
                                      itemBuilder: (context,index){
                                        Availability day = availability[index];

                                        List<Timings> timings = [];
                                        day.timingSlots.map((map){
                                          timings.add(map);
                                        }).toList();

                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(day.day,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                            Wrap(
                                              spacing:5,
                                              children:timings.map((time){
                                                return Text("${time.startTime} - ${time.endTime} ||",style: TextStyle(color: Colors.grey,fontSize: 12),);
                                              }).toList(),
                                            ),
                                          ],
                                        );
                                      })
                                ]
                            ),
                          ),
                        ),
                        SizedBox(height:unpublish ==true ?130: 100,)

                      ],
                    )
                    ,
                  ),
                ),
                unpublish == true ?Positioned(
                    bottom: 70,
                    left: 10,
                    right: 10,
                    child:buttonThemes.simpleButtonThemeComponent(forDelete,onDelete,delete:true)):SizedBox.shrink(),
                Positioned(
                    bottom: 10,
                    left: 10,
                    right: 10,
                    child:buttonThemes.buttonThemeComponent(categoryText, onPressedCategory) )
              ],

            ),
          );
        });
  }
}