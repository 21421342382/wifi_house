import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:wifi_house/home/home_page.dart';

import 'camera_page.dart';

late _complete_profileState stateOfcomplete_profile ;
class complete_profile extends StatefulWidget {
  const complete_profile({Key? key}) : super(key: key);

  @override
  State<complete_profile> createState() {
    stateOfcomplete_profile = _complete_profileState();
    return stateOfcomplete_profile;
  }
}

class _complete_profileState extends State<complete_profile> {
  @override

  bool photo = false;
  XFile? pictureFile;
  final picker = ImagePicker();
  bool gallery = false;
  bool camera = false;
  var _cmpressed_image;
  bool show_progress = false;


  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: (){
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => home_page()), (route) => false);
                  },
                  child: Text("Skip >",style: GoogleFonts.poppins(color: Colors.white, fontSize: 15),)),
            ),
          )),
          SizedBox(height: 30,),
          Center(child: Text("Complete Profile",style: GoogleFonts.poppins(color: Colors.white,fontSize: 27,fontWeight: FontWeight.w500),)),
          Center(child: Text("Upload your profile photo",style: GoogleFonts.poppins(color: Color(0xFFC2C2C2),fontSize: 15,fontWeight: FontWeight.w300),)),
          SizedBox(height: 60,),
          Center(
            child: Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(60)),
                border: Border.all(color: Color(0xFFDBFF00)),
                color: Colors.transparent
              ),
              child: Padding(
                padding: EdgeInsets.all(1),
                child: Center(
                  child: photo
                      ? ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(60)),
                    child: gallery
                      ?Image.memory(_cmpressed_image,fit: BoxFit.fill,height: 120,width: 120)
                      :Image.file(File(pictureFile!.path),fit: BoxFit.fill,height: 120,width: 120,)

                  )
                      : Icon(Icons.add_photo_alternate_outlined,color: Colors.white,size: 34,)
                ),
              ),
            ),
          ),
          SizedBox(height: 70,),
          Padding(padding: EdgeInsets.only(left: 18,right: 18),
          child: InkWell(
            onTap: ()async {
              await availableCameras().then(
                    (value) => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CameraPage(cameras: value,)))
              );
            },
            child: Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
              color: Color(0xFF1F397C),
              borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Center(
                child:Row(
                  children: [
                    SizedBox(width: 10,),
                    Icon(Icons.camera_alt,color: Colors.white,size: 37,),
                    Expanded(child: Center(child: Text("Upload from Camera",style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 20),))),
                  ],
                ),
              ),
            ),
          )
          ),
          SizedBox(height: 20,),
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
          SizedBox(height: 20,),
          Padding(padding: EdgeInsets.only(left: 18,right: 18),
              child: InkWell(
                onTap: ()async{
                  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                  if(pickedFile!=null){

                    try {
                      _cmpressed_image = await FlutterImageCompress.compressWithFile(
                          pickedFile.path,
                          format: CompressFormat.heic,
                          quality: 70
                      );
                      print(_cmpressed_image);
                      setState(() {
                        photo = true;
                        camera = false;
                        gallery = true;
                      });
                    } catch (e) {
                      _cmpressed_image = await FlutterImageCompress.compressWithFile(
                          pickedFile.path,
                          format: CompressFormat.jpeg,
                          quality: 70
                      );
                      print(_cmpressed_image);
                      setState(() {
                        photo = true;
                        camera = false;
                        gallery = true;
                      });
                    }
                  }
                },
                  child: Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Center(
                    child:Row(
                      children: [
                        SizedBox(width: 10,),
                        Icon(Icons.photo_library,color: Colors.black87,size: 37,),
                        Expanded(child: Center(child: Text("Choose from gallery",style: GoogleFonts.poppins(color: Colors.black87,fontWeight: FontWeight.w300,fontSize: 20),))),
                      ],
                    ),
                  ),
                ),
              )
          ),

          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(padding: EdgeInsets.only(left: 18,right: 18,bottom: 18),
                  child: InkWell(
                    onTap: ()async{
                      if(photo == false){
                        final snackBar = SnackBar(
                          backgroundColor: Colors.white,
                          duration: Duration(seconds: 2),
                          content: const Text('Select an Image',style: TextStyle(color: Colors.black87),),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }else{
                        setState(() {
                          show_progress = true;
                        });
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => home_page()), (route) => false);
                      }
                    },
                    child: Container(
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(0xFF1F397C),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: Center(
                        child: Center(child: show_progress
                        ? CircularProgressIndicator(color: Colors.white,strokeWidth: 2,)
                        :Text("CONTINUE",style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 20),)),
                      ),
                    ),
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
