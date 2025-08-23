import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:service_registeration/view_models/services_viewmodel.dart';

import '../view_models/detail_form_viewmodel.dart';
import 'button_component.dart';

class MapView{


  Widget flutterMapView(LatLng position,Function onPressed,ServiceDetailViewModel controller,RxString address){
    ButtonThemes buttonThemes = ButtonThemes();
    return Stack(
      children:[ FlutterMap(
        mapController: controller.mapController,
          options: MapOptions(

        initialCenter: position,
        onPositionChanged: (MapPosition mapPosition,bool isGestured){
          if(isGestured && mapPosition.center != null){
           controller.getAddress(mapPosition.center!);
          }
        },
        minZoom: 3,
        maxZoom: 15
      ),

          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            ),

          ]),
        Center(
          child: Icon(Icons.location_on,size: 30,color: Colors.red,),
        ),
      Positioned(
        left: 5,
          right: 5,
          bottom: 90,
          child:Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.location_on,color: Colors.red,size: 24,),
              SizedBox(
                  width:220,
    child: Text(address.value,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),)),
              Icon(Icons.my_location,color: Colors.green,size: 24,)

            ],
          ),
        ),
      ) ),
        Positioned(
            bottom: 20,
            left: 5,
            right: 5,
            child:buttonThemes.buttonThemeComponent(
                "Confirm Location"
                ,onPressed)
        )
      ],
    );
  }
}