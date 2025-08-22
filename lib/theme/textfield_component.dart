import 'package:flutter/material.dart';

class TextFieldComponent{

  Widget textFieldGeneralComponent(String labelData, TextEditingController textEditingController,{bool address = false, bool price = false, Function onTap}){
    return SizedBox(
      child: TextField(
        controller: textEditingController,
        keyboardType: price ? TextInputType.number:null,

        decoration:InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color:Colors.grey),
                borderRadius: BorderRadius.circular(50)
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50)
            ),
            prefixIcon: address?InkWell(
                onTap:()=>onTap(),
                child: Icon(Icons.location_on_outlined,color: Colors.grey,)):null,
            fillColor: Colors.white,
            filled: true,
            hintText: "",
            hintStyle: TextStyle(color:Colors.grey,fontSize:16),
            label: Text(labelData,style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.bold),)
        ),

      ),
    );
  }


  Widget textFieldforDetailComponent(String labelData, TextEditingController textEditingController){
    return TextField(
      controller: textEditingController,
      maxLines: 4,
      maxLength: 250,

      decoration:InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color:Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        fillColor: Colors.white,
        filled: true,
        hintText:labelData,
        hintStyle: TextStyle(color:Colors.grey,fontSize:16,fontWeight: FontWeight.bold),
      ),

    );
  }
}