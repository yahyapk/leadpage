import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:login/leadscreen.dart';
import 'package:login/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){}

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {

  final String apiUrl = "https://crm-beta-api.vozlead.in/api/v2/account/login/";
  final uname = TextEditingController();
  final pass = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  bool passwordObscured = false;
  var http;
  var Post;


  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 2.3,
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                      image: AssetImage('images/logimg.jpg'),
                      fit: BoxFit.fill),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(110)),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('Sign In', style: TextStyle(fontSize: 30,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Welcome back! Please enter your credentials to login',
                  style: TextStyle(
                      fontSize: 13, fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 20,),
              Center(
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 1.1,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 20,
                        offset: Offset(0,
                            7), // changes the position of the shadow
                      ),
                    ],
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name Required';
                      }else{
                        return null;
                      }
                    },
                    controller: uname,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.black54,
                          fontSize: 20),
                      hintText: "Username",
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Center(
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 1.1,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 20,
                        offset: Offset(0,
                            7), // changes the position of the shadow
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: pass,
                    validator: (value) {
                      if (value == null || value!.length < 5) {
                        return 'Password should be at least 5 characters';
                      }else{
                        return null;
                      }
                    },
                    obscureText: passwordObscured,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.black54,
                          fontSize: 20),
                      hintText: "Password",
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Forgot your',
                      style: TextStyle(fontSize: 15, color: Colors.grey),),
                    Text('Password?', style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold,),)
                  ],
                ),
              ),
              SizedBox(height: 30,),
              Center(
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 1.2,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 19,
                  child: MaterialButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        checklogin(context);
                        saveDataToStorage();
                      }else
                      {
                        print('data error');
                      }
                    },
                    child: Text("Sign In", style: TextStyle(fontSize: 20),),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 20),
                    child: Text("Don't have an Account?",
                      style: TextStyle(color: Colors.black54, fontSize: 17),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, right: 10),
                    child: Text("Sign Up", style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 15,
                        fontFamily: 'Oswald'),),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveDataToStorage() async {
    print(uname.text);
    print(pass.text);

    final sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setString('Sign In', uname.text);
    await sharedPrefs.setString('Sign In', pass.text);
  }

  Future<void> getsaveddata(BuildContext context) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final savedvalue = sharedPrefs.getString('Sign In');
    if (savedvalue != null) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => Lead()));
    }
  }
  Future<void> checklogin(BuildContext context) async {
    final username = uname.text;
    final password = pass.text;


    final Map<String, dynamic> credentials = {
      'username': username,
      'password': password,
    };

    try {

      final response = await post(Uri.parse(apiUrl),
          body: json.encode(credentials),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {

        final sharedPrefs = await SharedPreferences.getInstance();
        await sharedPrefs.setBool(KEYNAME, true);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context1) => Lead()));
      } else {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            margin: EdgeInsets.all(10),
            content: Text('Username and password do not match'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          margin: EdgeInsets.all(10),
          content: Text('An error occurred during authentication'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
