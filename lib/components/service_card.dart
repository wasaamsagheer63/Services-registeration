import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_registeration/models/timings.dart';
import 'package:service_registeration/models/user_info.dart';
import 'package:service_registeration/view_models/services_viewmodel.dart';

import '../models/availability.dart';
import 'bottom_sheet.dart';
import 'button_component.dart';

class ServiceCard{
  BottomSheetView bottomSheet = BottomSheetView();
  Widget serviceCardView(UserInfo service,ServicesViewModel controller,BuildContext context,String categoryText,Function onPressedCategory,String forDelete,Function onDelete,{bool unpublish = false}){
    ButtonThemes buttonThemes = ButtonThemes();
    return InkWell(
      onTap: () => bottomSheet.bottomSheetView(service,controller,context,categoryText,onPressedCategory,forDelete,onDelete,unpublish: unpublish),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width*0.91,
                  height:170,
                  child: Stack(
                    children: [
                      service.coverImageUrl == null ?Center(child: Icon(Icons.person,size: 50,)):
                      ClipRRect(
                        borderRadius:
                        BorderRadius.circular(15),
                        child: Image.network(service.coverImageUrl!,fit:BoxFit.cover,
                          width:MediaQuery.of(context).size.width*0.91,),
                      ),
                      Positioned(
                          top: 10,
                          left: 10,
                          child: Container(
                            padding:EdgeInsets.symmetric(vertical:5,horizontal: 8),
                            decoration: BoxDecoration(
                                color:Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                border: BoxBorder.all(width: 1,color: Colors.green)
                            ),
                            child: Text(service.category,style: TextStyle(color: Colors.green,fontWeight: FontWeight.w900),),
                          ))
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 5,
                    children: [
                      Text(service.service,
                        style: TextStyle(color: Colors.green,
                            fontSize: 18,fontWeight: FontWeight.bold),),
                      Text("(${service.experienceLevel})",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w600),)
                    ],),
                  Row(
                    children: [
                      Text("\$",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                      Text(service.pricePerHour.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                      Text("/hr",style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.bold),)
                    ],
                  )
                ],),
              Text(service.address,style: TextStyle(color: Colors.grey,fontSize: 12,fontWeight: FontWeight.w500),)
            ],
          ),
        ),
      ),
    );
  }
}