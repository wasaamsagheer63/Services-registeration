import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateService extends GetView {
  const CreateService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding:EdgeInsets.all(20) ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                appBar(),
                Text("Service Details",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),)
            
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget appBar(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(onPressed: (){
          Get.back();
        }, icon:Icon(Icons.arrow_back_ios)),
        Text("Create Service",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
      ,SizedBox(width: 30,)
      ],
    );
  }
}
