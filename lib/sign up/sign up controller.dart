import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wifi_house/sign%20up/sign%20up.dart';

import 'complete profile.dart';

class sign_up_controller{
  static TextEditingController email = new TextEditingController();
  static TextEditingController password = new TextEditingController();
  static TextEditingController token_id = new TextEditingController();

  static Future<List<ParseObject>> see_update(context) async {
    QueryBuilder<ParseObject> queryTodo =
    QueryBuilder<ParseObject>(ParseObject('Token'));
    queryTodo.whereContains('token', '${token_id.text}');
    final ParseResponse apiResponse = await queryTodo.query();

    if (apiResponse.success && apiResponse.results != null) {
      // print(apiResponse.results);
      for (var o in apiResponse.results!) {
        print((o as ParseObject).toString());
        if(o["login"] == 0){
          print("Validated! ... ");
          QueryBuilder<ParseObject> queryTodo =
          QueryBuilder<ParseObject>(ParseObject('user_'));
          final ParseResponse apiResponse = await queryTodo.query();
          queryTodo.whereContains('token', '${token_id.text}');
          if (apiResponse.success && apiResponse.results != null) {
            print("User Already Exist ... No need to create new account");
            return apiResponse.results as List<ParseObject>;
          } else {
            print("No Account found ... create a new account");
            var todo1 = ParseObject('Token')
              ..objectId = o["objectId"]
              ..set('login', 1);
            await todo1.save();
            print(email.text);
            print(password.text);
            print(token_id.text);
            print(o["Name"]);
            print(o["RoomNo"]);
            print(o["Partner"]);
            print(o["Wifi"]);
            print(o["Room"]);
            print(o["wifiRent"]);
            print(o["rent"]);
            print(o["leftdaysRoom"]);
            print(o["leftDaysWifi"]);
            print(o["login"]);
            print("Bool Updated");
            final todo = ParseObject('user_')
              ..set('email', email.text)
              ..set('password', password.text)
              ..set('token_id', token_id.text)
              ..set('Name', o["Name"])
              ..set('room_no', o["RoomNo"])
              ..set('partner', o["Partner"])
              ..set('wifi', o["Wifi"])
              ..set('room', o["Room"])
              ..set('wifi_rent', o["wifiRent"])
              ..set('room_rent', o["rent"])
              ..set('left_days_room', o["leftdaysRoom"])
              ..set('left_days_wifi', int.parse(o["leftDaysWifi"]))
              ..set('login', o["login"]);
            await todo.save();
            print("New Account Created");
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString("Login", "true");
            prefs.setString("token", "${token_id.text}");
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => complete_profile()));
            QueryBuilder<ParseObject> queryTodo =
            QueryBuilder<ParseObject>(ParseObject('user_'));
            final ParseResponse apiResponse = await queryTodo.query();

            if (apiResponse.success && apiResponse.results != null) {
              print(apiResponse.results);
              return apiResponse.results as List<ParseObject>;
            } else {
              print("No Data Found .. ");
              return [];
            }
            return [];
          }
        }else{
          final snackBar = SnackBar(
            backgroundColor: Colors.white,
            duration: Duration(seconds: 2),
            content: const Text('Token already in use ... Please Logout from another device',style: TextStyle(color: Colors.black87),),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => sign_up()));

        }
      }
      return apiResponse.results as List<ParseObject>;
    } else {
      print("Data Not Found");
      final snackBar = SnackBar(
        backgroundColor: Colors.white,
        duration: Duration(seconds: 2),
        content: const Text('Token id Not Valid!. Please Enter a valid Token id',style: TextStyle(color: Colors.black87),),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => sign_up()));

      return [];
    }
  }

  static sign_up_button(context){
    if(email.text != ""){
      if(password.text != ""){
          if(token_id.text != ""){
            see_update(context);
          }else{
            final snackBar = SnackBar(
              backgroundColor: Colors.white,
              duration: Duration(seconds: 2),
              content: const Text('Enter token id',style: TextStyle(color: Colors.black87),),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => sign_up()));

          }
      }else{
        final snackBar = SnackBar(
          backgroundColor: Colors.white,
          duration: Duration(seconds: 2),
          content: const Text('Enter Password',style: TextStyle(color: Colors.black87),),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => sign_up()));

      }
    }else{
      final snackBar = SnackBar(
        backgroundColor: Colors.white,
        duration: Duration(seconds: 2),
        content: const Text('Enter Email',style: TextStyle(color: Colors.black87),),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => sign_up()));
    }
  }
}