import 'dart:convert';

import 'package:service_registeration/models/user_info.dart';
import 'package:http/http.dart' as http;

class UserInfoClient{
  late final String userInfoEndPoint;

  UserInfoClient({
    this.userInfoEndPoint = "https://6848562eec44b9f34940977c.mockapi.io/user_info/s1/registration_form",});

Future<bool> uploadData(UserInfo userInfo)async{
  try{
  final responce = await http.post(Uri.parse(userInfoEndPoint),
  headers: {'Content-Type':'application/json'},);
  var data = jsonDecode(responce.body);
  if(responce.statusCode == 201){
    userInfo.id = data['id'];
    updateData(userInfo);
    print("User Informataion is successfully stored");
    return true;
  }
  else{
    print("This issue is causing data to not stored:${responce.statusCode}");
    return false;
  }
  }
   catch(e){
throw Exception(e.toString());
   }
}

Future<List<UserInfo>> getData()async{
  final responce = await http.get(Uri.parse(userInfoEndPoint));
  List<UserInfo> infoList = [];
  var data = jsonDecode(responce.body.toString());
  if(responce.statusCode == 200){
   for(var info in data){
     infoList.add(UserInfo.fromMap(info));
   }
   return infoList;
  }
  else{
    print("There is problem in getting data. This code is received: ${responce.statusCode}");
    return infoList;
  }
}

  Future<bool> updateData(UserInfo userInfo)async {
  try {
    final responce = await http.put(
        Uri.parse('$userInfoEndPoint/${userInfo.id}'),
        headers: {'Content-type': 'application/json'},
        body: jsonEncode(userInfo.toMap()));
    if (responce.statusCode == 200) {
      print("Data is successfully updated");
      return true;
    }
    else {
      print("Data is not updated ${responce.statusCode}");
      return false;
    }
  }
  catch(e){
    throw Exception("Error in updating ${e.toString()}");
  }
  }

  Future<bool> deleteData(UserInfo userInfo)async {
    try {
      final responce = await http.delete(
          Uri.parse('$userInfoEndPoint/${userInfo.id}'));
      if (responce.statusCode == 200) {
        print("Data is successfully deleted");
        return true;
      }
      else {
        print("Data is not deleted ${responce.statusCode}");
        return false;
      }
    }
    catch(e){
      throw Exception("Error in deleting ${e.toString()}");
    }
  }
}