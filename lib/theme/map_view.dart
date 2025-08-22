import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapView{


  Widget flutterMapView(LatLng position){
    return FlutterMap(options: MapOptions(
      initialCenter: position,
      minZoom: 2,
      maxZoom: 18,
    ),

        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          MarkerLayer(markers:[
            Marker(point:position,
                width: 40,
                height: 40,
                child:Icon(Icons.location_on,color: Colors.red,size: 40,))
          ])
        ]);
  }
}