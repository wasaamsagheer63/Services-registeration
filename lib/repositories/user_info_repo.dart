import 'dart:convert';

import 'package:service_registeration/models/user_info.dart';
import 'package:http/http.dart' as http;

class UserInfoRepo{
  late final String userInfoEndPoint;

  UserInfoRepo({
    this.userInfoEndPoint = "https://6848562eec44b9f34940977c.mockapi.io/shoe_store/s1/registration_form",});

Future<void> uploadData(UserInfo userInfo)async{
  try{
  final responce = await http.post(Uri.parse(userInfoEndPoint),
  headers: {'Content-Type':'application/json'},
    body: jsonEncode(userInfo.toMap()));
  if(responce.statusCode == 201){
    print("User Informataion is successfully stored");
  }
  else{
    print("This issue is causing data to not stored:${responce.statusCode}");
  }
  }
   catch(e){
throw Exception(e.toString());
   }
}
}