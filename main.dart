import 'package:flutter/material.dart';
import 'package:login/leadscreen.dart';
import 'package:login/login1.dart';
import 'package:login/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

 late SharedPreferences sharedPreferences;
 const KEYNAME = 'Userloggedin';


Future<void> main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  //sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splashscreen(),
    );
  }
}
