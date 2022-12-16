import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wifi_house/sign%20up/sign%20up%20controller.dart';

class sign_up_button extends StatefulWidget {
  const sign_up_button({Key? key}) : super(key: key);

  @override
  State<sign_up_button> createState() => _sign_up_buttonState();
}

class _sign_up_buttonState extends State<sign_up_button> {
  @override
  bool show_animation = false;
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: InkWell(
          onTap: (){
            sign_up_controller.sign_up_button(context);
            setState(() {
              show_animation = true;
            });

          },
          child: Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color(0xFF1F397C),
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: Center(
              child: show_animation
              ?CircularProgressIndicator(color: Colors.white,strokeWidth: 2,)
              :Text("Sign Up",style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 20),),
            ),
          ),
        )
    );
  }
}
