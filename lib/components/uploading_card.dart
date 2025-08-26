import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UploadingCard{
  Widget uploadingCard(String text){
    return DottedBorder(
      options:RoundedRectDottedBorderOptions(radius:Radius.circular(15),
        dashPattern: [8,4],
        color: Colors.grey,
        strokeWidth: 2,
      ),

      child: Container(
        padding: EdgeInsets.all(12),
        width: 340,
        height: 250,
        child: Column(
          spacing: 11,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 15,),
            Image.asset("assets/icons/upload-file.png",width: 50,),
            SizedBox(height: 2),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Upload ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900,color:Color.fromRGBO(
                    12, 12, 12, 0.6) )),
                Text(text,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900,color:Color.fromRGBO(
                    62, 193, 16, 0.6) )),
              ],
            ),
            Text("JPG, PNG or PDF, file size no more than 5MB",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:Color.fromRGBO(
                12, 12, 12, 0.4) )),
            Text("(Optimal size: 180 x 240 px)",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900,color:Color.fromRGBO(
                12, 12, 12, 0.3) ))
          ],
        ),
      ),
    );
  }
}