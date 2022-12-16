
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wifi_house/sign%20up/complete%20profile.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const CameraPage({this.cameras, Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;


  @override
  void initState() {
    super.initState();
    controller = CameraController(
      widget.cameras![0],
      ResolutionPreset.max,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Scaffold(
        body: const SizedBox(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: CameraPreview(controller),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: ()async{
                  stateOfcomplete_profile.pictureFile = await controller.takePicture();
                  stateOfcomplete_profile.setState((){
                    stateOfcomplete_profile.photo = true;
                    stateOfcomplete_profile.camera = true;
                    stateOfcomplete_profile.gallery = false;
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(60)),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(width: 10,),
                        Icon(Icons.camera,color: Colors.black87,size: 37,),
                        SizedBox(width: 100,),
                        Text("Take Picture",style: GoogleFonts.poppins(color: Colors.black87),),
                      ],
                    ),
                  )
                ),
              )
            ),
          ),

        ],
      ),
    );
  }
}