import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wifi_house/sign%20up/sign%20up%20button.dart';
import 'package:wifi_house/sign%20up/sign%20up%20controller.dart';

class sign_up extends StatelessWidget {
  const sign_up({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 60,),
            SafeArea(child: Center(
              child:Text("Welcome Back!",style: GoogleFonts.poppins(color: Colors.white,fontSize: 24,fontWeight: FontWeight.w500),),
            )),
            Text("please create your account",style: GoogleFonts.poppins(color: Color(0xFFC2C2C2),fontSize: 17,fontWeight: FontWeight.w300),),
            SizedBox(height: 60,),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 38),
                  child: Text("Email",style: GoogleFonts.poppins(color: Color(0xFFC2C2C2),fontSize: 14,fontWeight: FontWeight.w300),),
                )),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFB3BCBF).withOpacity(0.17),
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 18,right: 18),
                    child:  TextFormField(
                      controller: sign_up_controller.email,
                      style: GoogleFonts.poppins(color: Colors.white,fontSize: 14),
                      decoration: new InputDecoration.collapsed(
                          hintText: 'Email',
                          hintStyle: GoogleFonts.poppins(color: Color(0xFFC2C2C2).withOpacity(0.87),fontSize: 14)
                      ),
                    ),
                  )
                ),
              ),
            ),
            SizedBox(height: 40,),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 38),
                  child: Text("Password",style: GoogleFonts.poppins(color: Color(0xFFC2C2C2),fontSize: 14,fontWeight: FontWeight.w300),),
                )),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xFFB3BCBF).withOpacity(0.17),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 18,right: 18),
                      child:  TextFormField(
                        controller: sign_up_controller.password,
                        style: GoogleFonts.poppins(color: Colors.white,fontSize: 14),
                        decoration: new InputDecoration.collapsed(
                            hintText: 'Password',
                            hintStyle: GoogleFonts.poppins(color: Color(0xFFC2C2C2).withOpacity(0.87),fontSize: 14)
                        ),
                      ),
                    )
                ),
              ),
            ),
            SizedBox(height: 40,),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 38),
                  child: Text("Token id",style: GoogleFonts.poppins(color: Color(0xFFC2C2C2),fontSize: 14,fontWeight: FontWeight.w300),),
                )),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xFFB3BCBF).withOpacity(0.17),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 18,right: 18),
                      child:  TextFormField(
                        controller: sign_up_controller.token_id,
                        style: GoogleFonts.poppins(color: Colors.white,fontSize: 14),
                        decoration: new InputDecoration.collapsed(
                            hintText: 'Token id',
                            hintStyle: GoogleFonts.poppins(color: Color(0xFFC2C2C2).withOpacity(0.87),fontSize: 14)
                        ),
                      ),
                    )
                ),
              ),
            ),
              SizedBox(height: 40,),
              sign_up_button(),
            SizedBox(height: 40,)
          ],
        ),
      ),
    );
  }
}
