import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view_models/detail_form_viewmodel.dart';

class TextFieldComponent {
  Widget textFieldGeneralComponent(
    String labelData,
    TextEditingController textEditingController,
      Function() onTap,
      {
    bool address = false,
        bool isLoading = false,
    bool price = false,
    bool search = false,
  }) {
    return TextField(
      controller: textEditingController,
      keyboardType: price ? TextInputType.number : null,
      readOnly: address,

      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(50),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
        prefixIcon: address
            ? InkWell(
          onTap: ()=>address? onTap(): null,
                child:isLoading
                    ? Container(
                  margin: EdgeInsets.only(left:6),
                    padding: EdgeInsets.all(6),
                    child: CircularProgressIndicator(color: Colors.grey,))
                    : Icon(Icons.location_on_outlined, color: Colors.grey),
              )
            : search?Icon(Icons.search,color:Colors.grey,size: 30,):Icon(Icons.add,color:Colors.white),
        fillColor: Colors.white,
        filled: true,
        hintText: search?labelData:"",
        hintStyle: TextStyle(color: Colors.grey, fontSize:16,
            fontWeight: search?FontWeight.w600:FontWeight.w300),
        label:!search?Text(
          labelData,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ):Text(""),
      ),
    );
  }

  Widget textFieldforDetailComponent(
    String labelData,
    TextEditingController textEditingController,
  ) {
    return TextField(
      controller: textEditingController,
      maxLines: 4,
      maxLength: 250,

      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        fillColor: Colors.white,
        filled: true,
        hintText: labelData,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget textFieldSearchComponent(
      String labelData,
      TextEditingController textEditingController,
      ServiceDetailViewModel viewModel
      ) {
    return TextField(
      controller: textEditingController,

      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(50),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
        prefixIcon: Icon(Icons.search,color:Colors.grey,size: 30,),
        fillColor: Colors.white,
        filled: true,
        hintText: labelData,
        hintStyle: TextStyle(color: Colors.grey, fontSize:16,
            fontWeight:FontWeight.w600),
      ),
      onChanged: (value){
        viewModel.findLocation(value);
      },
    );
  }
}
