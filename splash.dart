import 'package:flutter/material.dart';
import 'package:login/leadscreen.dart';
import 'package:login/login1.dart';
import 'package:login/main.dart';
import 'package:shared_preferences/shared_preferences.dart';



class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {

  @override
  void initState() {
    checkuserlogedin();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator())
      );

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  Future<void> gotologin()async{
   await Future.delayed(Duration(seconds: 1));
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => login()));
  }
  Future<void> checkuserlogedin()async{
    final sharedPrefs = await SharedPreferences.getInstance();
    final userlogedin = sharedPrefs.getBool(KEYNAME);
    if(userlogedin == null || userlogedin == false){
      gotologin();
    }else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context1) => Lead()));
    }
  }
}
