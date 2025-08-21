import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateService extends GetView {
  TextEditingController nameController = TextEditingController();
  TextEditingController serviceController = TextEditingController();
  TextEditingController experiencController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  CreateService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Service",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900),),
      centerTitle: true,
        backgroundColor:Color.fromRGBO(248, 250, 248, 1.0,),
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon:Icon(Icons.arrow_back_ios_new_sharp,size: 18,)),
      ),
      body: Container(
        color: Color.fromRGBO(248, 250, 248, 1.0,),
        child: SingleChildScrollView(
          child: Padding(
            padding:EdgeInsets.symmetric(horizontal: 30,vertical: 10) ,
            child: Stack(
              children:[ Column(
                spacing: 19,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Service Details",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900),),
                  textFieldComponent("Enter Name", "Enter Name", nameController),
                  textFieldComponent("Select Service", "Select Service", serviceController),
                  textFieldComponent("Experience Level", "Experience Level", experiencController),
                  textFieldComponent("Price per hour", "Price per hour", priceController),
                  textFieldComponent("Address", "Address", addressController),
                  textFieldforDetailComponent("Service Details", "Service Details", detailController),

                ],
              ),
              Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child:  Container(
                width: MediaQuery.of(context).size.width*0.70,
                height: 50,
                decoration: BoxDecoration(
                  border: BoxBorder.fromLTRB(top:BorderSide(width: 2,color:Color.fromRGBO(
                    186, 188, 186, 0.6,))),
                  gradient: LinearGradient(colors:[Color.fromRGBO(
                    7, 125, 6, 1.0,),Color.fromRGBO(
                    6, 165, 6, 1.0,),Color.fromRGBO(2, 155, 2, 1.0,)],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight

                  ),
                  borderRadius: BorderRadius.circular(30),
                ),

                child: Expanded(
                  child: ElevatedButton(onPressed: (){}, child: Text("Next Step",style: TextStyle(fontSize:17,fontWeight:FontWeight.w900,color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),),
                ),
              )),]
            ),
          ),
        ),
      ),
    );
  }
  Widget textFieldComponent(String hintTextData, String labelData, TextEditingController textEditingController,{bool detail = false}){
return SizedBox(
  height:37,
  child: TextField(
    controller: textEditingController,

    decoration:InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color:Colors.grey),
          borderRadius: BorderRadius.circular(50)
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50)
      ),
      fillColor: Colors.white,
      filled: true,
      hintText: "",
      hintStyle: TextStyle(color:Colors.grey,fontSize:12),
      label: Text(labelData,style: TextStyle(color: Colors.grey,fontSize: 13,fontWeight: FontWeight.bold),)
    ),

  ),
);
}



  Widget textFieldforDetailComponent(String hintTextData, String labelData, TextEditingController textEditingController){
    return TextField(
      controller: textEditingController,
      maxLines: 3,
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
          hintText:hintTextData,
          hintStyle: TextStyle(color:Colors.grey,fontSize:13,fontWeight: FontWeight.bold),
      ),

    );
  }

}
