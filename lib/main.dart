import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:wifi_house/splash.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final keyApplicationId = '05hsUpzGMJp5TwWA99eKc1JWdyf94Vc10ATce5vC';
  final keyClientKey = 'JMgG7em1ZomTdJtNjfbtIuZ0yvQHXzk24XZEdRnq';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);

  // print("Connected");
  runApp(const engine());
}

class engine extends StatelessWidget {
  const engine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFF001922)),
      home: splash(),
    );
  }
}
