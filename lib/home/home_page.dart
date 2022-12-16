import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wifi_connect/flutter_wifi_connect.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_to_act/slide_to_act.dart';


class home_page extends StatefulWidget {
  home_page({Key? key}) : super(key: key);

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  @override
  Future<List<ParseObject>> getTodo(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Token - ${prefs.getString("token")}");
    QueryBuilder<ParseObject> queryTodo =
    QueryBuilder<ParseObject>(ParseObject('user_'));
    queryTodo.whereContains('token_id', '${prefs.getString("token")}');
    final ParseResponse apiResponse = await queryTodo.query();

    if (apiResponse.success && apiResponse.results != null) {
      print(apiResponse.results);
      return apiResponse.results as List<ParseObject>;
    } else {
      final snackBar = SnackBar(
        backgroundColor: Colors.white,
        duration: Duration(days: 365),
        content: const Text("Account Doesn't exist",style: TextStyle(color: Colors.black87),),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return [];

    }
  }

  bool connected = false;

  Widget build(BuildContext context) {


    return Scaffold(
      body: FutureBuilder(
          future: getTodo(context),
          builder: (context , snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,),
          );
        }else if(snapshot.hasError){
          return Center(
            child: Text("Something went Wrong .. Please try again later ",style: GoogleFonts.poppins(color: Colors.grey),),
          );
        }else{
          return SingleChildScrollView(
            child: Container(
              height: 900,
              child: Column(
                children: [
                  SafeArea(child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text("Welcome ${snapshot.data![0]["Name"]}!",style: GoogleFonts.poppins(color: Colors.white,fontSize: 24,fontWeight: FontWeight.w500,),overflow: TextOverflow.ellipsis,),
                      ),
                      Expanded(child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.logout,color: Color(0xFFEB3223),size: 22,),
                      )),
                      SizedBox(width: 10,)
                    ],
                  )),
                  Padding(
                    padding: const EdgeInsets.only(left: 8,right: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              InkWell(

                                onTap : ()async{
                                  await FlutterWifiConnect.connectToSecureNetwork("Swastika Kunj_5G", "rupamjha6",saveNetwork: false)
                                      .then((value) {
                                    print(value);
                                  });
                                  // String ssid = await Wifi.ssid;
                                  // int level = await Wifi.level;
                                  //
                                  // String ip = await Wifi.ip;
                                  // Wifi.connection("Swastika Kunj_5G", "rupamjha6").then((v) {
                                  //   print(v);
                                  // });
                                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage()));
                                  // setState(() {
                                  //   connected = !connected ;
                                  // });

                                },
                                child: Container(
                                  height: 53,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: connected
                                      ?Colors.green
                                      :Color(0xFF847C7C)
                                  ),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        SizedBox(width: 10,),
                                        Icon(Icons.wifi,color: Colors.white,size: 36,),
                                        SizedBox(width: 20,),
                                        Column(
                                          children: [
                                            SizedBox(height: 3,),
                                            Text("${snapshot.data![0]["left_days_wifi"]} days",style: GoogleFonts.poppins(color: Colors.white,fontSize: 14),)
                                            ,Text("Remaining",style: GoogleFonts.poppins(color: Colors.white,fontSize: 14),)

                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: connected
                                ? Text("Connected",style: GoogleFonts.poppins(color: Colors.white,fontSize : 14),)
                                  :Text("Connect Wifi",style: GoogleFonts.poppins(color: Colors.white,fontSize : 14),),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                            child: Column(
                              children: [
                                Container(
                          height: 53,
                          width: double.infinity,
                          decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Color(0xFFD15C5C)
                          ),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        SizedBox(width: 10,),
                                        Icon(Icons.house,color: Colors.white,size: 36,),
                                        SizedBox(width: 20,),
                                        Column(
                                          children: [
                                            SizedBox(height: 3,),
                                            Text("${snapshot.data![0]["left_days_room"]} days",style: GoogleFonts.poppins(color: Colors.white,fontSize: 14),)
                                            ,Text("Remaining",style: GoogleFonts.poppins(color: Colors.white,fontSize: 14),)

                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                        ),
                                Center(
                                  child: Text("Room Rent",style: GoogleFonts.poppins(color: Colors.white,fontSize : 14),),
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      Text("Room Info",style: GoogleFonts.poppins(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),),
                      SizedBox(width: 10,),
                      Expanded(child: Divider(color: Colors.white,)),
                      SizedBox(width: 10,)
                    ],
                  ),

                  SizedBox(height: 15,),
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      Text("Room No",style: GoogleFonts.poppins(color: Colors.white,fontSize: 14),),
                      Expanded(child: Align(
                        alignment: Alignment.centerRight,
                        child : Text("${snapshot.data![0]["room_no"]}",style: GoogleFonts.poppins(color: Colors.white,fontSize: 14),),
                      )),
                      SizedBox(width: 10,),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      Text("Name",style: GoogleFonts.poppins(color: Colors.white,fontSize: 14),),
                      Expanded(child: Align(
                        alignment: Alignment.centerRight,
                        child : Text("${snapshot.data![0]["Name"]}",style: GoogleFonts.poppins(color: Colors.white,fontSize: 14),),
                      )),
                      SizedBox(width: 10,),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      Text("Partner",style: GoogleFonts.poppins(color: Colors.white,fontSize: 14),),
                      Expanded(child: Align(
                        alignment: Alignment.centerRight,
                        child : Text("${snapshot.data![0]["partner"]}",style: GoogleFonts.poppins(color: Colors.white,fontSize: 14),),
                      )),
                      SizedBox(width: 10,),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      Text("Service Using",style: GoogleFonts.poppins(color: Colors.white,fontSize: 14),),
                      Expanded(child: Align(
                        alignment: Alignment.centerRight,
                        child : Text("${snapshot.data![0]["room"] == "true" ?"Room" : ""}, ${snapshot.data![0]["wifi"] == "true" ?"Wifi" : ""}",style: GoogleFonts.poppins(color: Colors.white,fontSize: 14),),
                      )),
                      SizedBox(width: 10,),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Divider(color: Colors.white,),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      Text("Service Info",style: GoogleFonts.poppins(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),),
                      SizedBox(width: 10,),
                      Expanded(child: Divider(color: Colors.white,)),
                      SizedBox(width: 10,)
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      Text("Wifi Rent",style: GoogleFonts.poppins(color: Colors.white,fontSize: 14),),
                      Expanded(child: Align(
                        alignment: Alignment.centerRight,
                        child : Text("₹ ${snapshot.data![0]["wifi_rent"]}",style: GoogleFonts.poppins(color: Colors.white,fontSize: 14),),
                      )),
                      SizedBox(width: 10,),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      Text("Room Rent",style: GoogleFonts.poppins(color: Colors.white,fontSize: 14),),
                      Expanded(child: Align(
                        alignment: Alignment.centerRight,
                        child : Text("₹ ${snapshot.data![0]["room_rent"]}",style: GoogleFonts.poppins(color: Colors.white,fontSize: 14),),
                      )),
                      SizedBox(width: 10,),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Divider(color: Colors.white,),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      Text("Service Info",style: GoogleFonts.poppins(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),),
                      SizedBox(width: 10,),
                      Expanded(child: Divider(color: Colors.white,)),
                      SizedBox(width: 10,)
                    ],
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Container(
                      height: 57,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(0xFF1F397C),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: Center(
                        child: Center(child: Text("MESSAGE",style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 20),)),
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.only(left: 18,right: 18),
                    child: Row(
                      children: [
                        Expanded(child: Divider(color: Colors.white,)),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Text("OR",style: GoogleFonts.poppins(color: Colors.white),),
                        ),
                        Expanded(child: Divider(color: Colors.white,)),
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Container(
                      height: 57,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: Center(
                        child: Center(child: Text("CALL",style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 20),)),
                      ),
                    ),
                  ),
                  Expanded(child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: SlideAction(
                        height: 60,
                        borderRadius:10,

                        sliderButtonIcon: Icon(Icons.attach_money_outlined,color: Colors.black87,),
                        onSubmit: (){

                        },
                        text: "Recharge Now",
                        textStyle: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w300,color: Colors.white),
                        outerColor: Color(0xFF1F397C),
                      ),
                    ),
                  ))
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
