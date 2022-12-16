
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wifi_house/home/home_page.dart';
import 'package:wifi_house/sign%20up/sign%20up.dart';

class splash extends StatelessWidget {
  splash({Key? key}) : super(key: key);

  @override

  Future<List<ParseObject>> see_update(context) async {
    QueryBuilder<ParseObject> queryTodo =
    QueryBuilder<ParseObject>(ParseObject('status'));
    final ParseResponse apiResponse = await queryTodo.query();

    if (apiResponse.success && apiResponse.results != null) {
      print(apiResponse.result![0]["update"]);
      if(apiResponse.results![0]["update"] == "Required"){
        final snackBar = SnackBar(
          backgroundColor: Colors.white,
          duration: Duration(days: 365),
          content: const Text('Please Download The Updated version of app',style: TextStyle(color: Colors.black87),),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }else{
        check_login_status(context);
      }
      return apiResponse.results as List<ParseObject>;
    } else {
      return [];
    }
  }

  check_login_status(context)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString("Login") == null){
      print("Not Login");
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => sign_up()), (route) => false);
    }else{
      print("Logged in");
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => home_page()), (route) => false);

    }
  }

  Widget build(BuildContext context) {
    final update = see_update(context);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                height: 413,
                width: 392,
                child: Column(
                  children: [
                    Container(
                        height: 370,
                        child: Image.asset("assets/WiFi House.png",fit: BoxFit.fill,)),
                    Row(
                      children: [
                        SizedBox(width: 100),
                        Center(child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,)),
                        SizedBox(width: 20,),
                        Center(child: Text("Starting App .... ",style: GoogleFonts.poppins(color: Colors.grey),))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 1/15),
                Container(
                  height: 51,
                  child: Image.asset("assets/Iconic_soft._production.png",fit: BoxFit.fitHeight,),
                ),
                Text("Iconic Software Production",style: GoogleFonts.poppins(color: Colors.white,fontSize: 20),)
              ],
            ),
          ),
          SizedBox(height: 10,)
        ],
      ),
    );
  }
}
