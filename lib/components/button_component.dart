import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class ButtonThemes{
  Widget buttonThemeComponent(

      String buttonText,
      Function onPressed,){
    return Container(
      decoration: BoxDecoration(
        border: BoxBorder.fromLTRB(top:BorderSide(width: 2,color:Color.fromRGBO(
          186, 188, 186, 0.6,))),
        gradient: LinearGradient(colors:[Color.fromRGBO(
          7, 120, 6, 1.0,),Color.fromRGBO(
          6, 160, 6, 1.0,),Color.fromRGBO(2, 160, 2, 1.0,)],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight

        ),
        borderRadius: BorderRadius.circular(30),
      ),

      child: ElevatedButton(onPressed: ()=>onPressed(),
        child: Text(buttonText,style: TextStyle(fontSize:17,fontWeight:FontWeight.w900,color: Colors.white),),
        style: ElevatedButton.styleFrom(
          backgroundColor:Colors.transparent,
          shadowColor: Colors.transparent,
        ),),
    );
  }
  Widget dropDownComponent(List<String> totalValues,String hintText, RxString selectedValue, Function(RxString?) onChanged,{bool service=false }){

    return DropdownButtonFormField(
      icon: service?SizedBox.shrink():null,
        decoration:InputDecoration(
          prefixIcon: Icon(Icons.add,color: Colors.white,),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color:Colors.grey),
            borderRadius: BorderRadius.circular(50),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50)
          ),
          fillColor: Colors.white,
          filled: true,
        ),
      borderRadius: BorderRadius.circular(15),
        value: selectedValue.isEmpty ? null: selectedValue.value,
        isExpanded:true,
        hint: Text(hintText,style: TextStyle(color:Colors.grey,fontSize:16,fontWeight: FontWeight.bold),),
        items:totalValues.map((item) => DropdownMenuItem(
        value:item,
        child:Text(item,style: TextStyle(color:Colors.black,fontSize:16,fontWeight: FontWeight.w400),))).toList() , onChanged:(value){
          selectedValue.value = value.toString() ?? "";
    });
  }
}
